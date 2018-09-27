Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CB6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE73921714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPwf9BbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE73921714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeI1BSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:18:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI1BSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:18:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id f10-v6so3803856wrs.0;
        Thu, 27 Sep 2018 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQhrEMrIctFAuGoJ0ik0udylvJdtDHzk4zT3K5RlHAQ=;
        b=IPwf9BbHTxNofc2pZGWfPpQN0D6y0awUQrdVPQUaa8abPCiD7FXFe+ie/iucXsKTyM
         8NBENnri3SuoHt9WkZ4ZSIoB0J8vj7mLEU7zhpIArd1kr0+mR4h0UT3d82XhLoRpA/vr
         df+RuOiSPyg5KrXpC++DaBUbU1w4wo6fOur6crbFVne/XxJfn91hWIx3zmQeBD6E+PZX
         ezFYHjRFGFxW22d7K8F8jtPmTMH1rScFf71cIqoloki+iFUGA0Vq33LCq6wk9nOY2k5o
         vfXlAqQC1mR+MbGD5Hm9E4PFoPNvgANL4Du2b/WIVztnvksbQpE9V1Zva60D+NBzmI+o
         hyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQhrEMrIctFAuGoJ0ik0udylvJdtDHzk4zT3K5RlHAQ=;
        b=JioV0K1ASfF6KK8RCDu5GbU+bKwq2iiH/kJN6WOMPjCpd5uMT2wURCJNoyeNgtpx3v
         jmDxIwuEb7N1VJCjvtKMTllgBr2fgNf61lgRJSwXtkQimGQuEfh+EDESEBCYg49oUTDq
         QGW/KtAyD88HE5me/02gaY8Avnbwq0wtWc/qJpmZI78rk33Yv0lt2ZdKr/kGF5bTY9B9
         hpzm1Btsyc8+0E/3+FM5hUu2Ky3C0RO6dC72ogwD468kx9kmpgihEqrMN0EpEc7Uo0u3
         zTlyWPLSZ/FknulV5w1gvsySL1kop7yYvGRE757Fk+WIvcoYU60D80xWr6gu/8wijqa9
         ySGQ==
X-Gm-Message-State: ABuFfoh0PPzk+pPkZiCZtUG5PzFK08fTDosZhLSs4R+5mr3wgpCwaPRa
        HVaWRniggV72KlEdW3kxSXY=
X-Google-Smtp-Source: ACcGV63/gZ8vJHXwurcdKGtlnfYV+izoT2Fwgufif5UWmt0FNThwv9eAazPSVVtfSYed1E2lMTeH0A==
X-Received: by 2002:a5d:6209:: with SMTP id y9-v6mr10210732wru.179.1538074720784;
        Thu, 27 Sep 2018 11:58:40 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j66-v6sm3790572wrj.28.2018.09.27.11.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:58:40 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:58:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/28] 4.4.159-stable review
Message-ID: <20180927185838.GA18188@flashbox>
References: <20180927090637.687829444@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:06:24AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.159 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Sep 29 09:06:27 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.159-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel 2 XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan

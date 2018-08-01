Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A9DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5289208AD
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGvk5UGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5289208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404924AbeHATjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:39:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34549 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404867AbeHATjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:39:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id c13-v6so20964762wrt.1;
        Wed, 01 Aug 2018 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aMMiABw1UTW4y1tNGY0jBjEtMtWnBMeJj226274ives=;
        b=VGvk5UGTq9c8g/0AejCHNZ/G9SK75pP2w5iOUQMsJTyUTHZ/ur4UswAqWfKS14fUP6
         PBdwphIR6kErddv2ZVithAXFF1yEi5DFiBvyCguJrKNkx9kyvUX/6UrVpZzB46Mp7k8Y
         3wjVRAIMUiPFQLpk2K82mma8fQAmg5GtYtkZJITLM8feK608qO02XYVbQcoex9h4Awf6
         ilwK/6/W9Xse/FznSKaRK94extEo2xS2mTsmHOWcsPU0wX3/N4Eua6CvYukDEPQj0XGu
         HlCznfnFm5LYFOuHDW3z2jvBqkaWLL/IgPIeRwAcTQ4XoKBlgDGhkOrQT2LHvpZ9OZQU
         bP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aMMiABw1UTW4y1tNGY0jBjEtMtWnBMeJj226274ives=;
        b=RAGpoHSfAhDGZ31UApRgrWli0Nm+IQ2/6QvchOYUWOY1NXN7YKtvFYOj+Mb4pNhCfp
         kIvJC5qwHerhakc0QseQBA8Wuq12jhtjsdKoTUuXP2+Bypm0JgdxgvK3hPjxZD06hhR/
         qIqQstawYdwDcB+fHKH0yTk5BIGvmWioF+/BHvYoeQ6EtHApv7UXK158FZBI9t4cEmjL
         1dvigtz6//5pHlUdcpkJKnvij1Rfq+GtjiYyP8rxMkG+CmIEFG3hdAXY10mn9ia3ZWke
         xYzDuvdL6ljN4p3SP2fdOhHaOl/Dr1gl2jShMsUHQGAxp1zV17yMra8ekVg0m/L3aJPL
         vRdA==
X-Gm-Message-State: AOUpUlHwvPoKTY0smLW9Za6U8jm0jxFjmporY5qcI0EJTLOxBb3zPyyg
        u72bEwDzN5A3XMS//YMKwnk=
X-Google-Smtp-Source: AAOMgpf1ps7i+aPkUddZAuDlpIo9b+IGNLvWUi4MiydET6RpbumsSCjdzMi3VCSDfBZfzxmid1ZR5g==
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr24073135wre.5.1533145979591;
        Wed, 01 Aug 2018 10:52:59 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z14-v6sm6013599wma.18.2018.08.01.10.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:52:58 -0700 (PDT)
Date:   Wed, 1 Aug 2018 10:52:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/144] 4.9.117-stable review
Message-ID: <20180801175257.GA24758@flashbox>
References: <20180801164949.023217860@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:50:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.117 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Aug  3 16:49:15 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan

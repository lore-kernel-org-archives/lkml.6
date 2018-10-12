Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D9FC67879
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8082077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odUn1Hzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8082077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJMAkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:40:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42625 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJMAkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:40:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so14199175wru.9;
        Fri, 12 Oct 2018 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IHBwZ5wRTCytc/6zX5COhhbrYoWY0Dm5kadaC58RMhg=;
        b=odUn1Hzf4oGiPDMnsACm1sK9E4Lddsuq9HrWq8HEn3+R+UGcJsk40hN5pfFF9WVIkB
         raXO8zoPmHgt0CR6aGTknGFWLkdZgq76dtDWLfIvvPwZQOooPJiRG7rQxBmY3i56ba0F
         kXwhzH4Hk8a9FnJ9Is1JAlciY/eAQb46h2Cb+R9whZaknkiRaR6yx3ahoJLgd5gI0879
         OSo1yYpUSIkBvWg7TeFTZ0qUIn+vL3XSnrDxLjK1cvBdSBYDgrKl3LwQF9b32pWjjT+n
         P+dnzQScM31DXUYBSSzEh+AXPwjNn/fzV/mPfyACCyMtVFvyKaYrs5e1Ogrs9Nmm1DCm
         nrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IHBwZ5wRTCytc/6zX5COhhbrYoWY0Dm5kadaC58RMhg=;
        b=M+OIvyXzqx1QjgHNtLCTdqNQEZuGjhcpusDdDCiNZ1c+/5GcwtqSdwv6ZquOdMa4pi
         ypw34zIeT/gAuMQaPvAVEhu35jJ2iglXIo1nXwPSNCRCsyclj6ro9cJD8DQgdaWqVZTm
         NqpR84dLAiTm22u2/uB0BrEetsEOvMNuZ53hmuZvzUvfUZ9M/i7obpdNy2e10dYXecpY
         YQjDCLrGx35rcPcTp5dQ1oNcZmalht/xKI+fTXGXJnB4LFVklQK2r/Pt+OmK8UmWextM
         YqEfVcmgNHkIrGl56tQnzijqTZMDA6a/tOs2bJ1PavxMXJc7qEQOXbdwQR8pzMvf2CuH
         1KSw==
X-Gm-Message-State: ABuFfoi3ftMPjJjeZwR6/2nrsNrd4vGgiI/BEFg7FpmbFOu26bx2Paqz
        A507Zao5ajr4Q6vZnDS/s2Udqkp7lwB5LQ==
X-Google-Smtp-Source: ACcGV63J3SgQFSOSyKHmxWN5Xrs1ZOCCVNOH4eCiB0tNLMEOc/E+L5Cv72sEy6XLnLqF88Rv7aGSPA==
X-Received: by 2002:adf:da43:: with SMTP id r3-v6mr6158583wrl.221.1539364032177;
        Fri, 12 Oct 2018 10:07:12 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x8-v6sm2947872wrd.54.2018.10.12.10.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 10:07:11 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:07:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 000/120] 3.18.124-stable review
Message-ID: <20181012170709.GA28298@flashbox>
References: <20181011152549.500488630@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:33:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.124 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.124-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my Pixel XL.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan

Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1ACC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2sxQ7pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF63C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeJOUTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:19:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40002 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeJOUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:19:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so17316548ljr.7;
        Mon, 15 Oct 2018 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dV3ZzffCqH4gGiQypCY/0lcySEx/CiYJnmRVOgcZ1FU=;
        b=W2sxQ7pCXOZP757gchRc4TSOBQPx4+ORCiavMv9NvIUwjxJf4WybjdCd8z0l5A+ux4
         kC2LyEs6FxrgYNpNp++thmKLyhA0e25Oi1YpMkSFIynBhiqkHHiImJgFkF+4slDqGUML
         xB2rLS+8JZwk6IjB2yE7XDXOZTxMH5Wn+z3y9ZKlAdlnjo+IsQ1gwex991F6fe6g4QYq
         Mjrj6bBXGBXiGZAFeSMkc6AZsByRCZH3zEvtw41o/BfCPkJQS6BMnoYULiDWNlkhIxE8
         D90KiWTDyY32lXEVoCZMC2AxM1IAqe7IEqvXB1ir6ee/O9Nd5x3a8IY3bGUmLtWqJY2r
         n8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dV3ZzffCqH4gGiQypCY/0lcySEx/CiYJnmRVOgcZ1FU=;
        b=Bm+/Mp8LrA7A7SCqOFtn+b6bnwiu5oqrQtqtSqErdj5dTy+IwoCebHjDIM2tb8ztcc
         jTmbpRTFgPs3xCaP2KHiv7qmQ8gGW9Lis2qLAp/rX7vvzjHhzSAnXhAcUqJzOrFLa/iI
         yjiMRSd9F42GN0UkxvIdWKC6IlaNPmAMs3GhSPwzsVpw4dqpTkbWAmI6YYKx6fsAa17k
         thf+WTi/PU8vAjwH9mdMDx0L+ci1EY+MBRSruFWWCtoajtd2x9FjML5HvqQ1ihNBLBox
         /mGh+PCxSvc3/vBzN+g4/6RGnwtg/cgP20gW9sCPCy2Ht09VG1CAPaVRhJTsThhx1Wqg
         O1pw==
X-Gm-Message-State: ABuFfoimqnlUvhW0sURNM/RMerm8hli8Fl6pCFB8OQBD00G1/MJNwkZX
        4RePYFlGKe0WIdpForj+z2ZS+4L4
X-Google-Smtp-Source: ACcGV60pp33jWGKgwBNxgmP3DhTXtX8foNuqgGlG3Fora0YIv8aQ6Vx0t25fiDpvoE7MPx5aolGJ3A==
X-Received: by 2002:a2e:1291:: with SMTP id 17-v6mr11814885ljs.74.1539606874690;
        Mon, 15 Oct 2018 05:34:34 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id l8-v6sm1405511lfh.2.2018.10.15.05.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 05:34:34 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] LP1/LP2 suspend-resume CPU clock fixes for Tegra30
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830190454.8729-1-digetx@gmail.com>
Message-ID: <d9e5dfc2-f4f3-9d79-d798-ecbbb50f1e45@gmail.com>
Date:   Mon, 15 Oct 2018 15:34:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180830190454.8729-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 10:04 PM, Dmitry Osipenko wrote:
> Hello,
> 
> This patch-series fixes CPU hanging after suspend-resume / LP2 cpuidle
> on Tegra30. The bug really appears during stress-testing, like frequent
> suspending under variable load + the upcoming Tegra30 CPUFREQ driver.
> 
> Dmitry Osipenko (2):
>   ARM: tegra: Switch CPU to PLLP before powergating on Tegra30
>   ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30
> 
>  arch/arm/mach-tegra/sleep-tegra30.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

ping

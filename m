Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC874C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8DA206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmtAgKxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8DA206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJCCEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:04:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55720 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeJCCEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:04:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so3374067wmb.5;
        Tue, 02 Oct 2018 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9L9HvxYNc60oUAYqo4/GFXqh8OhPdzSABcgbmcFoJzo=;
        b=TmtAgKxu69eSgVxxTTlIQk0NUgn2udQRIEaG6jcg9noHAK34TlHUxMuB1EV0kvE8x4
         z2j+ejMbtqYBTusXsAW03yUHYAiC5QYdJEYs1LCEnJNoUc4+MCZDfS1z1/nbR+bRpBK9
         CXpyAwdUDBb+Vve18bWoowYhB9E/ptcWY8za7GnqBMsmTS+PxgVHNbPQSJKizdPLYXYw
         2zeLUqUeop75O9p/yfIB97AcWO0mzRbExUINz3jFp1LlxDrmgHZ8FDWis11R8Odxcv5y
         85z501cZ9ZA6yu2ui4pRnQt9pYjCHBC18iLtb8h5kpWdgaU+1p3KgQIKXzFS4oI5qSXJ
         xLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9L9HvxYNc60oUAYqo4/GFXqh8OhPdzSABcgbmcFoJzo=;
        b=E+pKLseLsstqhxRFrSiuXNf2eoA7c446ZT2fd/VwQ9Gdie2EzXMZy9QYmvZDG1+IxI
         jqtV19R75qYuRlqUvSJz7EgMBetbKRbb0DOPs1Dws6GimWCgMztJrOaRDqJY7ceZqHC+
         71XiPwOc4BnQ5T6kIIu/Yt2KESTBgJcTUT6MgOhz3usfpbxMc7g9YNOPvGTyWYoZWaGA
         k6Nsi1dQbZ5KprXMrLKW8zuSW2R1WcqMDLCKBYtHBgoSZhy28Ar0aSTcJltfNyv/tdE1
         9EqQtbc1hBOXKkQiYt8BRjg/DywtpVrDCyKv6FLurofljAifaUml6w7cSVflTNnYQQR2
         B2Ug==
X-Gm-Message-State: ABuFfojOGsbjqid4oPEoa7DvuTrk3VqMWOjFqLTA971qPPclbGqbM63x
        TRsPqN/A5wttI4ddMHbiJZZyxzUZmrvZKw==
X-Google-Smtp-Source: ACcGV61Oc0UxXUNSHUBe8w9l9SSK0Vnai+9+JwQGqPTT1HoNFzf76bYCQHYY2+HXG4KgW6us06bqcA==
X-Received: by 2002:a1c:e386:: with SMTP id a128-v6mr3015070wmh.106.1538507959662;
        Tue, 02 Oct 2018 12:19:19 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k25-v6sm18415934wre.18.2018.10.02.12.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 12:19:19 -0700 (PDT)
Date:   Tue, 2 Oct 2018 12:19:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/94] 4.9.131-stable review
Message-ID: <20181002191917.GA4996@flashbox>
References: <20181002132500.494838053@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:24:14AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.131 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:37 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.131-rc1.gz
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

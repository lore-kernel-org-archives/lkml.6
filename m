Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E5ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40377214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Q99fe1q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40377214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeIWTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:53:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32978 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIWTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:53:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id l19-v6so1471122ljb.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pz0IiantMrh8hcVSeCCN38GXrM2ZpuEJkQwY+gg4i1U=;
        b=Q99fe1q8QsCCgdX2JM8BcniU75488Rfz6r87kjXnAwNkXQBtLwUTuQtzO+thTjzaro
         zce5KIogZxK/ucGePsoXq8S+kT13iBB4Pu0RAZO9jfUSyvM7gX3MNG7Rdr1Y1wCycoIN
         rV2uSLap7G8v0OKnaqwdNPpSqrhH6yq2Xq3W581WJfN6OSfmf274XnhPkYhdmA5cVPrV
         rVfrPyWgOoJOE0zkL/J0jiv2hA1+DWyDlO+YetSq/AfESyYnRE7NhZ5tZMVjrYc1OC69
         bqwH93poIvVhshHVlKgc36UcWN4v/3JZygEp76CAi/oQjH4Cj/6dw9qhebKeMGNKlOs3
         3hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pz0IiantMrh8hcVSeCCN38GXrM2ZpuEJkQwY+gg4i1U=;
        b=K4g3cVIl8KXhQUnXl9bIcYAgOIULQid6E57DetpXOSSy0FfjGEXu+yk+rPjuMZ2R5y
         fQB4VjVTdWSfa7f0dSo9QaN98mslIA46JthGy4ULL2lgpgMwIc76eKdxLeErn+SDRJ1x
         k4dxfUodkrvCQwpo03bzzRWe92rD456dBJLJAsUlUmcjYZP3YAALxHk/j2BjGZhjIdp8
         H9j52gyAJTIz5qLP9OwV/OiHb5cwlxiBBIKqOZhK0CfQRELs/5lG6U3EWLhQB88LDARU
         hJ3Ok+tuQ34UV0DOl4iaixi6kszX2KCpthuDx9UH+HKXM0se+Bcn4yyjpPMuA5R5p6hD
         EjDw==
X-Gm-Message-State: APzg51Af8ebmzlTB6eHwcl4TuzjBfxN96mfZbfd5fEu08FtASCJPQ6Os
        Bh+07vp2exDDu3tiljQmnGxLIg==
X-Google-Smtp-Source: ANB0Vda/+DqeLLnImyGFicFabjS2SgZo5uRYMgEYF7ZjHdIU4/uEwZHSu5LkjkPW015Dnh0kjTrX2g==
X-Received: by 2002:a2e:1652:: with SMTP id 18-v6mr7431553ljw.56.1537710937319;
        Sun, 23 Sep 2018 06:55:37 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id c4-v6sm602960lfc.35.2018.09.23.06.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:55:35 -0700 (PDT)
Date:   Sun, 23 Sep 2018 06:48:16 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/2] ARM: exynos: mach/soc for v4.20 (or 5.0)
Message-ID: <20180923134816.3oskgg3up5dgotdr@localhost>
References: <20180921174520.9126-1-krzk@kernel.org>
 <20180921174520.9126-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921174520.9126-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 07:45:20PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Nothing special, description in tag.
> 
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.20
> 
> for you to fetch changes up to f30858439e7db9ce9847eaedf440635fc6349c6e:
> 
>   ARM: s3c24xx: Restore proper usage of pr_info/pr_cont (2018-09-19 19:11:17 +0200)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.20
> 
> 1. Fix imprecise abort during Odroid XU3-family suspend to RAM (but it
>    is not end of work needed for suspend).
> 2. Cleanup and fix of SD card write protect on MINI2440.

Merged, thanks!

-Olof

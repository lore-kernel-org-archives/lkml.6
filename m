Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03C820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BKLUqVI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03C820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeGZIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:45:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35396 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeGZIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:45:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id f18-v6so507803lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9mFrtptWMtcV8yrAH/SdpttvROvtTPOsJI2Iv7t/iU4=;
        b=BKLUqVI3QZ7UFA3y9t1gC5ey9blp1MJoQdyFGqcPk4RTwEUCPAy+xzLiLALGykUGhu
         tQ+qGgKDHuByV3VPHvIucF3span2Ow54Wj45EfDj09coY5IHjgfry6wWhp973aGlu1Wt
         LcR6sP/kQMP7YTAYJWTheLH2e1JKA0bnxub1zZpUam2hJpyNiA64SxR7cqSbAvz81GTW
         CbNwesHQxAeEIHlhEAGO3JFIlVHtX/HxZIfJbzLchpmI+3VEf3XMe7VCAAjnfZev0J3X
         8rOciZbPZALgmkFhG2UAOr4tbNOKXpkrxCGYJzxNTPtY2HqJpWlSEvZ8ZLwtKSfwoBFz
         POJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9mFrtptWMtcV8yrAH/SdpttvROvtTPOsJI2Iv7t/iU4=;
        b=GOAH6r00rPUJ/SFBsWBLeZ3D5QEd5U/xHzKGbNmdDT3w5rF3xehpTVjuvj2uWT+Sdi
         mBvOEzFl7c6PPwcDya9T8HNFwrgyn3+TMaKQcLli7PbeQWo+qzELAuS7ntCuOKetY0ph
         X4NQ+G5s1gLyOE9gdPdZk4f6UdNVXQcV3oCWjVfwZIBbE+oWurs0X1iAfIRrUpYcRVWE
         tdov9sa45CATHx0H0gJ0zccLqOACO66k46R5XRvdgt2BUh90Z3F49umMnZ3kXmgK1QDv
         Sr6/HkVa2w+JxSAU9U+AGsRtLkpjJ3xHSMgSTCEreTzfu57K4QfwnToIdUnk2jrU6GzX
         2k4Q==
X-Gm-Message-State: AOUpUlGcSYiLkvmAjTz+99q7KFu3/MKxFXt+D8zKn10NLRGQi0LZuKo1
        CoIg5ZNpo+5eOis83v62rwSzHR+VbkZl8Q==
X-Google-Smtp-Source: AAOMgpdtGDBZ8uOVnUxhkGyg72nFvGWZJjMS/YfWY0lFO/N0NrJRNQfk7xzqdBeAST85VHB1wEV9/g==
X-Received: by 2002:a19:1586:: with SMTP id 6-v6mr549106lfv.51.1532590225616;
        Thu, 26 Jul 2018 00:30:25 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id w4-v6sm101266ljj.58.2018.07.26.00.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 00:30:24 -0700 (PDT)
Date:   Thu, 26 Jul 2018 00:18:04 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 1/3] drivers: samsung: Cleanup for v4.19
Message-ID: <20180726071804.pqmz4467lekt73xl@localhost>
References: <20180725162340.7488-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725162340.7488-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 06:23:38PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Rebased on v4.18-rc2, because at v4.18-rc1 the NFS root boot, which I use at my
> testing setup (https://krzk.eu), was broken.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> 
>   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos5440-4.19
> 
> for you to fetch changes up to c708e462e90e04afb7634e1f27f60cd6869936db:
> 
>   usb: host: exynos: Remove support for Exynos5440 (2018-07-24 18:44:00 +0200)
> 
> ----------------------------------------------------------------
> Exynos5440 drivers removal
> 
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
> 
> Removing Exynos5440 makes our life slightly easier: less maintenance,
> smaller code, reduced number of quirks, no need to preserve DTB
> backward-compatibility.
> 
> The Device Tree sources and some of the drivers for Exynos5440 were
> already removed.  This removes remaining drivers.

Merged, thanks!


-Olof

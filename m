Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B755FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B55120870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hhqVtW1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbeLLVO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:14:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43351 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLVO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:14:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id 83-v6so17575563ljf.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJQE7odjoT0vDvgNSD+M0i1h+g356x+vaYUpeGJ+wZU=;
        b=hhqVtW1x2132l4ROlvgIN564ciibbn13pa0lHftG3kcStFzCgjIw/2HwGTxuQ9HJqU
         s6Wk/LqTqfea5edm21iAc1BmRMJzZwkHgqFXbIrQVNwo8C0jHSzwbfkhH8uY/l7e/5eI
         n4M2pAgG/tJpT3nDCyWe+dTeCFt63lLrTDWNRJmM1zPajz7nXRKYlFh5KhMXdDj1OVXg
         OTl1fuXZiMP/MapwwnGYZZjM9r0uwFnRRbTbFM0zbd1bCcEdz9kA48NE0bqC52CRJnCg
         HfUDXn/fzDMp/HwrAVpLqiups1XCmKNTJA3izC0ID7UNYv/LfH4gRL1DsjqMTzJDVBX7
         C2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJQE7odjoT0vDvgNSD+M0i1h+g356x+vaYUpeGJ+wZU=;
        b=soZZhxiq+JTsetnLJyzYpr0vDzRH8AlBhEDVY1XPhjoD6ZxxoeKoKLitqUAOn853Oz
         RkwSMaqLomCCr5nKbRbTirbr4/Nii1XDO0plzTwZAF179VNEHb+k5CQkZ4glU7ebfSWY
         r9Rjt1Ms974pSEhzgQoNZF3Ft9fEP0j98e3DhUFECvsDo8sN0cmP4u8dy030hTbS+DuJ
         ogZs/AdmFAis/8Hmmyq7OIJjMtz306cL4QD5HN+PNlNIby4CONgi0emVgfEnHXdB7wCI
         0tc/k7aefLYh+WR/FZp+y1Gyv6nnGbvLODwgXedUnuRwnVhnJyfvSHvlc6CWyNW6HqMz
         dNxQ==
X-Gm-Message-State: AA+aEWYf+1S1br3SWv7uOv/19lmBYHDgBiuBXOhaN310MCy+WOuZvPpd
        CA2Pz8+vfR0jHcnicFLd8lo6Rw==
X-Google-Smtp-Source: AFSGD/WBjz/6OWgWTijrcxvGRE+4wHX3j56q812JT4zjZPZZyBnuhiaFUXypIorP08xRscoWDPqA2Q==
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr14382760lja.111.1544649294134;
        Wed, 12 Dec 2018 13:14:54 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d15-v6sm3458382lja.38.2018.12.12.13.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 13:14:52 -0800 (PST)
Date:   Wed, 12 Dec 2018 12:52:51 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/4] ARM: dts: exynos: Pull for v4.21
Message-ID: <20181212205251.lmbteairsojqvnge@localhost>
References: <20181209114911.25194-1-krzk@kernel.org>
 <20181209114911.25194-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209114911.25194-3-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 12:49:09PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21
> 
> for you to fetch changes up to 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:
> 
>   ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.21
> 
> 1. Add missing properties and nodes for PMIC clocks in multiple DTS
>    files.
> 2. Add UHS-I bus speed support to Odroid XU3/XU4/HC SD card and bump the
>    maximum clock frequency to 200 MHz for SD and eMMC.
> 3. Update cooling maps to include all CPU devices in multiple DTS files.
> 4. Enable quirks for Exynos3250 DWC.
> 5. Add JPEG CODEC node to S5Pv210.
> 6. Add opp-suspend to devfreq OPPs on Exynos4 boards to fix resuming
>    from suspend to RAM.
> 7. Remove eDP from Arndale board as it does not work and breaks also
>    DSI.

Merged, thanks!


-Olof


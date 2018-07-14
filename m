Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE81ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F2B2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Eg4dtpc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F2B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeGNWjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:39:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39705 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbeGNWjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:39:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so6917097lji.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 15:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDRb69GnyRxbm4yIp8sioEoSvH7OGJUiYOAO5lLXFrY=;
        b=Eg4dtpc/yMv9yO9eM0SESk2qbrXUf74kqY7HBLM28rfhws3CtJ7EJWMUwHbPjfPF0w
         lLCNEk/I/6Bmz6j0fX6XcEcH+tm2fRqvQGwTkZC4VB26mepN7h9vwGeVTPwGRV0eenT8
         zEiCFZE2vuNY6JXCyrBNZ5hMPN1WuQkpehE/rIqHvzZfDiHPdBj0c1eQ9wCm6wturkU2
         279rBwmmbxMs9zGz9u2VkdJ9ftzYw36JSVaIoQ6uVG86wLcpzB7B2/cvJow+r6LIi1UH
         nVP7/IcMvmkcBj6tYrsXQw0vSVCxyFjr5bHMmnLiAmrJn5Tby/bIb6fYaKvO8gihHK+D
         UjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDRb69GnyRxbm4yIp8sioEoSvH7OGJUiYOAO5lLXFrY=;
        b=dovTCmBGDZlitOdTy51bCfpYBitBGoS9ncYDIC+/9zh2KI4r8NIFDeTeut9e3Bv+6K
         sM33IvXAJgMEQpJp+TA6QMqIlR56bxz7uYo8rQuLTxZMlOXpESpEo9jfJFq0/3aYcjHd
         AO/4lKyQZX1f4xKV6pstSPsXjmer4dD6N1OgQwuW3/2tGfy/7b1iW8b5yGYiwgymMhja
         9AsOP+2GlcYrGZbhr2+PBEyGWmPejBgbiYX/7VdyIPnxD3U35YbdymVszAvGptDwFVr/
         yqs95BGaIYMaS9aF7TCPRgL0ytCZdmfuqDFdUH2IoT537jLLD9y6OSrGZBoMXZ43PM3y
         GJxg==
X-Gm-Message-State: AOUpUlFT/19g1HBV2bggYvDKXRZFHCDqxMxcdIvdSzP7/1G6Rbvgt0jj
        Bjz7iA+dI+1dYOJ4rqdlKoi3cg==
X-Google-Smtp-Source: AAOMgpffbjovrezaJk8UsgeGumRSDMF9Ik3iaeUgNTY5tVu2BaAtKXbYZmqbB27JTSfeSbYntdlAiQ==
X-Received: by 2002:a2e:1c6:: with SMTP id f67-v6mr6858034lji.88.1531606739220;
        Sat, 14 Jul 2018 15:18:59 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q1-v6sm2913329ljb.40.2018.07.14.15.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 15:18:57 -0700 (PDT)
Date:   Sat, 14 Jul 2018 14:30:30 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/3] ARM: defconfig: Pull for v4.19
Message-ID: <20180714213030.uxe2wwwulk6cvyop@localhost>
References: <20180712164641.19925-1-krzk@kernel.org>
 <20180712164641.19925-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712164641.19925-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:46:39PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Rebased on v4.18-rc2.
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.19
> 
> for you to fetch changes up to 24ede29d026a9f00aa3f4e7a5531803af4810734:
> 
>   ARM: s5pv210_defconfig: Enable options needed to boot typical Linux distro (2018-07-07 10:49:16 +0200)
> 
> ----------------------------------------------------------------
> Samsung defconfig changes for v4.19
> 
> Enable options needed for booting full system on S5Pv210-based Samsung
> Galaxy S mobile phones.

Thanks!


-Olof

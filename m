Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E96C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DA720811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pvPsR2ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DA720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeLLVPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:15:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44039 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbeLLVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:15:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so14644590lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vkZkrqIAi1/srhCBdVtehHcELojivhWWIOrcDOki4Uw=;
        b=pvPsR2ih4lcSyqDJrgF1aBBOcZU/91KdWvigVvbOZMr7KNcId29rI0cC5ZgJXTBGNK
         dBHeof8vVlB+FgzbT3Jz+zSguAzULPIxZzPLgb2XCdjkOIpTMJfzWfOy5p0NTX0Jtlp8
         AgjNRyr9rVsxdcTjNesJqCEmnEN0RJbw34Z+tIOGa/8QbcWC9QgSZk34QjvedFr/Kgkc
         JlcQvM4nj4zt0EConmKJtEQw/Q9LRx+mDwQ6hpE4GSgvpGSOT/krYqXSlBBmCB5kV+aV
         lEEYfH/P3h3uWS9NwmApLyWj5CuMnlAQDg/U7GA5nVXByYsrB1aXLj17euUifP67yFZD
         hp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vkZkrqIAi1/srhCBdVtehHcELojivhWWIOrcDOki4Uw=;
        b=bzbT/0YrwpcZOrhQL26XU94Lo/vz7rVr2wzMMOH0AGDaR5YqQJCj7pfK9dkHZz8Uwu
         UKsdEBd4NLn20pvKgCoW0Yhoka/OVbPO7CnJmHE7XY0v7/mPJYCNO4VW6i04Y0znEv2K
         pDlKf6aEyvAAUDaSgRYP6Mw0Hx/P4dS04cEzznXUwK15BaY+6j34G+MsFkt3CykpHC8S
         umr5q3YxQasD94HyO3UnNwqiYmgPzzZrMjzu75ie/Myk9dfXwQdhoxdY1uHOXhCWDZYT
         tnvxLkuV4r5UWae4hKWViNeJPEO1vhtIal2XZ7P6NOBWd+8UHkj+PWBPke7ewlgPr3QF
         /b2Q==
X-Gm-Message-State: AA+aEWaA5FFlC/5B9pc7yzMf2zkNqyUdUEraJoBIl8a3/kQfvcfvzlt+
        XTp+Ctf7S2sDarKld/h6meGhLQ==
X-Google-Smtp-Source: AFSGD/VBRN+YwZL/8uMZ8CVLMOQPITg7vfy6qTGyTfixosPmCwp7vEuG91oCfOLLAqxtD8GErcRVKg==
X-Received: by 2002:a19:2906:: with SMTP id p6mr12295600lfp.17.1544649314749;
        Wed, 12 Dec 2018 13:15:14 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id x16sm3318674lff.26.2018.12.12.13.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 13:15:13 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:05:53 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: DT for 4.21
Message-ID: <20181212210553.jk4uznjimi37fd7p@localhost>
References: <20181211171112.GA30925@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211171112.GA30925@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 06:11:12PM +0100, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here is the DT pull request for 4.21. The clock DT binding switch has
> been in -next for a while and doesn't seem to have any issue.
> 
> This is based on the 4.20 fixes branch that you alredy pulled.
> 
> The following changes since commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:
> 
>   ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-dt
> 
> for you to fetch changes up to d8007306f6ad18f2ba0dcad68ffe9b2fd1d56bfb:
> 
>   ARM: dts: at91: nattis: initialize the BLON pin as output-low early (2018-11-21 12:24:50 +0100)
> 
> ----------------------------------------------------------------
> AT91 DT for 4.21
> 
>  - Switch most platforms to the new clock binding
>  - Small improvement for Axentia nattis

Merged, but how does this affect downstream users who have out-of-tree DTS
files that include the SoC dtsi? Seems like lots of stuff would break.


-Olof

Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CC2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BCB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="T99FAEam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BCB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeLLWQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:16:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37899 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeLLWQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so5799lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pK5tgqfNqgPP5xIorS5Llvi/2pYzuE7zgs0rf8j2Xko=;
        b=T99FAEamdB3juIYYGkDmqmGXfvIZPgiXRucteCkiFNRV0EfQ7s6DYHhUetrOpaWppK
         ymuqNz24/brMR+PTQgvmvkJA+upxVKS1c8Yy4259ELoJa45hm4MZdXhIx1tJMKJJuCW4
         gRFR0EWexX0D5PPFH+3cQEEOyl7eOCyPsYodsg5rdiSR2tn0IDkinQ5dewqLN7Ouz/gI
         7wJstXOYZRw9xTgU3vHKyJ2j2QyT9L7KZxgv9DAd/7Cnl1XJT1Q8mC+6HOGODaHC9vt8
         /pPzLEC//Rsza2Qwbnb305gQYLZRIbuErWDFofJ+IvAYYhZfDc5B23cgfdBtMV7IhiZR
         YRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pK5tgqfNqgPP5xIorS5Llvi/2pYzuE7zgs0rf8j2Xko=;
        b=o5zmYuixP+YRZUZ2fTCBtK19oXSISXkn446LLSMYFeSo5PZSC6XRWkdTwiBtPYcUI1
         DcLsOGrDhr2xCBjnpwhdh/MB0eGqnYR7zOzla/auP7B0dz3yMGZLRrYNcdDVpvV//1p5
         B/7tNXxqWhdZvnOs1BnzK96TdDwAb3gyunsz/2TfK9mZkWU/ZfZPWY+Ftho/n5TI2PfU
         FS0EKmI6W3vG80A5FrjIWFifm/Ga6X0fHWBBczI/Hw8//2oqjhvo2XmQ62XevqQngCAH
         S7yXIzdUHNfGg4mjaVO6Z++Hh+VeQmeTTUsMeIlnqg3GlMfO4nM4z/PBPY7E+YMdX+kr
         KQXQ==
X-Gm-Message-State: AA+aEWbrzxXGxOHf1hhe1hNOnIQ/o9BCS9jDUwM1fKjrOaQQuluNx51o
        C4Kvh0rJSLEm8if7XU42JBLJeQ==
X-Google-Smtp-Source: AFSGD/XkRIoqJLM4j+DRHg+aKbwceKEnANRJHmwtLeBZFE9hMhqCNgUexmh88Zfy5akDNcicI5preg==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr12181361lfc.47.1544652966552;
        Wed, 12 Dec 2018 14:16:06 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 12-v6sm3482037ljf.96.2018.12.12.14.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 14:16:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 13:38:57 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: SoC for 4.21
Message-ID: <20181212213857.s5whr3khftogkk3p@localhost>
References: <20181212124330.GA27581@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212124330.GA27581@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:43:30PM +0100, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Not much this cycle, simply adding new SoC/SP ids to the SoC detection
> code.
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-soc
> 
> for you to fetch changes up to 446e8986a2417148aed14f362831bf2425d434cb:
> 
>   ARM: at91: add support in soc driver for new SAM9X60 (2018-12-12 11:55:20 +0100)

Merged into next/drivers. Thanks!


-Olof

Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C512C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6019320685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6019320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeJaUSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:18:00 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60836 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeJaUSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:18:00 -0400
Received: from ip5f5a8d7b.dynamic.kabel-deutschland.de ([95.90.141.123] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gHoXa-0004ZI-Rm; Wed, 31 Oct 2018 12:20:02 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Emil Renner Berthing <esmil@mailme.dk>
Cc:     linux-spi@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] Rockchip SPI cleanup and use interrupts
Date:   Wed, 31 Oct 2018 12:20:00 +0100
Message-ID: <4443653.p1DpZLIVTj@diego>
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 31. Oktober 2018, 11:56:57 CET schrieb Emil Renner Berthing:
> Emil Renner Berthing (14):
>   spi: rockchip: make spi_enable_chip take bool
>   spi: rockchip: use designated init for dma config
>   spi: rockchip: always use SPI mode
>   spi: rockchip: use atomic_t state
>   spi: rockchip: disable spi on error
>   spi: rockchip: read transfer info directly
>   spi: rockchip: don't store dma channels twice
>   spi: rockchip: remove master pointer from dev data
>   spi: rockchip: simplify use_dma logic
>   spi: rockchip: set min/max speed
>   spi: rockchip: precompute rx sample delay
>   spi: rockchip: use irq rather than polling
>   spi: rockchip: support 4bit words
>   spi: rockchip: support lsb-first mode

The series, on rk3288 with cros-ec and spi-flash, rk3328 with a spi-flash, 
rk3399 with cros-ec and spi-flash:

Tested-by: Heiko Stuebner <heiko@sntech.de>




Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB80C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A7D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SgkdIFSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A7D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeGIWse (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:48:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43761 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGIWsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:48:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so14655499pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=fgElJwzd6i1PjeiFSR0gMAdlNIevhnnLBX1NdA0RcZM=;
        b=SgkdIFSwYC+cgVXsr/0Yk9qpWniu9nTRhWuNRlM9jzn4VgQJI7ewHkUh8YwTdGiQrW
         mkn1MeZwKH5JcQwgFGHuGMdvCM5lvqI7bY1a0CtFFOR8DHpH9Y2kd5tL964XqYAN7cQ1
         8g5k7EbhReOGt6B6ucy/iKjoZft3sZt1t0eZB24Vjud3nVVHBGFT+10qrEObYjJkkxK3
         gco492TTE1glHx8xSINLEv9v1KmghaGnJxVSKg06Bg0hwZ7R34XNfkSZUJ2l6/21Gj16
         XeiQoPwDTuI6kRDfPZ9pUWINEFlp+4wdept7Dgle7pakBcA/BfUBTI211ML7xEUFvPF+
         AmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fgElJwzd6i1PjeiFSR0gMAdlNIevhnnLBX1NdA0RcZM=;
        b=IlQlBR8Fgv9GC76CelKPMoaZtcbA3KBcpZ+D3uCypL0Wr1ziSoTTFZlL/+OUaETo24
         ez11BUjSKp9911i8xsPBUMfz6pBFt3LhZoHeoseL05sd4hAnYdCsKNMig4MieYdf0pp9
         bjWxzwLCorrQA6RiYA8IMGE+oJ0ViCZJxX/EH0WgA4TT8BGgszSzXjbWMNESaxGSLVaC
         UjW6VZn8UYavgZd1PcaOuiPJH8NdxaJWfGnUsNUvYxqE+SE2FKMgFfxuGLX/yrBiGhXv
         RaOXiXsTMPyXUKNJ5i4x1o8zVXB7uWaNSBMyZ/osvmIzI2rvCA299BF0NFGbRZ1Expmi
         PmDQ==
X-Gm-Message-State: APt69E331judQk+Nt4YTi9/4SDiHnyBDSbhWlLVBeuDy1teBMRstT6GE
        4drf+pfd8B07PpC2QQPK179Vzw==
X-Google-Smtp-Source: AAOMgpft/zTowvNxJdl8BawE9YZELGehGksGVCdLSZ04e4f4Ss0XXawEJUZpeKX7NTap1wdeDBBBVg==
X-Received: by 2002:a62:229a:: with SMTP id p26-v6mr5300858pfj.53.1531176511283;
        Mon, 09 Jul 2018 15:48:31 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id x2-v6sm27658619pgq.33.2018.07.09.15.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:48:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 0/2] Add support for S805X based P241 Reference Design board
Organization: BayLibre
References: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com>
Date:   Mon, 09 Jul 2018 15:48:30 -0700
In-Reply-To: <1530784243-20823-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Thu, 5 Jul 2018 11:50:41 +0200")
Message-ID: <7hfu0sm3ep.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic P241 board is the Reference Design board for the S805X
> variant of the Amlogic Meson GXL SoC family.
>
> The S805X is a variant of the Amlogic Meson GXL SoC family with the
> following physical limitations :
> - No SDCard interface
> - No GPIOCLK pins
> - No USB OTG ID pin (but Gadget feature can stil be forced)
> - No 5V regulator
> - Reduced ADC inputs (only ADC0 and ADC1)
> - GPIODV_26, GPIOAO_3, GPIOAO_4, GPIOAO_5, GPIOAO_6, GPIOX_14,
>   GPIOX_15, GPIOH_3 are no more exposed on the package
>
> Amlogic exposes the following SW limitations :
> - HDMI max resolution should be 1080p60, VPU clock should be downgraded
> - Video Decoding should be limited to 1080p60, VDEC clock should be downgraded
> - CPU speed should be limited by SCPI OPP table to 1.2GHz
> - DRAM interface is limited to DDR4 16bit up to 1GiB
>
> The P241 board has the following features :
> - 1GiB DDR4 Memory
> - HDMI Connector with CEC
> - A/V jack with Stereo Audio and CVBS
> - 10/100 Ethernet
> - 2x USB2.0 Type-A
> - On-board WiFi SDIO Module
> - On-board eMMC storage
> - Infraread Received
> - Factory Reset button
> - UART connector

Applied to v4.19/dt64.

The cover letter didn't say, but I assume this was at least boot tested
on a p241 board?

Thanks,

Kevin

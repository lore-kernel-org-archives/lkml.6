Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E1324494
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yf4gUpOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E1324494
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933781AbeGCKBV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:01:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37857 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933442AbeGCKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:01:18 -0400
Received: by mail-wr0-f193.google.com with SMTP id q10-v6so1312937wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORRsA3CDuhh+rxRxov0g50tohMCHxgZhloTfPJZcPn8=;
        b=Yf4gUpOrInow/yw8zk1NFLjrPLfJ36MPwyVAp18180KDoQj/TBROfaZmwcqwD7MeYb
         OFjsTxVaqZW3mNsj+mWPq2/efKg2KHPcn1F+A//8NnnBKbU9IIbxfAeQaHRO8PzmzMBl
         jf/OOlaBH8hG3Ic6L9l6lrertdpRMM1ziy8HKOjovzHkFprFf8bS9RGucUXljENmfRMO
         Uu2nSM93uS5u+/Endcmpugcl5vdrtH/vHKkBs109WY1mkIU3MFzOfV77ZyMHwVr7PM81
         hEvlRCj8m/hyMqiKvShEA5QS4R8OchhR262qDD+yetWEEu5sO8qmGjMFCHZVzjQNVJKP
         ui3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORRsA3CDuhh+rxRxov0g50tohMCHxgZhloTfPJZcPn8=;
        b=kDEBf38LE9p7m1sUDvsFk6gKXUNish5KapcWGMKs1t3A7eOO7Z14YSerGc22hOu0Xw
         vhL+0rHFFEHy99DxRI0GpCCFJUr5oQoggusFODypIXJpR0PHM9zCT/GVUsTNa1FBeH3p
         2dUYvuXxZj/+1ezEYGMg7M4XTfACwK3TuoDWiv6B0zBIwueFJ2TesbBHDLfqZp589MHk
         IraIPeYnaIjTjt3HCPKz/ZPH+rcQdmT+PG5tbL+djaFa8o+34yl+MjFKVZER+HHNlthx
         k4+9t/u+j2jM9ysCYflpN1t3NvsvzV9qnE447zKE3wL4cWy1HGLmqGyp6Bw82eL4wM7T
         VizA==
X-Gm-Message-State: APt69E2bZl4eNSTb4hZpTpRwz4f02BDIqoxaRuwn1bE97aUbeH15a/pJ
        we+yuL/PBcAw+/UsfFWu31MHkw==
X-Google-Smtp-Source: AAOMgpc1xgzPcDwqgyi0bHHiq2cg3JKp7bRtHCFh9dW/kRjp4f6rygLJTR++Z8VeGDYZfq5Tnfl3nw==
X-Received: by 2002:adf:a211:: with SMTP id p17-v6mr953510wra.196.1530612077427;
        Tue, 03 Jul 2018 03:01:17 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s184-v6sm909956wmf.5.2018.07.03.03.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 03:01:16 -0700 (PDT)
Message-ID: <1530612075.2900.204.camel@baylibre.com>
Subject: Re: [PATCH 2/3] clk: meson: add sub EMMC clock dt-bindings IDs
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 03 Jul 2018 12:01:15 +0200
In-Reply-To: <1aedbb15-1373-adde-f5bb-bce3701d50b0@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
         <20180703145716.31860-3-yixun.lan@amlogic.com>
         <20180703092107.51497a8f@bbrezillon>
         <4b88c509-27ea-2605-023b-de208921e157@amlogic.com>
         <1530605373.2900.158.camel@baylibre.com>
         <1aedbb15-1373-adde-f5bb-bce3701d50b0@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 17:56 +0800, Yixun Lan wrote:
> > > Yes, It's true, the mux is parent of the div clock.
> > > 
> > > while testing for the NAND driver, I find it's kind of loose about the
> > > parent of the clock, so selecting the div (and let CCF decide freely) is
> > > actually works fine
> > > 
> > > but for the EMMC driver, especially when running at high clock, it's
> > > kind of picky about the parent of the clock, 
> > 
> > It would be nice to get an explanation about this behavior.
> > it seems that even of the rate provided by CLKID_SD_EMMC_X_CLK0 (main clock
> > controller) is correct, the eMMC cannot reliably tune with it.
> > 
> > Could you elaborate on this ?
> > 
> 
> It's during my own test in AXG platform, I found clock path
> a) fclk_div2 -> sd_emmc_c_clk0_sel -> sd_emmc_c_clk0_div ->
> sd_emmc_c_clk0 -> sd_emmc_c_mux -> sd_emmc_c_div
> 
> b) fclk_div2 -> sd_emmc_c_mux -> sd_emmc_c_div
> 
> path a) doesn't work in EMMC driver, even both clock parent of them from
> the same fclk_div2 source.
> 
>  sd_emmc_c_mux -> sd_emmc_c_div is the clock from the EMMC register base.
> I believe it's ASIC design issue

yes Yixun, I did the same test. What I meant with this question is: could you
confirm there a problem with this clock, and what it is exactly so we can adjust
the clock as necessary.

If FDIV2 entry to this clock is broken, maybe it should be removed.

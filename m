Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846DDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8AF2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAOgUk+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8AF2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeKHEVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:21:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43688 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKHEVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:21:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id r71so22169044qkr.10;
        Wed, 07 Nov 2018 10:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BPVN4bnWxVWD68pt2r0WHkMb4BWmAIrSIvpOqkpnGvs=;
        b=uAOgUk+qBcusZ7rfoGQZivsnzu+OztW3Wzxayu3vLhen264AC43BiuAC3PfRUmRCWJ
         1ZNVbV50Ds6Iq1G/Ix8XaXSo8v/lFUZTy21IUSCFADOqGYtOlIi6eFmmlyY3LU0j/28r
         k7oe+Vp46CYj3V/EFeva00k3fWbBS5Tk33gqZOM81gqEk5zbh9+oXzk330qdQIdnTFnO
         qRbFPqZhFTb0YbhyocxeLwWZXecaN+xPl9HtIVTK1jD+X5GBniH5C5w56pB1PlN6YkCj
         RO8fkl/xOsAbzNSs3lLLopTK+evr+cCpc2L20SSTURhQnEGrgV8I11J4SVc8WQTqbMLP
         GJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BPVN4bnWxVWD68pt2r0WHkMb4BWmAIrSIvpOqkpnGvs=;
        b=rUvLPS06ggVY0tt8spk55jPEyD5oZW8rpbxRtOOC+siofMMjt0k5ZzBv9SaoUcYHMQ
         4ZwLEUr6z12YYYYE4YS5P8Z+wZHst17MKRwQ26LWu6S7vW5agQEOoFzllFgQIxZdU+7M
         b6/7o0P2JWsPDZpuB31AdjriMNa1kkgnHtAopYUkCSwFrkKUTqkkbatVc0Wekc8NMpPs
         v9y/vGNp2daf3v3IXzaezyXaw63ff50IZOUzYiSmCnFgNNJjqUINDwXwY26hDrvCEV/U
         bxlBxo8Gp1xn6T8IYhdBoJrz5Mgo9zoWSVv8JBtgn0MuYYFkL/j8jRC2RiIYEnNpo+Nc
         1HNw==
X-Gm-Message-State: AGRZ1gKOrmlz+Ky6Hn7f5QNARTmGUe7SruRdGt2pWCafU3YTyWquezm4
        e/S0c/V0B9En0D3xynNH+Bk=
X-Google-Smtp-Source: AJdET5fJvkhUY2XZaM+fbhE6BMLxdPbtc/rsxDlZiWdLpkxZDp9QdpFOJg5ihiI/uAM+oj4Dz4AriA==
X-Received: by 2002:a37:6cc3:: with SMTP id h186-v6mr1339141qkc.49.1541616584713;
        Wed, 07 Nov 2018 10:49:44 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id i26sm1164596qtc.13.2018.11.07.10.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 10:49:44 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 7 Nov 2018 16:49:39 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/3] staging: iio: ad7780: Add is_ad778x flag chip info
Message-ID: <e7f1b071157abbb92d5cb42f310fb471ea43ff01.1541615978.git.giuliano.belinassi@usp.br>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541615978.git.giuliano.belinassi@usp.br>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows further checking of whatever the chip is (ad778x or
ad717x).

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 91e016d534ed..6e51bfdb076a 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -35,6 +35,7 @@ struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
 	unsigned int		pattern;
+	u8			is_ad778x;
 };
 
 struct ad7780_state {
@@ -135,21 +136,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 		.channel = AD7780_CHANNEL(12, 24),
 		.pattern = 0x5,
 		.pattern_mask = 0x7,
+		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7780_CHANNEL(16, 24),
 		.pattern = 0x5,
 		.pattern_mask = 0x7,
+		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
 		.pattern = 0x1,
 		.pattern_mask = 0x3,
+		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
 		.pattern = 0x1,
 		.pattern_mask = 0x3,
+		.is_ad778x = true,
 	},
 };
 
-- 
2.19.1


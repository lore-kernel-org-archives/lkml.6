Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A08C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DAC2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa8DVPoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfBZThJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:37:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34820 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfBZTga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so6732394pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zo1rOGgP1tAuDyRwTfd/XEth0y5njkvD5lYeSdDXZAc=;
        b=Wa8DVPoMfPYg1dc+cJWAkL3aOSAlBxfag0TNEmf7VqJBb7f/zd51WuGFKK7L4IbG0s
         iMZAnjWoeyPd1ElYSctYbTEFzTaWrgnHYVB8Le4hD57BxqCAh3sLN24kBw8ZcMkTCC2h
         bF2hcQsr6nASsAumgG/DU+bYhNZOsRRZV2yf2mE6svuqLArobsfDL8NMaLDSDyBze7jD
         OxUtO02DoDVF4hSmu2QwNetAzsYGFISJmfLH58NS4Cqtuw3+ItQJZkp3aFicgYgpDhrv
         sWUzOwlRCKgmdVMJ9Mbv6yQGytaUdARlF9RKOOaNAZy4rqtoASe7CJA7I+YdbypEMf2n
         ItKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zo1rOGgP1tAuDyRwTfd/XEth0y5njkvD5lYeSdDXZAc=;
        b=cPXLOWgsyB99Ij90ODqLQs2pTvhGvQ6Gip0Yojk9SnAzJXvlv2JiW+UuEe/JLGkU2P
         I5dt+NEpenT3WOtzj3EIIQ6sFXMX3N++cRei5W4r/7/X7VotdslUgshh5w0Tgy57YoK5
         uFn8QSBbS6z7Us1qcbweaRy4RyxtCD4ZkUpE0h2asg7c+BAUPl5qW1syVINf/f4gGmCB
         +TuxiFCe7Rc0jICOXCNErYx5jnqWo5Bxly91Lo0EwT8LqGTTfuB34kSa91FC2J1hDBWR
         jAggEtxLFCyxkXjHtv4o0dziEvAo2aZeaEiCt+h3t9fqWD5jeH49BNVxHrh3twV5GHi1
         Xhhw==
X-Gm-Message-State: AHQUAubJLOS75gK2/BKZWMtKJWMqbcPEovmhTUeusEW4OZu2n13D+yxi
        /swd2/gr4E6ePH2sq0QHDbZFn1qUw9k=
X-Google-Smtp-Source: AHgI3IYgfhBMhvIRNXR3hr3JMt3zWE7NydpqBa/LlgW/jZEPxDBlX56DtUTPTEdJQJoBTzEmef3kjQ==
X-Received: by 2002:a63:455f:: with SMTP id u31mr17194203pgk.241.1551209789266;
        Tue, 26 Feb 2019 11:36:29 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:28 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] drm/bridge: tc358767: Simplify tc_stream_clock_calc()
Date:   Tue, 26 Feb 2019 11:36:02 -0800
Message-Id: <20190226193609.9862-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the use of tc_write() as well as "magicly" used "ret" and "err:"
and replace it with a simple call to regmap_write(). No functional
change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index b0f8264a1285..86ebd49194b7 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -504,7 +504,6 @@ static int tc_pxl_pll_dis(struct tc_data *tc)
 
 static int tc_stream_clock_calc(struct tc_data *tc)
 {
-	int ret;
 	/*
 	 * If the Stream clock and Link Symbol clock are
 	 * asynchronous with each other, the value of M changes over
@@ -520,11 +519,7 @@ static int tc_stream_clock_calc(struct tc_data *tc)
 	 * M/N = f_STRMCLK / f_LSCLK
 	 *
 	 */
-	tc_write(DP0_VIDMNGEN1, 32768);
-
-	return 0;
-err:
-	return ret;
+	return regmap_write(tc->regmap, DP0_VIDMNGEN1, 32768);
 }
 
 static int tc_aux_link_setup(struct tc_data *tc)
-- 
2.20.1


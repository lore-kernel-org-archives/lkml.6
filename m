Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F13C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BCB206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJeOchJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BCB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeI2FpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46208 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2FpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so7923368wrr.13;
        Fri, 28 Sep 2018 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pN80Rw0L9zuyYJtcOwbG8AKZcMeKTKgEirKbEwnLrKo=;
        b=aJeOchJBN+qfSsXZfvjCOs2l/bBNh+k/RTSHbCWKnXRbBBh+r/rriq0kwiVELmpvyL
         tFgyZYNRzTc+RJyAfnLkTUH6AzS23qiHPd/VZQYGhATzDjZHPN9CesrArKq9CrPtZ0FY
         WstMvIaIjQuHBC9w+LoGICW//+w2tKYhu0jQI5OssFMaBlO5tRRH1V1IP2fi3VACfc9i
         Oi9YN/hoDqwJFaXpfZBsJbQjmrPQuLqpQt9reNmeSj69SIrqdzUqKdC62JUTA6iQEGko
         wKB+n1EhfnkJD5UtEGgdxr1xMxHL88LGcGJaqWmRsXgxkLjG9snSLMV4cUMJy7tdxGCE
         V1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pN80Rw0L9zuyYJtcOwbG8AKZcMeKTKgEirKbEwnLrKo=;
        b=a/yv01ZE3cN/lC47ei9UB3gw2vnQRQVcMTwxUXgUhG9HgnJyyA0BlZgalxnLp85ro3
         TK39L1iITI3WbRZlOmKlXO5n2795vWwpJrpZ+Y22NiZcIkergj5xCTkmO6Nh8Dgbm7ol
         BxlMNNPV8f40pT9Qs1voO68sZVaeB1VC8Pgv1dBF3Z/UjJa+QwbMc15lF340me/cUnT6
         CvV6wnw0YGEStEioiKL538NhetyHsXWuRiTG8X+7+rCMePu681miuBrfqrEaPDRn63tV
         0DRAubiocLoPylBvqRXIbMbmu7lra9epRaCjaYOBPsXSwU9zcd49Qm0IVdun8+USvlk3
         nN4Q==
X-Gm-Message-State: ABuFfohkdDBf03mRkLgNl9T/Du9VeJqiu8+X1uKZH4pcYUK5p1LywvNe
        mijxJHBDVbvYBmtVVy0e9ioJikha
X-Google-Smtp-Source: ACcGV617jKXuU86Tk7xQEPEtpy8bP9Q5X5Gs/mHsR2U3NS8zkJSgAkyiNKY7exvcSGyjE1z+KMw1sQ==
X-Received: by 2002:adf:9367:: with SMTP id 94-v6mr468849wro.211.1538176754240;
        Fri, 28 Sep 2018 16:19:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kees Cook <keescook@chromium.org>,
        Alexander Kurz <akurz@blala.de>,
        Hayes Wang <hayeswang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Grant Grundler <grundler@chromium.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Wang <ran.wang_1@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 1/7] asix: Check for supported Wake-on-LAN modes
Date:   Fri, 28 Sep 2018 16:18:50 -0700
Message-Id: <20180928231856.3587-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928231856.3587-1-f.fainelli@gmail.com>
References: <20180928231856.3587-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently silently accepts unsupported Wake-on-LAN modes
(other than WAKE_PHY or WAKE_MAGIC) without reporting that to the user,
which is confusing.

Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/asix_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index e95dd12edec4..023b8d0bf175 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -607,6 +607,9 @@ int asix_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= AX_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1


Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4DFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B984820842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="A6iZ9OW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfB0Rrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:47:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36044 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfB0Rrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:47:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id x206so5123891lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mmyBk9GgC8EvaZvsSj8EKGJFsCq9XS5xh0XfvJeZhkM=;
        b=A6iZ9OW1g/IIKbEvxkLCcp0DyilxMt7omV7zMciJ5Ev3wNiwQuIImYMWMckMjTcm8S
         JZFzQTMRbQgHgydFHny/otMDF/IG1tCoFKXTHXNTADhsfiWv3eIXYC0A0K8SeH1lBB3G
         dbNx8PxoKWBKtlPOSfZ85liifynfr1kBnQEYQHH/Q010CKme+iIsEd1ry4Yb8EOAwMsC
         hmCIbwkSjfydkwOOVezYCTv0zu8RCIJ22SzqgPv2G8YzcEvOWclvygf99E49P32pgVhJ
         P7mMFES8S4B1On/W2KnT1uigllPLCAiVdlHlGaNnYIFVXOw9s2U4cEGmrhzuIOw/j4gC
         8RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mmyBk9GgC8EvaZvsSj8EKGJFsCq9XS5xh0XfvJeZhkM=;
        b=tDj3MwV+GnEkOFbEutDkzJNbO1px7P7Lrm8SVO0sDLZ2uAsEHWPiIzruA9EfA04uRw
         h92o5Xs1z88w3PTWPlwkaYtIAbh617gNFlW6lDaMLNbqt+0QMgD6zf0SXi/QQKzwAvDL
         /lDqDdZI5QLICh1WQCexTqXbc9goeNGsPh8l08vbrZi9idlZJINVZ/uXzSWJs/UNsm1Q
         tG+dS2OU/MeaWR+BKNSBLVowAPKA9x9SPyB0EL5Nza/Iilm/YtmhNnxmmabvydWnZ8JD
         3OfVcJnl5IEWaWeR9j4aiCMFQRzCB1xN6zXKGP1yYhX0vcGgd54EypjfwKh3amdZp1yX
         fC3w==
X-Gm-Message-State: AHQUAuawBV3jJnIdNpN7HpxnzIiQ+P8hPFxpgpn8D1/dRnCxu0wDnZPI
        otZub50T6QPVEPzXIMiS+5tkTps0Jb4=
X-Google-Smtp-Source: AHgI3IYiEUnhOIAF9R6AfcE20S+QTWnML4Mbba11DqQDiwQoxl71EY1NiGxicUp6KPTCWsOlAJSVZQ==
X-Received: by 2002:a19:384a:: with SMTP id d10mr1577325lfj.111.1551289663762;
        Wed, 27 Feb 2019 09:47:43 -0800 (PST)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id m26sm3561637lji.22.2019.02.27.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 09:47:42 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux@armlinux.org.uk,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, stefanc@marvell.com,
        nadavh@marvell.com, mw@semihalf.com, jaz@semihalf.com,
        tn@semihalf.com
Subject: [net: PATCH] net: mvpp2: disable link IRQ waiting for IDLE frames
Date:   Wed, 27 Feb 2019 18:47:32 +0100
Message-Id: <1551289652-7377-1-git-send-email-mw@semihalf.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current version of the driver was configuring XLG MAC
in a way to wait 3 IDLE frames before allowing for the
link-up interrupt to be triggered. This resulted in an
issue, preventing to detect the link change during RX
traffic on the interface. Fix that.

Fixes: 4bb043262878 ("net: mvpp2: phylink support")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 16066c2..f1378f9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4532,8 +4532,7 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 		ctrl0 |= MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN;
 
 	ctrl4 &= ~MVPP22_XLG_CTRL4_MACMODSELECT_GMAC;
-	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
-		 MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
+	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC;
 
 	writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
 	writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
-- 
2.7.4


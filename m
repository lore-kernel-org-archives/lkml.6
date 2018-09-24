Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D020676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUEBuRPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9D020676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeIYC7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40655 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeIYC73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so1841143pfj.7;
        Mon, 24 Sep 2018 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKgRBdcbaLjCLYFNNphXO7D7Dwz80ZmX3ouxX2MzgvY=;
        b=YUEBuRPQTzT8CGzg7GgPki5xla5ibOAm1oSIOW5aQ5a5A8WXdhAHyxsj6Wc1nYrknc
         ntJUvNH7yTsTxVNGNkvt/rNqe/T0bj9ooS+Wxvx3nn8LW0Vop+7g1c7LyqGJ/8OoDBkY
         +gyo/EPUmpd9TKYvvEekob2zGM6dGvjX+eU/xMXEwWA/Df6UQk/OMlR6RfdIh2Shxt0D
         GaUKBPgNW1H0SOQ85dSxq8lLLk8tLX/bM46fYxlpAU5P92vwFST06jEvTSmjFFO1AHgV
         QeUTPIpR45Msh34k7biTNkYaCgYDCzEmTLLs/1IWDFfbzSuMbre8OofgSgMyoySWDqrn
         mBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKgRBdcbaLjCLYFNNphXO7D7Dwz80ZmX3ouxX2MzgvY=;
        b=kzsYrSjaaTO2ybeTmk8FwTwK73s0N5Tbtu1kE6+fQV0SJd6QJaiF7FWTCnAmbjo9cE
         bzGVAjKEt0CaoyO7i6dEe+WhhN2Z0DZIqv0bgD9YKPKFRt/N1bz0bRTFC5rCzOTrwW8Y
         UcIXVuSkTBZpdsinw5xVmoq5WBsXwWbNJ1BeWt0PRXZnGn1JUHed1XoMYoD4Rg7WoO1/
         QC7HSG6c4M3SLCiYA8X0U1S1gXhLxx5bXnPsTMWkWAl2tU9JibpdXx0NvxAk1wRyYFB6
         NDb/ywY83b58tZ8TPWC1/4VGhVvOqj0HPYlfmcYYMocY0+OrUVmYWOTSe60uRmTOHjJ0
         5jHw==
X-Gm-Message-State: ABuFfoieAXVoPoIb8eh7MUbTUPp4hS+kyn2F8bnHw3UZJGuD0Vcn5QI2
        3s+08l10IWzZn/7wF2+GuZ+j2ZcJ
X-Google-Smtp-Source: ACcGV60GkNZoQMsF2MNudIlwOdzYk0OxJ4zfUt4x2txWNL5Q3Fa/6a/HSmDIUPwO7stfpgh6tppArA==
X-Received: by 2002:a63:ff1f:: with SMTP id k31-v6mr463132pgi.20.1537822525156;
        Mon, 24 Sep 2018 13:55:25 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:23 -0700 (PDT)
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
Subject: [PATCH net 4/7] sr9800: Check for supported Wake-on-LAN modes
Date:   Mon, 24 Sep 2018 13:54:17 -0700
Message-Id: <20180924205420.31309-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924205420.31309-1-f.fainelli@gmail.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently silently accepts unsupported Wake-on-LAN modes
(other than WAKE_PHY or WAKE_MAGIC) without reporting that to the user,
which is confusing.

Fixes: 19a38d8e0aa3 ("USB2NET : SR9800 : One chip USB2.0 USB2NET SR9800 Device Driver Support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/sr9800.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 9277a0f228df..35f39f23d881 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -421,6 +421,9 @@ sr_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= SR_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1


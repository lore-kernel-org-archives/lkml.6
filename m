Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B59C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD6220676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxRmJh2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD6220676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeIYC7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36099 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeIYC7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so9801082pgo.3;
        Mon, 24 Sep 2018 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Piwc98Rhl39Hpiu2GJne8FYMrIF9jD8b1cwLP656bic=;
        b=sxRmJh2Wl4KakVXyJ4PMqjeSHQ2qIcAWEk4+0/48Hsk6XaXC9BEjsZ4YIrShVnUwI2
         egIUGhBScdyDzIkexGvlpRCTONxEkK3w1XDeaQ+hIx83qCViM2nGFJA/S7CrKyNooDiW
         E/s0p3s6O/luaPGpY7oePYr8jqRhoqlWw+F3HgodmUMkf1V5EpJNGDEISmx2GjWKuA0W
         QItWDRm0K3rKAl4ZKTPAZ8o/Y930ybWOdTZ87UEDiSImFRPxrUDBvsSHV6fEU/pD4PNC
         YTiBOPJ76VQXa97lK7+11ZCqwIyPeFNKJVZGRTdv76IMRb24su8UKlUsJz60SjQ1J1+t
         Eh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Piwc98Rhl39Hpiu2GJne8FYMrIF9jD8b1cwLP656bic=;
        b=UT3dvPbNlUh0jloRbpAyN6mlqhh4OzRhblUtLyiVp9/8t/GmWSnbw3DOK35OyfSifx
         pWVAjeZVgnwqdyY70ozlMluGURhgA8zsjmYHHTQ3i4/2v0Iv8WrIZ4dlaxWxqVMOsYWk
         94c1xZuKr+R4aOtFDaaG12+rkEtMMDFnhCw+5nfASyAyn2uYxPPGCV30JwE7Y4XY27oB
         0HfiN2vP3QjeUR/leCPFIa93RAoyNi4P190fEbeI8md54oVADRl42SW+qPYtPLxbcZau
         UKGyKF65ruFtvLZBLw+9VHYwvgi4fKN0M8nj8ru4NvcBvhmqGN5o8tEOYvt1AorYEYox
         Q1dg==
X-Gm-Message-State: ABuFfogsV2Mip//RkyhVbjpC+3XEA9Fpkn/6YrIKj/nmKT4zs9351L7D
        8djEY7hIfre+WBvwxxdcMZCcUugo
X-Google-Smtp-Source: ACcGV62HJSV6sInIbq4xhDOZ8aYmkM3/fMR+ZDTcr7K2Su4H85lGkzViNqQkbvYyMgLrCYU9bdf7MA==
X-Received: by 2002:a63:5726:: with SMTP id l38-v6mr486601pgb.118.1537822527166;
        Mon, 24 Sep 2018 13:55:27 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:26 -0700 (PDT)
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
Subject: [PATCH net 5/7] r8152: Check for supported Wake-on-LAN Modes
Date:   Mon, 24 Sep 2018 13:54:18 -0700
Message-Id: <20180924205420.31309-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924205420.31309-1-f.fainelli@gmail.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not check for Wake-on-LAN modes specified by an user,
but will conditionally set the device as wake-up enabled or not based on
that, which could be a very confusing user experience.

Fixes: 21ff2e8976b1 ("r8152: support WOL")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 2cd71bdb6484..f1b5201cc320 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4506,6 +4506,9 @@ static int rtl8152_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	if (!rtl_can_wakeup(tp))
 		return -EOPNOTSUPP;
 
+	if (wol->wolopts & ~WAKE_ANY)
+		return -EINVAL;
+
 	ret = usb_autopm_get_interface(tp->intf);
 	if (ret < 0)
 		goto out_set_wol;
-- 
2.17.1


Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0320676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTNRsf6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB0320676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeIYC71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38755 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeIYC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so4672666pgr.5;
        Mon, 24 Sep 2018 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4RYTqH0+Cakyvsu2OEu5e9Sb/xNwG7fIaEa14Pt55MU=;
        b=kTNRsf6y128e+KV3L86iWgqiMsbzxhwc1+Jw2kGTstMw0TIvMbVpVviyOF4DRDMFck
         BRR+/hHinJG1THjDLntRP2//kCzpev73euaN/3tq+xnYJU8VFNBeF0vKjylq8IWKGgmj
         YvNQF1pvBGY/c+ucU02mHTfUsi+U0o08cEsHG/R3DsH84ChhANESmHm0qAyBgxFJWFdz
         c/mW+lkYLc3Pvi0s7KSNn30n0cNagM6YosTHwfuXpJqMvCsYGtWrDnf2/SKYUIx20Jaf
         aQsiR2hIitNlVyWbO1QNF4bT8alWH99rcBWDgDUKJb8eD5LreGcc6VCAX+XMl4vADfcI
         t4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4RYTqH0+Cakyvsu2OEu5e9Sb/xNwG7fIaEa14Pt55MU=;
        b=OrvMfLfRR67ZJvK6ro8fjMKSWj4uYwrywpUNViyUavPwFxh0XqJ1iLFUpGwlGWkA0Z
         l9q8+v22f3kJak1LRoGBwXHadtFkpsuqzDGJhFkw3F7oN8SI6Djna86nb59LQy6qat8N
         Zp9EKuksgt9lLqzVSsD/Rkom4fecuFT9JtQPO0JxOLNEiTekKtQvRMRN9Fyq2v4ax4O8
         Td9zFKSZBSRzLH7naDDdUg/9dk9sKSgoGsNEe+/WPl5WnNiglCAAJ+1o7eSz4Ycd0pe7
         SgxXIs/03PRCRY/zDkLT++t+hY9DXV7YDO3C6O2xYUqm3bJDQM7alVM3jhg+u/E15fLf
         LQyg==
X-Gm-Message-State: ABuFfogo2a6xlDdbXzH5VLttGTvXE17C5E8So0IukYmWHH56tItDAyFF
        8ODJG8UndTE7I6HKIkJCozGICEK+
X-Google-Smtp-Source: ACcGV62dby03YwQr1oT39eMMwnuRdVDWprvqUXHXuuETe/OHqgUJuNIQrNJN6tEcACZxLJ6kIZW30A==
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr445784pge.23.1537822521052;
        Mon, 24 Sep 2018 13:55:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:19 -0700 (PDT)
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
Subject: [PATCH net 2/7] ax88179_178a: Check for supported Wake-on-LAN modes
Date:   Mon, 24 Sep 2018 13:54:15 -0700
Message-Id: <20180924205420.31309-3-f.fainelli@gmail.com>
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

Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/ax88179_178a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 9e8ad372f419..2207f7a7d1ff 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -566,6 +566,9 @@ ax88179_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= AX_MONITOR_MODE_RWLC;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1


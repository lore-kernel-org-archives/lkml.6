Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD6A218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 03:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGMARITx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfBRDs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 22:48:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40216 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfBRDs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 22:48:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so4217260pgo.7;
        Sun, 17 Feb 2019 19:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ry56zsJvQYyPJb5k5ciiC9BPYowLGJa4fdvmLCYeIYw=;
        b=fGMARITx2nfOjwZl7p8gRfDq5VPV5YgbK9vS9/5FCZNE+4fxvDH2X1OOcHXTx+NHSf
         IkwIRt+ht4QQz928vvP7j75Xq4O4rpuMqaxUthv3MaCxHVH+QxwoYEcxJuvrD9KWRAO2
         aw82x5FQs+4T7yKyTkKNi7QKwZTiaIcLoYQvUfON1xHSCn6/DSCclT/mqdflmg5adQA0
         BsNal23B5RXDSyRSQoF0UugW/d1gQRlxTHIel/HHeXs3zsB+KbTIFsFgkYANIym/S31A
         L0Az+k1mFaAr1x5IbwC+cpL3yQiJW8TZMLXRczJmMc47fcNHmFMBayf1GkQjdXqXOmV5
         cV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ry56zsJvQYyPJb5k5ciiC9BPYowLGJa4fdvmLCYeIYw=;
        b=sngY0MTQ5Xs22K0jmFmWwXqUyNrNV3UBIYn1c8cNjYDxBbU4JVQBdPpuN1ik7i3Z/2
         qAdjCf9AQ24ZT9Wu8Y+yE4ayC6bg/A4t5Fk5KJvJd9s4uNxGX8emyB462H41Rf2mHwMK
         vwvcgP0yNsJEd0tBM+yIIdRoGJh51PohQ6o2r6tafoVkWOZc4PFr13o9gZzwncf2suKJ
         y62fWqiFI0S1GZuyJY0fz7XpAL59I7sCU7CRT3G06VJz3GAlulLY6krxCz6s6qEdUn0h
         r8w1Uuohglum0Zv7MLQ/X/yXiNas1Hr8hVQknJwT7ZKwHic8EYlXg1+KzxJ0hEC8BuOs
         JTEg==
X-Gm-Message-State: AHQUAubldQuIBCJBu2rHtZdc+s5ZFf5KKJtcdcXywlmoGPvltbh/0Rqe
        OXMG+O4mUCD0uVNC+kNOGORB2+DSFGo=
X-Google-Smtp-Source: AHgI3Ib0yAoekfEMO+6Sp9SkDV3CRLmgmuoiJmUwtAjBrIHFRuYDWbDwH8qQxgaYyaEMeAyvQPJn/A==
X-Received: by 2002:a63:618d:: with SMTP id v135mr16822164pgb.238.1550461705043;
        Sun, 17 Feb 2019 19:48:25 -0800 (PST)
Received: from localhost.localdomain (2001-b011-1004-3ad8-7167-dbfd-33d1-77de.dynamic-ip6.hinet.net. [2001:b011:1004:3ad8:7167:dbfd:33d1:77de])
        by smtp.gmail.com with ESMTPSA id p2sm13720582pgs.7.2019.02.17.19.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 19:48:24 -0800 (PST)
From:   David Chen <david0813@gmail.com>
To:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, hayeswang@realtek.com,
        mario.limonciello@dell.com, bigeasy@linutronix.de,
        edumazet@google.com, jslaby@suse.cz, f.fainelli@gmail.com,
        david.chen7@dell.com, kai.heng.feng@canonical.com,
        zhongjiang@huawei.com
Subject: [PATCH 2/2] RTL8153-BD is used in Dell DA300 type-C dongle. It should be added to the whitelist of devices to activate MAC address pass through.
Date:   Mon, 18 Feb 2019 11:48:17 +0800
Message-Id: <20190218034817.7515-1-david0813@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Chen <david.chen7@dell.com>

Per confirming with Realtek all devices containing RTL8153-BD should
activate MAC pass through and there won't use pass through bit on efuse
like in RTL8153-AD.

Signed-off-by: David Chen <david.chen7@dell.com>
---
 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index ada6baf8847a..86c8c64fbb0f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1179,7 +1179,7 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 	} else {
 		/* test for RTL8153-BND and RTL8153-BD */
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
-		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK)) {
+		if ((ocp_data & BND_MASK) == 0 && (ocp_data & BD_MASK) == 0) {
 			netif_dbg(tp, probe, tp->netdev,
 				  "Invalid variant for MAC pass through\n");
 			return -ENODEV;
-- 
2.19.1


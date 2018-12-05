Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E42C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF896213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMQCgk3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF896213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeLEUlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:41:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40046 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:41:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so19622044lji.7;
        Wed, 05 Dec 2018 12:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1SYpFWful/LYR+Z8PGwojGR2UwW7UW11XztZ/uT98k=;
        b=tMQCgk3Ab2XibSFGqMubh8H0ioN9b8ZeSmxft7q/iMZxwu4FrF6BqIjyRKZ1hQPt7P
         DRfsdwDnLpuKwiirbQgumm5nX/JR5ODRWvybLoJwxfUVZJz+9KALrKCGV9DyP4KKQGKZ
         OO+kU+bOnln2Wq4hcL0XGyABnjNcEf3UHtE6QQqRF8rMVYZjLVBxBKufWouCbjtWnRyM
         5HpGFuG8ysg+0W/+a7Ct0R3A1sw2BSu1i2/JwcJsJTZpl7xQ1JG8nrFF91T9jStOHzj8
         fF6dSYXBRl0XgadO1ZG433dbmYPVjPYbS9+r69vixXToYauLnC4CH83dQnfxLdCfPls8
         kmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c1SYpFWful/LYR+Z8PGwojGR2UwW7UW11XztZ/uT98k=;
        b=IJgbTC1e+EBDz6o842rZvJUuz2onhrhKJDkhGZpRtzIsRpJAmNMyKbWgxngCcdaiCF
         cfjYzGNk6xnJxNUtMas0J5NUEVtBTa/EM0p8K5aJLmpA2NW6mc+fV3BroOqCuvfetlx0
         ffi6CuV5oXaMIiVjqzx9aKy3qe9gPFY+FGH4F9C6Pp57ifrFaIf1QmlO8DehXkAKwzme
         kHHHdsV3JBrOas4/TWmkNv+5ulZLqKlRzpypweRxUE8udHOmGxUozHrbzHo74pc+nkU6
         USx3+X4strLX5ew2k8owUiDsS7sMoSh75xFY73g8gmBlw/b9y1leK9goOoExR2wglOQ6
         WiiA==
X-Gm-Message-State: AA+aEWZgjHvzC6woNGxlJKDi8y4RrAWE5XNMIpesBBLs3B/bHF6AE17V
        yDe4GoTDgnPCXiFpEIv5hWHPauIBH0UjeA==
X-Google-Smtp-Source: AFSGD/UDZi8sZNzqDpbxw0ckYa9btaERcXoZPYmFSqbVoyA/hG/xEA41iVYdX120o9jSQNlQmaiMuQ==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr16214486ljk.114.1544042489623;
        Wed, 05 Dec 2018 12:41:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:41e8:260c:942a:b736])
        by smtp.googlemail.com with ESMTPSA id a18-v6sm4032412ljk.86.2018.12.05.12.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:41:28 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4329B1 UART bluetooth
Date:   Wed,  5 Dec 2018 21:41:16 +0100
Message-Id: <20181205204116.23815-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device ID for the BCM 4329 combo module used
in the Samsung Aries based phones (Galaxy S and it's variants).

```
[   11.508980] Bluetooth: hci0: BCM: chip id 41
[   11.518975] Bluetooth: hci0: BCM: features 0x04
[   11.550132] Bluetooth: hci0: BCM4329B1
[   11.557046] Bluetooth: hci0: BCM4329B1 (002.002.023) build 0000
[   13.737071] Bluetooth: hci0: BCM4329B1 (002.002.023) build 0744
```

Output from hciconfig

```
hci0:   Type: Primary  Bus: UART
        BD Address: 43:29:B1:55:00:00  ACL MTU: 1021:6  SCO MTU: 64:1
        UP RUNNING
        RX bytes:1675 acl:0 sco:0 events:145 errors:0
        TX bytes:20426 acl:0 sco:0 commands:146 errors:0
        Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x83
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH SNIFF
        Link mode: SLAVE ACCEPT
        Name: 'aries'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Version: 2.1 (0x4)  Revision: 0x2e8
        LMP Version: 2.1 (0x4)  Subversion: 0x4217
        Manufacturer: Broadcom Corporation (15)
```

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index e3e4d929e74f..ba330096d2c6 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -330,6 +330,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
 	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
+	{ 0x4217, "BCM4329B1"	},	/* 002.002.023 */
 	{ }
 };
 
-- 
2.17.1


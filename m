Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30148C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88E92184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlOEy8Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeLSLW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:22:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35203 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeLSLW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:22:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so14765278lfc.2;
        Wed, 19 Dec 2018 03:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O9HajEkEz4wp47TREsk2sYnZMM4bAOcAnD4tC/3VDFM=;
        b=YlOEy8ZoFtPj+1unFuFabPI/Z9/AgCuWYAIGCcUbYkWBJ5HoOZxTSRaPHWPrKFnzR6
         bwleT1Rx2mNLPSU12dRqBnRXNP9itiBV5KEAeauMI1CeYT+fTe+Mf4a85QS0iFiYHdrF
         DZi9ruwnAJGpo2kYmmmHf65kipvWa9+qoe2ZqY/T3BOIaQhCIVX+G83WQuptTwTchk28
         ppJvxq24pGHTChRnHvVYjFU00vTvHfJu3A2dcnyvgeYqyhKVmCk8crlw1fKyO2Poa4ES
         MXSHJgoqRPViVksvB0H8EJ/dVC8Qhko6850w+lKi7q354WAfgjUiezD+8fBYqktKY7AM
         J5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O9HajEkEz4wp47TREsk2sYnZMM4bAOcAnD4tC/3VDFM=;
        b=Yh0fOvucSU739HdJZxJNmK2ZZ9YCbsRRMDq/1akv+pe3lOxspbj94NyytXZBt1F0q/
         jdr90fiHMDzi5fr4T1+F9Lz/6h5+PoflELsSZTqA1dQ+Aj1bYeupEZcDBZffzRYncOtZ
         w2qYvhCh4F3W4HbvKBBhqLZRC9j4N8umHZYMyUY5jbpKBv18B5JDIncVXlAdmWEuzxkZ
         vYP2SmHj37+O7N7dKNeQHLN5ouFJB3qwCPeVbMmKffY/sntxuUpy7MAZ010ovG12RK2l
         aIun/iw0Raxw+cfYgc94H6oHbMLN1c3r/2z548ZTnDSuSl6Ky4TFBNrG5r63VAqFd0Hu
         9Krg==
X-Gm-Message-State: AA+aEWYx9Cd2/6tAwVjBVo88Fbjf9ikke67a76V4UUn9d5luIz0LOfbh
        ic4JTB6Cws8Vfr3o4uMlhKY=
X-Google-Smtp-Source: AFSGD/XcEt7oW7NfSQEkvw3DrgEVrX9EaamkLArEri/ODaByNTDi3Gpi4BJW34Z7Mq1Bci1fsP0jEw==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr13188912lfi.2.1545218575047;
        Wed, 19 Dec 2018 03:22:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:e05f:a77f:eff8:4ba])
        by smtp.googlemail.com with ESMTPSA id g4-v6sm3602408lji.17.2018.12.19.03.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 03:22:54 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2] Bluetooth: btbcm: Add entry for BCM4329B1 UART bluetooth
Date:   Wed, 19 Dec 2018 12:22:46 +0100
Message-Id: <20181219112246.9800-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v1:
   - Rebased against latest bluetooth-next tree
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 08e1f3dd4e03..d5d6e6e5da3b 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -341,6 +341,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
+	{ 0x4217, "BCM4329B1"   },	/* 002.002.023 */
 	{ }
 };
 
-- 
2.17.1


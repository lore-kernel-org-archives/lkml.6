Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C123206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp7J8sNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C123206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIDWR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:17:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42784 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:17:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so4853122wrr.9;
        Tue, 04 Sep 2018 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jdcm7ObhJOJlpA+5H3pKYWgVlJnAh6sMiQQY4OsxDhc=;
        b=qp7J8sNcUarld2kj9d/sLEE920Y/Ma/HWSc2CwNNdMb/bp5eJix/QQeSafMt+tFcD9
         NdtJnXf2Z+I5vRccdgtlC9jpmt1Qtb6oVdr/MQLBx8nHKIEl3eNAEKHvgFNPBlGfMWNU
         l7xN7By2JfYYgfFYgaXBTkqvbTsuXRME3UyYuBTfzoLb3GSc/oxPNFunOsGsI7mzF4ZR
         7X5M1BAiQi8W7COwGBlWDfsbIHkb3mhCu1GG+0Bh2xBHNIkGS17aDbVf8QFCOel2YIB8
         6pVuuRU+v436ySFrVc0bOJuxnJWtK4wNL7HyeyaxEuaO8VAqor40pg6cWXJjuQQO0qO4
         pmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jdcm7ObhJOJlpA+5H3pKYWgVlJnAh6sMiQQY4OsxDhc=;
        b=SAYP0fJ8V6VbrltsVRIDyi/soPBsxePDn0fz6WRBdpS+L5TFn7rAmIRQ8YgwHU/6Up
         Z7ANMm9I0J2THdX4adutvChN52HnePvPYQaeqSWFB6rMkfTBVAagl2b52nrNL4LsAikl
         ilkhrYFnHIgmqLoOnwoZXO4hD81J8rbDKfCVZ3t8VROoxaw/1PvGrUZfjfGEjiK3iGPg
         8flNzSgO6Isfi8xZj0t9Gjmol+A3aDSMCg4+infyvItKUvaGqbi5V9ALL1vAI7QQrub5
         e08i7YItuzhmm27cP4R5LlaCVi2VPOgUKOQF1r200Mi/S5FAV9sBArcmRsrRi54ELeVe
         8eNw==
X-Gm-Message-State: APzg51DYa34xmhd5CSvZpeKkXwSupLEE2stniajoum/XRHNd8vymDt+k
        M30UQY5uy5xd2Tc3Q2NNX8M=
X-Google-Smtp-Source: ANB0VdZydF76eC+/jD0x/UIYUhk28U4v09+0dSiViWSvWH9dbUUN4QCxOwmNIU36qJDRY5614CYzhA==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr23403458wrm.143.1536083507967;
        Tue, 04 Sep 2018 10:51:47 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id j44-v6sm32535249wre.40.2018.09.04.10.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 10:51:47 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth
Date:   Tue,  4 Sep 2018 21:50:57 +0400
Message-Id: <1536083457-28895-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the device ID for the AMPAK AP6335 combo module used
in the 1st generation WeTek Hub Android/LibreELEC HTPC box. The WiFI
chip identifies itself as BCM4339, while Bluetooth identifies itself
as BCM4335 (rev C0):

```
[    4.864248] Bluetooth: hci0: BCM: chip id 86
[    4.866388] Bluetooth: hci0: BCM: features 0x2f
[    4.889317] Bluetooth: hci0: BCM4335C0
[    4.889332] Bluetooth: hci0: BCM4335C0 (003.001.009) build 0000
[    9.778383] Bluetooth: hci0: BCM4335C0 (003.001.009) build 0268
```

Output from hciconfig:

```
hci0:	Type: Primary  Bus: UART
	BD Address: 43:39:00:00:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING
	RX bytes:7567 acl:234 sco:0 events:386 errors:0
	TX bytes:53844 acl:77 sco:0 commands:304 errors:0
	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH SNIFF
	Link mode: SLAVE ACCEPT
	Name: 'HUB'
	Class: 0x0c0000
	Service Classes: Rendering, Capturing
	Device Class: Miscellaneous,
	HCI Version: 4.0 (0x6)  Revision: 0x10c
	LMP Version: 4.0 (0x6)  Subversion: 0x6109
	Manufacturer: Broadcom Corporation (15)
```

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 99cde1f..e3e4d92 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -324,6 +324,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
+	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2122, "BCM4343A0"	},	/* 001.001.034 */
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
-- 
2.7.4


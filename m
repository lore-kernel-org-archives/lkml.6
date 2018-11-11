Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1487223D1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryM2xADO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1487223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbeKLIUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388231AbeKLIT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CCC208A3;
        Sun, 11 Nov 2018 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975402;
        bh=D2j4m8W6UVG2o7kWISgYsHJK+lUOZsm3mp4duArBsN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryM2xADO9Tso0yklkUdRwB1J0YNOeDUzK0bWmyfEMKGug4ngAF7H6XJBlFPOooSJb
         Y+kvIupG66LAZ2jNDZgsiha5KCFrjdIs9V9mIqb/BdxP2HVrJsysor0GTXAA2I+7PX
         jdiKezwIRH4t3J/8DU1rllz3OW8YXbAZ6Qz3yboA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 101/350] Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth
Date:   Sun, 11 Nov 2018 14:19:25 -0800
Message-Id: <20181111221711.324473292@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit a357ea098c9605f60d92a66a9073f56ce25726da ]

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
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btbcm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -324,6 +324,7 @@ static const struct bcm_subver_table bcm
 	{ 0x4103, "BCM4330B1"	},	/* 002.001.003 */
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
+	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2122, "BCM4343A0"	},	/* 001.001.034 */
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */



Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C312C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57402085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="b2sRvgoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfAGHcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:32:18 -0500
Received: from mout01.posteo.de ([185.67.36.65]:58351 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfAGHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:32:18 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4F0E5160061
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jan 2019 08:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1546846336; bh=MJcsuiwjKKqMTkcEInxfoLh0qKgDYIU2EcxwEMBOseA=;
        h=From:To:Cc:Subject:Date:From;
        b=b2sRvgoPCVHepwN3f9/StRapT7Na0YKPSH3kNiZgiFT5Zx302fYyT1b7AAbRHSMVD
         qHQg6cQwO0kz7PlT0sMjvtuOixdPKgbzVjl7q54Jm1J6SY+nTJs74bm+GtoZnIAK/k
         deNNHszy4D00gESgLu8jbaePTLMhZPG/UZnLHmm/5SE4P+WLjQOAOhAVjn9NcwwH+r
         aF3RFrIhjDLCUcR5B6nyes7NiWsOUvER/ePXs2Ag2c516HO2Zg4whLuTXGSAY1Xn05
         tnSPkNerkOrCgr2pS1I8uCb4sOoDp6uSa0Ekx4Pf4hpaXVPB5R8os2h9SHPhDgx/JZ
         4VvvMAUKyNKvw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43Y6Xv2FdLz6tm9;
        Mon,  7 Jan 2019 08:32:15 +0100 (CET)
From:   Max Schulze <max.schulze@posteo.de>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Max Schulze <max.schulze@posteo.de>
Subject: [PATCH] USB: serial: simple: add Motorola Tetra driver for TPG2200
Date:   Mon,  7 Jan 2019 08:31:49 +0100
Message-Id: <20190107073149.8214-1-max.schulze@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Motorola Tetra (simple) driver for Motorola Solutions TETRA PEI
device

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0cad ProdID=9016 Rev=24.16
S:  Manufacturer=Motorola Solutions, Inc.
S:  Product=TETRA PEI interface
C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb_serial_simple
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb_serial_simple

Signed-off-by: Max Schulze <max.schulze@posteo.de>
Tested-by: Max Schulze <max.schulze@posteo.de>
---
 drivers/usb/serial/usb-serial-simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 4d0273508043..edbbb13d6de6 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -85,7 +85,8 @@ DEVICE(moto_modem, MOTO_IDS);
 /* Motorola Tetra driver */
 #define MOTOROLA_TETRA_IDS()			\
 	{ USB_DEVICE(0x0cad, 0x9011) },	/* Motorola Solutions TETRA PEI */ \
-	{ USB_DEVICE(0x0cad, 0x9012) }	/* MTP6550 */
+	{ USB_DEVICE(0x0cad, 0x9012) },	/* MTP6550 */ \
+	{ USB_DEVICE(0x0cad, 0x9016) }	/* TPG2200 */
 DEVICE(motorola_tetra, MOTOROLA_TETRA_IDS);
 
 /* Novatel Wireless GPS driver */
-- 
2.20.1


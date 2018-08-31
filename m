Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC5120841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV3yQoGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC5120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeIADNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:13:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34652 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id j25-v6so4372002wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZY1oOLnvvIu+TIFMSTHaSpn3nf3ouvQ7kg9qNVkEnLE=;
        b=LV3yQoGj+gDiFheHq3LuC+wdtRd59OXUNRb2+0xX1QG1zLtI0nuaFsAKNUXCPbsEbu
         P2LCi/iTnWOHlyz3GKS+6rrBBYPNuNeQ2uRa3lBDMsFTeUqKPcFZ/BX+4h3eIlpm0Owv
         3uByAwTI7WAtQeNUzCglzvpqVsDI5b30ZpWyIfbvzI32vmGqpyrEKrdZ8CFKIPkXOaug
         BM+IZuqJBzRrHQPPf++rAWoBOqy1YtwOtdeXuc/f/fswSUwxRGdb8AEZpwPOo+VM+z2m
         iPxCOLn6QeSoG4b9LwB81fN5ymhmuE8wfVCdMGmq3JAT0TpAPSVPoU6jCmYMQHd0vOYm
         SR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZY1oOLnvvIu+TIFMSTHaSpn3nf3ouvQ7kg9qNVkEnLE=;
        b=Ae76poPtiFT4Vjl6GZrNCRGCTZubn+K4eC3GKg3USbgM617sMJhBoqF5lsbyRxwlry
         +7Tf6donL1KxRmvkrE387HVxAKs9rXf1ZFrfZqawoZMe8Bcf6qXv4oC2iZcqk162cwE4
         owRVtY7mIkhLv0gUDJTenbJkNcrhbLvbSdnaSpEIHMODgQ5hwmEn3EIbCzafjOABCcpt
         KjHlDe0e0MFJBw9T3BXz2n34jNYiEWUGA0gdYRCUXGNLN9AcXFL7GuIeij2kdTz9G0ex
         WCDiYnyJOB1ci6gpPbGAXaFIuq9Y+8PY99pgpb573ovS8fDGwNY2uL/7qbW5aMKrsFEe
         KPWw==
X-Gm-Message-State: APzg51DVCjuK4xE5egDoXPsvN3eOfEJxzFMkWb/04BRY++vcIP4Il1j8
        Bj1+ks7mXPcbG2PFGv1PsBROIV1bUNs=
X-Google-Smtp-Source: ANB0VdbKy3rZ2pUK1t+lr+M4tPkiZCNzUDgSjsZq5oz6qqxhMKXqoug3FfTLEgwIShui8WC5sabv0g==
X-Received: by 2002:a1c:c345:: with SMTP id t66-v6mr980027wmf.100.1535756599302;
        Fri, 31 Aug 2018 16:03:19 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:18 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/20] staging:rtl8192u: Rename Reserved... structure members - Style
Date:   Sat,  1 Sep 2018 00:02:45 +0100
Message-Id: <20180831230250.16810-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the 'Reserved...' members of the 'tx_desc_819x_usb' structure
to 'reserved...'. This change clears the checkpatch issue with
CamelCase naming.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 8aaea1d8cf50..5d643870a1e3 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -160,7 +160,7 @@ struct tx_desc_819x_usb {
 	/* DWORD 0 */
 	u16	pkt_size;
 	u8	offset;
-	u8	Reserved0:3;
+	u8	reserved0:3;
 	u8	CmdInit:1;
 	u8	LastSeg:1;
 	u8	FirstSeg:1;
@@ -177,7 +177,7 @@ struct tx_desc_819x_usb {
 	u8	PIFS:1;
 	u8	QueueSelect:5;
 	u8	NoACM:1;
-	u8	Reserved1:2;
+	u8	reserved1:2;
 	u8	SecCAMID:5;
 	u8	SecDescAssign:1;
 	u8	SecType:2;
@@ -185,13 +185,13 @@ struct tx_desc_819x_usb {
 	/* DWORD 2 */
 	u16	TxBufferSize;
 	u8	ResvForPaddingLen:7;
-	u8	Reserved3:1;
-	u8	Reserved4;
+	u8	reserved3:1;
+	u8	reserved4;
 
 	/* DWORD 3, 4, 5 */
-	u32	Reserved5;
-	u32	Reserved6;
-	u32	Reserved7;
+	u32	reserved5;
+	u32	reserved6;
+	u32	reserved7;
 };
 
 struct tx_desc_cmd_819x_usb {
-- 
2.18.0


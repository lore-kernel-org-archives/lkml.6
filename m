Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C35C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE75425032
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2v1CrLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE75425032
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeGBVs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:48:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35639 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753470AbeGBVsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:48:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id z137-v6so229277wmc.0;
        Mon, 02 Jul 2018 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lnDoJf+9j4VKmIjBJPRULv9+pzzH/07WoCB9OCK34oU=;
        b=o2v1CrLFJJ4h40cl8fR0DGwN+IKs10M6ha34NCY6x8Cyoe2MIKPlCCxz3C6SPcVrsC
         LH2x73YR0UbIwOFNlniJnsjNK3OE5QR96rBl8zylDphY5R4dHgiK9oGw+4/fEotMrP2M
         eYefzYMznOupua0faomrfhakmdjbV+iC22jfngoGi4M3mocjJXo7nvUXsTwr6+odBhxX
         IuRtFlvearYmrZ4s/rr2FwlxgPzwMC3D7DcL9fo+e7S9khlWVSuw1o/J82Pv7BgORxPn
         X9bOs1P3gBo6TS+4uw8PbiYxtyDpXVMlWjBSOtbWHeXAVJM0OEo42LLLh86zJ0TFLvuf
         EgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lnDoJf+9j4VKmIjBJPRULv9+pzzH/07WoCB9OCK34oU=;
        b=JbqKsCQ/kO2xC9w80zh4CAwo39U0UIODCdrkDKiSXjBLh6ETjLrH33mI6eKdvBLSXJ
         Yh8DfpvnHXnhXmVDEwCBqmb7Y98+6IPtUlfZjRchHGWIGxxwQgpjaE1E2JhGKbfXQknB
         JGeJYHepMgAJxymEja7UURyf8YFDl/3jm1VeObqKB2wm9//B7aKGZv8wJGwL+uKFiVSo
         bYmTZABsZy9aGHDDVDfCKoXiuKI2vKCcbdiW2uil6IdhpP548GDGZaV1E0LETSm9eO5o
         4Yncpx9vmvzmq2l4lyh0Sc8rzTcE2D51i/RWXcBRtpoNVHCn9alf3wVi4OzHKtfWSsOR
         26Vg==
X-Gm-Message-State: APt69E3BNpJPv5q1iIk577joVn5u8hpSw32OwFoEtDB1apm21VMm9BAF
        eJO5tgSLzLq9gwtdWBT1Qa8=
X-Google-Smtp-Source: AAOMgpfmq2dxGb4Q2sgnn7HuGfYdS3vSGAiwtr9oYwnDrnuM6E+pCGmwSfIDBeUGwgmZqPZdaLlu9w==
X-Received: by 2002:a1c:9e8a:: with SMTP id h132-v6mr8764627wme.48.1530568103583;
        Mon, 02 Jul 2018 14:48:23 -0700 (PDT)
Received: from localhost.localdomain (ipb218f5b0.dynamic.kabel-deutschland.de. [178.24.245.176])
        by smtp.gmail.com with ESMTPSA id l7-v6sm1349821wrg.95.2018.07.02.14.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 14:48:22 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: [PATCH] usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'
Date:   Mon,  2 Jul 2018 23:46:47 +0200
Message-Id: <20180702214647.1574-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list [1] of commits doing endianness fixes in USB subsystem is long
due to below quote from USB spec Revision 2.0 from April 27, 2000:

------------
8.1 Byte/Bit Ordering

Multiple byte fields in standard descriptors, requests, and responses
are interpreted as and moved over the bus in little-endian order, i.e.
LSB to MSB.
------------

This commit belongs to the same family.

[1] Example of endianness fixes in USB subsystem:
commit 14e1d56cbea6 ("usb: gadget: f_uac2: endianness fixes.")
commit 42370b821168 ("usb: gadget: f_uac1: endianness fixes.")
commit 63afd5cc7877 ("USB: chaoskey: fix Alea quirk on big-endian hosts")
commit 74098c4ac782 ("usb: gadget: acm: fix endianness in notifications")
commit cdd7928df0d2 ("ACM gadget: fix endianness in notifications")
commit 323ece54e076 ("cdc-wdm: fix endianness bug in debug statements")
commit e102609f1072 ("usb: gadget: uvc: Fix endianness mismatches")
       list goes on

Fixes: 132fcb460839 ("usb: gadget: Add Audio Class 2.0 Driver")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/usb/gadget/function/f_uac2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index d2dc1f00180b..540a0ce63ad4 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -438,14 +438,14 @@ static struct usb_descriptor_header *hs_audio_desc[] = {
 };
 
 struct cntrl_cur_lay3 {
-	__u32	dCUR;
+	__le32	dCUR;
 };
 
 struct cntrl_range_lay3 {
-	__u16	wNumSubRanges;
-	__u32	dMIN;
-	__u32	dMAX;
-	__u32	dRES;
+	__le16	wNumSubRanges;
+	__le32	dMIN;
+	__le32	dMAX;
+	__le32	dRES;
 } __packed;
 
 static void set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
@@ -703,9 +703,9 @@ in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 		memset(&c, 0, sizeof(struct cntrl_cur_lay3));
 
 		if (entity_id == USB_IN_CLK_ID)
-			c.dCUR = p_srate;
+			c.dCUR = cpu_to_le32(p_srate);
 		else if (entity_id == USB_OUT_CLK_ID)
-			c.dCUR = c_srate;
+			c.dCUR = cpu_to_le32(c_srate);
 
 		value = min_t(unsigned, w_length, sizeof c);
 		memcpy(req->buf, &c, value);
@@ -742,15 +742,15 @@ in_rq_range(struct usb_function *fn, const struct usb_ctrlrequest *cr)
 
 	if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
 		if (entity_id == USB_IN_CLK_ID)
-			r.dMIN = p_srate;
+			r.dMIN = cpu_to_le32(p_srate);
 		else if (entity_id == USB_OUT_CLK_ID)
-			r.dMIN = c_srate;
+			r.dMIN = cpu_to_le32(c_srate);
 		else
 			return -EOPNOTSUPP;
 
 		r.dMAX = r.dMIN;
 		r.dRES = 0;
-		r.wNumSubRanges = 1;
+		r.wNumSubRanges = cpu_to_le16(1);
 
 		value = min_t(unsigned, w_length, sizeof r);
 		memcpy(req->buf, &r, value);
-- 
2.18.0


Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54183C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE622208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rt3NrHbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE622208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeFLFrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:47:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46334 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeFLFr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:47:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id d2-v6so10906182pga.13;
        Mon, 11 Jun 2018 22:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RvT1QbMntoujOsymkKNfMFzuy919lC9/dZnzAnll76g=;
        b=rt3NrHbwqtL6+y4VtOUROz4GNYT1zydo6/ffPog2nwNqKuXqiJ90hkL2YuKtVjZ8dh
         YTI5HQa6eEf0pKU6jfpNq/c8yZZCijdtns1yiqtrAEH6b/o2WPIkzbGz4xsEch50eji2
         eAyltWOXrf5p9G2WfwEWFnIo4CYXhCFenx/Bpe9TmoIEgwr17THHdP2Trh4d73onzJEf
         oxTdUYMjNHa1M6JyYt5UPrNHPN05PGkTKPpHYSZoXFecrDq31XNIEzZZXSkU95Q2Qx8k
         qR3fH241ogJWv2o7T/ZQtjFIDlSWoJvHkX0aAnrpe0MXZycHSm6jf79qzQ5QRo/6PuOp
         iwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RvT1QbMntoujOsymkKNfMFzuy919lC9/dZnzAnll76g=;
        b=XXoZX8khz3dI5A5T6H65juNT9vq+7mi7M3KE3bQ40w62iWDlUiSyd6kRx16a54AW5U
         WBQrokmiupGWGU0RAkYF8H9BU4IDvI371j33L6f96nSqwLgZgQu3PR+HflnZQhH8XM3S
         lqifh01K4mvb5pGZh7ADJSUXC1iu32/f1baLnUI19g1LHFHnN0qUZ+n33Jg+Rf6/HoOo
         0rA5lxy8hJyRBzSz31cYk1kRHfQHOyAxJYJ3+U7aKlwrazFCynddGVXJSOH8S82qJUUe
         LtulAC3wqtBINqFLAU3IJ4qDFXQdbLE48uIW+e4LV2g5SL850fjAGrGyWDieF+V4Yuyk
         Wirg==
X-Gm-Message-State: APt69E1//j2YsAVKBZJiVFydEJR4vRGSngwT5/DC61VFrn/h4/orvbg2
        XBvUSQd3XzTkNYFmawSq88c=
X-Google-Smtp-Source: ADUXVKJPNDCx2iv9/sEQX5Ob1N/oSma/H2xZ7Xp/GQGTgPSbDHKeJnnDj41CWiok2/NdRaHZY5XmcQ==
X-Received: by 2002:a63:a05d:: with SMTP id u29-v6mr1934163pgn.80.1528782448816;
        Mon, 11 Jun 2018 22:47:28 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id o77-v6sm379796pfj.0.2018.06.11.22.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 22:47:28 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: tm6000: add error handling for dvb_register_adapter
Date:   Tue, 12 Jun 2018 13:47:20 +0800
Message-Id: <1528782443-43329-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528691962-31010-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528691962-31010-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dvb_register_adapter fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling dvb_register_adapter.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/media/usb/tm6000/tm6000-dvb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/tm6000/tm6000-dvb.c b/drivers/media/usb/tm6000/tm6000-dvb.c
index c811fc6..2e69486 100644
--- a/drivers/media/usb/tm6000/tm6000-dvb.c
+++ b/drivers/media/usb/tm6000/tm6000-dvb.c
@@ -266,6 +266,11 @@ static int register_dvb(struct tm6000_core *dev)
 
 	ret = dvb_register_adapter(&dvb->adapter, "Trident TVMaster 6000 DVB-T",
 					THIS_MODULE, &dev->udev->dev, adapter_nr);
+	if (ret < 0) {
+		printk(KERN_ERR "tm6000: couldn't register the adapter!\n");
+		goto err;
+	}
+
 	dvb->adapter.priv = dev;
 
 	if (dvb->frontend) {
-- 
2.7.4


Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7678DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234C020841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdVE82bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234C020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbeG1VV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 17:21:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42368 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbeG1VV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 17:21:27 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so14842627oib.9;
        Sat, 28 Jul 2018 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to;
        bh=Cyff5ZDAljJB2q/b6oSjpFNPcmyk7DiuV5K1MtrWWIc=;
        b=CdVE82bfIj4IHTl9H1UGzlXwGFQk0VA+AZE3A9K8HwLgL2TULDaDP2YGurgLxNfWXp
         54hKdm5wxO1R1eL7NVeiduSKxXpUgOvDdhg9lYuSjA1uA74QHJr8StITfSNO1n5xCSuU
         cJ8nYisdJiTXRs0Zmx/pXODkeSRBgQWdg3C9UgRCMZc6rvZBzB50DCMgP+6L0GZAi9ot
         DjZ3gDo66aHi9aU52XmUZd9rdX0edbCUGs5d+iVWhloTn/5mxq+DTVh7FBQlnkJr6Wl0
         TQ46qSFJ8uV9oT1WybsVql7IJpSBaANYbTSHWhvI0uukVsdFbLSrn3HZIXEUwcqgpdIK
         tXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to;
        bh=Cyff5ZDAljJB2q/b6oSjpFNPcmyk7DiuV5K1MtrWWIc=;
        b=pJsaeOWz/hCChM+4jnus67bbZ+Kt42n2v6cd0vxvO4tJ5IW9AzG5ApuPEgNixbBB66
         kCC8F3taGRb6uEtFS9KD67QnQRmioSQm5IPGbM2RpZ3ZlpXp7f7lmTVJIar3czsGvpLX
         JWGv9ZC7sfLtXVlFbR7ZuChhcu19mmU6Q8NtQBWCi5Mdd58VMz9N/CgjN33kq+i3Lqme
         f+ceTGdVmw/DGpIIypRr2VevZmc07yPjPtV/uR4x1TlhI/OrCv9P5IzNEHUp2KoYZO6G
         bkMaxvb4MTTICMpXGM/qTpDIcpyz9dtSLlsjZCD+cl7qCX5tx9nokJgQumznJYT7YkUX
         2p8w==
X-Gm-Message-State: AOUpUlF4Gomo9Zy9Qta07nm3sCEhnA31pI2qLYkBuwj+TG6+M7yzpmSJ
        KoKaCfoJsK3LlwWTJyL+Oh0R1cKrqhPGhdCUREM=
X-Google-Smtp-Source: AAOMgpe9ooudiO4UrMj5Kwda7pF++YCs6lL8dWd6qDFRqBs5hkpMXN90dNHgAAvzOPdI81TCcKutrPG6C5k8TofXktQ=
MIME-Version: 1.0
X-Received: by 2002:aca:d682:: with SMTP id n124-v6mr12443151oig.32.1532807631580;
 Sat, 28 Jul 2018 12:53:51 -0700 (PDT)
Received: from 329980741037 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 28 Jul 2018 15:53:51 -0400
From:   John S Gruber <JohnSGruber@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
 <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
Date:   Sat, 28 Jul 2018 15:53:51 -0400
Message-ID: <CAPotdmQh_sWqPmiQ=_+fJ27AT7GA5hcne=wsXcmKhNnUpUs3wQ@mail.gmail.com>
Subject: [PATCH 2/2] HID: redragon Add additional verification to rdesc
 modification quirk
To:     Jiri Kosina <jikos@kernel.org>,
        Robert Munteanu <rombert@apache.org>,
        linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        JohnSGruber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many devices using the vendor_id 0c45 and device_id of 760b
combination. Also the two bytes 0x81 0x00 aren't rare for a report
description. For these reasons the report description being altered
by the quirk should be verified more completely

If I'm understanding this correctly, I believe for an array field the
report_size should be greater or equal to
ceil(log2(usage_maximum - usage_minimum + 1)). That's 3 bits for these 8
shift keys, 0xe0-0xe7. Therefore the incorrect report description can't
be valid for any device.

Check the actual count of the rdesc and compare the entire field
description to reduce the chance of patching the wrong thing by
inadvertence.

Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
---
 drivers/hid/hid-redragon.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
index 85a5fbb..6e506cb 100644
--- a/drivers/hid/hid-redragon.c
+++ b/drivers/hid/hid-redragon.c
@@ -18,6 +18,21 @@

 #include "hid-ids.h"

+static __u8 asura_redragon_badfield[] = {
+	0x05, 0x01,	/* Usage Page (GenericDesktop)		*/
+	0x09, 0x06,	/* Usage (Keyboard)			*/
+	0xa1, 0x01,	/* Collection (Application)		*/
+	0x85, 0x04,	/* Report ID (4)			*/
+	0x05, 0x07,	/* Usage Page (Keyboard)		*/
+	0x19, 0xe0,	/* Usage Minimum (0xe0) Left Control	*/
+	0x29, 0xe7,	/* Usage Maximum (0xe7) Right GUI	*/
+	0x15, 0x00,	/* Logical Minimum (0)			*/
+	0x25, 0x01,	/* Logical Maximum (1)			*/
+	0x75, 0x01,	/* Report Size (1)			*/
+	0x95, 0x08,	/* Report Count(8)			*/
+	0x81, 0x00	/* Input Array [Should be Input Var]	*/
+};
+

 /*
  * The Redragon Asura keyboard sends an incorrect HID descriptor.
@@ -36,7 +51,9 @@
 static __u8 *redragon_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (*rsize >= 102 && rdesc[100] == 0x81 && rdesc[101] == 0x00) {
+	if (*rsize == 169 &&
+			memcmp(&rdesc[78], asura_redragon_badfield,
+			sizeof(asura_redragon_badfield)) == 0) {
 		dev_info(&hdev->dev, "Fixing Redragon ASURA report descriptor.\n");
 		rdesc[101] = 0x02;
 	}
-- 
1.9.1

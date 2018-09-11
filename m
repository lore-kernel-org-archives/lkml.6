Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BF7C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C21820839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3pp5vX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C21820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeIKVgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:36:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46010 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:36:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id x26-v6so12529805pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HHF6FLSHgN9FMxwBT7+K1PcnegjZXTDgC90CToQjQSU=;
        b=N3pp5vX7WD76T0V1R6d6pVQEsV8x72pZPPOUpzbdHBZODdC2CbC+LyejIILb6raVnc
         CyBizmctGb8R0dEcdv2II6P12Zba5VVYYT7C5WKwQKMHMb3QXo3xQp2bNvX2d0RPCYS/
         a9kWPaqXoKmZsIg/TdNV9DlrCWj3uJlI+DmP2O/JJo4eNUCTqy6M6IhddhzHfCbu9UYV
         2YzbRIYW4hFwttBEFtprIkAnBmI1In4XFhDrqCHYFPrY1eHDS/NQYEulN78ib2xiHwYp
         K156wlzrYKl12MWatjP0nxRwVadvK2dpEnL0q/bt00V55nquboqoieLnZH4+xcBb6Uqp
         A4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HHF6FLSHgN9FMxwBT7+K1PcnegjZXTDgC90CToQjQSU=;
        b=tdgfJdO2HL1Lct9BOqQ2Ha8g+Atuhgte92CwJgvOrNU/Id1w5tXLLPhC7gs6Vn0x7t
         uvZB76JU4yu/WY7sRN0ZWmyrk4F9RY3ZMExS8vGIbNI3GbA6zbawWJ5zJMzGQmMfnBFB
         f/WEBqRpmngP501CL80U0KjiTEj/U/lgDXS+hOh/Tsf8/zEC/Cf9vRVrMCGw4QP5Zm3X
         ahPGwNiizj6uH26x1BrLiadf5DwEBLsxP+6ls1fpVyLDDvNQcXUiDG0o9hxVwlBvOpIh
         QiMXyDrUyUFSbFhaX8fb9yPuR2CRK2wjZ6YKSkYGBiYvMoUvfZZ5rQt9bLcOeNbzLJ7H
         anhA==
X-Gm-Message-State: APzg51C9itAy+jFr2M6qtX90iJVm91PVCsh1FEPMg6aBB3y4BcKeXtG7
        4XJQRsxWsE+bm1fPd7tKr2kG7zZLos8=
X-Google-Smtp-Source: ANB0VdYsmU7hk8H0SYATxML4rHcecLa4Ii4fauk8Bs/Y/gWSK3Xw6nnGOFWVrbWWBvhvuBU00rBEYg==
X-Received: by 2002:a62:9f4c:: with SMTP id g73-v6mr30591185pfe.142.1536683757638;
        Tue, 11 Sep 2018 09:35:57 -0700 (PDT)
Received: from localhost.localdomain ([103.224.155.47])
        by smtp.googlemail.com with ESMTPSA id f87-v6sm51482627pfh.168.2018.09.11.09.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:35:56 -0700 (PDT)
From:   Jagdish Tirumala <t.jag587@gmail.com>
To:     tern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Jagdish Tirumala <t.jag587@gmail.com>
Subject: [PATCH] USB: STORAGE: ISD200 Fixed error space required in for loop
Date:   Tue, 11 Sep 2018 09:35:00 -0700
Message-Id: <20180911163500.2737-1-t.jag587@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed errors spaces required around the for loop '=' , ';' and '<'
in drivers/usb/storage/isd200.c

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/usb/storage/isd200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
index f5e4500d9970..2b474d60b4db 100644
--- a/drivers/usb/storage/isd200.c
+++ b/drivers/usb/storage/isd200.c
@@ -1153,7 +1153,7 @@ static int isd200_get_inquiry_data( struct us_data *us )
 				/* Fill in vendor identification fields */
 				src = (__be16 *)&id[ATA_ID_PROD];
 				dest = (__u16*)info->InquiryData.VendorId;
-				for (i=0;i<4;i++)
+				for (i = 0; i < 4; i++)
 					dest[i] = be16_to_cpu(src[i]);
 
 				src = (__be16 *)&id[ATA_ID_PROD + 8/2];
-- 
2.17.1


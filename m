Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93E0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E342173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrdcrDmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E342173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeHNJdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:33:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41390 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeHNJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:33:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id w19-v6so7951129ply.8;
        Mon, 13 Aug 2018 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bjXVpOfM4P9Glb181PtGGDdLiDZ8/PlBb2QNr7KtlZY=;
        b=LrdcrDmbpD3hlVGWndR23eSupH6xZNFQRXmzNhxEjE8UOPDcEFXel32ZLSWi2sVfdC
         ny9EJScel2fc8M3MZ70fac27Z1yxj+iL4ucC937yUvoNu7kRTR1JZ3yvm4tBNB7jrHy6
         G/uQylqzuo13ZDThYO7iardbucNhAqaLzOYvzUdU36MDxuS3CDOnz91JvG16ewLtR/Jw
         xT/z8ODwHucSVAoc/xVHDhJ7GRhKovd4umZ/LgpI3N2eVuC6ug43gKuBcqptO/BuCEJs
         51FbxCk92JmF2ToJf/EL3Yg9lj1vxpvWeTGE4RAaCPtBzCdgkLwbqz11cyEor9c9QGe9
         ZCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bjXVpOfM4P9Glb181PtGGDdLiDZ8/PlBb2QNr7KtlZY=;
        b=lrFY6d1mFRIVdAJcIGaz1qpUY+o0NXs4HfwGoB770Q0WCRGV/gNhHaJHis4+wom5AF
         PaEntUsZt9UfZM8DghTdS2MgMBFFkW0QX1pDeFbPqQM+V6kWKfBkrCsEmMksX4MgGd/v
         vbFR4Am9UfjmaJX5zt67S3x88yZKMyI4cn6Ifwys6NoTHpGpGJtkz9gdNCjKY71g659H
         pUFCalRjg1tzHVou0Ye5MPeUstPCgIdmXqduGizZHA75VByg4BbQn6raOmHf6KA4MwdV
         zTOw6dRljBrPsQiqcH2TIIu+wpAtPzkBcAJd9jZkKMPMpkByclEht10LqN/VK4rQPrsr
         CORg==
X-Gm-Message-State: AOUpUlEPAy/RtlzQUIn30FyzzUH+u52PQlDfcLdy9qINtorOTFKl3I2q
        YIm+/b0FCzyGLzgU6Xf8Opy0cQ9j
X-Google-Smtp-Source: AA+uWPzPbW8fuxDu1LJYX/uTNUGC1R8YhdG+cs0tUWN/t/bjVlfg/aqWzcyAyqOcJo9SGRpYVepEXA==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr19489373pla.60.1534229270966;
        Mon, 13 Aug 2018 23:47:50 -0700 (PDT)
Received: from localhost.localdomain ([58.173.153.121])
        by smtp.googlemail.com with ESMTPSA id c85-v6sm39660477pfd.110.2018.08.13.23.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 23:47:50 -0700 (PDT)
From:   Ian W MORRISON <ianwmorrison@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com
Cc:     Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] Use default .cfg file name for RTL8723BS devices with id of OBDA8723
Date:   Tue, 14 Aug 2018 16:47:42 +1000
Message-Id: <20180814064742.14519-1-ianwmorrison@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RTL8723BS devices the current config file name is a composite of
both the config name (rtl8723bs) and a postfix of the device-id.

Given the majority of RTL8723BS devices use a device-id of OBDA8723
this simplifies the config file name to use "rtl8723bs_config.bin"
as a default of for these devices.

Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 drivers/bluetooth/hci_h5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 8eede1197cd2..cce422dc1b8d 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -852,7 +852,9 @@ static int h5_btrtl_setup(struct h5 *h5)
 	bool flow_control;
 	int err;
 
-	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
+	btrtl_dev = strcmp("OBDA8723", h5->id) ?
+		btrtl_initialize(h5->hu->hdev, h5->id) :
+			btrtl_initialize(h5->hu->hdev, NULL);
 	if (IS_ERR(btrtl_dev))
 		return PTR_ERR(btrtl_dev);
 
-- 
2.17.1


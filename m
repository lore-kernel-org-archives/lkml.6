Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F19ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C704F20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiL7sO5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbeGXDji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:39:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43681 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbeGXDjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:39:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so1728600pgr.10;
        Mon, 23 Jul 2018 19:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mD3PWRCj5mqYnL5xweDska8i9nG++WfB/+0jxS2BtM4=;
        b=MiL7sO5yUKCET86mCBE8X6LZHilv//mYUyG4mCN0utgYPUoBLc+S6/97GgC6q8N017
         uJjK1SJtCcVIDSH2B0qRcxjVXl9St6t3U2a8UfdNYIPr3MIC7sL83iH2NNLQbr8ZYaRg
         oTQKsBWbPY9az+hEJblNLxDgaXQ318RdIru71M4VltSopVI1BeWCrpI2GTavDbRk6IBe
         GrguSs5zheXAJiYg45c2wp4ZeGzt4246WYILpPykcTVo2E6Z5w5DtnLwQ4fNm4Dd720u
         aPCzYd3HHKrtXfqQrDO/N8sJxp+qxiNYzTUJliNKrbCwih4suMOYjd4vO9d1JykLpU0b
         8rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mD3PWRCj5mqYnL5xweDska8i9nG++WfB/+0jxS2BtM4=;
        b=TWT9780Zmq5q3kORe2hCqbCCda2xev9Kvz0TqnyCYN8bY+C5yvG3nd1iX9INuuFMng
         ppdrfKAiGbQFKw4nQm4eTfkF6Y0N6VFbx3ic0E7U+3S5Jrs5uB/NzfkfdpeQstWv3eC5
         eFysVXskem7b2w8yJo/he5oj9MgA/D5ND45+9Z9doOwo0R0sMSt2dpOl/cMFyu/Wxmv7
         f7dhJayvHLzJ40n+tIj04f5V9JrqA/fsDRbg6+pgh+DyLCg5cOOvxL8oBuCKnD/+AYbF
         GXZ1Bh3iyKLMZoAMt2l1QIpung5zic0WAIm5auOEz+jOt1akvnih1UuRLhFZYNaudNbO
         zA/w==
X-Gm-Message-State: AOUpUlG/0KA4uFJnJr62hJnVL4AcKDdUe8kQjcgHrIsQA062v22ZLiiv
        cuuooXYejNm0MzWSCwF5Mdc=
X-Google-Smtp-Source: AAOMgpfm27HrkBpyRGJgPJsP3IPvwK3zGUAEwGM9YEasPn1y1E8lfyhXsVbjEA4kWp9/Az979iVmrg==
X-Received: by 2002:a63:d155:: with SMTP id c21-v6mr2826065pgj.188.1532399726940;
        Mon, 23 Jul 2018 19:35:26 -0700 (PDT)
Received: from penguin.lxd ([146.74.94.74])
        by smtp.gmail.com with ESMTPSA id n9-v6sm20540942pfg.21.2018.07.23.19.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:35:25 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 3/5] Input: pxrc - move module device table closer to where it is used
Date:   Tue, 24 Jul 2018 02:35:18 +0000
Message-Id: <20180724023520.2189-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the device table first in the file.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 1560f0e39c34..327b5ef8515f 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -19,12 +19,6 @@
 #define PXRC_VENDOR_ID	(0x1781)
 #define PXRC_PRODUCT_ID	(0x0898)
 
-static const struct usb_device_id pxrc_table[] = {
-	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
-	{ }
-};
-MODULE_DEVICE_TABLE(usb, pxrc_table);
-
 struct pxrc {
 	struct input_dev	*input;
 	struct usb_interface	*intf;
@@ -277,6 +271,12 @@ static int pxrc_reset_resume(struct usb_interface *intf)
 	return pxrc_resume(intf);
 }
 
+static const struct usb_device_id pxrc_table[] = {
+	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, pxrc_table);
+
 static struct usb_driver pxrc_driver = {
 	.name =		"pxrc",
 	.probe =	pxrc_probe,
-- 
2.11.0


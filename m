Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B517ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F8920890
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwHZ3GH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F8920890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeGNNMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:12:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43892 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbeGNNMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:12:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so1048706edt.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=10xLzur+h2IUgASTTUNhq1G9XRFXxU3sWi19EEyY8NE=;
        b=UwHZ3GH+JhxDxF6w0FvPL7coKhVhYK3Z2JiX/eZDSnLi/FwjMBhP/jaPiN5JhPh+gH
         5xi/M7StPtkAslj+AWOaGOOu5uISVwuiQn8EUb5NS9RbK7d4jbuVD2dkxVK9tXaCSCPF
         kKZev0W+4ng2qDCJhGF6q/uejtDaQMhbexKmk6qRUnneYjURI0XrRu7WEZVfCH+M6fnd
         HNbJ0AeqNs3KkcsUQ2oxqgAma5hXR2uEiCw14jrvcwGIUpRmgiDzQ4rOMEgOXcsXXYoa
         kR4MjmOxTbMyGAlYeR7zOb9lsHq6axrT5OuO6yvQDMGjDiMm5DWfZ4HjXAx1QHWedvt3
         LBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=10xLzur+h2IUgASTTUNhq1G9XRFXxU3sWi19EEyY8NE=;
        b=rGU8wMKYDimaKrlcj5JKOWJ2pf9ss7mS32wbq9UiCpabBa7dYjn0LU7CQ7WhvbCYFj
         DIjk7yRcctD2Vxr81dr44i3g3EBqpcFzbwFIx4nABbZ5CRNoTY0PM5sayOyTeyTzNnjG
         FSdlogfH/dGaSGlhqvdZHD8ahh6E50L4gSKEKEVFZRY/x3EDX66lzx+8yjF1XcKnSScd
         I0x8Oi7l/WzA4sO7i8zxxtKo7nMM9mcJR5cMRjM4fokYaMcNiMxruwR7aHt0Njis/1kd
         kf1w6v+xvJIMFy5D6b7I+D/m62EhjmkFDF5eBa7qGkFdWvZk82FmBP+qfldti0KAUCTO
         5WKA==
X-Gm-Message-State: AOUpUlGNqhopZm6E/BvrzAfdgAxCRXbDkZRb+9j03I46UEnsMmQzQY+g
        1PyfD9+K8GwSBLWxtOAWfwY=
X-Google-Smtp-Source: AAOMgpfIyt4w4XlqIDFFp1JEXSbSa9eTzYNNPagmuAU6hCPXU+0OlunoqWxZ3xvjGaYUrXrJJN0Gqg==
X-Received: by 2002:a50:f577:: with SMTP id w52-v6mr10981425edm.230.1531572792438;
        Sat, 14 Jul 2018 05:53:12 -0700 (PDT)
Received: from arch.localdomain (x4db2bd54.dyn.telefonica.de. [77.178.189.84])
        by smtp.gmail.com with ESMTPSA id n10-v6sm16577396edr.59.2018.07.14.05.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 05:53:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: rtl8188eu: add spaces around '+'
Date:   Sat, 14 Jul 2018 14:52:40 +0200
Message-Id: <20180714125241.15509-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714125241.15509-1-straube.linux@gmail.com>
References: <20180714125241.15509-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' to follow kernel coding style.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 93d20bc758e7..b19aa26d1705 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -59,18 +59,18 @@ void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
 
 		if (write) {
 			/*  Enable LDO 2.5V before read/write action */
-			tempval = usb_read8(pAdapter, EFUSE_TEST+3);
+			tempval = usb_read8(pAdapter, EFUSE_TEST + 3);
 			tempval &= 0x0F;
 			tempval |= (VOLTAGE_V25 << 4);
-			usb_write8(pAdapter, EFUSE_TEST+3, (tempval | 0x80));
+			usb_write8(pAdapter, EFUSE_TEST + 3, (tempval | 0x80));
 		}
 	} else {
 		usb_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
 
 		if (write) {
 			/*  Disable LDO 2.5V after read/write action */
-			tempval = usb_read8(pAdapter, EFUSE_TEST+3);
-			usb_write8(pAdapter, EFUSE_TEST+3, (tempval & 0x7F));
+			tempval = usb_read8(pAdapter, EFUSE_TEST + 3);
+			usb_write8(pAdapter, EFUSE_TEST + 3, (tempval & 0x7F));
 		}
 	}
 }
-- 
2.18.0


Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F885C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC57B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDX+e5j/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfBSTaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:30:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfBSTaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:30:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so10606975pgd.1;
        Tue, 19 Feb 2019 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uvj7RqVVPMq95VowXE34LorbZJE+X6J7oIbmcbxIkKY=;
        b=QDX+e5j/WGROiA+N6Ma5KeUkEAjbLhukykU0gHld4alhkyyeu/H/W2sb8yi40ePAp4
         sjsf/LByMab+5MzVr4O5TlphXvNcTiLF44kBXRIX63PCRVU41aH9ktNsNrd9ga0NLFrF
         C5Uu5xHhauVZgcwIJLuvCtgoFZi+XY34PZcyszY6/YYSHdPsbbFyq9q5MXteBCH9y2v1
         XRp04mwol5ddcb83750BeR87guIR1uUDrODmYjrDVaI02j2ZyKG6SmLYgJhz4eLFuoUt
         Rlkl6VC7okC3dgfqhBh6sniuNGKzXZ2CJ+J30O4tfQJatyFC2bE8jCYPqKLCAt3jj3Tk
         E5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uvj7RqVVPMq95VowXE34LorbZJE+X6J7oIbmcbxIkKY=;
        b=CWOMGs5ck0qiU2E8p30IlH23zS28YFqCaWiyjnZZoWp26vxYLnt0vHKCOTK8jK060Q
         GHSAMrpKhyg+vikGOgk6HxjWVC1oiRetuk0oZbXA/jJWuP/BLJnUCPaBJYBSsH40n8ox
         1ZnuV5cPW1WjnvbUHOXWcDS3V7NYJIoG2Lk0ygNxRPd1EABhRfMY3qJwUkj0+MJ5Pgj9
         i2/VsbxFr3SDIJjDf9csVDgj7kT51xqZjqFSry1PS5sGwvPleI65jtUjJt+/fNAcTeVv
         FAE1IdWmbnU+fzhIZiRlgCLrS+WK+lMKw9xpL0iXYEX9Efw61if3KIkHmSkQeKyiShDY
         9RdQ==
X-Gm-Message-State: AHQUAuZz7jZiIY+WlRAFfeyUztublsMUfHldV7YaKN2p+6eGqeDoh+8r
        5YTp4Gsnmk0EoFDljggbt0Q=
X-Google-Smtp-Source: AHgI3IYexCgWjEQwRynNGiuYJrJQsya9RgSs6CmttiClON/J1NjiaMphhDtRG+EatmrNG0cOXTVYcA==
X-Received: by 2002:a63:575d:: with SMTP id h29mr10777999pgm.442.1550604654030;
        Tue, 19 Feb 2019 11:30:54 -0800 (PST)
Received: from abbey.corp.xevo.com (hq.xevo.com. [4.14.243.50])
        by smtp.gmail.com with ESMTPSA id i8sm29375202pgo.19.2019.02.19.11.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:30:53 -0800 (PST)
From:   Jim Broadus <jbroadus@gmail.com>
To:     ckeepax@opensource.cirrus.com, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client device.
Date:   Tue, 19 Feb 2019 11:30:27 -0800
Message-Id: <20190219193027.13882-1-jbroadus@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous change allowed I2C client devices to discover new IRQs upon
reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
assigned in i2c_new_device, that information is lost.

For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
client device structures are initialized during an ACPI walk. After
removing the i2c_hid device, modprobe fails.

This change caches the initial IRQ value in i2c_new_device and then resets
the client device IRQ to the initial value in i2c_device_remove.

Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
Signed-off-by: Jim Broadus <jbroadus@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 9 +++++----
 include/linux/i2c.h         | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..af87a16ac3a5 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -430,7 +430,7 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-	client->irq = 0;
+	client->irq = client->init_irq;
 
 	return status;
 }
@@ -741,10 +741,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->flags = info->flags;
 	client->addr = info->addr;
 
-	client->irq = info->irq;
-	if (!client->irq)
-		client->irq = i2c_dev_irq_from_resources(info->resources,
+	client->init_irq = info->irq;
+	if (!client->init_irq)
+		client->init_irq = i2c_dev_irq_from_resources(info->resources,
 							 info->num_resources);
+	client->irq = client->init_irq;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..7e748648c7d3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -333,6 +333,7 @@ struct i2c_client {
 	char name[I2C_NAME_SIZE];
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct device dev;		/* the device structure		*/
+	int init_irq;			/* irq set at initialization	*/
 	int irq;			/* irq issued by device		*/
 	struct list_head detected;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-- 
2.20.1


Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B087C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B994218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kVEMJZR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfBMNn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:43:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37458 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391141AbfBMNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:43:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so2450845wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rD/Z65OnYoppq/ikSxqUpjeEOremUITKG7uIaduTeV4=;
        b=kVEMJZR8tdqV14sKwFhzyvImqWJNMq3T9kBsQQsaepO5o/I9ZGRX2UuyIRjZyXt/SK
         KTSS/jOXrXkxgFsuOIFXhdLa3iLP+QkyUhNt3GhVyvRB49eDu8GAmkoB8XPeWn9U85CX
         O1zZ0P/+ZBQCUV7Po5DhrrRLpNE3mBf64qSg9BA7oVmVJE3X1dCte7KLks3Mwd39Ys3n
         zRGH2teO6Q8WfOcw50tADm8FubZAvfPEz0aemlPTHcNY5DgvlMcwwmp+fGr/FQAkq7v+
         ZrM0WufqK7RLbDcTLdz1TQvT7qZpLKxdcRkjybhiNrXtHqfET8gnTGhdN7a24+/gz1ZD
         ifgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rD/Z65OnYoppq/ikSxqUpjeEOremUITKG7uIaduTeV4=;
        b=Tqcx0WJKFoUehHghJQd56vMNRdr1xnscY3U8Y3ZnMT4EPOJFDQK7MPl2PQEhBlbcIe
         Um6mXDKqJa57ckIFWVC3Pv2MDEDMR1iPcYRHypy34qtILkJlFmMvH7Axkkj2duvv2bVe
         UNTl4ENfwrvL3SUaaybYn49FvdyG5VSNIHvuvrW7LNlvqFtUTAY30iycsz5jVpyi1H8m
         kqvuQw0prsuDzMx+JPY7rkX+nuW9YFp4PHTFzrAscWURqbo5sEx6fXTITsokTIKPKim9
         lEht12kno9dOtWPM/7fnC/sYmvatD/E5AqknMTSSFhfpmcfW7c5OhLbxXUiSvPmOAwsQ
         lhYA==
X-Gm-Message-State: AHQUAubzCeOm0CdvwWl/6ebF0GnpZbbNv1ccZ6mOgY89851cD4Dy6/4X
        Ya0ukMGarkyoJujX7olhNP0iXg==
X-Google-Smtp-Source: AHgI3IYAU8IuXWgYNtLGd62E5KTPoaGgHZS/AIqE/P1IPOU23pBVNL9R6qg0pl/RpVt8GRUbWko8Bw==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr344002wmj.147.1550065436067;
        Wed, 13 Feb 2019 05:43:56 -0800 (PST)
Received: from debian-brgl.home (amontpellier-652-1-54-116.w109-210.abo.wanadoo.fr. [109.210.45.116])
        by smtp.gmail.com with ESMTPSA id e7sm2046720wrw.35.2019.02.13.05.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:43:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 05/11] mfd: core: document mfd_add_devices()
Date:   Wed, 13 Feb 2019 14:43:29 +0100
Message-Id: <20190213134335.10838-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213134335.10838-1-brgl@bgdev.pl>
References: <20190213134335.10838-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a kernel doc for mfd_add_devices().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mfd/mfd-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..0898a8db1747 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -269,6 +269,20 @@ static int mfd_add_device(struct device *parent, int id,
 	return ret;
 }
 
+/**
+ * mfd_add_devices - register a set of child devices
+ *
+ * @parent: Parent device for all sub-nodes.
+ * @id: Platform device id. If >= 0, each sub-device will have its cell_id
+ *      added to this number and use it as the platform device id.
+ * @cells: Array of mfd cells describing sub-devices.
+ * @n_devs: Number of sub-devices to register.
+ * @mem_base: Parent register range resource for sub-devices.
+ * @irq_base: Base of the range of virtual interrupt numbers allocated for
+ *            this MFD device. Unused if @domain is specified.
+ * @domain: Interrupt domain used to create mappings for HW interrupt numbers
+ *          specificed in sub-devices' IRQ resources.
+ */
 int mfd_add_devices(struct device *parent, int id,
 		    const struct mfd_cell *cells, int n_devs,
 		    struct resource *mem_base,
-- 
2.20.1


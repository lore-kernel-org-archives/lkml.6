Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C378DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2A82229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gTCgFho7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439139AbfBNOBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:01:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438978AbfBNOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:00:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so6577877wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rD/Z65OnYoppq/ikSxqUpjeEOremUITKG7uIaduTeV4=;
        b=gTCgFho7zo/veyoui1W9bvplodyAUd1b04B19jU298EYa2SsV4BWgz/23WmBUvOvAi
         fwgRsJffRaRxJYjwgSwV6H3hCzMwjbGsU94koPJxPNIOefHQ2LL52Rgdb7AtilKWqmW0
         ZitUDRL8A6rd+6ozFB6LlPD5SHPYFiuKw5w1nx3M5JDSq7OlJi7WVeHyb0xMsBFFmK04
         lfwPJY1kez09+1URhoWJS/I4moaijbPeJi9i39zZu7s4orN9qOQeqdO2svcETnuauFxn
         pwgWfQrJDrD4XmQ+nN2UY9tzlxKeztzA99wYnSzT9+fKBePxhAv8ObJwBSOPwB5HRheX
         bMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rD/Z65OnYoppq/ikSxqUpjeEOremUITKG7uIaduTeV4=;
        b=f1TawFMOTQEPatne1NKScMspBDpkqJ1ND7sLzX1BO9Q7WqUuKUExwOij4sKonJSi2G
         E93Oz+EzzAEsHBh3np85B6KJXW3RHMeRvf8wRJESIPihnSjkqg49hSsXn4mtSWMdPZzK
         F8fuEf9Hu/KfoUvE7PP/warhNfW279/uTKCxVyrr5tamqhrsuaGMy64n/AiMmzdgEbea
         FKLx+nSwD5W26rhfYZI6yAEmifHFqIo0hppTIz/gvxHfURw+zp5trvieGetbqDTgiC46
         BpIkgVW+G2aOgQxgcTYKTnpMnWmkS8+85t1IQrGnCQEB0P8BdVLTUTKgK53SdqnWkz7+
         tjDg==
X-Gm-Message-State: AHQUAuZVfifxI+g2Cj2aKeT8P3zug063+GVHGNckbaxpAI61Q68u6xUK
        v95DnK9TC1SFNtc3XozTlItjEw==
X-Google-Smtp-Source: AHgI3IYccfpg672+aKnS7Pnxwnja+i8dtvQUAyVPxCFJsa/p/QIqpaWlODJf+ZkYv4XEGSU3KJvuQg==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr3087778wru.127.1550152843984;
        Thu, 14 Feb 2019 06:00:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h142sm3395677wme.33.2019.02.14.06.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:00:43 -0800 (PST)
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
Subject: [PATCH v6 05/11] mfd: core: document mfd_add_devices()
Date:   Thu, 14 Feb 2019 15:00:16 +0100
Message-Id: <20190214140022.19201-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214140022.19201-1-brgl@bgdev.pl>
References: <20190214140022.19201-1-brgl@bgdev.pl>
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


Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E80AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229AC218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O8/RUD7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfAaNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:39:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33577 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387634AbfAaNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id p7so3380951wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8H9cxuoVpV+o/EPh2jcV/8Q1lf7tmeXG7dsABKpPJQ=;
        b=O8/RUD7KsWSq63NEF7YF4QVRbxNAAYhzJ9MInh1aFoEeR9KnKjgSNjDsUp2a8jCF3c
         Mpat2znwaoI8ALGlLxC06g95aRfuPjSupU7kY5wpSyKtJ8Qs7HHu+9ZV6f/Qg/+1QTkD
         Z0swP/zvqkMEE3Lqx/NA/mwt4PMEvZUdc/FcOl6UJKY6/5KfOs4A/2dI/jfcuVtQ3O1L
         FOmD1XE8pRQac+zl8ck96qwIni9ju5G0J9C6nWS6hXvm7tKOsFLykK2HCIAYnX4VX0SO
         0VYqhM5Hj3UUZLB/j1QoSAn51uzsmYeRLrVUE/4bUPMXpxZ4JeyRMb8x8hUHke46Fvsm
         ZW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8H9cxuoVpV+o/EPh2jcV/8Q1lf7tmeXG7dsABKpPJQ=;
        b=KTfDRGoHjIBUT/4m8jjzrbToBNnYuLJTaDsHaPCmU87hcEygIXvin/HeNfFLFFmbrH
         1fxL3Yl+fUplxCKd5qYeVspyiis+UDcOvuVqeWnjRpMuNZQHXlqmyiQYKywII/CGzn/a
         j5V+D2QjnGBxTVyVwkVH+/qwx3zpiLJedqD1OdrtD98Q2CXUrk0dM1g0hzThOVaKYqkS
         0atClwo7mOv9nQRN73y02nzORGfr/G23zvfexJaQzTf8gcx7xcced9NAqxrxbByGxd4G
         k/O8bIpNigCaxYFgz73mZmz+z+DFjtkNNoYb9dW9EucWdW0wJvj1uUuvXdxC2oQdPK3d
         Qt6Q==
X-Gm-Message-State: AJcUukdsLyzMTA7nPUrQBa7gBuFGtUFlMlHwJKsEINA9X2nhXib6kJKX
        y+BqBlQ411vg5BrEfl18RVVtLA==
X-Google-Smtp-Source: ALg8bN5VrZ8UZaJpfQfNa4qk9A8vu/HqtkTiKWAu3qNrzR7nrldhvcUyLZI1TKuQUO8unm5xrsumkg==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr33449692wrv.202.1548941992672;
        Thu, 31 Jan 2019 05:39:52 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/35] ARM: davinci: aintc: drop GPL license boilerplate
Date:   Thu, 31 Jan 2019 14:39:02 +0100
Message-Id: <20190131133928.17985-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Replace the GPLv2 or later license boilerplate with an SPDX identifier.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2b8b653aeb98..b908b4903b9a 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -1,23 +1,9 @@
-/*
- * Interrupt handler for DaVinci boards.
- *
- * Copyright (C) 2006 Texas Instruments.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Copyright (C) 2006, 2019 Texas Instruments.
+//
+// Interrupt handler for DaVinci boards.
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-- 
2.20.1


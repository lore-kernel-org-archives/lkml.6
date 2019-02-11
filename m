Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA38C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BFVLyWtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfBKM0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53473 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfBKM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so17498035wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=BFVLyWtEcq3eYr+UveOpnwt303iKNYCSo0ye2M7eD7Yq1k8CGzjLZhHDhVurnWT22/
         UOFx8iul2pzQWy8e0R4O/gYu+YlAqKoNgvBHDA+US0tCk6sVfC71J5O03Qztv37b/iMN
         mQYCqXTStM9DKBTrUmZGEgLsBbZF9wwUXseXWKvqAzyJtpCVRj/enIJczCUINHShdC32
         hvgqjB17gJzdMpVORlyehifzHJci24srzGIM6Q6Ew80v9BanmdfzK6GQ1eeASSWi8o9q
         K0CMjuOMG8XZosP3FXc+pxGj4AvgC6I6Vp9bwmgseQEDTPIzOXkz7l3jWRxZduVi0fJd
         LG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=FXPLDtcK5Ge/CRMio1SocrQ6ab8mfuP9sgPM80n4v3lIxT0HJ35xTzsYY5XYQQICXH
         wD/rLxs27FTWh038iWv+fAlkGITaf9CX4mbqgYS8HbhySj9cBYtn1rLWF+OUqmVlo4w+
         ICZhaooo/1Uzy1v2l/W3RCwGb18kM3QaJIDMwbwNcHxUNxdpYEzXmn4vcVS9zqqRLtQP
         O5BrlQq7R8duH4PhMFBy8S/cRJCvROpJs+C0fvs0+4LNwK2u7GD8BRckIaD4q7Sl/iES
         r8gmGfNUN5CE4jEoZ3L1sDR4/voumgoK7+aO3lR4O+zWnMcL1k6gfP7ZfCRSk44QLgHK
         JFuA==
X-Gm-Message-State: AHQUAuZMJSixrw3/yZElmqo1jF6Uy4HB0jMOxVx3YNcs95A/v0ItYAjr
        aXph5wYGI1kgxB4L27hLwmOX5g==
X-Google-Smtp-Source: AHgI3IblV/DCRQY/D7Xl++V8bobEnOVNtH+5cIads6wnGJzdT2I4A8o4xQeOWLInrKHGvdc2hXMNzw==
X-Received: by 2002:a1c:7a18:: with SMTP id v24mr8767751wmc.107.1549887974861;
        Mon, 11 Feb 2019 04:26:14 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 01/33] ARM: davinci: remove intc_host_map from davinci_soc_info struct
Date:   Mon, 11 Feb 2019 13:25:34 +0100
Message-Id: <20190211122606.8662-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The intc_host_map field in struct davinci_soc_info is not used by any
board. Remove it as part of the interrupt support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 5 -----
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 94085d21018e..67805ca74ff8 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -117,7 +117,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	u32 *host_map		= davinci_soc_info.intc_host_map;
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
@@ -182,10 +181,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
 	}
 
-	if (host_map)
-		for (i = 0; host_map[i] != -1; i++)
-			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
-
 	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b577e13a9c23..944afd57ee38 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -61,7 +61,6 @@ struct davinci_soc_info {
 	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
-	u32				*intc_host_map;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1


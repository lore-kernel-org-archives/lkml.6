Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,TVD_PH_SUBJ_META1,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCCBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5D21773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbc0+ghJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404027AbfBKPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:19:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34922 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403765AbfBKPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:18:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so780827wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/luPbIaWn/o1jbjpJm684Y9h7+/FjogTtlIIBk0uBg=;
        b=mbc0+ghJykD0+MQpVOqrQJJL4mBl/lxjvuf+QI4VGe7Fa4oCvIDq7RXL0zWXc7Q875
         JqAhaWeAZqNTS1EbGdFS9HApEGdvpuczVnbcvdgZePLGI6Pnkr0vF4jlBdKeXAxvMc0t
         4d+VJG9BDwWamVoLCXk7nk9L47ptagWUjB/7dRrNwKhWvLmfrCc7ir6QliF7pS/3yQsq
         2uqUjAId6VKR+0blZgZgAo+a216P52IB5QLM3sPKMctpHi3AOb7UUyxmMpbcSDtrHs1A
         fMDfw2tXoSot3oNvc7yWmIXx6vjspPgv3LhYuSmMlCzzFdO562MOl8WiHFAAd5OJMJGt
         zorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/luPbIaWn/o1jbjpJm684Y9h7+/FjogTtlIIBk0uBg=;
        b=UUvFkk+R0JwmclFNHVbIzpZO9kXsBx7nRAR1/lREYNo/R3cZjOf0YhC8Z4VdVA0wNI
         sLj4X4xYp79YLI8eCQ/2u1ELRRJm69WlFPn8MhHiVFRApl0DiGv6z6iNV7mtZGE7Ycip
         wpBEpVrlJRO0Ldthtx237kA3n4H3VlpUCpCJZoMnJJ3P3f+s392C9tcGUJtYWfKkvvHB
         SSyofzAK5F2uYcgE0Lu/SX7JIyIYw6TKRAK8lBqpkkeQHBGeytfyKm6qr7ShTrpxwj/u
         9s4N2+T+Y3PRNnRvhvy8HIU/6ptRno8L3mKXxswCtCsAqB6SnibqAAWACSCQsVQRD3YY
         /fxw==
X-Gm-Message-State: AHQUAuaTU46RggM7HW+7hDA5cJRWvIVy1tsOTLQHk8Y25VFNCc7BvXJG
        MjT8Z0PTF/OGEgfNjhWOG/U=
X-Google-Smtp-Source: AHgI3IYSQ5bGu3qQaFbvwMOH+DwZFw5238T6Ue9ZUTQG5p8slxKXPLBe2KHkrWvvNeJYZbyWhfWMiw==
X-Received: by 2002:adf:e747:: with SMTP id c7mr5579259wrn.176.1549898335056;
        Mon, 11 Feb 2019 07:18:55 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c186sm12531380wmf.34.2019.02.11.07.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:18:54 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v4 15/15] Update MAINTAINERS and CREDITS with habanalabs info
Date:   Mon, 11 Feb 2019 17:17:51 +0200
Message-Id: <20190211151751.12336-16-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211151751.12336-1-oded.gabbay@gmail.com>
References: <20190211151751.12336-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The habanalabs driver was written from scratch from the very first days
of Habana and is maintained by Oded Gabbay.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 CREDITS     | 2 +-
 MAINTAINERS | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index e818eb6a3e71..03f3d67126fc 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1222,7 +1222,7 @@ S: Brazil
 
 N: Oded Gabbay
 E: oded.gabbay@gmail.com
-D: AMD KFD maintainer
+D: HabanaLabs and AMD KFD maintainer
 S: 12 Shraga Raphaeli
 S: Petah-Tikva, 4906418
 S: Israel
diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..ac6fde220d2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6647,6 +6647,15 @@ F:	drivers/clocksource/h8300_*.c
 F:	drivers/clk/h8300/
 F:	drivers/irqchip/irq-renesas-h8*.c
 
+HABANALABS PCI DRIVER
+M:	Oded Gabbay <oded.gabbay@gmail.com>
+T:	git https://github.com/HabanaAI/linux.git
+S:	Supported
+F:	drivers/misc/habanalabs/
+F:	include/uapi/misc/habanalabs.h
+F:	Documentation/ABI/testing/sysfs-driver-habanalabs
+F:	Documentation/ABI/testing/debugfs-driver-habanalabs
+
 HACKRF MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
2.17.1


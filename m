Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D866C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FE820871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FE820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbeKLMVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:21:50 -0500
Received: from shell.v3.sk ([90.176.6.54]:59291 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKLMVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:21:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3EDA2C6A0B;
        Mon, 12 Nov 2018 03:30:50 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YX5s3QT3MCVv; Mon, 12 Nov 2018 03:30:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 22911C6A12;
        Mon, 12 Nov 2018 03:30:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id exjVzHChiXt0; Mon, 12 Nov 2018 03:30:36 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 994D4C6A0A;
        Mon, 12 Nov 2018 03:30:35 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 4/6] Input: olpc_apsp: drop CONFIG_OLPC dependency
Date:   Mon, 12 Nov 2018 03:30:27 +0100
Message-Id: <20181112023029.648408-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
References: <20181112023029.648408-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_OLPC is specific to the x86 platform code, while the driver is for
an ARM-based laptop.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/input/serio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index d90d9f1098ff..c9c7224d5ae0 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -254,7 +254,6 @@ config SERIO_APBPS2
=20
 config SERIO_OLPC_APSP
 	tristate "OLPC AP-SP input support"
-	depends on OLPC || COMPILE_TEST
 	help
 	  Say Y here if you want support for the keyboard and touchpad included
 	  in the OLPC XO-1.75 and XO-4 laptops.
--=20
2.19.1


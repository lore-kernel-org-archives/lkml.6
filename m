Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CABEC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A4C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A4C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJPRRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:17:44 -0400
Received: from mail1.skidata.com ([91.230.2.99]:21989 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPRRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:17:43 -0400
X-IronPort-AV: E=Sophos;i="5.54,388,1534802400"; 
   d="scan'208";a="12887976"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 3/7] dt-bindings: input: touchscreen: sx8654: add compatible models
Date:   Tue, 16 Oct 2018 11:16:49 +0200
Message-ID: <20181016091653.26896-4-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181016091653.26896-1-richard.leitner@skidata.com>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the sx865[456] share the same datasheet and differ only in the
presence of a "capacitive proximity detection circuit" and a "haptics
motor driver for LRA/ERM" add them to the compatbiles. As the driver
doesn't implement these features it should be no problem.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
index ca521d8f7d65..a538678424dd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
@@ -1,7 +1,10 @@
 * Semtech SX8654 I2C Touchscreen Controller
 
 Required properties:
-- compatible: must be "semtech,sx8654"
+- compatible: must be one of the following, depending on the model:
+	"semtech,sx8654"
+	"semtech,sx8655"
+	"semtech,sx8656"
 - reg: i2c slave address
 - interrupts: touch controller interrupt
 
-- 
2.11.0


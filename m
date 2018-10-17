Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B63AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592492150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592492150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJRAEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:04:41 -0400
Received: from mail1.skidata.com ([91.230.2.99]:30724 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRAEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:04:41 -0400
X-IronPort-AV: E=Sophos;i="5.54,393,1534802400"; 
   d="scan'208";a="12919554"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 3/8] dt-bindings: input: touchscreen: sx8654: add compatible models
Date:   Wed, 17 Oct 2018 14:51:11 +0200
Message-ID: <20181017125116.20077-4-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
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


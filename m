Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21832C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA3F206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZR+KYUbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfAIJLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48260 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbfAIJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:11:31 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x099BPP7055470;
        Wed, 9 Jan 2019 03:11:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547025085;
        bh=T95Y86NyeBidhSBq6WO8eyGDoXfesh1J731lMD15qnk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZR+KYUbQnR+P5Ee0UW0OzYmmpzlL/kGEyGKg/iLDdfx+jxzhs3Euwpm4udTrY5S3e
         7Vp8zc0shlY2D5ZKkH1s1wGM1ASmy86XCNY7qec21GWEWSA3kG9T5/YGjGpLSSbQn7
         M0d8YDXzj1/Kawok/kVA2rZ9G2eYI0zPw/Lx4a9Q=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x099BP3O013404
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 03:11:25 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 03:11:25 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 03:11:25 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x099BFBQ017497;
        Wed, 9 Jan 2019 03:11:22 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: serial: omap_serial: add clocks entry
Date:   Wed, 9 Jan 2019 14:42:05 +0530
Message-ID: <20190109091206.25759-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109091206.25759-1-vigneshr@ti.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document clocks property used to pass phandle to functional clk.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/serial/omap_serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index c35d5ece1156..0a9b5444f4e6 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -22,6 +22,8 @@ Optional properties:
 - dma-names : "rx" for receive channel, "tx" for transmit channel.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
 - rs485-rts-active-high: drive RTS high when sending (default is low).
+- clocks: phandle to the functional clock as per
+  Documentation/devicetree/bindings/clock/clock-bindings.txt
 
 Example:
 
-- 
2.20.1


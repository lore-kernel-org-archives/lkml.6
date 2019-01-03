Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D2EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C19217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cYPPBzg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfACOEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:04:11 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56336 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbfACOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:04:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x03E411M105836;
        Thu, 3 Jan 2019 08:04:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546524241;
        bh=G1VelCFHk487LDZk3rSTti0A+x1tj4BJ75Uu/m/XSgE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cYPPBzg6oTPn15k/pwUcvZa9ZQ2IN7P5twUmFe3t0LCeDfEojufiVjaRkaz6ds1aX
         tjh+NxoesRNtdqxZt6VF2wITA5iDW749Nvhfszj6DBM15Q244nRR/Ua7StPVgtAWzv
         YiVKZpJnrr+vFwqfGVKhTNjFWQJtPOXg5bWt3l4g=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x03E40OD020771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jan 2019 08:04:00 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 3
 Jan 2019 08:04:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 3 Jan 2019 08:04:00 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x03E3rlO021111;
        Thu, 3 Jan 2019 08:03:58 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] bindings: sound: davinci-mcasp: Document GPIO support
Date:   Thu, 3 Jan 2019 16:05:51 +0200
Message-ID: <20190103140552.29809-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103140552.29809-1-peter.ujfalusi@ti.com>
References: <20190103140552.29809-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

McASP pins can be used as GPIO, add optional section to enable GPIO support
for McASP.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index b279b6072bd5..a58f79f5345c 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -45,6 +45,23 @@ Optional properties:
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
 
+Optional GPIO support:
+If any McASP pin need to be used as GPIO then the McASP node must have:
+...
+  gpio-controller
+  #gpio-cells = <2>;
+...
+
+When requesting a GPIO, the first parameter is the PIN index in McASP_P*
+registers.
+For example to request the AXR2 pin of mcasp8:
+function-gpios = <&mcasp8 2 0>;
+
+Or to request the ACLKR pin of mcasp8:
+function-gpios = <&mcasp8 29 0>;
+
+For generic gpio information, please refer to bindings/gpio/gpio.txt
+
 Example:
 
 mcasp0: mcasp0@1d00000 {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


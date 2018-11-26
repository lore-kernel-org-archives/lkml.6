Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9640C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB852084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RCEIAfgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB852084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeKZLJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:09:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52656 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeKZLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:08:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ0FZMH098864;
        Sun, 25 Nov 2018 18:15:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543191335;
        bh=wibd5CRYV6Uj19ty14uDoJlKqN1IRqXWZd8ylDb1+V4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RCEIAfgF5vWNUMe16/Cp1JqCN/Szp8n64wH7HfAKH2CfkDVrbGGYbZCL63WF2pReq
         5afETDDCIgsPcwBFEnAEeop22FtHQ1ox3wE18uQpVuDXgEFOG+a15Oi5QVc/oOkllE
         Ohnd4uGEeT+sea2Oyy/Rreakm+GTfNhZNzxemr/I=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ0FZk0126565
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 18:15:35 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 18:15:35 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 18:15:35 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ0FZtZ005271;
        Sun, 25 Nov 2018 18:15:35 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAQ0FYU04370;
        Sun, 25 Nov 2018 18:15:34 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 09/10] dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
Date:   Sun, 25 Nov 2018 18:15:30 -0600
Message-ID: <20181126001531.12974-10-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
deprecate cpsw-phy-sel bindings.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt b/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
index 764c0c7..5d76f99 100644
--- a/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
+++ b/Documentation/devicetree/bindings/net/cpsw-phy-sel.txt
@@ -1,4 +1,4 @@
-TI CPSW Phy mode Selection Device Tree Bindings
+TI CPSW Phy mode Selection Device Tree Bindings (DEPRECATED)
 -----------------------------------------------
 
 Required properties:
-- 
2.10.5


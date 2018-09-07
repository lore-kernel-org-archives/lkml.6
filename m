Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0309FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C2D2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="D7Jqrwot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C2D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeIGFhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:37:54 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:57572 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbeIGFhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:37:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ED1658364D;
        Fri,  7 Sep 2018 12:59:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1536281978;
        bh=Et5dUGRmuIpZlkKoZYfqWaBWdH6VsTUQD15gZ9nIg5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D7JqrwotDuoa7KklXD6as3E7o3MBlz6keC5ESGBpnsBOVEiLYOcDLACa4POeL6m5S
         hVpLsWUEk16JRY5W/DaxdjDx2BSwXHN5gpP8ED7HRr9RILAM440XYEKLADXZ71+4XP
         1wdiXUosDHbN8sFSfCanxQh7lH8yYQAAY03dJ3/4=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b91cd7a0001>; Fri, 07 Sep 2018 12:59:38 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id A146513EF5B;
        Fri,  7 Sep 2018 12:59:41 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 6C6D81E1DDB; Fri,  7 Sep 2018 12:59:38 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, gregory.clement@bootlin.com
Cc:     jason@lakedaemon.net, davem@davemloft.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] dt-bindings: marvell,prestera: Add common compatible string
Date:   Fri,  7 Sep 2018 12:59:25 +1200
Message-Id: <20180907005926.27134-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
References: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "marvell,prestera" as a compatible string so that drivers can be
written to account for any prestera variant without needing to
specialise to the more specific values.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/devicetree/bindings/net/marvell,prestera.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.txt b/Documentation/devicetree/bindings/net/marvell,prestera.txt
index c329608fa887..83370ebf5b89 100644
--- a/Documentation/devicetree/bindings/net/marvell,prestera.txt
+++ b/Documentation/devicetree/bindings/net/marvell,prestera.txt
@@ -2,7 +2,7 @@ Marvell Prestera Switch Chip bindings
 -------------------------------------
 
 Required properties:
-- compatible: one of the following
+- compatible: must be "marvell,prestera" and one of the following
 	"marvell,prestera-98dx3236",
 	"marvell,prestera-98dx3336",
 	"marvell,prestera-98dx4251",
@@ -21,7 +21,7 @@ switch {
 	ranges = <0 MBUS_ID(0x03, 0x00) 0 0x100000>;
 
 	packet-processor@0 {
-		compatible = "marvell,prestera-98dx3236";
+		compatible = "marvell,prestera-98dx3236", "marvell,prestera";
 		reg = <0 0x4000000>;
 		interrupts = <33>, <34>, <35>;
 		dfx = <&dfx>;
-- 
2.18.0


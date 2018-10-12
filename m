Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82CEC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C502098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C502098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeJLV5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeJLV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:57:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32823C04BD59;
        Fri, 12 Oct 2018 14:24:28 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32AB32B59F;
        Fri, 12 Oct 2018 14:24:25 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/5] dt-bindings: add more optional properties for elan_i2c touchpads
Date:   Fri, 12 Oct 2018 16:24:11 +0200
Message-Id: <20181012142413.26107-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Oct 2018 14:24:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some new touchpads IC are connected through PS/2 and I2C. On some of these
new IC, the I2C part doesn't have all of the information available.
We need to be able to forward the touchpad parameters from PS/2 and
thus, we need those new optional properties.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
index 797607460735..ace6bcb0b4eb 100644
--- a/Documentation/devicetree/bindings/input/elan_i2c.txt
+++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
@@ -13,6 +13,14 @@ Optional properties:
   pinctrl binding [1]).
 - vcc-supply: a phandle for the regulator supplying 3.3V power.
 - elan,trackpoint: touchpad can support a trackpoint (boolean)
+- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
+- elan,max_x: the maximum reported value on the X axis
+- elan,max_y: the maximum reported value on the Y axis
+- elan,min_x: the minimum reported value on the X axis
+- elan,min_y: the minimum reported value on the Y axis
+- elan,x_res: the resolution of the X axis (in units per mm)
+- elan,y_res: the resolution of the Y axis (in units per mm)
+- elan,width: max reported width of a blob
 
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 [1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-- 
2.14.3


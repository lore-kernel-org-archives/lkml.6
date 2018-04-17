Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1954995-1523973254-2-15467099948783864724
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523973253; b=Ci6iE69e1JY6mOY+jx7j2IxoOpPxqgpwvUrntFrIBhZ3SxJuEm
    +CG6LyygTAE0FhgX/fv/Fl5l1xTpMCL70GinCwW/wBcY2sDis1hwwfshbiE0+iDo
    QZ/zlQrgINCFZ2p2X5+VkZyaFKpUuovpEW5LKgNt+zTQ8Ps5BoYWjVcqYJZXQlDm
    TN+xU6KiL4WOz5I7bFJbc6MnJugIdmtpi1shQW3YycoUUJV3sEv0grIAYfGNa6J3
    XPJEypbkzK/Xuukr1FOJE/NE8fXf3S8S4bUGFBQZUdTahopM3VjIKs2f0CcX5+ze
    XVglNhzYMvnsCv9rFoe4ZYYEXGTbgb6JfLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523973253; bh=YHUOPc+Jr5Z15pUMXLHUV8w+tSi3VD
    yz3Si3uvS4nCE=; b=cQH4bjNMa4ghZB7+d0yKIpCNACF5qh9SlzFxD5ZMF56hl3
    iol2hm4zb4zTkhBD9OSrMo0F6rsWFNUU4pMRJotS/AFzSmj28vU3Ft0mqFf0A/C+
    io2PqICnv7B3b6STJuGq7p7rQVB0G1kGk8ld987TAWKQSLkuUirvLrTsUPC1IRgv
    NyOEueQb0zbedLK2/VU6JhJG4kYuh7dFjY4i0OSX5KjgWyPE4uzJXZ1hRpZqUBhN
    7uX1Qzp7DWk2gnT0hp5Ok8m1gQSXl7VUeeHhthpjHFwo/n48wGTzbUmj4vvz40Sq
    /IYUmEexi3g4vcmRoxRjFXk+N6rG8/A/I3wLUiDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=l4NpdZmm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=l4NpdZmm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=l4NpdZmm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=l4NpdZmm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEvac54MK4/hznqWC/MmKB+CH4ADW2F0gmuydcSRGZh0cACwpmwTZGibZNbKQ2zxqhax/kv6HWGZ+4aB0i1GOtAXUAq1o2sJrXvRPlKtuqDBGxj6c1Y9
    pBNzs4J23+wPoHNEdGIOKN9ZPZQBZQsRyuCRcn09IkB5oxhE2vt8CPsV9+ZYOr9atuaHS9xKGPCrY8SGOcAVMRHd8CG1f0sMD2f6KpeVzinZ8nWBcnBIUVly
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=ISB2Xr1dKNDCVahVjTsA:9 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeDQNxw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 09:53:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753783AbeDQNxv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 17 Apr 2018 09:53:51 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2892C603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yossim@codeaurora.org
From: Yossi Mansharoff <yossim@codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc: swboyd@chromium.org, Yossi Mansharoff <yossim@codeaurora.org>
Subject: [PATCH v2] doc: usb: ci-hdrc-usb2: Add property "mux-controls"
Date: Tue, 17 Apr 2018 16:53:25 +0300
Message-Id: <1523973206-2165-1-git-send-email-yossim@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The chipidea usb controller may be connected, in some platforms,
to an external mux to toggle between different usb ports for
different roles (host and device).

The mux-controller property, if set, binds the chipidea usb
controller with a mux for this use.

Signed-off-by: Yossi Mansharoff <yossim@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index 0e03344..2e93181 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -76,6 +76,10 @@ Optional properties:
   needs to make sure it does not send more than 90%
   maximum_periodic_data_per_frame. The use case is multiple transactions, but
   less frame rate.
+- mux-controls: The mux control for toggling host/device output of this
+  controller. It's expected that a mux state of 0 indicates device mode and a
+  mux state of 1 indicates host mode.
+- mux-control-names: Shall be "usb_switch" if mux-controls is specified.
 
 i.mx specific properties
 - fsl,usbmisc: phandler of non-core register device, with one
@@ -102,4 +106,6 @@ Example:
 		rx-burst-size-dword = <0x10>;
 		extcon = <0>, <&usb_id>;
 		phy-clkgate-delay-us = <400>;
+		mux-controls = <&usb_switch>;
+		mux-control-names = "usb_switch";
 	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


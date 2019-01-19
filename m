Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC68C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484942086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kIdFfgKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfASSVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:21:51 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:35044 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbfASSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vQT2blScUouxrTEKhEUzWsU5ZKit9n0YusMuo0ydMmM=; b=kIdFfgKvRd/Fw/SmgHq1IFC2e
        RP3lbVrtdXJfiac8yUOr5n9PVn6Vf1KibATnAddx9HMGLAawXNPNoj3O6lYy0Ta5U3Rvv9I+/Toos
        rr3otW7ze0+o8GoVBZydgbZQQgaoivMsjEnC4ZPzy3/0uo2BxxgK2q2dun7h/KBKIzBdY=;
Received: from p200300ccfbfb41001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbfb:4100:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkvFU-0002M9-Qk; Sat, 19 Jan 2019 19:21:40 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkvFU-0002T2-HK; Sat, 19 Jan 2019 19:21:40 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] dt-bindings: panel: td028ttec1: add backlight property
Date:   Sat, 19 Jan 2019 19:21:31 +0100
Message-Id: <20190119182131.9341-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190119182131.9341-1-andreas@kemnade.info>
References: <20190119182131.9341-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add an additional backlight property as described
in panel-common.txt

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
index ed34253d9fb1..898e06ecf4ef 100644
--- a/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
@@ -6,6 +6,7 @@ Required properties:
 
 Optional properties:
 - label: a symbolic name for the panel
+- backlight: phandle of the backlight device
 
 Required nodes:
 - Video port for DPI input
@@ -21,6 +22,7 @@ lcd-panel: td028ttec1@0 {
 	spi-cpha;
 
 	label = "lcd";
+	backlight = <&backlight>;
 	port {
 		lcd_in: endpoint {
 			remote-endpoint = <&dpi_out>;
-- 
2.11.0


Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DF3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACDB2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Pskhtp6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBEGih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:38:37 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:56046 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfBEGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X6xgfu49tlJOvLDPN2BMLPMWFbuK+sXPsiUnNPhpLW4=; b=Pskhtp6UuAqqye2US+92Blhes
        I7mRQEx9hY7zviQ6N7Zx/QBapJqHhCNQSXDAAsDY6tKIr0wdwIYdOsawFrYIt4AALePcLulv/iunG
        WNhPog4o1gdj2OVbGAG8VgTsmtrUWMdoVsWq4s4U/Fl+dQ+Q5lo+r/TIv7xqAu3tphheE=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gquNG-0005Ad-Gc; Tue, 05 Feb 2019 07:38:26 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gquNF-0003sp-Fr; Tue, 05 Feb 2019 07:38:25 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/2] dt-bindings: panel: td028ttec1: add backlight property
Date:   Tue,  5 Feb 2019 07:38:13 +0100
Message-Id: <20190205063813.14873-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190205063813.14873-1-andreas@kemnade.info>
References: <20190205063813.14873-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an additional backlight property as described
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


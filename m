Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54424C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233DF218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpnPyU45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfBZXgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:36:07 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34657 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfBZXgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:36:06 -0500
Received: by mail-qk1-f202.google.com with SMTP id y6so11929988qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xwLLkVZVrKsESATG/Bj+yNpM6E6f7I8z/W+5OcO4Kcs=;
        b=gpnPyU45bx8iW23CkthrrXNIg7y9cfb/upaEFJeu3hW1uLTedjfdGDJ6qPdJI27ZuS
         V51tPpHUtYM6unXtEM333OxnIXzeV2fi1JyJG4nAn6+7qtIQp07t1sc25I7qEz5VH44Q
         PJIPte+R7TtNHFGvIG1NVZgYzyH8qUO4CkHwtKi0FF+RMY585JZiyccKBjiHzO08gPrT
         vmoYK7gNVsR60vjwXbfBjskHFZl7UByIWCWtR6qYMEWUs7sZIf7MyCz35G4Q2b+pflor
         HoThi9Pe/cSqJmKuCtbjqGZqAywEzC3WK9w3Plqiltu8ZvAJi6hXa8pca1/iPUYdy6BH
         ZJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xwLLkVZVrKsESATG/Bj+yNpM6E6f7I8z/W+5OcO4Kcs=;
        b=pfTikJ4sFxdofIJOZ67dVFBypDXUyb5S08+3krk0k0hH/bT+yMgwnWpbd2anTNisIz
         wF1r0wgYsx3Wi1OdxTHR7p88p+iyxPpkDE+h7brRDGhf1TNjxgvvMNWian3pTx5cVX/4
         AQu5Uqm0O8+ZZjy6VisiRXVJ5Q9U2h73n8xP9AeYszFz2Utx4Lfys0WPQ0/B3hs5r2c+
         0TmqCvuEKf34a1W4yC4unVLH+L7zbVI6SN/AvBx/cIQOBVmEJQZJrvgNHm/3h9ohCjqu
         gYEYLU0mcrvNM70/sKXIJKu92wKe+hOz6d+I9gfcODYL/9fKoaxQdwJBC+fHlthZo7yk
         xT6w==
X-Gm-Message-State: AHQUAuaL/+25MVIuhkFClQZI+gtRZtYRmyO/Qp5ya1EamC5ZaE/OOOur
        kJTPE7SJz/DGSS/1ZBDDALB8qGPYm7UL
X-Google-Smtp-Source: AHgI3IZrTgR8opxWkUGsEGbDKGCRjFiXKDFEMQsz/Y26Suq94jJkJ3C2GcqzXdDU5BpYif6bW2i6FacU0mwj
X-Received: by 2002:a05:6214:1048:: with SMTP id l8mr14825293qvr.46.1551224165568;
 Tue, 26 Feb 2019 15:36:05 -0800 (PST)
Date:   Tue, 26 Feb 2019 15:36:00 -0800
Message-Id: <20190226233600.140153-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v2 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.

Signed-off-by: Patrick Venture <venture@google.com>
Change-Id: Ic89a2df0f555dee10598f87537ee004e82d13acd
---
Changes for v2:
- Added comment about syscon required parameter.
---
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 000000000000..1092d62d1c92
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,32 @@
+======================================================================
+Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
+======================================================================
+
+The bridge is available on platforms with the VGA enabled on the Aspeed device.
+In this case, the host has access to a 64KiB window into all of the BMC's
+memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
+has read access to all the regions of memory, however the host only has read
+and write access depending on a register controlled by the BMC.
+
+Required properties:
+===================
+
+ - compatible: must be one of:
+	- "aspeed,ast2400-p2a-ctrl"
+	- "aspeed,ast2500-p2a-ctrl"
+
+ - syscon: handle to syscon device node controlling PCI.
+
+Optional properties:
+===================
+
+- memory-region: A phandle to a reserved_memory region to be used for the PCI
+		to AHB mapping
+
+Example:
+
+p2a: p2a-control@1e6e2000 {
+	compatible = "aspeed,ast2400-p2a-ctrl";
+	memory-region = <&reserved_memory>;
+	syscon = <&syscon>;
+};
-- 
2.21.0.rc2.261.ga7da99ff1b-goog


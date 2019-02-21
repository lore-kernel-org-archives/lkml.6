Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05523C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6320823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/MwN8fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfBUWZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:25:30 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55957 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:25:30 -0500
Received: by mail-qt1-f201.google.com with SMTP id e31so198885qtb.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xLBRuMMrq0cNA0zgwp4oOxjDeaWQ2llxgXZA+AoiLoA=;
        b=s/MwN8fJqdU4JJnSkRG929/qC+zalwdqJlGZJhQjpiFCInLx2blcK3XIhjOXSvDeEw
         x5iTvmAvjADGfobNXn93JNovuei7H55uxKbZPnVirmCM45axH8iwSuTwptZqVype86fh
         t8glXYmLfjEJyDBWkB4ytbC6BA6SqPhnrco2RTyIWEUSn8kakvqofTeKcvNgV4YdSmOB
         wiNdrhHWMpdfKwccKKpVXhahUOM1pKFHghPrg9LDuTY+7F1VrjaTf7gJqNv2JOF3/eXx
         tIkKfiNQWacOgqoLCImZ+soqresIyARpfz2gKEqle3v/AqDr0dUzt8gN/nk1TIZzDFFz
         fFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xLBRuMMrq0cNA0zgwp4oOxjDeaWQ2llxgXZA+AoiLoA=;
        b=RZwa/7hO4i36P8Fsh/7T57ws2w02UVGjh9s9bgemUPww26gbYont/Fsrl8rMNkl1nq
         uR12GFMlu/S/VNPdpSccvjPFnidiVQQuy5v8aDFAgBeGJnBeu/cauOyETagpNPU+1BL6
         6tOsr7MvLk3IY8IKA7RQvbsdNUZETlnyh0xMJLpjEQtAS6Hnz35ZSmi50ySGg2WchftU
         3yUhtfBDqLs3tmop0FA5bar+cG7eVWprL/l0FJZvZ2O3k4y0kIPfA4GxXKUTZhH3zwiW
         +poRKoa6x6Sp9llafp79DwHA5vcbPiOagauWzl/EA1vPsoasba+NA+Eq6ZVsoP0WZ8z/
         ubNQ==
X-Gm-Message-State: AHQUAuY+Uxb6wn+bvTEHbR+tXzTTDfFiF0nbJ/jtp468xU0kUB6sNjSA
        TYK7Tvsr/tAmllWMUSh2uOJhhH9xSUS+
X-Google-Smtp-Source: AHgI3IZkF9L+sVhap9e/1SWARIAl0vz+RHh4/EQZ9OUOi/MHRfLZT/lT9Ds2u2e04cBUHnv6IJjzmH85dKkP
X-Received: by 2002:aed:3a25:: with SMTP id n34mr548310qte.17.1550787928702;
 Thu, 21 Feb 2019 14:25:28 -0800 (PST)
Date:   Thu, 21 Feb 2019 14:25:23 -0800
Message-Id: <20190221222523.136829-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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
---
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 000000000000..9c4d036ad5f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,33 @@
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
+ - reg: physical address of SCU2C followed by SCU180
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
+	reg = <0x1e6e202C 4
+	       0x1e6e2180 4>;
+	memory-region = <&reserved_memory>;
+};
-- 
2.21.0.rc0.258.g878e2cd30e-goog


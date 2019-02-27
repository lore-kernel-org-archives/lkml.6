Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5820823
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiNs3dpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfB0Q6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:58:52 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:47999 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfB0Q6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:58:51 -0500
Received: by mail-io1-f74.google.com with SMTP id p12so13499505iod.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2eptaMvxu/Yjv7wstKV5wbLlhTQnULNRTprcgCrZVTA=;
        b=NiNs3dpHdXbXZqRqwnb2pK2sf6NTErOjaatUdMe2afhO2BhvqYLfSHUOEM3UbSB7DJ
         WMu46+QAFEfrcudgE/JhjO+SKitGMURIsWGt5c6XJpxe1EC9pMsL/ev8A9msmvBk1c1+
         oJ6vaNcYJ5ax8T+vEGuv+QrmNO54rDyi4s95YN4WGuK3WYYBn4GoTcOvFUB/+V4Tu6w5
         CYWTzZ0pRm5By2CNgdhl9Gsct3AGfOl/acPxetOJTnnndiSmOxR7PFnH2k5l7n0qYbvS
         dgaXHF++sw23mc/HfbrJBhiYtOhce4VSPkmbAqFZ+lqmz6qH9YF1BmDyy+7kN5fOaY8h
         YeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2eptaMvxu/Yjv7wstKV5wbLlhTQnULNRTprcgCrZVTA=;
        b=Fmu/Ucf3fgbMR2vCL+10kf3czvCKWEoCTIF2wr6SVsUP7bNqJonDpo3yJVMdMZzHFi
         vCPBqg+UcC2S2YZx3dcxZNNodvgD/zN77y4iBFI1KbXuGFnh8dhuPkyPOwpO3H+aCeeX
         GW9xsPp3UM60KjL60MKXpIdb1u6KouFPwNjIspHkDvf87OSFYfu4Ijr8nTb7g68T1d3E
         vqXhyMSJNjJQuyDb0E5yeXnpMQYY/qrYKrd/hL+ykgTfGXUaq31QBlrA+xt80qtmXqgW
         DNvBMUlIDPZ+ICzuAVggC9No6F7NMAZvP2N0iYEtz85NaQW/86FTvTTCFjZELk3RmzAT
         Io5A==
X-Gm-Message-State: AHQUAuamzm5Wn0P4XWG79A5XH0x8KakvmZ808l5kq/MQo15J5GGGVJU1
        2BGOVjT3phBg5XisUnwAbj5BrzQuAvIJ
X-Google-Smtp-Source: AHgI3IanU/eCFiw7CWFWFrcfmEO6ShyPi8W35xztC/xt6XZCMHYRktRiMC6jXoX5SV873BIJlyKQ9RdJUIiG
X-Received: by 2002:a24:5e94:: with SMTP id h142mr103861itb.35.1551286730735;
 Wed, 27 Feb 2019 08:58:50 -0800 (PST)
Date:   Wed, 27 Feb 2019 08:58:41 -0800
Message-Id: <20190227165841.143802-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v4 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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
Changes for v4:
- None
Changes for v3:
- None
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


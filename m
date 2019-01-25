Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DAFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EEE217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIuUDY9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAYLaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:30:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:30:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so9939524wrb.2;
        Fri, 25 Jan 2019 03:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cni3YG26TUwTwn0/m/XP6xKVhkAi6RTA9FiGH4/p6co=;
        b=MIuUDY9uOKx7OMT9UzYZeUU5ybjdNCSeISFo7H2Jpjrlkj9q1mM3rsckl/yMWSY4Ys
         rCEk5P7E/EQi3GCyR8h71klsoPmwQin7tVmGY8V/hWI6FUG5M1nBxufqxjKxxAD5A6fJ
         DOGg2J/LsvVlBoFpNdjBwQdK2E7PUhbCizhct/kIQYpeKLk0oQ4qM/3cySQ08GVkFOvt
         jewV5jH4hKc/7i5wUalp94DRz9dvqteVtuaxkZvm0voN/PUooEW2OjlNMKdhu060zawN
         4Xw77Q40BHhmSQhlkJVWtn7wCzmV2LJsHAP1915pV5evYwZwO8zyGN6yr3ic49tFx4Ni
         /DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cni3YG26TUwTwn0/m/XP6xKVhkAi6RTA9FiGH4/p6co=;
        b=FJW+NDiE9M0g2Ls6IH1fj1hoEzLyOlQPDGTdUDtPrdlBxbJfy8L1mFXTjrEJws0Ggt
         a8hDuMb/CYTO3dhP964dNV0/m3Wa2QEVgBfqWBjgjQZqmIl4pf/gH8ZVOiNwMY7hy5DM
         m9qPPjuKxlAWj8AMJbP5xmYjHX9gbKfajV/Bt4XxyYPb6Goju+lGvAKjCyym71ceUaJ3
         s7gGl99bpL+8VsF0ZpX7Lq1rgGe5gabdfFbCAImmz2FTXFfsKNyFQgru6b/bk+Yss6Y6
         DQqRjWeQIpKO2X+K0M9ppmuw0/cITmNvWqjLqD4yMhPchNgDvn0kIFT5cIyF81xiVY3X
         /UKQ==
X-Gm-Message-State: AJcUukcsAp/5bB31aiMUeLMztmfxUDegQaJc2gCOPOZBqdH5Gl3wiJrA
        hQBq6C0toPMbvZWo43lZq9M=
X-Google-Smtp-Source: ALg8bN6j5um3WSEr6GlxyxGSeBxIvenxOhvBwAymC2DpOto297RNA2N2awwMXXLvr0kHnXgHwHvatg==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr11690083wrn.109.1548415815745;
        Fri, 25 Jan 2019 03:30:15 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w16sm127162070wrp.1.2019.01.25.03.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:30:14 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: usb: xhci-tegra: Add Tegra186 support
Date:   Fri, 25 Jan 2019 12:30:08 +0100
Message-Id: <20190125113013.11447-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Extend the bindings to cover the set of features found in Tegra186.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
index 4156c3e181c5..5bfcc0b4d6b9 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
@@ -10,6 +10,7 @@ Required properties:
   - Tegra124: "nvidia,tegra124-xusb"
   - Tegra132: "nvidia,tegra132-xusb", "nvidia,tegra124-xusb"
   - Tegra210: "nvidia,tegra210-xusb"
+  - Tegra186: "nvidia,tegra186-xusb"
 - reg: Must contain the base and length of the xHCI host registers, XUSB FPCI
   registers and XUSB IPFS registers.
 - reg-names: Must contain the following entries:
@@ -59,6 +60,8 @@ For Tegra210:
 - avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
 - dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
 - hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
+
+For Tegra210 and Tegra186:
 - power-domains: A list of PM domain specifiers that reference each power-domain
   used by the xHCI controller. This list must comprise of a specifier for the
   XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
@@ -78,6 +81,7 @@ Optional properties:
   - Tegra132: usb2-0, usb2-1, usb2-2, hsic-0, hsic-1, usb3-0, usb3-1
   - Tegra210: usb2-0, usb2-1, usb2-2, usb2-3, hsic-0, usb3-0, usb3-1, usb3-2,
               usb3-3
+  - Tegra186: usb2-0, usb2-1, usb2-2, hsic-0, usb3-0, usb3-1, usb3-2
 
 Example:
 --------
-- 
2.19.1


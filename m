Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF88820880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jig5rcPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfBTPNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:13:44 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2406 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:13:44 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6d6eb00000>; Wed, 20 Feb 2019 07:13:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 07:13:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 07:13:43 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 15:13:43 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 15:13:43 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6d6ea40000>; Wed, 20 Feb 2019 07:13:42 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/3] ALSA: hda/tegra: property for card name
Date:   Wed, 20 Feb 2019 20:43:22 +0530
Message-ID: <1550675604-14788-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550675632; bh=OAAQLyFtj25y1vGIGDEX6nErjxGE93r6zi1GwXxvDhA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=jig5rcPt+HxccFdj7XvRYCqtUmfmte+laFnM3kMXG6VLBIPYi7BBRoFWzzDeEeUi3
         b8jwlwDzQvjg8VJqCofBkC4Mr/rgNkDDUNlQ6BdrlmTVcw8CWGITel44TFFz14dISU
         5NZxLoTqZynOKEKY8tDcW3Cdukt6dIe+ESYevSGh1sFfmU9Jp9YjLQUpLFWgMUCgGA
         OczHWfWdBmNPktmrKX/GAvtOhuFiLfG0G7fJkuXF2SWy8piwuaT97R1Lfa0IgVMAVL
         iuPfsdx1+SW+rS6c0iIlwaJaOmef4VVNPrh4B8e1gYDKJCSYo/FmxE2ZIfqy/X+qNP
         tmtU/33zhCyxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An optional property "nvidia,model" is introduced for hda to pass custom
name for the sound card. The suffix "-hda" in the name passed is useful
to distinguish between multiple cards available for a platform.
When the property is not specified, default name("tegra-hda") mentioned
in hda driver is used. This property can be added in platform specific
file of the board and card name can relate to the board in use.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
---
 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
index 44d2745..21cd310 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
@@ -13,6 +13,10 @@ Required properties:
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries: hda, hda2hdmi, hda2codec_2x
 
+Optional properties:
+- nvidia,model : The user-visible name of this sound complex. Since the property
+  is optional, legacy boards can use default name provided in hda driver.
+
 Example:
 
 hda@70030000 {
@@ -27,4 +31,5 @@ hda@70030000 {
 		 <&tegra_car 128>, /* hda2hdmi */
 		 <&tegra_car 111>; /* hda2codec_2x */
 	reset-names = "hda", "hda2hdmi", "hda2codec_2x";
+	nvidia,model = "jetson-tk1-hda";
 };
-- 
2.7.4


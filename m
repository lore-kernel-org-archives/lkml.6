Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE8C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8220861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080350;
	bh=1A6ot/xE7bjmz8qrOjxhlGfc87fVLeztcdwp3io4lu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PGccsF7SrPgNqGiSUUOYErNKVdbPwnN3OT/vxlVKXNFK7GzICzgoCavPfZxbDF2au
	 yCvoSfSJZ5GzALfAFaTHiFkEr17T/cGiq5SDKa3B5dKw0/u2woRJX4IzG0RO4tdSWo
	 CGlCj7kKBTCdZok5SHrb94zQuBX/yIn6gu/MHxeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfAUOTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbfAUNtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:49:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775E720861;
        Mon, 21 Jan 2019 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078541;
        bh=1A6ot/xE7bjmz8qrOjxhlGfc87fVLeztcdwp3io4lu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Doc5HLwDuqiFXCrrzf9spUwAadDboLSjHLRdo57rLhpkO9Vum80f+eIRw8cjaiV8+
         g8DzgiT+rZeXX496i4nRsAgejdjhihBedngw1q/3IpgpjTV/txyX+WsWk3HMlsbFv0
         Ct1ffPs32FKsTgdNHLu0uTDeFd/mztQuCr2JWN8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.20 068/111] arm64: dts: marvell: armada-ap806: reserve PSCI area
Date:   Mon, 21 Jan 2019 14:43:02 +0100
Message-Id: <20190121122503.971094755@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit 132ac39cffbcfed80ada38ef0fc6d34d95da7be6 upstream.

The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
attempt to access it from Linux leads to an immediate crash.

So let's make the same memory reservation as the vendor kernel.

[gregory: added as comment that this region matches the mainline U-boot]
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -28,6 +28,23 @@
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * This area matches the mapping done with a
+		 * mainline U-Boot, and should be updated by the
+		 * bootloader.
+		 */
+
+		psci-area@4000000 {
+			reg = <0x0 0x4000000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;



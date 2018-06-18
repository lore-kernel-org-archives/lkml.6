Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A5FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBCF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBCF20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967357AbeFRIcv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:32:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966870AbeFRIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD9AFCB5;
        Mon, 18 Jun 2018 08:32:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 055/189] ARM: dts: da850: fix W=1 warnings with pinmux node
Date:   Mon, 18 Jun 2018 10:12:31 +0200
Message-Id: <20180618081211.541593733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sekhar Nori <nsekhar@ti.com>

[ Upstream commit 94a82284ad4711b7f9fd78981fdc7a1cb645030b ]

Remove unused #address-cells and #size-cells from pinmux
node. This fixes W=1 warnings of the type:

arch/arm/boot/dts/da850-lcdk.dtb: Warning (avoid_unnecessary_addr_size): /soc@1c00000/pinmux@14120: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Tested on DA850 LCDK by checking output of:

/sys/kernel/debug/pinctrl/1c14120.pinmux-pinctrl-single/pins

before and after the change.

Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/da850.dtsi |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -34,8 +34,6 @@
 		pmx_core: pinmux@14120 {
 			compatible = "pinctrl-single";
 			reg = <0x14120 0x50>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			#pinctrl-cells = <2>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;



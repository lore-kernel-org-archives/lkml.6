Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD65320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD65320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934685AbeFRIRD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:17:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934611AbeFRIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:17:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEBA3C96;
        Mon, 18 Jun 2018 08:16:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 048/279] ARM64: dts: meson-gxm-khadas-vim2: enable the USB controller
Date:   Mon, 18 Jun 2018 10:10:33 +0200
Message-Id: <20180618080610.825740020@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 4b7b0d7b25538d2ad421a1041267d5208d3425bc ]

The Khadas VIM2 board connects the dwc3 controller to an internal 4-port
USB hub which. Two of these ports are accessible directly soldered to
the board, while the other two are accessible through the 40-pin "GPIO"
header.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -413,3 +413,7 @@
 	status = "okay";
 	vref-supply = <&vddio_ao18>;
 };
+
+&usb0 {
+	status = "okay";
+};



Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64F5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF06120857
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfA1R2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:28:42 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45899 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731410AbfA1R2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:28:37 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 28 Jan 2019 19:28:33 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x0SHSSPX008169;
        Mon, 28 Jan 2019 12:28:28 -0500
Received: (from lsun@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x0SHSSTO009024;
        Mon, 28 Jan 2019 12:28:28 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 2/2] dt-bindings: soc: Add TmFifo binding for Mellanox BlueField SoC
Date:   Mon, 28 Jan 2019 12:28:07 -0500
Message-Id: <1548696487-8840-3-git-send-email-lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548696487-8840-1-git-send-email-lsun@mellanox.com>
References: <1548696487-8840-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for the TmFifo which is found on Mellanox
BlueField SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 .../devicetree/bindings/soc/mellanox/tmfifo.txt    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt

diff --git a/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt b/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
new file mode 100644
index 0000000..8a13fa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
@@ -0,0 +1,23 @@
+* Mellanox BlueField SoC TmFifo
+
+BlueField TmFifo provides a shared FIFO between the target and the
+external host machine, which can be accessed by external host via
+USB or PCIe. In the current tmfifo driver, this FIFO has been demuxed
+to implement virtual console and network interface based on the virtio
+framework.
+
+Required properties:
+
+- compatible:	Should be "mellanox,bf-tmfifo"
+- reg:		Physical base address and length of Rx/Tx block
+- interrupts:	The interrupt number of Rx low water mark, Rx high water mark
+		Tx low water mark, Tx high water mark respectively.
+
+Example:
+
+tmfifo@800a20 {
+	compatible = "mellanox,bf-tmfifo";
+	reg = <0x00800a20 0x00000018
+	       0x00800a40 0x00000018>;
+	interrupts = <41, 42, 43, 44>;
+};
-- 
1.8.3.1


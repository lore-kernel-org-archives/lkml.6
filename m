Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2325C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4980B21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fv3NtWxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfBOQRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:17:42 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:46612 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbfBOQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:17:38 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id ED4A224E2391;
        Fri, 15 Feb 2019 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550247457; bh=d6fl6xEY4l+VIcEAC+RTtJpdZFQEWJKdZ18yC8MIfXo=;
        h=From:To:Cc:Subject:Date:From;
        b=fv3NtWxFmF0yLJ8r/lMR2v6vuS7qfjD+MDTExm9R9ydJp2YLBpLcg2LZ4bB/o55FB
         eQlekTMiS6/OeKLqRE0kdfvGAfL2EVA6+D95vKQgrBoL1OFbK0zPn+/W4jHgA+Kvtm
         qGoLVs43Ul0K3O2J18FIsEddewxr5Ny1/nfWmtcn0nNtrIqgJGu0Ezfq0eQrhwBlDU
         iw/PhnaJqmNdjEZ4mHIjYLYKMcMsxGvRekyB2aadxTt/Nc/42jyyTZzPMTStfrjw0O
         JKK/0Zywj5n1mBf1QKyUEYCWUk2MVlW8byldleW6WpCMFSBH8lTiuhBfpCNp71bNYI
         uBgS7BpgOXDkg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.62])
        by mailhost.synopsys.com (Postfix) with ESMTP id 874A3A0091;
        Fri, 15 Feb 2019 16:17:34 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk]: Add reset controller handle to manage USB reset
Date:   Fri, 15 Feb 2019 19:17:33 +0300
Message-Id: <20190215161733.29914-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW USB controller on HSDK hangs sometimes after SW reset, so
add reset handle to make possible to reset DW USB controller HW.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/hsdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 43f17b51ee89..f80fb9dc8653 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -200,6 +200,7 @@
 			compatible = "snps,hsdk-v1.0-ohci", "generic-ohci";
 			reg = <0x60000 0x100>;
 			interrupts = <15>;
+			resets = <&cgu_rst HSDK_USB_RESET>;
 			dma-coherent;
 		};
 
@@ -207,6 +208,7 @@
 			compatible = "snps,hsdk-v1.0-ehci", "generic-ehci";
 			reg = <0x40000 0x100>;
 			interrupts = <15>;
+			resets = <&cgu_rst HSDK_USB_RESET>;
 			dma-coherent;
 		};
 
-- 
2.14.5


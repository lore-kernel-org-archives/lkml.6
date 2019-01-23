Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE67C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA29921726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfAWObH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:31:07 -0500
Received: from mx1.emlix.com ([46.4.235.150]:37990 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfAWObH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:31:07 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 18CFA25F1A1;
        Wed, 23 Jan 2019 15:31:05 +0100 (CET)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: usb: ci-hdrc-usb2: add property power-active-high
Date:   Wed, 23 Jan 2019 15:31:02 +0100
Message-Id: <20190123143103.16891-1-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX USB controller may drive the usb power line directly, but the
polarity depends on the board. Reset state of the polarity is low-active so
add this property to allow it to be high-active.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes in v4: do not limit to i.MX6

 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index adae82385dd6..a254386a91ad 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -93,6 +93,7 @@ i.mx specific properties
 - over-current-active-low: over current signal polarity is active low.
 - over-current-active-high: over current signal polarity is active high.
   It's recommended to specify the over current polarity.
+- power-active-high: power signal polarity is active high
 - external-vbus-divider: enables off-chip resistor divider for Vbus
 
 Example:
-- 
2.20.1


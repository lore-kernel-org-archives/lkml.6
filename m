Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A88FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB662150B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HW7a3rkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB662150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJJWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:38:29 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:45416 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539184551; x=1570720551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ak8F6a3uz6gaeOf23I+bW8Rs2dY3Z5HNkMTtuWQti9M=;
  b=HW7a3rkjrn333LB3CM97F69SfmJTcvw7yWqRGpQQ2VpvrO4Z+ZDCu6sO
   a82dtMArRc7yYxaypmli898+/RZkF5awCV3NdqoE5DXU9vl8rY+BThEn5
   yv+vlVZXhwN0KuSbEyetVpm5Xed1b/QDjWrKEqGOiwRoL7fA3I5Np032L
   c=;
X-IronPort-AV: E=Sophos;i="5.54,364,1534809600"; 
   d="scan'208";a="635417497"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Oct 2018 15:15:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9AFFa4Y103516
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 10 Oct 2018 15:15:36 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 15:15:35 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.173) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 10 Oct 2018 15:15:29 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <jonnyc@amazon.com>, <ronenk@amazon.com>,
        <barakw@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 1/2] dt-bindings: spi: dw: add compatible for Alpine spi controller
Date:   Wed, 10 Oct 2018 18:15:15 +0300
Message-ID: <1539184516-8200-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539155293-21750-1-git-send-email-talel@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.173]
X-ClientProxiedBy: EX13D18UWA001.ant.amazon.com (10.43.160.11) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This compatible adds the ability for dw spi controller driver to work with
the dw spi controller found on Alpine chips.

The dw spi controller has an auto-deselect of Chip-Select, in case there is
no data inside the Tx FIFO. While working on platforms with Alpine chips,
auto-deselect mode causes an issue for some spi devices that can't handle
the Chip-Select deselect in the middle of a transaction. It is a normal
behavior for a Tx FIFO to be empty in the middle of a transaction, due to
busy cpu. In the Alpine chip family an option to change the default
behavior was added to the original dw spi controller to prevent this issue
of de-asserting Chip-Select once TX FIFO is empty. The change was to allow
SW manual control of the Chip-Select. With this change, as long as the
Slave Enable Register is asserted, the Chip-Select will be asserted. As a
result, it is necessary to deselect the Slave Select Register once the
transaction is done. This feature is enabled via a new device compatible
string called 'al,alpine-dw-apb-ssi'.  Once the driver identifies the new
compatible string, it enables the hw fixup logic, by writing to a dedicated
register found in the IP reserved area and will start manual deselecting
the Slave Select Register when the transfer ends.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 642d3fb..d25b1f8 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -2,7 +2,7 @@ Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
 - compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2"
+  "jaguar2", or "al,alpine-dw-apb-ssi"
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
-- 
2.7.4


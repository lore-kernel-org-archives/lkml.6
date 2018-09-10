Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A1B20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A1B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeIKClv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:41:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:2481 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeIKClv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:41:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 14:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,357,1531810800"; 
   d="scan'208";a="256062310"
Received: from maru.jf.intel.com ([10.54.51.80])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2018 14:45:36 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [RFC PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: Add 'idle-wait-timeout-ms' setting
Date:   Mon, 10 Sep 2018 14:45:18 -0700
Message-Id: <20180910214519.14126-2-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
References: <20180910214519.14126-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds 'idle-wait-timeout-ms' setting which can be used
for bus idle waiting logic in multi-master environment.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index 8fbd8633a387..42ecaaf67172 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -13,9 +13,13 @@ Required Properties:
 - interrupts		: interrupt number
 
 Optional Properties:
-- bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
-		  specified
-- multi-master	: states that there is another master active on this bus.
+- bus-frequency		: frequency of the bus clock in Hz defaults to 100 kHz
+			  when not specified
+- multi-master		: states that there is another master active on this
+			  bus.
+- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds when
+			  multi-master is set, defaults to 100 ms when not
+			  specified.
 
 Example:
 
-- 
2.18.0


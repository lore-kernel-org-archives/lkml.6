Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB13C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96402086D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96402086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJaGE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:04:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:28959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeJaGE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:04:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 14:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="100110049"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2018 14:09:21 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH i2c-next v9 1/5] dt-bindings: i2c: Add 'bus-timeout-ms' and '#retries' properties as common optional
Date:   Tue, 30 Oct 2018 14:09:12 -0700
Message-Id: <20181030210917.32711-2-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds 'bus-timeout-ms' and '#retries' properties as
common optional properties that can be used for setting 'timeout'
and 'retries' values of 'struct i2c_adapter'. With this patch, the
bus timeout value and the master transfer retries count can be set
through these properties at the registration time of an adapter.
Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
on cdev at runtime too.

These properties may not be supported by all drivers. However, if
a driver wants to support one of them, it should adapt the
bindings in this document.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index 11263982470e..bdead91f82a4 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -80,6 +80,12 @@ wants to support one of the below features, it should adapt the bindings below.
 	Names of map programmable addresses.
 	It can contain any map needing another address than default one.
 
+- bus-timeout-ms
+	Bus timeout in milliseconds.
+
+- #retries
+	Number of retries for master transfer.
+
 Binding may contain optional "interrupts" property, describing interrupts
 used by the device. I2C core will assign "irq" interrupt (or the very first
 interrupt if not using interrupt names) as primary interrupt for the slave.
-- 
2.19.1


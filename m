Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeFANRK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:17:10 -0400
Received: from foss.arm.com ([217.140.101.70]:51878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbeFANQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:16:59 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, sudeep.holla@arm.com, robh@kernel.org,
        mark.rutland@arm.com, frowand.list@gmail.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, john.horley@arm.com,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 3/8] coresight: Cleanup platform description data
Date: Fri,  1 Jun 2018 14:16:02 +0100
Message-Id: <1527858967-16047-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody uses the "clk" field in struct coresight_platform_data.
Remove it.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/coresight.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d950dad..32aaa1c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -94,7 +94,6 @@ struct coresight_dev_subtype {
  * @child_ports:child component port number the current component is
 		connected  to.
  * @nr_outport:	number of output ports for this component.
- * @clk:	The clock this component is associated to.
  */
 struct coresight_platform_data {
 	int cpu;
@@ -104,7 +103,6 @@ struct coresight_platform_data {
 	const char **child_names;
 	int *child_ports;
 	int nr_outport;
-	struct clk *clk;
 };
 
 /**
-- 
2.7.4

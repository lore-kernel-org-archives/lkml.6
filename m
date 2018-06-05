Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeFEVo5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:44:57 -0400
Received: from foss.arm.com ([217.140.101.70]:34462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFEVoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:44:55 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 04/20] coresight: Cleanup platform description data
Date: Tue,  5 Jun 2018 22:43:15 +0100
Message-Id: <1528235011-30691-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
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
index e5421b8..69a5c9f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -87,7 +87,6 @@ struct coresight_dev_subtype {
  * @child_ports:child component port number the current component is
 		connected  to.
  * @nr_outport:	number of output ports for this component.
- * @clk:	The clock this component is associated to.
  */
 struct coresight_platform_data {
 	int cpu;
@@ -97,7 +96,6 @@ struct coresight_platform_data {
 	const char **child_names;
 	int *child_ports;
 	int nr_outport;
-	struct clk *clk;
 };
 
 /**
-- 
2.7.4

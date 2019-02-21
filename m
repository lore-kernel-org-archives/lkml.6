Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F23BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10613214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfBUL3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:29:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48885 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:29:34 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 7fade34a28580be5; Thu, 21 Feb 2019 12:29:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        devel@driverdev.osuosl.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: Add missing description of new struct device_link field
Date:   Thu, 21 Feb 2019 12:28:05 +0100
Message-ID: <1917831.AxOkpi0hM7@aspire.rjw.lan>
In-Reply-To: <201902202102.r25FNhNI%fengguang.wu@intel.com>
References: <201902202102.r25FNhNI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 36003d4cf57c ("driver core: Fix PM-runtime for links added
during consumer probe") forgot to add a kerneldoc decription for the
new struct device_link member added by it, so do that now.

Fixes: 36003d4cf57c ("driver core: Fix PM-runtime for links added during consumer probe")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Sorry about missing this.

---
 include/linux/device.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -848,6 +848,7 @@ enum device_link_state {
  * @rpm_active: Whether or not the consumer device is runtime-PM-active.
  * @kref: Count repeated addition of the same link.
  * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
+ * @supplier_preactivated: Supplier has been made active before consumer probe.
  */
 struct device_link {
 	struct device *supplier;


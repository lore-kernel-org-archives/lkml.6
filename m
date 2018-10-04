Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159402084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159402084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJDVc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:32:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:62464 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeJDVc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:32:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 07:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,340,1534834800"; 
   d="scan'208";a="96059386"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 04 Oct 2018 07:38:22 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] drm/i915/sysfs: make attrs arrays const
Date:   Thu,  4 Oct 2018 17:37:50 +0300
Message-Id: <20181004143750.30880-2-jani.nikula@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181004143750.30880-1-jani.nikula@intel.com>
References: <20181004143750.30880-1-jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They don't need to be modified.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/i915_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_sysfs.c b/drivers/gpu/drm/i915/i915_sysfs.c
index e5e6f6bb2b05..b9aa8515254e 100644
--- a/drivers/gpu/drm/i915/i915_sysfs.c
+++ b/drivers/gpu/drm/i915/i915_sysfs.c
@@ -483,7 +483,7 @@ static ssize_t gt_rp_mhz_show(struct device *kdev, struct device_attribute *attr
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static const struct attribute *gen6_attrs[] = {
+static const struct attribute * const gen6_attrs[] = {
 	&dev_attr_gt_act_freq_mhz.attr,
 	&dev_attr_gt_cur_freq_mhz.attr,
 	&dev_attr_gt_boost_freq_mhz.attr,
@@ -495,7 +495,7 @@ static const struct attribute *gen6_attrs[] = {
 	NULL,
 };
 
-static const struct attribute *vlv_attrs[] = {
+static const struct attribute * const vlv_attrs[] = {
 	&dev_attr_gt_act_freq_mhz.attr,
 	&dev_attr_gt_cur_freq_mhz.attr,
 	&dev_attr_gt_boost_freq_mhz.attr,
-- 
2.11.0


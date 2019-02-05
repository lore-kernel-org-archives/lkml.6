Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1296FC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01F320821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfBEMZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:25:46 -0500
Received: from mail.sysgo.com ([176.9.12.79]:52110 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfBEMZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:25:46 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 07:25:45 EST
From:   David Engraf <david.engraf@sysgo.com>
To:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, hdegoede@redhat.com, aspriel@gmail.com,
        brgl@bgdev.pl, heikki.krogerus@linux.intel.com,
        vivek.gautam@codeaurora.org, joe@perches.com, jroedel@suse.de
Cc:     linux-kernel@vger.kernel.org, David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] device: Fix comment for driver_data in struct device
Date:   Tue,  5 Feb 2019 13:19:52 +0100
Message-Id: <20190205121952.14873-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_set_drvdata/dev_get_drvdata is used to access driver_data
in struct device.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..601594771153 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -985,7 +985,7 @@ struct device {
 	void		*platform_data;	/* Platform specific data, device
 					   core doesn't touch it */
 	void		*driver_data;	/* Driver data, set and get with
-					   dev_set/get_drvdata */
+					   dev_set_drvdata/dev_get_drvdata */
 	struct dev_links_info	links;
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
-- 
2.17.1


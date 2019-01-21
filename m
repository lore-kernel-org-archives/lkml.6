Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2519FC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8262085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfAUOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:38:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:44420 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbfAUOi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:38:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 06:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="127679745"
Received: from epg-ubt28.iil.intel.com ([143.185.152.137])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2019 06:38:24 -0800
From:   Ramon Fried <ramon.fried@linux.intel.com>
To:     linus.walleij@linaro.org, corbet@lwn.net
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ramon Fried <ramon.fried@linux.intel.com>
Subject: [PATCH] pinctrl.txt: Remove outdated information
Date:   Mon, 21 Jan 2019 16:38:22 +0200
Message-Id: <20190121143822.20225-1-ramon.fried@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning -EAGAIN is no longer supported by pin_config_group_set()
since ad42fc6c8479 ("pinctrl: rip out the direct pinconf API")

Remove the relevant section from the documentation.

Signed-off-by: Ramon Fried <ramon.fried@linux.intel.com>
---
 Documentation/driver-api/pinctl.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/driver-api/pinctl.rst b/Documentation/driver-api/pinctl.rst
index 6cb68d67fa75..2bb1bc484278 100644
--- a/Documentation/driver-api/pinctl.rst
+++ b/Documentation/driver-api/pinctl.rst
@@ -274,15 +274,6 @@ configuration in the pin controller ops like this::
 		.confops = &foo_pconf_ops,
 	};
 
-Since some controllers have special logic for handling entire groups of pins
-they can exploit the special whole-group pin control function. The
-pin_config_group_set() callback is allowed to return the error code -EAGAIN,
-for groups it does not want to handle, or if it just wants to do some
-group-level handling and then fall through to iterate over all pins, in which
-case each individual pin will be treated by separate pin_config_set() calls as
-well.
-
-
 Interaction with the GPIO subsystem
 ===================================
 
-- 
2.17.1


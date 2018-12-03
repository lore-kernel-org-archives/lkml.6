Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5126A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5126A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeLCPJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:09:18 -0500
Received: from mail5.windriver.com ([192.103.53.11]:33078 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeLCPJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:09:18 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wB3F8DFC001748
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 3 Dec 2018 07:08:24 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 07:07:57 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 EA5802E0818; Mon,  3 Dec 2018 10:07:56 -0500 (EST)
Date:   Mon, 3 Dec 2018 10:07:56 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alessandro Rubini <rubini@gnudd.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>
Subject: Re: [PATCH 12/22] mfd: sta2x11: drop unused MODULE_ tags from
 non-modular code
Message-ID: <20181203150756.GA23156@windriver.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
 <1543811009-15112-13-git-send-email-paul.gortmaker@windriver.com>
 <20181203111442.GK26661@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181203111442.GK26661@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 12/22] mfd: sta2x11: drop unused MODULE_ tags from non-modular code] On 03/12/2018 (Mon 11:14) Lee Jones wrote:

> On Sun, 02 Dec 2018, Paul Gortmaker wrote:
> 
> > The Kconfig currently controlling compilation of this code is:
> > 
> > drivers/mfd/Kconfig:config MFD_STA2X11
> > drivers/mfd/Kconfig:    bool "STMicroelectronics STA2X11"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > Lets remove the couple traces of modular infrastructure use, so that
> > when reading the driver there is no doubt it is builtin-only.

[...]

> > Cc: Lee Jones <lee.jones@linaro.org>
> 
> I think you should add some of the driver developers.

Fair point, but note that get_maintainers doesn't list any developers,
and neither of the driver authors put an e-mail address in the driver.

   
   $ gm drivers/mfd/sta2x11-mfd.c
   ------------------------------------------------------
   Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEVICES (MFD))
   linux-kernel@vger.kernel.org (open list)
   ------------------------------------------------------
   Cc: Lee Jones <lee.jones@linaro.org>
   Cc: linux-kernel@vger.kernel.org
   ------------------------------------------------------
   $ 

Looking in git history, I was able to find two e-mail, but one hasn't
been used in 5+ years, so hopefully it is still active.  I have added
both to the Cc: of this e-mail and added them to the commit below.

Alessandro, Davide - you can find additional context regarding why we
are making these changes in the [00/22] e-mail that can be found here:

https://lore.kernel.org/lkml/1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com/

Thanks,
Paul.

--

From 34742ffbf343abca07f9d0d680ebfebaedd993c9 Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 6 Jul 2016 16:46:39 -0400
Subject: [PATCH] mfd: sta2x11: drop unused MODULE_ tags from non-modular code

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_STA2X11
drivers/mfd/Kconfig:    bool "STMicroelectronics STA2X11"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We replace module.h with init.h and export.h ; the latter since the
file does export some symbols.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Davide Ciminaghi <ciminaghi@gnudd.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
index 3aeafa228baf..cab9aabcaa1f 100644
--- a/drivers/mfd/sta2x11-mfd.c
+++ b/drivers/mfd/sta2x11-mfd.c
@@ -1,4 +1,6 @@
 /*
+ * STA2x11 mfd for GPIO, SCTL and APBREG
+ *
  * Copyright (c) 2009-2011 Wind River Systems, Inc.
  * Copyright (c) 2011 ST Microelectronics (Alessandro Rubini, Davide Ciminaghi)
  *
@@ -18,7 +20,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -653,8 +656,3 @@ static int __init sta2x11_mfd_init(void)
  */
 subsys_initcall(sta2x11_drivers_init);
 rootfs_initcall(sta2x11_mfd_init);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Wind River");
-MODULE_DESCRIPTION("STA2x11 mfd for GPIO, SCTL and APBREG");
-MODULE_DEVICE_TABLE(pci, sta2x11_mfd_tbl);
-- 
2.7.4


Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF3C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BEF2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BEF2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeI2EaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:30:20 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:36435 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbeI2EaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B4AE621950;
        Fri, 28 Sep 2018 22:04:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wing47_27b6805978533
X-Filterd-Recvd-Size: 3027
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:04:32 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Bad MAINTAINERS pattern in section 'STI CEC DRIVER'
Date:   Fri, 28 Sep 2018 15:04:30 -0700
Message-Id: <20180928220431.31656-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	13992	STI CEC DRIVER
	13993	M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
	13994	S:	Maintained
-->	13995	F:	drivers/staging/media/st-cec/
	13996	F:	Documentation/devicetree/bindings/media/stih-cec.txt

Commit that introduced this:

commit 82abbea734d659b4218ad06734b4927b43261985
 Author: Randy Dunlap <rdunlap@infradead.org>
 Date:   Fri Jul 21 13:32:27 2017 -0700
 
     MAINTAINERS: fix alphabetical ordering
     
     Fix major alphabetic errors.  No attempt to fix items that all begin
     with the same word (like ARM, BROADCOM, DRM, EDAC, FREESCALE, INTEL,
     OMAP, PCI, SAMSUNG, TI, USB, etc.).
     
     (diffstat +/- is different by one line because TI KEYSTONE MULTICORE
     had 2 blank lines after it.)
     
     Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
     Acked-by: Andrew Morton <akpm@linux-foundation.org>
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
 
  MAINTAINERS | 1683 +++++++++++++++++++++++++++++------------------------------
  1 file changed, 841 insertions(+), 842 deletions(-)

Last commit with drivers/staging/media/st-cec/

commit fc4e009c6c986a8cc717dc070d65ccb60d7de91a
Author: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue Jan 3 12:54:56 2017 -0200

    [media] stih-cec: add CEC notifier support
    
    By using the CEC notifier framework there is no longer any reason
    to manually set the physical address. This was the one blocking
    issue that prevented this driver from going out of staging, so do
    this move as well.
    
    Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
    Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

 drivers/media/platform/Kconfig                     | 18 +++++++++++++
 drivers/media/platform/Makefile                    |  1 +
 .../st-cec => media/platform/sti/cec}/Makefile     |  0
 .../st-cec => media/platform/sti/cec}/stih-cec.c   | 31 +++++++++++++++++++---
 drivers/staging/media/Kconfig                      |  2 --
 drivers/staging/media/Makefile                     |  1 -
 drivers/staging/media/st-cec/Kconfig               |  8 ------
 drivers/staging/media/st-cec/TODO                  |  7 -----
 8 files changed, 47 insertions(+), 21 deletions(-)

Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BAFC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D81206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D81206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeI2ETY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:19:24 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:55966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbeI2ETX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:19:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B82FB180295A0;
        Fri, 28 Sep 2018 21:53:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fang54_5a4ef75302e40
X-Filterd-Recvd-Size: 2854
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:53:40 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Bad MAINTAINERS pattern in section 'INTEL PMC CORE DRIVER'
Date:   Fri, 28 Sep 2018 14:53:39 -0700
Message-Id: <20180928215339.29516-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	7441	INTEL PMC CORE DRIVER
	7442	M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
	7443	M:	Vishwanath Somayaji <vishwanath.somayaji@intel.com>
	7444	L:	platform-driver-x86@vger.kernel.org
	7445	S:	Maintained
-->	7446	F:	arch/x86/include/asm/pmc_core.h
	7447	F:	drivers/platform/x86/intel_pmc_core*

Commit that introduced this:

commit 7683e9e529258d01ce99216ad3be21f59eff83ec
 Author: Linus Torvalds <torvalds@linux-foundation.org>
 Date:   Sun Jul 23 16:06:21 2017 -0700
 
     Properly alphabetize MAINTAINERS file
     
     This adds a perl script to actually parse the MAINTAINERS file, clean up
     some whitespace in it, warn about errors in it, and then properly sort
     the end result.
     
     My perl-fu is atrocious, so the script has basically been created by
     randomly putting various characters in a pile, mixing them around, and
     then looking it the end result does anything interesting when used as a
     perl script.
     
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
 
  MAINTAINERS                  | 3585 +++++++++++++++++++++---------------------
  scripts/parse-maintainers.pl |   77 +
  2 files changed, 1868 insertions(+), 1794 deletions(-)

Last commit with arch/x86/include/asm/pmc_core.h

commit 941691ef2197944a202d7870dcd7da3fb0391c65
Author: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Date:   Wed Jan 31 11:50:22 2018 +0530

    platform/x86: intel_pmc_core: Remove unused header file
    
    Recently sent patch 'platform/x86: intel_pmc_core: Remove unused EXPORTED
    API' missed to remove the header file 'arch/x86/include/asm/pmc_core.h'
    which was solely used to declare the EXPORTED API
    'intel_pmc_slp_s0_counter_read'. This patch provides the errata fix for the
    same.
    
    Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

 arch/x86/include/asm/pmc_core.h       | 27 ---------------------------
 drivers/platform/x86/intel_pmc_core.c |  1 -
 2 files changed, 28 deletions(-)

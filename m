Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57286C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D135206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D135206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeI2E1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:27:18 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:35026 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbeI2E1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:27:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C8F02180A814D;
        Fri, 28 Sep 2018 22:01:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fog07_d7b890405e5c
X-Filterd-Recvd-Size: 2948
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:01:32 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Bad MAINTAINERS pattern in section 'PARALLEL LCD/KEYPAD PANEL DRIVER'
Date:   Fri, 28 Sep 2018 15:01:31 -0700
Message-Id: <20180928220131.31075-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	11056	PARALLEL LCD/KEYPAD PANEL DRIVER
	11057	M:	Willy Tarreau <willy@haproxy.com>
	11058	M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
	11059	S:	Odd Fixes
	11060	F:	Documentation/auxdisplay/lcd-panel-cgram.txt
-->	11061	F:	drivers/misc/panel.c

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

Last commit with drivers/misc/panel.c

commit 51c1e9b554c996284d5d3bd44da829f41a49a21b
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Apr 4 20:25:21 2017 +0300

    auxdisplay: Move panel.c to drivers/auxdisplay folder
    
    It looks like panel.c belongs to auxdisplay subsystem.
    
    Move it to drivers/auxdisplay folder.
    No functional changes intended.
    
    Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 drivers/auxdisplay/Kconfig           | 280 +++++++++++++++++++++++++++++++++++
 drivers/auxdisplay/Makefile          |   1 +
 drivers/{misc => auxdisplay}/panel.c |   0
 drivers/misc/Kconfig                 | 280 -----------------------------------
 drivers/misc/Makefile                |   1 -
 5 files changed, 281 insertions(+), 281 deletions(-)

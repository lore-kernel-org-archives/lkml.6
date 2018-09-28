Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BCC64E93
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F31A20779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F31A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeI2Ea4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:30:56 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:35297 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbeI2Eaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DF819180A812F;
        Fri, 28 Sep 2018 22:05:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boat52_2cf841e38ea0f
X-Filterd-Recvd-Size: 2282
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:05:08 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: Bad MAINTAINERS pattern in section 'USER-MODE LINUX (UML)'
Date:   Fri, 28 Sep 2018 15:05:07 -0700
Message-Id: <20180928220507.31886-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	15491	USER-MODE LINUX (UML)
	15492	M:	Jeff Dike <jdike@addtoit.com>
	15493	M:	Richard Weinberger <richard@nod.at>
	15494	L:	linux-um@lists.infradead.org
	15495	W:	http://user-mode-linux.sourceforge.net
	15496	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
	15497	S:	Maintained
	15498	F:	Documentation/virtual/uml/
	15499	F:	arch/um/
	15500	F:	arch/x86/um/
	15501	F:	fs/hostfs/
-->	15502	F:	fs/hppfs/

Commit that introduced this:

commit 679655daffdd2725b66ba2c5a759bbcb316fca5a
 Author: Joe Perches <joe@perches.com>
 Date:   Tue Apr 7 20:44:32 2009 -0700
 
     MAINTAINERS - Add file patterns
     
     Better description of file pattern tag "F:"
     Add file exclusion tag "X:"
     Add patterns to sections
     
     Signed-off-by: Joe Perches <joe@perches.com>
 
  MAINTAINERS | 1194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
  1 file changed, 1193 insertions(+), 1 deletion(-)

Last commit with fs/hppfs/

commit f74a14e870c80d6261afed66d4bad779c1213e03
Author: Richard Weinberger <richard@nod.at>
Date:   Tue Apr 21 20:52:26 2015 +0200

    um: Remove hppfs
    
    hppfs (honeypot procfs) was an attempt to use UML as honeypot.
    It was never stable nor in heavy use.
    
    As Al Viro and Christoph Hellwig pointed some major issues out
    it is better to let it die.
    
    Signed-off-by: Richard Weinberger <richard@nod.at>

 arch/um/Kconfig.um |  15 --
 fs/Makefile        |   1 -
 fs/hppfs/Makefile  |   6 -
 fs/hppfs/hppfs.c   | 766 -----------------------------------------------------
 4 files changed, 788 deletions(-)

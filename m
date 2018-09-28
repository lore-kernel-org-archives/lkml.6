Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606BBC004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E464206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E464206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeI2ERL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:17:11 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:59422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbeI2ERL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:17:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E0140100E86C4;
        Fri, 28 Sep 2018 21:51:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smell83_4715ffb24f109
X-Filterd-Recvd-Size: 3069
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:51:28 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>
Subject: Bad MAINTAINERS pattern in section 'ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT'
Date:   Fri, 28 Sep 2018 14:51:26 -0700
Message-Id: <20180928215127.28790-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	2009	ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
	2010	M:	Kyungmin Park <kyungmin.park@samsung.com>
	2011	M:	Kamil Debski <kamil@wypas.org>
	2012	M:	Jeongtae Park <jtp.park@samsung.com>
	2013	M:	Andrzej Hajda <a.hajda@samsung.com>
	2014	L:	linux-arm-kernel@lists.infradead.org
	2015	L:	linux-media@vger.kernel.org
	2016	S:	Maintained
-->	2017	F:	arch/arm/plat-samsung/s5p-dev-mfc.c
	2018	F:	drivers/media/platform/s5p-mfc/

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

Last commit with arch/arm/plat-samsung/s5p-dev-mfc.c

commit b93b315d444faa1505b6a5e001c30f3024849e46
Author: Kukjin Kim <kgene@kernel.org>
Date:   Thu Jul 30 01:48:17 2015 +0900

    ARM: SAMSUNG: make local s5p-dev-mfc in mach-exynos
    
    This patch moves s5p-dev-mfc from plat-samsung into mach-exynos
    because it is used for only exynos no other platforms.
    
    Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
    Signed-off-by: Kukjin Kim <kgene@kernel.org>

 arch/arm/mach-exynos/Kconfig                         | 5 +++++
 arch/arm/mach-exynos/Makefile                        | 2 ++
 arch/arm/{plat-samsung => mach-exynos}/s5p-dev-mfc.c | 0
 arch/arm/plat-samsung/Kconfig                        | 5 -----
 arch/arm/plat-samsung/Makefile                       | 1 -
 5 files changed, 7 insertions(+), 6 deletions(-)

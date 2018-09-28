Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96159C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64326206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64326206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeI2ERQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:17:16 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:40508 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbeI2ERP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:17:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 83C8C182CED34;
        Fri, 28 Sep 2018 21:51:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hour17_47d467ab5fc0a
X-Filterd-Recvd-Size: 2857
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:51:33 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Bad MAINTAINERS pattern in section 'ARM/Synaptics Berlin SoC support'
Date:   Fri, 28 Sep 2018 14:51:32 -0700
Message-Id: <20180928215132.28867-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	2111	ARM/Synaptics Berlin SoC support
	2112	M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
	2113	M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
	2114	L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
	2115	S:	Maintained
	2116	F:	arch/arm/mach-berlin/
	2117	F:	arch/arm/boot/dts/berlin*
-->	2118	F:	arch/arm64/boot/dts/marvell/berlin*

Commit that introduced this:

commit bc52497a595d2246923749177d99e4216703b0f4
 Author: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
 Date:   Fri Mar 30 11:02:11 2018 +0800
 
     MAINTAINERS: update entry for ARM/berlin
     
     Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
     So change the berlin entry name and move it to its alphabetical
     location. We move to ARM/Synaptics instead of ARM/Marvell.
     
     This patch also updates my email address from marvell to synaptics.
     
     [1] https://www.synaptics.com/company/news/conexant-marvell
     
     Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
 
  MAINTAINERS | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

Last commit with arch/arm64/boot/dts/marvell/berlin*

commit 031106ce95a201f6dd4c5ebf35abb900cf34e2ba
Author: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date:   Wed May 16 17:43:28 2018 +0800

    arm64: dts: move berlin SoC files from marvell dir to synaptics dir
    
    Move device tree files as part of transition from Marvell berlin to
    Synaptics berlin.
    
    Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

 arch/arm64/boot/dts/Makefile                                 | 1 +
 arch/arm64/boot/dts/marvell/Makefile                         | 4 ----
 arch/arm64/boot/dts/synaptics/Makefile                       | 4 ++++
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi    | 0
 6 files changed, 5 insertions(+), 4 deletions(-)

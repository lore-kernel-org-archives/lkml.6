Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3438CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54CF217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NhMBpiTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54CF217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeHDGsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:48:22 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64044 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHDGsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:48:21 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w744lBUd027764;
        Sat, 4 Aug 2018 13:47:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w744lBUd027764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533358032;
        bh=Z/L2kTHPiGConeFBI3Xf0SKHrgDQmudCHaDSUkpYBjU=;
        h=From:To:Cc:Subject:Date:From;
        b=NhMBpiTu/CanJiYdC/ppDqDD95Tse0co4Q3n2IXqI6Uuoz7PlNChMnob4HXYkxLFR
         dro8OMv/KNTOjlkHZqCWnEY630MhUT+4vAbTvkDe/MeD0Yghh/MrGNv8UOS25zk7pz
         jh7wHOGy2c4vJqx58G4twwAoKJUzHMK0RF7fPicg82y5ZfdZsfGjnIe+qmmUrsE9EO
         ko1YnTSiBFjROvJYTkIPYu6HRQz2Dl7T4SHxUOD4v0iQcupdGq1V6PVCuX4enJ43IF
         Y6IVPthdbhVYBJquKYfL3CuflxPolxpKW5YNpDJ2Ur03Nn4pIyFzLL/eLTStOW4/b6
         ymrTHDCGwd+Ow==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Kbuild: fix and clean-up arch/um/Makefile
Date:   Sat,  4 Aug 2018 13:47:00 +0900
Message-Id: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1/3 fixes the build failure reported by Randy.
(I may have seen a similar report before, but I cannot recall it.)

2/3 and 3/3 clean-up the Makefile a bit more.

I'd like to apply this series to kbuild tree.
Ack from UML folks are appreciated.



Masahiro Yamada (3):
  um: fix parallel building with O= option
  kbuild: add %asm-generic to no-dot-config-targets
  um: clean up archheaders recipe

 Makefile         | 2 +-
 arch/um/Makefile | 9 +--------
 2 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.7.4


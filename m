Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6870DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37199206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37199206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeI2EZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:25:14 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:60009 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbeI2EZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:25:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 86B14100E86C2;
        Fri, 28 Sep 2018 21:59:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk25_8d1bd519aea45
X-Filterd-Recvd-Size: 2750
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:59:29 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: Bad MAINTAINERS pattern in section 'MIPS/LOONGSON3 ARCHITECTURE'
Date:   Fri, 28 Sep 2018 14:59:28 -0700
Message-Id: <20180928215928.30611-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	9766	MIPS/LOONGSON3 ARCHITECTURE
	9767	M:	Huacai Chen <chenhc@lemote.com>
	9768	L:	linux-mips@linux-mips.org
	9769	S:	Maintained
	9770	F:	arch/mips/loongson64/
	9771	F:	arch/mips/include/asm/mach-loongson64/
	9772	F:	drivers/platform/mips/cpu_hwmon.c
-->	9773	F:	drivers/*/*loongson3*
	9774	F:	drivers/*/*/*loongson3*

Commit that introduced this:

commit ffe1f9356fbe55df7dd7f7f6b050ee8b7136611f
 Author: Huacai Chen <chenhc@lemote.com>
 Date:   Thu Dec 7 14:31:08 2017 +0800
 
     MAINTAINERS: Add Loongson-2/Loongson-3 maintainers
     
     Add Jiaxun Yang as the MIPS/Loongson-2 maintainer and add Huacai Chen
     as the MIPS/Loongson-3 maintainer.
     
     [ralf@linux-mips.org: Don't put all of drivers/platform/mips/ into these
     two entries but rather only the files required even though at this time
     the Loongson platforms are the only users of drivers/platform/mips/.]
     
     Signed-off-by: Huacai Chen <chenhc@lemote.com>
     Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
     Cc: Linus Torvalds <torvalds@linux-foundation.org>
     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     Cc: Stephen Rothwell <sfr@canb.auug.org.au>
     Cc: James Hogan <james.hogan@mips.com>
     Cc: Rui Wang <wangr@lemote.com>
     Cc: Binbin Zhou <zhoubb@lemote.com>
     Cc: Ce Sun <sunc@lemote.com>
     Cc: Yao Wang <wangyao@lemote.com>
     Cc: Liangliang Huang <huangll@lemote.com>
     Cc: Fuxin Zhang <zhangfx@lemote.com>
     Cc: Zhangjin Wu <wuzhangjin@gmail.com>
     Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
     Cc: r@hev.cc
     Cc: zhoubb.aaron@gmail.com
     Cc: huanglllzu@163.com
     Cc: 513434146@qq.com
     Cc: 1393699660@qq.com
     Cc: linux-mips@linux-mips.org
     Cc: linux-kernel@vger.kernel.org
     Cc: Huacai Chen <chenhc@lemote.com>
     Patchwork: https://patchwork.linux-mips.org/patch/17888/
     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
     Signed-off-by: James Hogan <jhogan@kernel.org>
 
  MAINTAINERS | 19 +++++++++++++++++++
  1 file changed, 19 insertions(+)

No commit with drivers/*/*loongson3* found


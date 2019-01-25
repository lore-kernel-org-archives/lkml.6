Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05270C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF62021934
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l1MuJiXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfAYH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:58:43 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:17312 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbfAYH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:58:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0P7vbeO015362;
        Fri, 25 Jan 2019 16:57:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7vbeO015362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548403058;
        bh=bWGogFjdAjj5RntcVo7bEd6FALUn0TMsMmCN+Olj4yo=;
        h=From:To:Cc:Subject:Date:From;
        b=l1MuJiXFUIFlza3PP+5weoV+BVc2KSSt0yW/goI30hKYK11EamxvVPXgbOR7Dp1MC
         bp1AjEowo5k1qBksnR+ZI+T6KPdJGEzr8vsy0np1LTOvVIj849aDR77EG8hWBuF3f6
         W2vymEKv6dIHhUVoN4QkspuvD0Kw2iJurAcwyEDHKEUIBIFK/NpikCk0w8gf7exjif
         OgpKLpDZqEshxWTzQoG1Pv71dormKaPb9JVs731I4hMmRTpi9Ldr1JQrQXQQPfEpEs
         U4ptO+dEPQlL+n0soZpmzmbQfMf+DDHUTxR9VaOVbFgD4JOeEnWHH3uTQhoA2aH4Ua
         tsYhXASfRE8DA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 0/3] KVM: arm/arm64: trivial header path sanitization
Date:   Fri, 25 Jan 2019 16:57:27 +0900
Message-Id: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My main motivation is to get rid of crappy header search path manipulation
from Kbuild core.

Before that, I want to finish as many cleanup works as possible.

If you are interested in the big picture of this work,
the full patch set is available at:

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test



Masahiro Yamada (3):
  KVM: arm/arm64: fix TRACE_INCLUDE_PATH
  KVM: arm/arm64: remove -I. header search paths
  KVM: arm/arm64: prefix header search paths with $(srctree)/

 arch/arm/kvm/Makefile   | 5 ++---
 arch/arm64/kvm/Makefile | 4 +---
 virt/kvm/arm/trace.h    | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.7.4


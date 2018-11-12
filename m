Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29849214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Y5+jxYWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29849214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeKLM3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:29:30 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:16506 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbeKLM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:29:29 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAC2ZqVS015801;
        Mon, 12 Nov 2018 11:35:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAC2ZqVS015801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541990153;
        bh=QNuGxZanL/Y+BPrezzzgYjKa+CWGG7l6IBD17r6BlRs=;
        h=From:To:Cc:Subject:Date:From;
        b=Y5+jxYWhfiq1HNEpgyGIjnSw3pk5W0nWi/6VdfnIo76V8PXlnRKAi3gBUhfXopzox
         f7bNoaO97n7KLp6WFQNuzYoXJ0Qc123JxrQRKFXgVvLgmyoG9RsbVs+jqGRe/HZG/D
         6lkPYpa2EmpeGv9ScsMCfeUXZL3x54uNKGVXFpbDcuQYjCAfsL2tYanubLFGAvsyOL
         1ZK11KdgOHwzSKMXIALZs+KWiUqEornER0ZZ0VQAoDuUm3ZXmWBuvLGhpbYJtGDoP+
         EUsHrXSwLfjpSvvCLzjqAvVZ12H6hkQ/YpZOB+s4Qx3QctRx6D73saIEVqY8y4oP68
         +Rbj8wdhR1Z5A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Richard Weinberger <richard@sigma-star.at>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/2] Remove -fno-unit-at-a-time and -funit-at-a-time compiler flags entirely
Date:   Mon, 12 Nov 2018 11:35:18 +0900
Message-Id: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1/2: remove dead code, which is logically obvious
     because the minimum GCC version is now 4.6

2/2: we can say -funit-at-a-time is no longer useful
     according to GCC 4.6 manual

I hope, this series can be applied through x86 tree.



Masahiro Yamada (2):
  um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
  x86, powerpc: remove -funit-at-a-time compiler option entirely

 arch/powerpc/Makefile | 4 ----
 arch/x86/Makefile     | 4 ----
 arch/x86/Makefile.um  | 9 ---------
 3 files changed, 17 deletions(-)

-- 
2.7.4


Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B13C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244A821CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="shOtRKXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244A821CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeGCBw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:52:56 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:20959 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbeGCBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:52:53 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w631oqZm012779;
        Tue, 3 Jul 2018 10:50:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w631oqZm012779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530582653;
        bh=KYcnS3UAtiFS+uhKGua+TymVdMNmbwjw2SsFpudf+eg=;
        h=From:To:Cc:Subject:Date:From;
        b=shOtRKXQGWh4EqxF9rGiXOa0VaiBy0lHpE3eCBHOnLDuu0Fqz6XXb6mrdPMq0e7Vx
         hITTwIVHr+n/BMGkOZSAnlH/VDI/ElOx8nFdR0yipN7JOdyIdHvU+NGrfb4MsB6yjt
         5vLge3u4ucOk5mAI08YhCs5QjGw4WDKUdDiVZfO0MaUj0dCsX4QVAnub9Wf3Hdg6KU
         rnuerZl1ISYGpvxWwuTpFDkaiPwBhML1mM8EHTcSn+lI36K35wNjghzwG2Pjz/KK74
         VZHlzGcFrEzzbpFUkmpIYyAERZfdbtEIHEhRgv27dvvkhqmT+BOoRmxr7L6qaZDCx+
         F7VhwU2xp3JSw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Andy Lutomirski <luto@kernel.org>,
        Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 0/2] x86/build/vdso: a little more Makefile cleanups
Date:   Tue,  3 Jul 2018 10:50:12 +0900
Message-Id: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


At first, I sent the first patch to UML ML,
but they did not pick it up.
Instead, I was able to get Acked-by from Richard,
one of the UML maintainers.

https://patchwork.kernel.org/patch/10399787/

I am resending it to x86 ML.



Masahiro Yamada (2):
  x86/build/vdso: remove unused vdso-syms.lds
  x86/build/vdso: simplify cmd_vdso2c

 arch/x86/entry/vdso/Makefile |  4 +---
 arch/x86/um/vdso/.gitignore  |  1 -
 arch/x86/um/vdso/Makefile    | 16 ----------------
 3 files changed, 1 insertion(+), 20 deletions(-)

-- 
2.7.4


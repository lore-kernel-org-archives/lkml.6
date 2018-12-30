Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8B3C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B952084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="k/nU8YDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeL3QIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:08:18 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:38398 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeL3QIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:08:18 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 3C1735C09B9;
        Sun, 30 Dec 2018 17:08:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1546186096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=HaH+ectJntGjYeol3GIRZzeglaAV6+fvFtypLoSDJlo=;
        b=k/nU8YDrqgVgTTht/tKsdyXMqQPlj6oxZyEfAzEI6cjBCJ+jSNWPr3iyvzP0EucyoRcFq4
        oxK25DEUFmdbAEmnPREVKxcF+v72w2QrMcVhNVzbU5vRFsEL4hPKvRNQThS/Mni3cGKAEZ
        Os+jIYJFNaEAv2/7HOa2vYRWslJ6CY0=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 0/3] ARM: trivial assembly fixes to enable LLVM as
Date:   Sun, 30 Dec 2018 17:08:16 +0100
Message-Id: <cover.1546185298.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the last few days I tried compiling the kernel for ARM32 with
LLVMs integrated assembler. The elephant in the room is definitely the
unified syntax which is required by the LLVM assembler. I converted most
mnemonics using a regex, but it is not perfect and needs some manual fixes.
I am not sure if this is the right approach, feedback welcome. I plan to
send fixes in groups in the next few weeks, if that effort is welcome.

There are a couple of other issues besides unified syntax, e.g. lack of
feature argument parsing (e.g. armv7-a+sec).

This patchset is a starting point to enable LLVM integrated assembler and
contains some trivial changes. With this patchset the LLVM integrated
assembler can be used to assemble almost all C files.

Stefan Agner (3):
  ARM: fix argument count to match macro definition
  ARM: uaccess: use unified assembler language syntax
  ARM: spinlock: use unified assembler language syntax

 arch/arm/include/asm/spinlock.h | 2 +-
 arch/arm/include/asm/uaccess.h  | 2 +-
 arch/arm/lib/copy_template.S    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1


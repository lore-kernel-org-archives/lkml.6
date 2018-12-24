Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B130C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F83218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545692319;
	bh=8fmQdtF6LCJWlBCQmfCrygRNCFTG5RnzmkK+BlVh0u4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=JLMb/DovGwrcBwORsvv2keTb+olpVcfQd1ZkXsIYZ2fyQIdEySKOHk1YEMhyUAS7v
	 LpXK19SWfhzOmo1v6P6ihBD68ZPBKeWVCDU+d2P0OTGfawT8ZCMZHySvugBnxkVxyR
	 qqbTRN+nUO7eRmyRgQvgspzaz24hlS9cTN9fwpTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbeLXW6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:58:37 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:50298 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXW6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:58:37 -0500
Received: by mail-wm1-f47.google.com with SMTP id n190so12068851wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2RLiR110ag0+6woys/nIxBkOIf4y7vt17rWq2+OAZDI=;
        b=A9HRykOh4+1lI4pC/a64E2Zm+S0vffvblXSDt3rpV57VLe5ZHrT/rQP7khXVPHzVGj
         W1krUYZ4k6hNpNnxhFSHFNW4/4MNJHsJq2anCcQFIpu+95jMbhiRuhPu12K4IsgSaz8/
         2Uky9PUW6i8WBGguiiis05sdUOt5JDYhgZtJqTe6+pU5WygMQLvWCS6uW36wSmXseQh8
         aoGg26KnzX8mkxOQrzQ3N6LX6Fe/AIW/eaQ1M8XZrGypgpWOI03H6XRCtTYx5XrWZ7LH
         0Z1zxSIU5Jm2+oI1s4vmYCQ4LW5LU2eLRUq35a8jU02m+cPhWMPhSIkcQsQ8X/bi708l
         k6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=2RLiR110ag0+6woys/nIxBkOIf4y7vt17rWq2+OAZDI=;
        b=J1NeTZJ1jkyjb6ECscypi7R2EfXNrRZ7yAOyWaz0uQwaYMlBY6gfg4v95qily0DVDL
         Lh7WiGp1CSkFvfPAqM23+XMJA7Kjf7Cji7oYHiOHQmwz/Yze2lh/k/nCJFlrN4Euivg5
         4jh8bGarFXCTegj1J6Q72bAxkAsedcAI/ZM4rC8coqZwzkWdVQ4Ex1wI7sAMYyr5v3S9
         NFzPCH9HknJ6WW7yZ1TOhO+uiHQ6KEA4CGtHk1scVsLxP3wn9ORul9RyN12EeXp88dqF
         XZBe7oLZ0uN0xIHF7y1TbY1Lw9XsuW2hx6v9S7xuiLgRfeegZIRIR2Kbex4Emix0721D
         /5Fg==
X-Gm-Message-State: AA+aEWYocjoXGWYfz1AN1PqpJyLN2duFkQKPCQ2R64RumOP8pPwbqGCJ
        93S1hIjF38Fw/VzeTCFS2Q0=
X-Google-Smtp-Source: ALg8bN4HPOLP1Kd4PRPhe3K0tZlyUN5CiYQIoSPgKZ7c3fWVN9y7rbQEG37riXqlIZG2hNCPOnNR7w==
X-Received: by 2002:a1c:6e06:: with SMTP id j6mr13710732wmc.3.1545692314680;
        Mon, 24 Dec 2018 14:58:34 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a62sm19153346wmf.47.2018.12.24.14.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:58:33 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:58:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] x86/build changes for v4.21
Message-ID: <20181224225831.GA36544@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: e4f752dda0de351efd198f438b68e743029da68a x86/um/vdso: Drop implicit common-page-size linker flag

 - resolve LLVM build bug by removing redundant GNU specific flag

 - remove obsolete -funit-at-a-time and -fno-unit-at-a-time use from x86 
   PowerPC and UM.

The UML change was seen and acked by UML maintainer Richard Weinberger.

  out-of-topic modifications in x86-build-for-linus:
  ----------------------------------------------------
  arch/powerpc/Makefile              # 63fea0af43af: x86, powerpc: Remove -funit-

 Thanks,

	Ingo

------------------>
Masahiro Yamada (2):
      x86/um: Remove -fno-unit-at-a-time workaround for pre-4.0 GCC
      x86, powerpc: Remove -funit-at-a-time compiler option entirely

Nick Desaulniers (1):
      x86/um/vdso: Drop implicit common-page-size linker flag


 arch/powerpc/Makefile     | 4 ----
 arch/x86/Makefile         | 4 ----
 arch/x86/Makefile.um      | 9 ---------
 arch/x86/um/vdso/Makefile | 2 +-
 4 files changed, 1 insertion(+), 18 deletions(-)

Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F45C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZaaZGP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E3520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJWUEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:04:44 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:34313 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:04:44 -0400
Received: by mail-wm1-f41.google.com with SMTP id z25-v6so11417000wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MMJmjMZDiegL05twTYGG/uUvJOumkvYrEzwG00EtUfs=;
        b=HZaaZGP1xHdONIn4S/dI/xTkwQw4CtvwKJJ4k9OjHj6GP8FzefllcAL5/lLcyqI3hj
         XlLHBVpLKyznBVxWQIqvOCroVoTIJK57tTb1QefR+KsG6sUMoOKIAL7QJFrjyqwB4miR
         E8anUkpHvHaoKo84iAhLJMHaaLvAqTQrKlJTIZER01fA+6YYf7b3bd9f8VtlEls/qCHb
         g7A8fQArAYv9Ar/loMFMptKKhOrSWZo1JnlHIoM7kRusrvaXn14nWIISljjvCb4HX8uB
         14k2FoKIWYiNw55PBgRknugO0xmueAjk3htKxdY4syA+W/kDryGGN89FKoInybXGzyWG
         xoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=MMJmjMZDiegL05twTYGG/uUvJOumkvYrEzwG00EtUfs=;
        b=WFQ5u/7uKUA9XVFE8t6OW90IHgDG6wHZ3/tuDCxS8HWgdnts4SkzAWgXfzh1amWJi4
         1ymTRn4AOrsnr2lEAzeWkVvDUj5WlgYK1aGLbkMMwFbioEmR2adZWWDKq1qVOvAyUzwm
         jZbNB8gsomwcm9Kukyd6xxROBYaXM9QDp9DcIgtqW5cNFszM+M6+7KShKEthrgRpCt+X
         es5hsf+Aansbp/r64UMk+s0sMHFDicThUayz0G5opdw84YSwDGyS2OIDid8oZebemg+j
         m1vahz1mXPhowh4EYfWQq6iqM9ewNVygsvw48brhhFgPGYps5z1jnPKrqDuqjyBaOgR6
         QMKQ==
X-Gm-Message-State: ABuFfoi07kmtDMextMRaZSkp0h9pzKoSxCU3MSXCf1PXvcYwZe/ZltN2
        gn6nCkimTJYHQv4ErkcY+UU=
X-Google-Smtp-Source: ACcGV61FqoJJ2ebjfZXNP/1TDz2xWc7oVQ0p8roxXLuCaQ0e0ICZU7xYx+22PtPyNFCTO/n5BFJp4Q==
X-Received: by 2002:a1c:7ed4:: with SMTP id z203-v6mr19538632wmc.62.1540294895596;
        Tue, 23 Oct 2018 04:41:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q77-v6sm2542936wmd.33.2018.10.23.04.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:41:35 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:41:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>
Subject: [GIT PULL] x86/grub2 changes for v4.20
Message-ID: <20181023114132.GA119389@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-grub2-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-grub2-for-linus

   # HEAD: e7b66d16fe41722350ba87f5788052ef53ee28bb x86/acpi, x86/boot: Take RSDP address for boot params if available

This tree extends the x86 boot protocol to include an address for the 
RSDP table - utilized by Xen currently. Matching Grub2 patches are 
pending as well. (Juergen Gross)

 Thanks,

	Ingo

------------------>
Juergen Gross (3):
      x86/xen: Fix boot loader version reported for PVH guests
      x86/boot: Add ACPI RSDP address to setup_header
      x86/acpi, x86/boot: Take RSDP address for boot params if available


 Documentation/x86/boot.txt            | 32 +++++++++++++++++++++++++++++++-
 arch/x86/boot/header.S                |  6 +++++-
 arch/x86/include/asm/acpi.h           |  7 +++++++
 arch/x86/include/asm/x86_init.h       |  2 ++
 arch/x86/include/uapi/asm/bootparam.h |  4 ++++
 arch/x86/kernel/acpi/boot.c           |  6 ++++++
 arch/x86/kernel/head32.c              |  1 +
 arch/x86/kernel/head64.c              |  2 ++
 arch/x86/kernel/setup.c               | 17 +++++++++++++++++
 arch/x86/kernel/x86_init.c            |  3 +--
 arch/x86/xen/enlighten_pvh.c          |  2 +-
 11 files changed, 77 insertions(+), 5 deletions(-)


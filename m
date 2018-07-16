Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D71ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACE220844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Ta2D0CGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACE220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeGPMsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:48:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37182 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbeGPMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:48:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so2594386eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JkRzUpVSbLz8pSh84iRWw/9lE0/Y3iCMZEHP5BGx5XI=;
        b=Ta2D0CGUytyb9IcWvSkq+AXvnm6UBKNsyoq/Ra4/DgAarMRScCbeHwVseXAC1ZNEeZ
         fsim27NwuvV+myYmQ/PI/uLdiaXLfVlXerWwHkSxNEt14u2s5xO47zFIj5n1sUKtcV9N
         ZsKqaLRN8LR6+DTkTP9R1dz1uuUojQUI7vGuY4elX27hgb0xuVp2AZLFtuWXN2Skrut6
         afTYhKnfnAwRcZu/ZiDVzTqWaMrI3CGuvNnAfXL3GjZbvblc0rKmiAo/uiwFUbzdwjOJ
         HZsBV9Oi7T2ylq7hJfnyM4UcjOH8Guk+H7TIrscJrMV8OwCT3mGSB8gl/U2F8kRrRZke
         Ll9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JkRzUpVSbLz8pSh84iRWw/9lE0/Y3iCMZEHP5BGx5XI=;
        b=CqLTlZJs3mD+JWQZsN9Y53h+jLcEvzXYYTmiAM9nN0Oap6SuJumEc1tp1af17hF03W
         k1KE6Y7cafXoVTEwZjN08Frdek404DLDzO2GYS+2b3E+2c3uLAk6zmdFacF75BL/piV8
         m2qRC1dwHDQsF2yeK9qEZJPc9nHOtzb5PHztXdG6qHXIYZY7YNYDambtF1ujnEqjycJS
         jQRBK02beWJul/bN8CKvy/F1YfEFsXWkzvNIGwYXrLHirv0wqCc3gYFW9p4lztR9pDOv
         b1GtmtTxM88Arvq5HEXBskyEcmWD/JPYoX2XbDV2OTrjNg/un0QE+IjqrMetiTnAI2ce
         fdvQ==
X-Gm-Message-State: AOUpUlEpYYICFWu6EemJ+PNt5Abz5BVVtVhGeRsD+DN9MiknBT/XIf0U
        14qUGoScib9gjikfF8/HIoQVkZUsS8c=
X-Google-Smtp-Source: AAOMgpcFgYt7PHwbJTIbBCfHF2IzRE6hNQ55De3LR9jPPfM/21+NNsqbO82wG295WM2AI9c/3699gQ==
X-Received: by 2002:a50:da01:: with SMTP id z1-v6mr17330336edj.62.1531743692737;
        Mon, 16 Jul 2018 05:21:32 -0700 (PDT)
Received: from maco.fcp3.net (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a9-v6sm4635471edi.26.2018.07.16.05.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:21:31 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, maco@google.com, sspatil@google.com,
        malchev@google.com, joelaf@google.com
Subject: [PATCH 0/6] Symbol namespaces
Date:   Mon, 16 Jul 2018 14:21:19 +0200
Message-Id: <20180716122125.175792-1-maco@android.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of Linux 4.17, there are more than 30000 exported symbols
in the kernel. There seems to be some consensus amongst
kernel devs that the export surface is too large, and hard
to reason about.

Generally, these symbols fall in one of these categories:
1) Symbols actually meant for drivers
2) Symbols that are only exported because functionality is
   split over multiple modules, yet they really shouldn't
   be used by modules outside of their own subsystem
3) Symbols really only meant for in-tree use

When module developers try to upstream their code, it
regularly turns out that they are using exported symbols
that they really shouldn't be using. This problem is even
bigger for drivers that are currently out-of-tree, which
may be using many symbols that they shouldn't be using,
and that break when those symbols are removed or modified.

This patch allows subsystem maintainers to partition their
exported symbols into separate namespaces, and module
authors to import such namespaces only when needed.

This allows subsystem maintainers to more easily limit
availability of these namespaced symbols to other parts of
the kernel. It can also be used to partition the set of
exported symbols for documentation purposes; for example,
a set of symbols that is really only used for debugging
could be in a "SUBSYSTEM_DEBUG" namespace.

Martijn Coenen (6):
  export: explicitly align struct kernel_symbol.
  module: add support for symbol namespaces.
  modpost: add support for checking symbol namespaces.
  modpost: add support for generating namespace dependencies.
  scripts: Coccinelle script for namespace dependencies.
  RFC: USB: storage: move symbols into USB_STORAGE namespace.

 Makefile                            |  11 +++
 arch/m68k/include/asm/export.h      |   1 -
 arch/x86/include/asm/Kbuild         |   1 +
 arch/x86/include/asm/export.h       |   5 --
 drivers/usb/storage/alauda.c        |   1 +
 drivers/usb/storage/cypress_atacb.c |   1 +
 drivers/usb/storage/datafab.c       |   1 +
 drivers/usb/storage/ene_ub6250.c    |   1 +
 drivers/usb/storage/freecom.c       |   1 +
 drivers/usb/storage/isd200.c        |   1 +
 drivers/usb/storage/jumpshot.c      |   1 +
 drivers/usb/storage/karma.c         |   1 +
 drivers/usb/storage/onetouch.c      |   1 +
 drivers/usb/storage/realtek_cr.c    |   1 +
 drivers/usb/storage/sddr09.c        |   1 +
 drivers/usb/storage/sddr55.c        |   1 +
 drivers/usb/storage/shuttle_usbat.c |   1 +
 drivers/usb/storage/uas.c           |   1 +
 drivers/usb/storage/usb.c           |  20 ++---
 include/asm-generic/export.h        |   2 +-
 include/linux/export.h              |  84 ++++++++++++++-----
 include/linux/module.h              |  13 +++
 kernel/module.c                     |  79 ++++++++++++++++++
 scripts/Makefile.modpost            |   4 +-
 scripts/add_namespace.cocci         |  19 +++++
 scripts/mod/modpost.c               | 120 ++++++++++++++++++++++++++--
 scripts/mod/modpost.h               |   9 +++
 scripts/nsdeps                      |  41 ++++++++++
 28 files changed, 379 insertions(+), 44 deletions(-)
 delete mode 100644 arch/x86/include/asm/export.h
 create mode 100644 scripts/add_namespace.cocci
 create mode 100644 scripts/nsdeps

-- 
2.18.0.203.gfac676dfb9-goog


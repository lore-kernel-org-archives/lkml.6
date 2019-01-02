Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74353C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEFB20643
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOwnZd5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfABPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:07:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43249 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfABPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:07:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so15280112pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l72O1yHKskevMuQqETV1P3+jNv442XJdoumK6XZxj5E=;
        b=QOwnZd5wGvIU23cC4WECPVNiyx8pWr81BbfyBBugkfVbY7b05SUFMBfy12vaSliC+I
         MXxWoYOGSX3zgRvHoI/iNrSUTH2nakX7KWltw1w6mLMkvfuKA6FOYD7u8Mk+lAU/ElCk
         2YSynOQkYZtI+CQWKqvOOAWOkYlpJaURgitG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l72O1yHKskevMuQqETV1P3+jNv442XJdoumK6XZxj5E=;
        b=mOP/wJMKvUCLYZOPFLVb2VDQ4gEso5xLeVeTgjpByNBNKqt4Wb2F5dL3PpVEnXlSBM
         uxhP1T8q6trw8PfdCgk9yT+24mWPYdP3mdPtahStyA+I9KEbMlsFROhg5cdwGnYWio0k
         ymhlxD+NhHea8Uewhgp8y1R5NiquLrb/lcHer+p8a8SGYGo01bkpSMDknf0ihUhoHh7v
         G89ZmeEs0M4TCf+KFrF2Ht5AtEXporJNwtAdjqkS92JeXA0jzXhSmCo9qpe4ma/t8beC
         ZPn1F6vdLCRGpz0nhXESybpLWyg2yyFu+AoXNiw+mVlInTKM/fKLR69B32X3YXL3tcye
         7fSw==
X-Gm-Message-State: AJcUukfDJEG+1cqXbAiMClTQ1BOvje8f7SC0AOHpXYlZ3zb0d4ZXJ4dc
        etL190oQEyXgrttjcZOS0u+CxQ==
X-Google-Smtp-Source: ALg8bN4KBVBhJc7kYXK2p+Cg0C2cqRjNsBaaSqyzQSOkZZ9jXK/spRGN1WJJLE3c1YudBNtpo4f7iQ==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr41072134pgd.110.1546441646486;
        Wed, 02 Jan 2019 07:07:26 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id k24sm78458985pfj.13.2019.01.02.07.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:07:25 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] alpha: Unify the system call scripts
Date:   Wed,  2 Jan 2019 20:36:57 +0530
Message-Id: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System call table generation support is provided for
alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
sh, sparc and xtensa architectures. The implementat-
ions are almost similar across all the above archte-
ctures. In order to reduce the source code across all
the above architectures, create common ".sh" files and
keep it in the common directory, script/. This will 
be a generic scripts which can use for all the above
architectures.

This patch depends on;
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (2):
  alpha: remove nargs from __SYSCALL
  alpha: generate uapi header and syscall table header files

 arch/alpha/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/alpha/kernel/syscalls/syscallhdr.sh | 36 --------------------------------
 arch/alpha/kernel/syscalls/syscalltbl.sh | 32 ----------------------------
 arch/alpha/kernel/systbls.S              |  2 +-
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


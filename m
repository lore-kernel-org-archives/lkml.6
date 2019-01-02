Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0282C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B62E21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoZwWJgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfABPxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:53:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37207 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfABPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:53:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so15350476pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Wlj2Imi+ru6bAMxIUQgUfy+8uJP/NAo9+fc7ximXBpo=;
        b=eoZwWJgpJTcviof0YR5kPtaXJOC/oIHfASQciG36kCMZX5aCO59MzVvIh4BwNz7owo
         2liuapZCKvL631q3wVEll6/4ct6JbYgyqS78kDZp4I+JEFLYZ7jFnwk/pzUI4oiaZcYQ
         BWkPvFBTvF9a/wDzECyNMD5f1/ADV4t0Y+TNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wlj2Imi+ru6bAMxIUQgUfy+8uJP/NAo9+fc7ximXBpo=;
        b=b3wvO12sprEaSgEkVwVCXobbDMbhHHXrDsmUM+ERRgU4xzlFTovuBdbpAlYRdkEIDO
         37ZTdej+CtcexNBhEx55/T+L5rh3Tmv9qIhK8rSybofJrVHqiehuZ3pF22g4W8bJPNlx
         MTa0XDbTaikRkuTjlP+MQmuU0b3iL11TrKFtKlCzY7a84p20qaBkvJptzPFkLQnjR6LS
         fnm6mVk6iBZz2LYMf4lKkExsSimHr+Z6o+q/PSs80ecg5Vz/b11PmJHXmN7BGfEKlaNB
         cirf+nK0+zKptwfFXFY8MEFlJjb6vbH0whcFstNXI6lqq40nXXFJCULCNi0LvwYe7JiJ
         LUmw==
X-Gm-Message-State: AJcUuke7Cf7j6RLw9/DfCdce3DvEeG8lghi6+w5b8oB2+mAzxKRbgIA/
        wgb8s/6zPZye1M813hjdLuoUsQ==
X-Google-Smtp-Source: ALg8bN57pNwEaadWoytZ+isz2QiNupDnq+MbLP1VGOCgWMRrQGEFxLB04xDvht9c75RZV1K8Iwy6OA==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr14054549pgd.57.1546444395298;
        Wed, 02 Jan 2019 07:53:15 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n7sm95242637pff.36.2019.01.02.07.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:53:14 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/3] sparc: Unify the system call scripts
Date:   Wed,  2 Jan 2019 21:22:50 +0530
Message-Id: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
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

Firoz Khan (3):
  sparc: remove nargs from __SYSCALL
  sparc: rename not implemented system call
  sparc: generate uapi header and system call table files

 arch/sparc/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/sparc/kernel/syscalls/syscall.tbl   | 26 +++++++++++------------
 arch/sparc/kernel/syscalls/syscallhdr.sh | 36 --------------------------------
 arch/sparc/kernel/syscalls/syscalltbl.sh | 36 --------------------------------
 arch/sparc/kernel/systbls_32.S           |  3 ++-
 arch/sparc/kernel/systbls_64.S           |  4 +++-
 6 files changed, 27 insertions(+), 89 deletions(-)
 delete mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


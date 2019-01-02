Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA40C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B9218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPLC2ftD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfABQC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:02:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45000 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbfABQC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:02:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so14662964plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PXGuCJrVW20PniJ7mybEcH0RVohbyohqaTTZOSaXkz0=;
        b=DPLC2ftDLLWTiKH5I2fBT7p1Ks7YM5jEpdDrfiL7FynM3G6HXbjZWklZBRyQfj3Cg4
         3b0JPYdVpogG/+hzdtUVqPB3Yd6/kxYLMWLEHW8MRWXVdNTXDrxVdPTe3kS0/abEdJXY
         eULgGve24PoQlP87btDf1zzqp7iICWK6kbDro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PXGuCJrVW20PniJ7mybEcH0RVohbyohqaTTZOSaXkz0=;
        b=JcjUM3J966VZwfc5lDXpFDhsh3Wl8eifdLfuxCs6fuRxGFnX7nrK8jU9oU78v5IBiO
         RbNHCX63nT+HTTKCkMljE+GNL560k369Jg8DQ/O/nLmrNPgSV2EjQSqcUvOW/6xEGzCs
         4CbdVsfc8Z92zMXVR/OMEZzzL746gScpBzfkKe75uiJpj0UK1/UfKUeyZFj4ylX2AHZq
         pKTIcuGMR2E+4+OzRGuLd08TqSd4RmpNkjtUzUfXtwcA8dgH5J4qpstlOsrK1aFt17Q0
         BB7nCgGL+I3uOduoMpEIS5/x0PRfwf5GDkaXZMhBoYvhGCuRRNDEHMQDdf5um7gmnSDN
         jICw==
X-Gm-Message-State: AJcUukcHI5+P9z0k/p0Xf5G6IWaj1ifdGhtIad/YG9rR3witEILJTjWi
        v1Kq5pMo/M4xAjeX8ETPqxrj2A==
X-Google-Smtp-Source: ALg8bN6m+1wu1Mn2e2YHDFLjLcI7RgCeWKGTKcZ5aKe0pzRUqejFgYjLHXIOj9emtG8haba+ZDmtdg==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr44490679plu.127.1546444976145;
        Wed, 02 Jan 2019 08:02:56 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id s2sm104344924pfa.167.2019.01.02.08.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 08:02:55 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] parisc: Unify the system call scripts
Date:   Wed,  2 Jan 2019 21:32:31 +0530
Message-Id: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
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
  parisc: remove nargs from __SYSCALL
  parisc: generate uapi header and system call table files

 arch/parisc/kernel/syscall.S              |  2 +-
 arch/parisc/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/parisc/kernel/syscalls/syscallhdr.sh | 36 -------------------------------
 arch/parisc/kernel/syscalls/syscalltbl.sh | 36 -------------------------------
 4 files changed, 10 insertions(+), 75 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


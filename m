Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C60218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nmuqwq4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfABPMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:12:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34121 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfABPM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:12:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so14639565plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O+zrzYAxeXEOx58VUHxPqqRZ23WPNW/oAuhz7XlA5NM=;
        b=Nmuqwq4Gq1WqLiTYQpFeSfgEgot2qzGAT2KRWhAAvZ8K+4L36d78iuXjN7HPU/813f
         fG582hUxaPZmvPhtU/8TGE4qepUdiM5ZiwieRrjOx5O4uZZaKcw/lxqJKuecYL6Mo8Ur
         fBIC1NQc7p1EG9RSab0ZbPyDydiVZkLNM02co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O+zrzYAxeXEOx58VUHxPqqRZ23WPNW/oAuhz7XlA5NM=;
        b=XRv+NIBDg7Mrok6/l3sDDFrDS+YbNkpuMWKQneHu+w2siamDD4u3zNyESA2l3Iumlz
         oqQQzZrm4sVQOblqxLJF6MFtbBywVpZym4AAOIS/8uy4eYAC0BI2opQOoc6ltiGUujS4
         dAxc9mcKcC3dWpBt1ecWsqqwrkoLblShO+5y1Qiq0xjecS6ypb8ALGktJbqjxs+oBoYv
         AByXVVaoPjAk8c8XTkZb9rNrXifz7dtEmdVcFhLKAnaRFW2fDNNHxq+HDxBxkgyYPxIn
         DP7nnEOxIE3r+5q8cpGGVrEaOeUpu66sko6VvWKZ2kMpVjwm4CKD4cKfziLvRivRhFiw
         lk7w==
X-Gm-Message-State: AJcUukcVqNOeZ3KqfR0EmMdAm5gWVJ/NCiJ7/NiwTejSXOMke73m5o4c
        T2JBnfJYEHVe+ChOdOQtfgc1f2Z0hxo=
X-Google-Smtp-Source: ALg8bN56K4CT4342/qo4BYQHPPk+IPXxv9iV5HHyG4pHDYl7hbL8nh+ZCChFOR0LsaekimOfL+0jOw==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr43434339pll.187.1546441949221;
        Wed, 02 Jan 2019 07:12:29 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 125sm94973786pfd.124.2019.01.02.07.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:12:28 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] microblaze: Unify the system call scripts
Date:   Wed,  2 Jan 2019 20:42:02 +0530
Message-Id: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
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
  microblaze: remove nargs from __SYSCALL
  microblaze: generate uapi header and system call table files

 arch/microblaze/kernel/syscall_table.S        |  2 +-
 arch/microblaze/kernel/syscalls/Makefile      | 11 ++++++--
 arch/microblaze/kernel/syscalls/syscallhdr.sh | 36 ---------------------------
 arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 ------------------------
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E84F218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVDWBEEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfABO4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:56:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39140 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfABO4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:56:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so14609078pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 06:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yQZUNhRU9x643lviFmppAzPvgmfeUutu99BhDAlP9SE=;
        b=AVDWBEEUsjjgagENCFY9VlVx2VCSlcrAqY1TZQdqevIJEK1+QZnCvEqtIhB6Luw0E6
         Pg4M6lsZYw94OeOEjTB1TJiffVKt9STZbi/wqrIF5IHMRdt6q05TUiiBHFZjRatAJQ1+
         Xx+qwpFiw5hb2IDUm4u3ZyNP+1uWW0UvlAIO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yQZUNhRU9x643lviFmppAzPvgmfeUutu99BhDAlP9SE=;
        b=ZNnXPtPApCIBNEsqrzlO2ZDF0beO8PO+FIRFP6kqLZ6wnIMougLLv4ohrUD5LQWrIL
         jAQ26S8K+KQOhAOOBtJrZIipC+4/eNoCm6AV+2vkkDUyWdZcezz23nKrEzz1Reqlbt9Y
         af2ZGcpnG/MKtUo34WBDOL3nEawfS4QzAbAuil2Lu02b9Adx0G5Irr/9I55mtk12cO8Q
         jL7blU4hXvfZ9SyjziC8NW5EvloCZ4nzwa0QTbbG9Y2xZoT5eNUt2W6IJdm2S0ayMNwf
         +MQdqfMec/nUwubJVkSLykaNdMwvMb99k/mj8hhYXi3ni2mJdAaPvS0NqriBEQv7l9KN
         6NzQ==
X-Gm-Message-State: AJcUukf8USU2tQr3d+9uV4qvuYa8eZHzU/iAP2qukt40kWthqcecTNxs
        sldggEcgoKQRe0+IgkkxCxp3sQ==
X-Google-Smtp-Source: ALg8bN6CzO1XSNV0us/oGa2Obt+47jrTz0crHOIOfHsO3ST+236can8wCi/H7qVzq5ft81NYeGJaGQ==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr41063619pls.124.1546441004777;
        Wed, 02 Jan 2019 06:56:44 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5sm96745685pfz.149.2019.01.02.06.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 06:56:44 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] Unify the system call scripts
Date:   Wed,  2 Jan 2019 20:26:16 +0530
Message-Id: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
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
  mips: remove nargs from __SYSCALL
  mips: generate uapi header and system call table files

 arch/mips/kernel/scall32-o32.S          |  2 +-
 arch/mips/kernel/scall64-n32.S          |  2 +-
 arch/mips/kernel/scall64-n64.S          |  2 +-
 arch/mips/kernel/scall64-o32.S          |  2 +-
 arch/mips/kernel/syscalls/Makefile      |  6 +++---
 arch/mips/kernel/syscalls/syscallhdr.sh | 37 ---------------------------------
 arch/mips/kernel/syscalls/syscallnr.sh  | 28 -------------------------
 arch/mips/kernel/syscalls/syscalltbl.sh | 36 --------------------------------
 8 files changed, 7 insertions(+), 108 deletions(-)
 delete mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


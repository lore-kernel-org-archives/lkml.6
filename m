Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C13CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E05F218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyMqJ79J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfABP3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:29:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44100 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfABP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:29:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so14710774pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TzfxDIuhFcGaalVZm9i393UYXlotuCx1hu7UhTiNLRM=;
        b=XyMqJ79JnUDnAXiWm0gwWwFDwbZQyOO0bePDDocH5J6yXEOjFH4DF0HXgO+UHP+MFX
         7x6SOMHQlsXqARen5uSlO3kUdOKTJHdLNlzMnT/t6qfUOF9hPRCxU2ve10k9zx90qD3b
         JkC6jywrScpqEU+lgIVJ/Tx9a0oeax51sUSQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TzfxDIuhFcGaalVZm9i393UYXlotuCx1hu7UhTiNLRM=;
        b=kGPTNhcfi5KYA2knBAg7wpENSJubc8jmD/9kROogXTo5tXw2kEAjxfuQZPdck6IG7z
         anQ5E5TRZzk32auXn2xavpye8ETFiIzQKBPwfI88mca7vA/IMjznhzF15WDfhAvupdJz
         VRoARMpiTY1n1VHnqcovjDQQzJEKhy3c50agMzkk915ebqnfelH1kl/6wbvZmkfGymKp
         3oihXdUeYVtF7UefZoj7/eQEud2l2zq9WEmfnp4IWbjT2D75pNr96Py7w2f+JpHfpb/x
         qsINpqCTPvjkQ4TiUw9ZI972mn9lfzyArhH6nVk56IffC79QrUAWIF7TgFKzENKxwz3c
         lWpQ==
X-Gm-Message-State: AJcUukeclg3mHiJ5SWJ2un4cS23RyUfA4lhrP2awWn6wXzvODoggXilc
        EMVLEA/7MzNgwkVCsuReQzE2Eg==
X-Google-Smtp-Source: ALg8bN6WfDWTT2KmBkZlW6Kto7qtcSZjIXu6/11w2VbslSKI4+ZoxvpbG1VZXV98G4xuL2aZ60oWSw==
X-Received: by 2002:a63:a553:: with SMTP id r19mr13772729pgu.53.1546442957256;
        Wed, 02 Jan 2019 07:29:17 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id k191sm63030673pgd.9.2019.01.02.07.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:29:16 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] xtensa: Unify the system call scripts
Date:   Wed,  2 Jan 2019 20:58:30 +0530
Message-Id: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
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
  xtensa: remove nargs from __SYSCALL
  xtensa: generate uapi header and syscall table header files

 arch/xtensa/kernel/syscall.c              |  2 +-
 arch/xtensa/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/xtensa/kernel/syscalls/syscallhdr.sh | 36 -------------------------------
 arch/xtensa/kernel/syscalls/syscalltbl.sh | 32 ---------------------------
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/xtensa/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/xtensa/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F177218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wc7DPsu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfABPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:19:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfABPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:19:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so15293260pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TTa/Cpj//DAXZ+qsZt/BdISx8sOAhaNi0VmpmwYlG9k=;
        b=Wc7DPsu9evplx04B9EEKVfbx2OXpPaP+a5RnDXEXQlQZXlMr/KVXjNcHFiXwx5KcwB
         kXWkDr9mHZV7NfkAPOBdXc+EEg7EQgLGkwB7W5eXw0QO0nclBVtBD/KyosmBF8T/ilUA
         hcpJENmT4oSmyvlp4NK1PM+DM95kWFaajUe6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TTa/Cpj//DAXZ+qsZt/BdISx8sOAhaNi0VmpmwYlG9k=;
        b=ufC8d4PKmKn5ro5CEJp8jEV4fNYbbb+I11NnrTzIvILHZJf65ySgOw7D3wh2ZvGFOW
         3s1g+G8NlR4DRGvahkyr/+sN53T2FQlq89Ax+uBZg2MmWTQvfmG/krMKqyVVzs+aIBZe
         Xch8S3j/mKx8hR/gbiTC9qa9i0SXf2cPLUKqa+XtgOu7wyryMR2fqfd2Q/4yqxUrJgS6
         2rblX+xOzKTOMEqfRMA4LARw+yMPDxsuoW11d2qK96M4fTQ9uB0NAa+3DXA/y/gJbVJm
         I2AT0xV0CMgsvNpAjhleEX8uKExN8VPMkSa98L3X9jm6iDOJo4guyDb8s7A5cmvm1/49
         KX0w==
X-Gm-Message-State: AJcUukdtYtIMhbWatZ/yQFiqEH0rkCFcwguFNKPkUNZ0oVWdDdJbjH1Y
        sHJRZ+PYrGwN2idCyqiKT9VJvRhs9Gs=
X-Google-Smtp-Source: ALg8bN68MEyuLHAp3RKDcoF4ZOUZIK223jC4cpRkUH50PRdhkzmrzXutVhmAzAQAGrEqprAZKvs9cQ==
X-Received: by 2002:a63:d208:: with SMTP id a8mr13616122pgg.77.1546442339942;
        Wed, 02 Jan 2019 07:18:59 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id i2sm14726788pfi.66.2019.01.02.07.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:18:59 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] m68k: Unify the system call scripts
Date:   Wed,  2 Jan 2019 20:48:37 +0530
Message-Id: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
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
  m68k: remove nargs from __SYSCALL
  m68k: generate uapi header and syscall table header files

 arch/m68k/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/m68k/kernel/syscalls/syscallhdr.sh | 36 ---------------------------------
 arch/m68k/kernel/syscalls/syscalltbl.sh | 32 -----------------------------
 arch/m68k/kernel/syscalltable.S         |  2 +-
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


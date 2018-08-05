Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC41217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZt5Obip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC41217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeHEFZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 01:25:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33628 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHEFZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 01:25:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so5199260pfn.0;
        Sat, 04 Aug 2018 20:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xhFVOJthM2Kcd/hhGu+MWtF5+C5N8XfpRNAkYf0VHyM=;
        b=iZt5ObipaTLO0jWH5cA2l4NqL5xzWhLsI77iiA6JDd/DBfm74dazcp1DsQtGOxB8fj
         EF/bzGGTZ4IAtPlMXejTr+uWKfoQ7jd5T1F92A+V9b8Ka7t8Gamvb9Qp+gMQRuRfDmwu
         /X5uLlliPJAOVcq2qSkPwnLOdX/y9KY9CE2/cNjBfOr21RDgTwLK9sUm25kjyPfQj7q3
         GvTEaq2fN7cEYX+9Z6QSJdb1LahMYYT1wfVEj8sSM5l7s1PF2k48utBldkaLb3MK6YMN
         JAQOOBZiWQWmF6yMuqSEu6T1Fvl1cTgFa8C+fk6Cbf5sXAViLuIwXlTwxAvvnmTtgP3u
         2rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xhFVOJthM2Kcd/hhGu+MWtF5+C5N8XfpRNAkYf0VHyM=;
        b=saycqJyOBfN+6KjScNY0t/qqOJxmWmoWR3nDrATOaBykWmznw2fNPiCkk1FFtO1XZA
         +4YEz1TosorTQPdzkiXRBDBYC1z447wL55NRDVt1Bqpv4AmlxxoEBMkovIh48GqN4YTp
         TJrw7gFF2NN6kInlV5JlblhvAtOiToQRmf7l+AOmKf7CwCxrqffD4R8zTDuamWq8Yy7e
         S16Mjj0pB2DrMhN6U4/wetieFYIpGm31+yBF2WshVZf15xQhEMSNrFrRb3Mox46ioswW
         UNJzPNC9TbARivugrnLnVpx6Yx65R87PQ3WZ2UJTYk7GqfUPpWhpPEb8EFOSWRIFfQKC
         KyUw==
X-Gm-Message-State: AOUpUlFjqrVzmatQQx8fmaRG/9fznajsS1LIze87hBsP+vWRSLw+AKHc
        awgb9ZkcI2+KY3h2Ax95uXlSfrv3
X-Google-Smtp-Source: AAOMgpf2sfWF3srnNiN2ZEtu/Y/4kPPiPxSwqrKX5ySZQf23R4sf0mFqPnnfQ22ZPjwjK3fZolzPFA==
X-Received: by 2002:a62:90d4:: with SMTP id q81-v6mr11385759pfk.37.1533439338773;
        Sat, 04 Aug 2018 20:22:18 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x87-v6sm15971922pfa.143.2018.08.04.20.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 20:22:18 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 0/6][RFC] Add EFI secure key to key retention service 
Date:   Sun,  5 Aug 2018 11:21:13 +0800
Message-Id: <20180805032119.20485-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When secure boot is enabled, only signed EFI binary can access
EFI boot service variable before ExitBootService. Which means that
the EFI boot service variable is secure.
   
This patch set add functions to EFI boot stub to generate a 512-bit
random number that it can be used as a root key for encryption and
authentication. This root key will be kept in EFI boot service variable.
EFI boot stub will read and transfer ERK (efi root key) to kernel.
    
At runtime, the ERK can be used to encrypted/authentication other
random number to generate EFI secure key. The EFI secure key can be
a new master key type for encrypted key. It's useful for hibernation
or evm.

Here is the proof of concept for using EFI secure key in hibernation:
  https://github.com/joeyli/linux-s4sign/commit/6311e97038974bc5de8121769fb4d34470009566

Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Lee, Chun-Yi (6):
  x86/KASLR: make getting random long number function public
  efi: the function transfers status to string
  efi: generate efi root key in EFI boot stub
  key: add EFI secure key type
  key: add EFI secure key as a master key type
  key: enforce the secure boot checking when loading efi root key

 Documentation/admin-guide/kernel-parameters.txt |   6 +
 arch/x86/boot/compressed/Makefile               |   1 +
 arch/x86/boot/compressed/cpuflags.c             |   2 +-
 arch/x86/boot/compressed/eboot.c                |   2 +
 arch/x86/boot/compressed/efi_root_key.c         | 212 +++++++
 arch/x86/boot/compressed/kaslr.c                |  21 -
 arch/x86/boot/compressed/misc.c                 |  17 +
 arch/x86/boot/compressed/misc.h                 |  12 +-
 arch/x86/include/asm/efi.h                      |  13 +
 arch/x86/include/uapi/asm/bootparam.h           |   1 +
 arch/x86/kernel/setup.c                         |   3 +
 arch/x86/lib/kaslr.c                            |  61 +-
 arch/x86/lib/random.c                           |  68 +++
 drivers/firmware/efi/Kconfig                    |  31 +
 drivers/firmware/efi/Makefile                   |   1 +
 drivers/firmware/efi/efi-secure-key.c           | 748 ++++++++++++++++++++++++
 include/keys/efi-type.h                         |  57 ++
 include/linux/efi.h                             |  40 ++
 include/linux/kernel.h                          |   3 +-
 kernel/panic.c                                  |   1 +
 security/keys/encrypted-keys/encrypted.c        |  10 +
 21 files changed, 1226 insertions(+), 84 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi_root_key.c
 create mode 100644 arch/x86/lib/random.c
 create mode 100644 drivers/firmware/efi/efi-secure-key.c
 create mode 100644 include/keys/efi-type.h

-- 
2.13.6


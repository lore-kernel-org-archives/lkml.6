Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B29F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XpJxqRSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B29F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeH3Ebc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:31:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39320 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeH3Ebc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:31:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so3027963plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=lGj4aGsalmptCksQNuYsLwaud7Iri0vykS9eWcQwxSE=;
        b=XpJxqRSvVG4x8Lb+qYJfDKuCoxnhPT5Z3xFCa1JhgRYNcUO1/RHg6dp+Aq20oIV0jl
         xbE9wD0g6an7qMLTmP1rwJOA4Fifureqtd1bfG333pSdqhfBjQau8TV4cer0eoja3XOx
         WUyH+e06BZo561V2gCaEDjr6QDkwJM+bNUbZF4mZIyiwTkXNgiq4LW+aqV7nR0e74kaZ
         ebiyB+wSwQdGW8qgvpXhpTnXmxLOtSsenfqJNd6NTRrnm90/m002IUy/nGf6ncs+DvcJ
         eqpAqIV8ioyVSmAhfW/TmngurKvk92t+CdswVUGZu+WYgRBhVN3biEebkAMG9tp5Mf9h
         Pykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=lGj4aGsalmptCksQNuYsLwaud7Iri0vykS9eWcQwxSE=;
        b=U0hGljq1E696XXk4TwBx4PSZ4iL40mfE10+8Tkicg0ea72EZfPMKwFCrHpF/5b8qbo
         8HZ3H0VpE4Av6+Qq8OiKEDX2N4bK0UDK6U+BycqHflNCOpEtPIcAycxN+I9K7tUVeasb
         fhXv651QrPKX30YLANK1G7RlrnDrL3ztheTD8Aqh3UDkRwbo1iXvnahHsn2wLAQYMKL9
         PcYF7L0TBH3O1ZN/lYNES7n2PZu8GkvP+v1fzlSvSeP5fsZjzZZb22KVkZIYM5tLUkNw
         J7FzmN0jrAueOCpeQBqXY7bpQIl9p6dvYOReqUAuwVBUjlg9hQQKwib7u/ZVrkjW4LXm
         uiJw==
X-Gm-Message-State: APzg51CJPYvW1wDZpwCoBfj2xow13GTO5AmN97aShh/ECBtGQaT8V+eA
        +tJZdaONBtg0Kz4zXubFOJ2cOg==
X-Google-Smtp-Source: ANB0Vda5cAWOe/IdZlr7faprjuPNAlkf6KhcMRme05eKc31vXWJX0SwmZ5Avn739Tmp5NLFuvFkEWw==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89-v6mr7770403pld.69.1535589126104;
        Wed, 29 Aug 2018 17:32:06 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l6-v6sm6965864pfl.169.2018.08.29.17.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 17:32:05 -0700 (PDT)
Date:   Wed, 29 Aug 2018 17:32:05 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Aug 2018 17:32:01 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes and Cleanups for 4.19-rc2
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ffc7dae9-c6aa-4209-8baa-7f23a8d6d33d@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.19-rc2

for you to fetch changes up to 47d80a68f10d3290204a12f7836a9a8190dfc327:

  RISC-V: Use a less ugly workaround for unused variable warnings (2018-08-28 12:58:36 -0700)

----------------------------------------------------------------
RISC-V Fixes and Cleanups for 4.19-rc2

This tag contains a handful of patches that filtered their way in during
the merge window but just didn't make the deadline.  It includes:

* Additional documentation in the riscv,cpu-intc device tree binding
  that resulted from some feedback I missed in the original patch set.
* A build fix that provides the definition of tlb_flush() before
  including tlb.h, which fixes a RISC-V build regression introduced
  during this merge window.
* A cosmetic cleanup to sys_riscv_flush_icache().

----------------------------------------------------------------
Palmer Dabbelt (2):
      dt-bindings: riscv,cpu-intc: Cleanups from a missed review
      RISC-V: Use a less ugly workaround for unused variable warnings

Will Deacon (1):
      riscv: tlb: Provide definition of tlb_flush() before including tlb.h

 .../bindings/interrupt-controller/riscv,cpu-intc.txt      | 14 +++++++++++---
 arch/riscv/include/asm/tlb.h                              |  4 ++++
 arch/riscv/kernel/sys_riscv.c                             | 15 +--------------
 3 files changed, 16 insertions(+), 17 deletions(-)

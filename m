Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B97C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B582081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FXcRGjAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfBLVSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:18:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44050 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBLVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:18:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id y1so48755pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 13:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=7jn3J1N45mjFhAjEYdQDoen/Jj3zXV3ffwF+Car7qjM=;
        b=FXcRGjAAnulMtToNJJXzQMHEGVoLr32XFsEK6RHS6woHCvivq4333WrY4mTUCIUrs8
         ms/20OPAgHQYPl6OMTY3EXbB3RxcKwrA6ZZEnSMgAc1NzDML1grF72Zfd6mD9PJpZXmg
         cnZYza9H8rh8rKCG9s/oHRg3TgWaYhsC5H8MnA7kQE0EshnhD+jdhz6svgCxdLDc4fEF
         yJoYhbhOPsxKDmNMFky0VzrU31mXPhBbcb6pAaW/B25yHV+2NA9V7zHhaKIS9yXYBRFa
         HxGyUJD24wY1YTl3iQjOS+GlHQ78hgj2Nf1GgSwlnZo2ZpBAZL5OtXR44OVTtbcu2FTu
         hc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=7jn3J1N45mjFhAjEYdQDoen/Jj3zXV3ffwF+Car7qjM=;
        b=SNfbz1MgWleaDXTEm11JtuZsx65ihmw/x2HeaFlvhVvjMV2hVuq90ZSdkUWFim/BrZ
         RCO7O/j7gP0zZnM0ojwOuTg2/Z/Dzd9dXj2wV175jRxNq7GJQFyTZ5JF9BkkZIBbin2y
         wSxd0JoG1G/deRyFe0TdIRsA4BnyqDfhFDxeyldmm8R1jZAMub6JBBADVLjOUv4fvtne
         FFk1aIzgcMf77kEf9KsYTJIHI+v4HCjr1j04X5XtSEkbHf/VsHREhI1zmLzGr7Oux+CX
         VOLeTGEVXHfmcY2M6w1la0Wu3DW5vFktRvWlSpQhv491ky1WCNHwBxrDbBFcxcuetjO2
         H68g==
X-Gm-Message-State: AHQUAuYL8z4K6HZA5UsAIed0hZWRLBhC84iag/M2obpJ2kscDAO0RC74
        AXrtZ4GuTm1zxoMIUM/CUASXjYzVarE=
X-Google-Smtp-Source: AHgI3IbFgOyBnuZx9ir/kVuBH1aXHVAW4D1pKnhKZDynCCh0H+XAPi0uXlDUwfsYLN40+xIdXvTtQQ==
X-Received: by 2002:a63:6244:: with SMTP id w65mr5401230pgb.300.1550006330084;
        Tue, 12 Feb 2019 13:18:50 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c4sm36770281pfm.151.2019.02.12.13.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:18:49 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:18:49 -0800 (PST)
X-Google-Original-Date: Tue, 12 Feb 2019 13:17:26 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.0-rc7
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-57c6009c-7e1d-4742-af0a-807c08dab07a@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.0-rc7

for you to fetch changes up to 41fb9d54f12b87fb1f670653e95d34668a08e8ee:

  Revert "RISC-V: Make BSS section as the last section in vmlinux.lds.S" (2019-02-11 15:24:45 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.0-rc7

This tag contains a pair of bug fixes that I'd like to include in 5.0:

* A fix to disambiguate swap from invalid PTEs, which fixes an error
  when trying to unmap PROT_NONE pages.
* A revert to an optimization of the size of flat binaries.  This is
  really a workaround to prevent breaking existing boot flows, but since
  the change was introduced as part of the 5.0 merge window I'd like to
  have the fix in before 5.0 so we can avoid a regression for any proper
  releases.

With these I hope we're out of patches for 5.0 in RISC-V land.

----------------------------------------------------------------
Palmer Dabbelt (1):
      Revert "RISC-V: Make BSS section as the last section in vmlinux.lds.S"

Stefan O'Rear (1):
      riscv: Add pte bit to distinguish swap from invalid

 arch/riscv/include/asm/pgtable-bits.h | 6 ++++++
 arch/riscv/include/asm/pgtable.h      | 8 ++++----
 arch/riscv/kernel/vmlinux.lds.S       | 8 ++------
 3 files changed, 12 insertions(+), 10 deletions(-)

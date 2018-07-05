Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86739C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC51240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOvUncLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC51240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGEVgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:36:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42379 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEVgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:36:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id v9-v6so6512978pff.9;
        Thu, 05 Jul 2018 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1kAkNM1JCVYSJaZnsKjgVRyIrW1VHH37L1SeTPHE5IU=;
        b=qOvUncLqYVzS2A+KLOSjOx+ftqbhgmgmi3MUkAAqib7WxmCqTN4S6gKM7nzg222J14
         LPGeCEecIziYvphucQroWcQU8Y4Kf9OCBUT8tP86b142gU881EwC1QbRDRZRFbH6fu/q
         Ud05+MBIxH2zOLAfLJkINAtgnG+QHAq6hZl9nZ9CsmZj1/Gnmgc276YK8s9UQxzbR8QB
         c1Z6aH40yGiStHNFv8W6+mnh2QYZQmBasHwYJRAMVE7ppMN4cGfZTR95gM6PKYzA0EnF
         bb9mN1mM1SgRvhErPtqxYmMWJdaECYZyWlTwF7sfgCDH3jASqwgtqkGMxRlGcmzNXi8l
         CU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1kAkNM1JCVYSJaZnsKjgVRyIrW1VHH37L1SeTPHE5IU=;
        b=TeV6/IcCZEONVdWZHDOMvtYpoNUGU5afUHS0IZ7qjWPeDdD6vlyjg5N21F3rT/zarG
         jFCvlyaoRmz1XBSX8pqW8ARpsqyQZGFjEeHMhf1a9tENlResK4CZ0t4IzF4IWRP8HD6G
         qRKrVBfKm+k2DuaR5bUD1MFsYmYFBWupVRn0PZKtMXn1mmakca5BkFfrcM+7jvctZ4RY
         rAMNPozQKiZ1+peJAE1WA10y7vAN45TQLENRLKyKV0IjpeVbuQ8HXIlBksXIrCCmhSdy
         Gr4URKNIZSqZujSJEvohpf7suA2mt6sQFJev16kdg7C0Q7wFtYWqR+TLCiKPkJdSmJ+3
         O3Iw==
X-Gm-Message-State: APt69E2W1rX802XVNp9hmhNPBva6d3xygtqRx8d3it9+Lb/Q6Bf1PjWr
        7tiyJQwUXpYco/qB71/ahMY=
X-Google-Smtp-Source: AAOMgpeyBr+2Jlfd2NC6N0OX8oIX7gRi6QWHpWsij2GK+9f2E0AKhymFC1vUzvrylw+lRy1it5XJQQ==
X-Received: by 2002:a62:f587:: with SMTP id b7-v6mr8058898pfm.158.1530826610914;
        Thu, 05 Jul 2018 14:36:50 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id v89-v6sm20438290pfd.64.2018.07.05.14.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 14:36:50 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, catalin.marinas@arm.com,
        davem@davemloft.net, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        palmer@sifive.com
Subject: [PATCH v2 0/7] Introduce struct __kernel_timex
Date:   Thu,  5 Jul 2018 14:35:57 -0700
Message-Id: <20180705213604.18883-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series introduces struct __kernel_timex as a substitute for
the non y2038 safe struct timex.

The series is based on the original series posted by Arnd Bergmann
in [1].

The overview of the series is as below:
1. Prepare for the compat timex interfaces to be used unconditionally.
2. Introduce struct __kernel_timex.
3. Use struct __kernel_timex in place of struct timex.
4. Switch syscalls to use struct __kernel_timex.

[1] https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html

Changes since v1:
* Fix riscv asm/compat.h to pick up generic compat types

Deepa Dinamani (7):
  arm64: Make basic compat_* types always available
  sparc: Make thread_info.h available directly
  riscv: Include asm-generic/compat.h
  timex: prepare compat helpers for y2038 changes
  time: Add struct __kernel_timex
  timex: use __kernel_timex internally
  timex: change syscalls to use struct __kernel_timex

 arch/alpha/kernel/osf_sys.c     |  2 +-
 arch/arm64/include/asm/compat.h | 22 ++++-----
 arch/riscv/include/asm/compat.h |  3 ++
 arch/sparc/include/asm/compat.h |  2 +
 drivers/ptp/ptp_clock.c         |  2 +-
 include/asm-generic/compat.h    |  8 +++-
 include/linux/compat.h          | 33 --------------
 include/linux/compat_time.h     | 34 ++++++++++++++
 include/linux/posix-clock.h     |  2 +-
 include/linux/syscalls.h        |  5 +--
 include/linux/timex.h           |  9 +++-
 include/uapi/linux/timex.h      | 41 +++++++++++++++++
 kernel/compat.c                 | 63 --------------------------
 kernel/time/ntp.c               | 12 ++---
 kernel/time/ntp_internal.h      |  2 +-
 kernel/time/posix-clock.c       |  2 +-
 kernel/time/posix-timers.c      | 14 ++----
 kernel/time/posix-timers.h      |  2 +-
 kernel/time/time.c              | 80 ++++++++++++++++++++++++++++++---
 kernel/time/timekeeping.c       |  4 +-
 20 files changed, 201 insertions(+), 141 deletions(-)


base-commit: e30b8745c892204095c0a8b69405868f63ddcce1
-- 
2.17.1

Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: netdev@vger.kernel.org
Cc: palmer@sifive.com

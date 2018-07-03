Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38C22087C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEKNj9Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38C22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbeGCFov (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:44:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43709 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754329AbeGCFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:44:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id v13-v6so422940pgr.10;
        Mon, 02 Jul 2018 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b/Ny68IeWgdDJaS78uW+oO/uYqsHyiX/ZV/bWKK2Qbo=;
        b=FEKNj9Qu7lk22symzMwwZkwF6GKjVrCJPOyQk9k21oFIlb2GNjV9RCWgBP39Oe3V8A
         FzscpOr3E7HRDHVf1W9mqKA5mGxUXY79wFrybvD6UEErlmp25xQhsfTI9vfFIUrPYFCu
         enzDHXgy7QGJfxWClv8h9VFRGU9DT9/h0occO/76bBlVo5etRuGcWnXWTglY6h2GnQ9U
         cbAlL7wj7myDihenJod86vbSG95BNsT/Nwjq1aDzQ2gOG71KT2EshlDLTI+4qu4+UOXI
         hpdqf579znsloKf2U2Nnh973Zml9AyqTiPdZyEGKLDD5h9PGmTgALs7p5Dg7Je1rsYDY
         7EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b/Ny68IeWgdDJaS78uW+oO/uYqsHyiX/ZV/bWKK2Qbo=;
        b=Yawjgkj1fiDduebyVu+KXLdZwsMBFGTt8juvigXlHk118n8FDjwB0LWl1Czc0X7hI5
         +eB09BsSEbSZXWXbNgOow0bBiUmytU5DY6olRE/oCS0f++rLAE0g7Ny596L2umpod+4V
         irsRvmIzwLNbesHbjDH2XEjTjkZDTOutF5GOOA+TPjxLKwYkxioQrRGA6vDeVAftZzQo
         hVd4fsJYdWe1GYzSMFio9N63U33wm2rL4U1XMkGzRbG0uj78UCQqrYmHcaQUBIznFihQ
         AH1+2ZS6bsr2WVOpjhPsKthGbU1MIvlRu9KXnYRefS9XX1XP1Dv/R73kp8dEILdz2LgK
         Zstg==
X-Gm-Message-State: APt69E1yjps96AfIVTyLR0Yb+UDgg6yLKSQ63dbBryn6l2di/uU9QzIF
        CeDbgM+XM058hQ9EfIg/XMvryA==
X-Google-Smtp-Source: AAOMgpebU3tYRW7AK16qTph3aX13yjnT6C7iTMUccKbIAsG4Qb0ZCioIN344PhiRCfVw8bsfz1DyVQ==
X-Received: by 2002:a63:b74a:: with SMTP id w10-v6mr15808818pgt.266.1530596687874;
        Mon, 02 Jul 2018 22:44:47 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h75-v6sm784780pfh.86.2018.07.02.22.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 22:44:47 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, catalin.marinas@arm.com,
        davem@davemloft.net, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 0/6] Introduce struct __kernel_timex
Date:   Mon,  2 Jul 2018 22:44:16 -0700
Message-Id: <20180703054422.12089-1-deepa.kernel@gmail.com>
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

Deepa Dinamani (6):
  arm64: Make basic compat_* types always available
  sparc: Make thread_info.h available directly
  timex: prepare compat helpers for y2038 changes
  time: Add struct __kernel_timex
  timex: use __kernel_timex internally
  timex: change syscalls to use struct __kernel_timex

 arch/alpha/kernel/osf_sys.c     |  2 +-
 arch/arm64/include/asm/compat.h | 22 ++++-----
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
 19 files changed, 198 insertions(+), 141 deletions(-)


base-commit: 69877f06915f1c7a9f1704442993bcc12c13ace2
-- 
2.17.1

Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: netdev@vger.kernel.org

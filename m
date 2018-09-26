Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8250C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2FA20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZEHEoRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2FA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeIZOop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:44:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38772 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:44:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so8430764pgr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MO7664pAV2ldFdH0JaoDq4/TZtmoHdXkovT5pjpOKjc=;
        b=vZEHEoRSKUi1UeC73MMcyVmTtLY2W292HV02GtVgQAASQNs1+o2bkZudMwaHin9MnW
         8ZklOoVg6UtAWb+XAOLwwvjjTRzMtOYQF4urGSoUAp7q2KnCql9e5/snUXIZpSunrCNG
         VWQuIeuy0X+AkHwadhb4h0iflcCt9xXo+obMmQzDStpUC46kBwtorfewm7f6SammPzJV
         jpn/WoaT0rXVF8HWQi3H7UJFXevXyRWexdoor2yORbMYJ9EIq1PQch7yPp7SG0qoAsoI
         jVDfCCao34e1XS6o2+SY7NDegr/eP5+WvjsxrZooOj43p8xmIeGJ7ZIjLCxARzCnwUse
         ukOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MO7664pAV2ldFdH0JaoDq4/TZtmoHdXkovT5pjpOKjc=;
        b=asHiDeUKHDaKEQzwKtcbAN3G+KQTYOLwr1LXZhABootM1bFcGVI8SFgqfl4ksbw/1j
         MlHRwe6wscogeqGkP5PdclEY66LMSZxjiUKNeXT5mVgTyztuvWvMjZj77ZhUkfvEPxqc
         QKOloqnE04fRB7OMsMHAjh+5+h0MoJtq8EIvkeID7x1w//9RLa9iL8/vzW1Jndjpc9LZ
         YO1jkMIfaUPYSvIuJrWv1E10P/RkKoUuGzNpL9nKadeYF5vO/7+xCW3c8+hlUDbXY+X5
         zeuEUN/nsr4jIA87U+TeK+JxW4DO5ir5fC8aEox5hU82Q6NdBlb8IQa8Fjt3Aefngn2P
         /u1g==
X-Gm-Message-State: ABuFfohPfqqh2wo2CFp7IRe1Us1qI41oLy6K5dajJcDoZZ2j69vSIuqD
        x/oD9NnbJtndOgNBK0PGKAU=
X-Google-Smtp-Source: ACcGV62AR77HEmfg4s+9K/8CJNgkytT17zzBtIAhMg1iGsXiVuBPoxhogxOCl+wzGnPuYoOCztQ8sQ==
X-Received: by 2002:a63:d645:: with SMTP id d5-v6mr4628381pgj.450.1537950777504;
        Wed, 26 Sep 2018 01:32:57 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id f15-v6sm5530764pgv.66.2018.09.26.01.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:32:57 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v2 0/5] Fix some bugs on RV32 build fail and issue
Date:   Wed, 26 Sep 2018 16:31:09 +0800
Message-Id: <cover.1537949825.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches contain the modificaion as follows:
1. Fix up the building fail on RV32.
2. Add umoddi3 and udivmoddi4 functions for RV32.
3. Fix ioremap problem on RV32.

Changes in v2:
 - Retain the copyright notices from libgcc in umoddi3.c and udivmoddi4.c.

Vincent Chen (1):
  RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap

Zong Li (4):
  RISC-V: Build tishift only on 64-bit
  RISC-V: Use swiotlb on RV64 only
  lib: Add umoddi3 and udivmoddi4 of GCC library routines
  RISC-V: Select GENERIC_LIB_UMODDI3 on RV32

 arch/riscv/Kconfig        |   1 +
 arch/riscv/kernel/setup.c |   3 +
 arch/riscv/lib/Makefile   |   3 +-
 arch/riscv/mm/ioremap.c   |   2 +-
 lib/Kconfig               |   3 +
 lib/Makefile              |   1 +
 lib/udivmoddi4.c          | 309 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/umoddi3.c             |  34 +++++
 8 files changed, 354 insertions(+), 2 deletions(-)
 create mode 100644 lib/udivmoddi4.c
 create mode 100644 lib/umoddi3.c

-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935909AbeBLOpG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:45:06 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56363 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754448AbeBLOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:45:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Sy3nhB9_1518446695;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: tglx@linutronix.de, jolsa@redhat.com, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] /proc/kcore: Fix SMAP violation when dumping vsyscall user page
Date: Mon, 12 Feb 2018 22:44:52 +0800
Message-Id: <1518446694-21124-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset was validated with the combinations of pti=on/off and vsyscall=native/emulate/none.
In addition, CONFIG_HARDENED_USERCOPY is always enabled.

v2:
  - Use { } around kclist_add() when there's more than 1 line code 

Jia Zhang (2):
      /proc/kcore: Fix SMAP violation when dumping vsyscall user page
      x86/mm/64: Add vsyscall page to /proc/kcore conditionally

 arch/x86/mm/init_64.c | 6 ++++--
 fs/proc/kcore.c       | 4 ++++
 include/linux/kcore.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

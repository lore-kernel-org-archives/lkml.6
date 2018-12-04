Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EF7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5B20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBmz8p6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C5B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLDMSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:18:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35028 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbeLDMSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:18:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so11798255lfc.2;
        Tue, 04 Dec 2018 04:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=EKomztucFdGpdw25mVtPM/fFZFyL6QsN9atK4DfZDNk=;
        b=dBmz8p6Gj1TniGyArDhrqTvxjff/YpIVbYvKz3HIM/22sCvHedrQGmmk93KLD+qDHq
         n23SaJV5/fBzfBQgs88D8p15egV7O/OGgG3PZamjm9mf9uFyTYRShbbIFGwQj7zdoErI
         TxhS97CQapHHQRQrRRD8HnQyBgl3ALg8DlXbxv7R/Qla3c4Ehb9clJVc+iVXcWX6d894
         OKDhJTZNJx1IpqB6G0Iiuhc8AMPxxmVFRp65zYYznWwZqCWq5AOqi67TVWteuLyph3CP
         YntSoTAydAuIzLJaJ9F8KIfnXmfqYuou3x56DprEE5TdzeDsnSOhMQ/s4p8lFD7znBpR
         TucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=EKomztucFdGpdw25mVtPM/fFZFyL6QsN9atK4DfZDNk=;
        b=dBlmifdnMsqQSZdzKVskhrILBMExrX7iguT9m5hZItA/F7Qg0XsJAGx7y+5O2fOlwa
         8vfDvG/FnR7ciCa0PpLLdtLkhFHAjmxe80lB1hTrCDBFc5nMwP5LJArXjDsvlVJoQeEQ
         q9MA6OMGBHNC4Kor6gDmvW+7lN6s7YweIk7WtV7/e9ptM7We9TVtwyJlGA1XGKUBBzhh
         pdRJvRVtGx+CnIvV48vpDD4C2borF2CtP+q5svFCXK2A26r0o7Sqsyfmh2Tyg3iuh09b
         dHMJIrpDK56ycvBFLilHwcswJ5FymfCI4NJIz7KtRL7HN1C3iZ0ztYvpN7Ge0XcJI7/I
         AqyA==
X-Gm-Message-State: AA+aEWYnn/EAs41Oy5y0y6iPZP96Vmxzn9rvDavx6uZiPd5VKomJ/LLm
        QhUwwigowbZP7vh9C3Fvf1Q=
X-Google-Smtp-Source: AFSGD/W8gWphoUuoSjw5YUOeRczkQhI1FHNhM18fBvHXKNRhCUl79/Pygk/pqszc8KF1a/GsEa7y5g==
X-Received: by 2002:a19:c396:: with SMTP id t144mr11305526lff.110.1543925920097;
        Tue, 04 Dec 2018 04:18:40 -0800 (PST)
Received: from localhost.localdomain (91-156-179-117.elisa-laajakaista.fi. [91.156.179.117])
        by smtp.gmail.com with ESMTPSA id h3sm2899653lfj.25.2018.12.04.04.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 04:18:39 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v1 PATCH 0/6] hardening: statically allocated protected memory
Date:   Tue,  4 Dec 2018 14:17:59 +0200
Message-Id: <20181204121805.4621-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set is the first-cut implementation of write-rare memory
protection, as previously agreed [1]
Its purpose it to keep data write protected kernel data which is seldom
modified.
There is no read overhead, however writing requires special operations that
are probably unsitable for often-changing data.
The use is opt-in, by applying the modifier __wr_after_init to a variable
declaration.

As the name implies, the write protection kicks in only after init() is
completed; before that moment, the data is modifiable in the usual way.

Current Limitations:
* supports only data which is allocated statically, at build time.
* supports only x86_64
* might not work for very large amount of data, since it relies on the
  assumption that said data can be entirely remapped, at init.


Some notes:
- even if the code is only for x86_64, it is placed in the generic
  locations, with the intention of extending it also to arm64
- the current section used for collecting wr-after-init data might need to
  be moved, to work with arm64 MMU
- the functionality is in its own c and h files, for now, to ease the
  introduction (and refactoring) of code dealing with dynamic allocation
- recently some updated patches were posted for live-patch on arm64 [2],
  they might help with adding arm64 support here
- to avoid the risk of weakening __ro_after_init, __wr_after_init data is
  in a separate set of pages, and any invocation will confirm that the
  memory affected falls within this range.
  I have modified rodata_test accordingly, to check als othis case.
- to avoid replicating the code which does the change of mapping, there is
  only one function performing multiple, selectable, operations, such as
  memcpy(), memset(). I have added also rcu_assign_pointer() as further
  example. But I'm not too fond of this implementation either. I just
  couldn't think of any that I would like significantly better.
- I have left out the patchset from Nadav that these patches depend on,
  but it can be found here [3] (Should have I resubmitted it?)
- I am not sure what is the correct form for giving proper credit wrt the
  authoring of the wr_after_init mechanism, guidance would be appreciated
- In an attempt to spam less people, I have curbed the list of recipients.
  If I have omitted someone who should have been kept/added, please
  add them to the thread.


[1] https://www.openwall.com/lists/kernel-hardening/2018/11/22/8
[2] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793199.html
[3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1810245.html

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org



Igor Stoppa (6):
	[PATCH 1/6] __wr_after_init: linker section and label
	[PATCH 2/6] __wr_after_init: write rare for static allocation
	[PATCH 3/6] rodata_test: refactor tests
	[PATCH 4/6] rodata_test: add verification for __wr_after_init
	[PATCH 5/6] __wr_after_init: test write rare functionality
	[PATCH 6/6] __wr_after_init: lkdtm test

drivers/misc/lkdtm/core.c         |   3 +
drivers/misc/lkdtm/lkdtm.h        |   3 +
drivers/misc/lkdtm/perms.c        |  29 ++++++++
include/asm-generic/vmlinux.lds.h |  20 ++++++
include/linux/cache.h             |  17 +++++
include/linux/prmem.h             | 134 +++++++++++++++++++++++++++++++++++++
init/main.c                       |   2 +
mm/Kconfig                        |   4 ++
mm/Kconfig.debug                  |   9 +++
mm/Makefile                       |   2 +
mm/prmem.c                        | 124 ++++++++++++++++++++++++++++++++++
mm/rodata_test.c                  |  63 ++++++++++++------
mm/test_write_rare.c              | 135 ++++++++++++++++++++++++++++++++++++++
13 files changed, 525 insertions(+), 20 deletions(-)




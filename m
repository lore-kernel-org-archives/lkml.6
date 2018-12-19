Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941BC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8942086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqoruNp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbeLSVeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:34:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37079 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLSVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so16166934lfj.4;
        Wed, 19 Dec 2018 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=gao6Paz78Wv+S9Y48uFekujRhjWOk2WMhVie8VXtSvs=;
        b=RqoruNp3Aj0t6Olz38BcPZUI2zTP1E3aLZSl4Kch+Ute9g4+3+9cUga3xAVw/dRDwa
         fVc3kx65CAJWYrGhq4NvLMlBNq4Yar6HcDKKaztPllm+UFtnD4Nta+pTUin7yMfk4gh+
         05BP+Em8ahLQvI4aYUrtuTZWX8f/y315R2JZEbkK7AqPcNSqMgrXOTjo15L+TVvg4EWL
         ORSmEnxPIjZ7Q58QfP8TSRyyScu3ucKAVkvFtyeaAsG5fpy7C5QkSyY2vZw3OaYOXedX
         5AVNKLiz/IlF8Dl7kl5hjJ+eXTs5Mc0tE8xdznnY/Jug1A6WIWsFOPRvkpz9TE6FJy4c
         XOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=gao6Paz78Wv+S9Y48uFekujRhjWOk2WMhVie8VXtSvs=;
        b=moiuFA6B6rxk42NDCgIfIHH3A0JNlv7IVYofa3BJcn15XSJSQtG3aBJGGohIctr/vb
         nz4uWuJGeBXEhcB0biH6XIAxkZFHSRFkrCm0PWR8Rv5y/FrQqq7plrJxJvraZtnri74N
         uqT0F4ltAAnORtFNRKVFIqXijwzM9e6cZxguZ4kAsQtTscLlhSqiKrPu4hXGQ+4AVe5r
         8B41tb6Z/GynHnVIkB/KbPxfT24unkzzucFUUa7Ql/qqKh8bJiySxziNziCDcNIjKKgt
         I+bmyd1FfZpMVvQcmpaCW4BTOy5N+gC+gJWVWF4PhxD518Ht3slgd77EE3Y1zfBBxnZY
         S9Og==
X-Gm-Message-State: AA+aEWYITTR+MaL1+DwFO/8XEDyLxcgLrgEaunWqXajIfSkH7Hb7NCCQ
        I6dEFVRWn6CLpHB1+Rv5NI0=
X-Google-Smtp-Source: AFSGD/U7kEXKUSbUtVkzDdx+CUSIjSN8XwOZn8JMB3LuNWtVD5/pHTGn0qTJ02elVdg7VFo1rt5ZeQ==
X-Received: by 2002:a19:f204:: with SMTP id q4mr14260365lfh.133.1545255244431;
        Wed, 19 Dec 2018 13:34:04 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:03 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 PATCH 0/12] hardening: statically allocated protected memory
Date:   Wed, 19 Dec 2018 23:33:26 +0200
Message-Id: <20181219213338.26619-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch-set implementing write-rare memory protection for statically
allocated data.
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
* supports only x86_64, other earchitectures need to provide own backend

Some notes:
- there is a part of generic code which is basically a NOP, but should
  allow using unconditionally the write protection. It will automatically
  default to non-protected functionality, if the specific architecture
  doesn't support write-rare
- to avoid the risk of weakening __ro_after_init, __wr_after_init data is
  in a separate set of pages, and any invocation will confirm that the
  memory affected falls within this range.
  rodata_test is modified accordingly, to check also this case.
- for now, the patchset addresses only x86_64, as each architecture seems
  to have own way of dealing with user space. Once a few are implemented,
  it should be more obvious what code can be refactored as common.
- the memset_user() assembly function seems to work, but I'm not too sure
  it's really ok
- I've added a simple example: the protection of ima_policy_flags
- the last patch is optional, but it seemed worth to do the refactoring

Changelog:

v1->v2

* introduce cleaner split between generic and arch code
* add x86_64 specific memset_user()
* replace kernel-space memset() memcopy() with userspace counterpart
* randomize the base address for the alternate map across the entire
  available address range from user space (128TB - 64TB)
* convert BUG() to WARN()
* turn verification of written data into debugging option
* wr_rcu_assign_pointer() as special case of wr_assign()
* example with protection of ima_policy_flags
* documentation

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org

Igor Stoppa (12):
	[PATCH 01/12] x86_64: memset_user()
	[PATCH 02/12] __wr_after_init: linker section and label
	[PATCH 03/12] __wr_after_init: generic header
	[PATCH 04/12] __wr_after_init: x86_64: __wr_op
	[PATCH 05/12] __wr_after_init: x86_64: debug writes
	[PATCH 06/12] __wr_after_init: Documentation: self-protection
	[PATCH 07/12] __wr_after_init: lkdtm test
	[PATCH 08/12] rodata_test: refactor tests
	[PATCH 09/12] rodata_test: add verification for __wr_after_init
	[PATCH 10/12] __wr_after_init: test write rare functionality
	[PATCH 11/12] IMA: turn ima_policy_flags into __wr_after_init
	[PATCH 12/12] x86_64: __clear_user as case of __memset_user


Documentation/security/self-protection.rst |  14 ++-
arch/Kconfig                               |  15 +++
arch/x86/Kconfig                           |   1 +
arch/x86/include/asm/uaccess_64.h          |   6 +
arch/x86/lib/usercopy_64.c                 |  41 +++++--
arch/x86/mm/Makefile                       |   2 +
arch/x86/mm/prmem.c                        | 127 +++++++++++++++++++++
drivers/misc/lkdtm/core.c                  |   3 +
drivers/misc/lkdtm/lkdtm.h                 |   3 +
drivers/misc/lkdtm/perms.c                 |  29 +++++
include/asm-generic/vmlinux.lds.h          |  25 +++++
include/linux/cache.h                      |  21 ++++
include/linux/prmem.h                      | 142 ++++++++++++++++++++++++
init/main.c                                |   2 +
mm/Kconfig.debug                           |  16 +++
mm/Makefile                                |   1 +
mm/rodata_test.c                           |  69 ++++++++----
mm/test_write_rare.c                       | 135 ++++++++++++++++++++++
security/integrity/ima/ima.h               |   3 +-
security/integrity/ima/ima_init.c          |   5 +-
security/integrity/ima/ima_policy.c        |   9 +-
21 files changed, 629 insertions(+), 40 deletions(-)


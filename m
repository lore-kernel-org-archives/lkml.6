Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C180C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7032184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imun+eR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfAKFNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:13:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36523 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfAKFNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:13:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so6239507plo.3;
        Thu, 10 Jan 2019 21:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yiNiXONw2hvDBpSYOL1d5N1MZI2fH8KXdlUQmgz4Znk=;
        b=Imun+eR9QhZIf1CBWp1uTUvcu5c57x6vr/TD90brUG3h9+tzOmOdHmt/PFarV+h4iM
         ECaoPAXZhC7f+gFgH8zk3gm3sDYQWwWUiJHxmbpVd4VfkM5Nhkr3SNVHzirNLtqmRR8r
         3n8XqbC1ZS6MYSropDcrzMzA+8NTDWmgfpD7CXX04EMJXKXl64uawfa7vR89Sc+fnA3G
         j+sguhsTgN5w9Jm45XJyfT7l5vmjIkKqrCugfyIheLGK7Id9ZpHttrA5JWFwPiY97a++
         89mZzdRxZvm3R+yrRBFO4lE6XTtghhI1ZY0rmclP4ZZxDhPAwQoAPEQL5xMe58Ku3j/E
         iCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yiNiXONw2hvDBpSYOL1d5N1MZI2fH8KXdlUQmgz4Znk=;
        b=h3O8/zc1/IuWMfA5uDTzqkyDwwRX3MGVTMspRngq+386+uP6peIPhas1yg+oEiCzcL
         m6HG616sD6GaR1fiDp4eQgmqEAtT1zHXXayh4uqdVx1/9q8ixjKJymU5xL2GQ9uuI+Ak
         7fZ9CigGZfnqgLn7080tLLHzCkQHV7blC0zxPhc5scfHxg/rF8WJ3ZxfwIXrWpBPUfaY
         edea85SHvPW2OIHFcahkKkbSW8BVDzzMnHMg7I6Wxzjp5YQ685FNVcWAi1i4BxrF4mmD
         hbdYupiySVuc/3ntzXdwK6oInDYlbwiRbU44XbO+pThFUL/Po9ds9Y5h9BfPeu2CqmEH
         w04Q==
X-Gm-Message-State: AJcUukc+h20Wh/uWDnVSB6diwb2Hg0PY/yckLYMgunowQx8VqxKhNGug
        ZgJ38c33MMqrvaTJ5fftPQSyY+gl6UWk
X-Google-Smtp-Source: ALg8bN5rMV8JFql1nyNXCDkvGEFzOQ0KzKP/vFF0LATwv/Hp28/MAYHRgpLWoRhd7tg434tfMvck9w==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr12667449plb.226.1547183597655;
        Thu, 10 Jan 2019 21:13:17 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q7sm93490471pgp.40.2019.01.10.21.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 21:13:16 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHv2 0/7] x86_64/mm: remove bottom-up allocation style by pushing forward the parsing of mem hotplug info 
Date:   Fri, 11 Jan 2019 13:12:50 +0800
Message-Id: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background
When kaslr kernel can be guaranteed to sit inside unmovable node
after [1]. But if kaslr kernel is located near the end of the movable node,
then bottom-up allocator may create pagetable which crosses the boundary
between unmovable node and movable node.  It is a probability issue,
two factors include -1. how big the gap between kernel end and
unmovable node's end.  -2. how many memory does the system own.
Alternative way to fix this issue is by increasing the gap by
boot/compressed/kaslr*. But taking the scenario of PB level memory,
the pagetable will take server MB even if using 1GB page, different page
attr and fragment will make things worse. So it is hard to decide how much
should the gap increase.
The following figure show the defection of current bottom-up style:
  [startA, endA][startB, "kaslr kernel verly close to" endB][startC, endC]

If nodeA,B is unmovable, while nodeC is movable, then init_mem_mapping()
can generate pgtable on nodeC, which stain movable node.

This patch makes it certainty instead of a probablity problem. It achieves
this by pushing forward the parsing of mem hotplug info ahead of init_mem_mapping().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: x86@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-mm@kvack.org
Pingfan Liu (7):
  x86/mm: concentrate the code to memblock allocator enabled
  acpi: change the topo of acpi_table_upgrade()
  mm/memblock: introduce allocation boundary for tracing purpose
  x86/setup: parse acpi to get hotplug info before init_mem_mapping()
  x86/mm: set allowed range for memblock allocator
  x86/mm: remove bottom-up allocation style for x86_64
  x86/mm: isolate the bottom-up style to init_32.c

 arch/arm/mm/init.c              |   3 +-
 arch/arm/mm/mmu.c               |   4 +-
 arch/arm/mm/nommu.c             |   2 +-
 arch/arm64/kernel/setup.c       |   2 +-
 arch/csky/kernel/setup.c        |   2 +-
 arch/microblaze/mm/init.c       |   2 +-
 arch/mips/kernel/setup.c        |   2 +-
 arch/powerpc/mm/40x_mmu.c       |   6 +-
 arch/powerpc/mm/44x_mmu.c       |   2 +-
 arch/powerpc/mm/8xx_mmu.c       |   2 +-
 arch/powerpc/mm/fsl_booke_mmu.c |   5 +-
 arch/powerpc/mm/hash_utils_64.c |   4 +-
 arch/powerpc/mm/init_32.c       |   2 +-
 arch/powerpc/mm/pgtable-radix.c |   2 +-
 arch/powerpc/mm/ppc_mmu_32.c    |   8 +-
 arch/powerpc/mm/tlb_nohash.c    |   6 +-
 arch/unicore32/mm/mmu.c         |   2 +-
 arch/x86/kernel/setup.c         |  93 ++++++++++++++---------
 arch/x86/mm/init.c              | 163 +++++-----------------------------------
 arch/x86/mm/init_32.c           | 147 ++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mm_internal.h       |   8 +-
 arch/xtensa/mm/init.c           |   2 +-
 drivers/acpi/tables.c           |   4 +-
 include/linux/acpi.h            |   5 +-
 include/linux/memblock.h        |  10 ++-
 mm/memblock.c                   |  23 ++++--
 26 files changed, 290 insertions(+), 221 deletions(-)

-- 
2.7.4


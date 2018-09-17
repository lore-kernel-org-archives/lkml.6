Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F380ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F53214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJAjwBsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F53214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeIQKJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:09:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38121 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:09:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so7047544pgb.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sViNzsDXuSjeBsXI1jEaKxugCqm0GD5SkhvqW9ARpM8=;
        b=KJAjwBsuPAyz2jbWEETMMWX/H4xD+9LQGjl6m/Zs+mJ9oQfu47H2QJsK9dJ1wdBbQQ
         xiK7wA4era9eS4D/3UIRkdNcZAxAcrrHX769CS/wiQ6wV2DEIUf8ps65bKHnD3wZ0UFd
         jMqoM4VYqQ+h9rI0VbOGzO2WUR3PelS8LyzNOr9nc5RYCQzfaZz47vOApt1IohypHmWb
         nSXnks3hauc6UPPonxxYuXafM4tnl0wnf6k8ReI5AqBTZcYF8Y16KpvuU3jVutzyDY6W
         93uXoDLqYl5q7WgwwGjjxtb6tKyzlA/YDEs3nQn4xMjgO52V5O7xGGSztloGhwUiULkR
         cQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sViNzsDXuSjeBsXI1jEaKxugCqm0GD5SkhvqW9ARpM8=;
        b=jzvvftVkwbVv8aeuL5fHr+YKH50PWXFS1mIf1XzJTYenAiwGEF4QxiHxgh72o4rpkL
         /dvbK+1Qin73xuWblxFPW+mqpChIDPYftfWu9WMutYN2Q2QaBAxsstic8U1n2EpR0RPa
         ugathvd9cvf4+oEM81OaPI1OYdi9gHu57yXzx1+i+Vm2P5AERKrYRhMBPVFed9kjxCw8
         sfpPBJ/1FK+dKWWX6dVnWdObMiZiN3VdFdcUWFppPX4nchGGPnBC2AfDQz9Wp/xI9Ym8
         2e7+Gj4eHw4ZKVqOSdmw22LxxyO2p7dHPrkCnPkCBVtQ3EL4abCn7/UFxLFzAHRoWH0J
         6Jqg==
X-Gm-Message-State: APzg51DxqomewcpXUyu+FiBxh05oLAzCpNo9NtOg1YwIncj7cr9GDkrM
        inetMR8kwPPmds6NiWs0wm8=
X-Google-Smtp-Source: ANB0VdZm0BxwY5UvOSLFMAdwoQKrCTGG00lqzFS6ooU8Twv7x0270cCUslq7JSJ5DXMjh8dO41iPSQ==
X-Received: by 2002:a62:7885:: with SMTP id t127-v6mr24041934pfc.6.1537159430606;
        Sun, 16 Sep 2018 21:43:50 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l3-v6sm16876399pff.8.2018.09.16.21.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 21:43:50 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
Date:   Mon, 17 Sep 2018 12:43:27 +0800
Message-Id: <20180917044333.30051-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 5 changes:
	1. Correct spelling and indentation errors[1].
	2. Update init_mm.pgd by assembly[2].
	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
	   during paging_init()[3].

v4: https://www.spinics.net/lists/arm-kernel/msg672195.html
v3: https://www.spinics.net/lists/arm-kernel/msg662537.html
v2: https://patchwork.kernel.org/patch/10485641/
v1: https://patchwork.kernel.org/patch/10476595/

[1] https://www.spinics.net/lists/arm-kernel/msg675189.html
[2] https://www.spinics.net/lists/arm-kernel/msg675193.html
[3] https://www.spinics.net/lists/arm-kernel/msg675196.html

Jun Yao (6):
  arm64/mm: Introduce the init_pg_dir.
  arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
  arm64/mm: Create the initial page table in the init_pg_dir.
  arm64/mm: Create the final page table directly in swapper_pg_dir.
  arm64/mm: Populate the swapper_pg_dir by fixmap.
  arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.

 arch/arm64/include/asm/assembler.h | 29 ++++++++++++++++++
 arch/arm64/include/asm/pgtable.h   | 36 ++++++++++++++++++----
 arch/arm64/kernel/asm-offsets.c    |  1 +
 arch/arm64/kernel/head.S           | 48 ++++++++++++++++++++----------
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 47 +++++++++++++++++++----------
 arch/arm64/mm/mmu.c                | 45 +++++++++++++---------------
 7 files changed, 147 insertions(+), 60 deletions(-)

-- 
2.17.1


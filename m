Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35698C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10422550D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnIKokjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10422550D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeGBLRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:17:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45512 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGBLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:17:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id bi1-v6so7801837plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5PpOo5CURtD1XpIQGYYJWhuyFZ9iY+u7nTdh2Dnh+u4=;
        b=TnIKokjxTkfOteatzA0qHiXIvsvfvH3CUgha+dY5mKFBtkE66/X5EdFNZtvBXvVbXg
         FrT9yCRJylXUfal71VfYsTRxNQySBCl0wZwG7menNQa7jS944oqbgD6iMemLrNh9XexI
         0pNOAM6T93RFeKQCb23HUxzrokD9tO3x8BcqIG9e9ehhmRp9FaUf24MosrIWJw240v78
         kIseFdCgoeF1fiwTT6iuveClLeXQgG+fR5bAyqXgL7ryAny5gSWwGnvpOkK64YVyEhf2
         TakJLkzYD98qKuKeIPBoQfKF4UPceRxWBOzCC5HaSmFYya90QSQQ5TR+7+pDyds1f/nn
         zmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5PpOo5CURtD1XpIQGYYJWhuyFZ9iY+u7nTdh2Dnh+u4=;
        b=LYABGvsE+fRBXvCVt3wl6ergIAN2L9W5kAP75zL0rSypjwPJVNlmJkTH9U8sqrTG+e
         8oN1F36pwASQY7a0hutXI7BumWGbXXL94b6noPB0F7a8WI17TWhQI/tO1drF/x08Zg0N
         VtI3OSKyCu+Sk4SK7NNEamFHOs0iTY1THmG2ZHGG2qD8bqJ3vJZH2ZGmWbQ5IxTFhO5L
         JmSs3SsvhnCQxX7TxVV5XjAFp9MIb+5j3tBWHZdpi/BeoS3plYYgATBTfpWkTBpcOLA1
         vUPV5H0+1KnU75F7rL+9pHIjksOCR8+SpKyr8PN0Y5+gzKeOasCIIYV3jr6MtXdtkA8r
         yfZQ==
X-Gm-Message-State: APt69E0guOKEntoCL67AWjScQH3gSrJz7Q+jsjYEzFfHQIkVKkv/RKN2
        SF26JLOMbFV/v7rok0RKAGM=
X-Google-Smtp-Source: ADUXVKKWusifURQMZTwGwtMG88PvX/Ce7oNRuz4Ee484FNBY8iS8EKluTReElHpSKK+A75yhu41RFA==
X-Received: by 2002:a17:902:2884:: with SMTP id f4-v6mr25467381plb.204.1530530240427;
        Mon, 02 Jul 2018 04:17:20 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id s2-v6sm11262150pfh.186.2018.07.02.04.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:17:19 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Move {idmap_pg_dir,swapper_pg_dir} to .rodata
Date:   Mon,  2 Jul 2018 19:16:54 +0800
Message-Id: <20180702111659.25570-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3 changes:
	As James Morse suggested[1], we split the old patch into 5
	patches:

	1. Introduce init_pg_dir.
	2. Make __enable_mmu() take the ttbr1 page as an argument.
	3. Create initial page tables in init_pg_dir and then create final
	   page tables in swapper_pg_dir directly.
	4. Make swapper_pg_dir smaller.
	5. Move {idmap_pg_dir, swapper_pg_dir} to .rodata section.

	At the same time, fix bugs mentioned in [1] and [2].

Special thanks to James Morse and Suzuki K Poulose. Without their help, I
couldn't write these patches.

v2: https://patchwork.kernel.org/patch/10485641/
v1: https://patchwork.kernel.org/patch/10476595/

[1] https://patchwork.kernel.org/patch/10485641/
[2] https://patchwork.kernel.org/patch/10485643/

Jun Yao (5):
  arm64/mm: Introduce init_pg_dir
  arm64/mm: Make __enable_mmu() take the ttbr1 page as an argument
  arm64/mm: Create initial page tables in init_pg_dir
  arm64/mm: Make swapper_pg_dir smaller
  arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to .rodata section

 arch/arm64/include/asm/assembler.h | 23 ++++++++++++++
 arch/arm64/include/asm/pgalloc.h   | 48 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h   | 17 ++++++-----
 arch/arm64/kernel/head.S           | 31 ++++++++++++++-----
 arch/arm64/kernel/setup.c          |  1 +
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 29 ++++++++++++------
 arch/arm64/mm/mmu.c                | 32 +++-----------------
 8 files changed, 129 insertions(+), 53 deletions(-)

-- 
2.17.1


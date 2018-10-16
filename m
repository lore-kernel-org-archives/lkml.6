Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A0FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4568C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm4P1UIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4568C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPVEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:04:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32962 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPVEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:04:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so9070248pfq.0;
        Tue, 16 Oct 2018 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a64q9IsY9mfK+JGEdi2vqlrBaBM9lMLc6dBKgesPus8=;
        b=Fm4P1UIGZcZlSKjY/TiRr3qRMVWRSvmx3cUaLtDHArZq5cTRjdHwdh0jIwo2Tdm3DT
         sYbM/EBo61INU00lYEP70p9e3w1oLsW4SDhLk0jx9ZQBj4FxPN8+0IYDcdKTA12kPs/z
         P1cIBYYQH6itjnUgwwzV7Ki13ac69Th1OylXYonanQRV0kFPFC6FhDWjaKXnca0LMveb
         AmbLWUguC9lOH3Uk9CC43noJrRd33CuDkf6tqprJ+Fa2C9XrERR1eA8HIsuNHmqVFO0L
         AKL2RZ23ZkdJpjLKMJYfX5WeGJftOSZsg/MKMeZRjmUrrxk4MxmzAiPzFxtV6N97xPBk
         xzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a64q9IsY9mfK+JGEdi2vqlrBaBM9lMLc6dBKgesPus8=;
        b=Wk+XP6ylYm/WHVIC9b2q+q5nc1oNmWTJ9rxXP/E9N284wrl1o72vMl7l6LWEcYIW62
         +wit98dVKstvmxdCRs0gcRrhoQFQ0k6to8EOyxONXlNd48waFvd+9cHY9w7FBznWR+6k
         2UN95W9LW+OaA+b87VT9D414FntZ1F5AowzxwGA1PZiefFWh8QBafS9Gpg8kKKQDvcOR
         iVSx2v83YBnGdII3KRG5GtjkqDudvPS3sJZ+DfKgv0HBPEEXgiW5x+ggtqX5P2mgkNn0
         T+p5XhzEJ7Otu3oHZL1exzjHfC0Ou0wpCecyUbqL5fxSGm+GfbHe5AYwQ1jXgMgKFq9i
         Zs1g==
X-Gm-Message-State: ABuFfojC8T57F3baQ191K4rr2mkacl7lYYyg6ay6o5L08+VJ8etfxsH2
        IeRteyrvr4Jk2TAUAra2B6M=
X-Google-Smtp-Source: ACcGV63fufuC78nwRl2J1kK16yYyt2v0azobVvGKFe3gFlVrmI37vE3DAVJ2CPDaDJTkoMmSWv/sPA==
X-Received: by 2002:a63:81c8:: with SMTP id t191-v6mr20202153pgd.399.1539695636307;
        Tue, 16 Oct 2018 06:13:56 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
        by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:13:55 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 0/5] mm: dirty/accessed pte optimisations
Date:   Tue, 16 Oct 2018 23:13:38 +1000
Message-Id: <20181016131343.20556-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v1 I fixed the hang in nios2, split the fork patch into two
as Linus asked, and added hugetlb code for the "don't bother write
protecting already writeprotected" patch.

Please consider this for more cooking in -mm.

Thanks,
Nick

Nicholas Piggin (5):
  nios2: update_mmu_cache clear the old entry from the TLB
  mm/cow: don't bother write protecting already write-protected huge
    pages
  mm/cow: optimise pte accessed bit handling in fork
  mm/cow: optimise pte dirty bit handling in fork
  mm: optimise pte dirty/accessed bit setting by demand based pte
    insertion

 arch/nios2/mm/cacheflush.c |  2 ++
 mm/huge_memory.c           | 24 ++++++++++++++++--------
 mm/hugetlb.c               |  2 +-
 mm/memory.c                | 19 +++++++++++--------
 mm/vmscan.c                |  8 ++++++++
 5 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.18.0


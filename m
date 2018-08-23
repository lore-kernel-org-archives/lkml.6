Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6CCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E042077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEGTrO3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E042077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbeHWMQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:16:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32852 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeHWMQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:16:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so2369907pfn.0;
        Thu, 23 Aug 2018 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6k6nVoIr0ditQr3HJek6gsje6fl12edfRlaXmMdkuO0=;
        b=mEGTrO3fv5nnllbAG9dKZ1cud4fgKhuCkRtcpcF2zB3lazkm7qxQY5d5NpOo+seIbC
         n2vpHHuvRpjHM9xq9/Fob80I4WRUojXvQfvz7f6MTCk96XuHx2ssVKIma+BIJLN/EhjZ
         fMpN+5XxJNZaIyLv40A+d1LT+RTMBFnOmqRdzY2+7vVH5htXT2j/mKYqLCTBRV1TKaLi
         1VnZVJX/JVhJk7Lze1kicRZLJU8/LREkTfpurYjTIGjHUjW96oe+qdbwMC9ckk6fVAUA
         po4zevVC4rUzvhFCXJzrctenEb7wpmDnd47qZ/ZouC1PMUboqQuWm7p02eSCYPur27fu
         sEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6k6nVoIr0ditQr3HJek6gsje6fl12edfRlaXmMdkuO0=;
        b=a5irenllqNlzG5H38ufS2/A/iyeTQTj0jEtQ58NpDgrgDM21u/R8VvF4xMASibLO2E
         3wKT+VqcZ/VzMYe53YGtUzHXOeJ8Jh4EU3WtpSvlBqqwxSTF5f1AcydScRMXQerr7QwE
         0TrHG76Zt7ppO/wdzs+o7oh9vB2GRjzqpWXxhlzXNpZqlO2CjuPQYz39Q3EtD/gcjH8a
         VBZbVQUyMShoySeV6N1fzjICm2+3l+rRbE+t/J9Eqo+qacxMs6KOBbkfBjvbe1JCwZ4P
         4aalODAD8yW0EvsEvdNsATKJJolkeUfLpwKVr4G4c+UzJVOvyr+uMQ0lHgI5MwuryJFI
         7y2A==
X-Gm-Message-State: AOUpUlHZFzoSulKCaVOWSlIXj9R87cJdnjV8aRKx4/BSwcSUVPfW6Qli
        w5KWHtjWWaZ4DcA3pTxfuvQ=
X-Google-Smtp-Source: AA+uWPz9tg60W7s0lbt18az1ksmM78D2c1+qgOiyraDn8hmTJ61Gup0OThzvaVEsv3MMGdj9f5ccWw==
X-Received: by 2002:a62:6f87:: with SMTP id k129-v6mr61423320pfc.26.1535014042292;
        Thu, 23 Aug 2018 01:47:22 -0700 (PDT)
Received: from roar.ozlabs.ibm.com. ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id w5-v6sm5170503pfn.44.2018.08.23.01.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 01:47:21 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, torvalds@linux-foundation.org,
        luto@kernel.org, x86@kernel.org, bp@alien8.de, will.deacon@arm.com,
        riel@surriel.com, jannh@google.com, ascannell@google.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH 0/2] minor mmu_gather patches
Date:   Thu, 23 Aug 2018 18:47:07 +1000
Message-Id: <20180823084709.19717-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are split from some patches I posted a while back, I was going
to take a look and revive the series again after your fixes go in,
but having another look, it may be that your "[PATCH 3/4] mm/tlb,
x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE" becomes
easier after my patch 1.

And I'm not convinced patch 2 is not a real bug at least for ARM64,
so it may be possible to squeeze it in if it's reviewed very
carefully (I need to actually reproduce and trace it).

So not signed off by yet, but if you think it might be worth doing
these with your changes, it could be a slightly cleaner end result?

Thanks,
Nick


Nicholas Piggin (2):
  mm: move tlb_table_flush to tlb_flush_mmu_free
  mm: mmu_notifier fix for tlb_end_vma

 include/asm-generic/tlb.h | 17 +++++++++++++----
 mm/memory.c               | 14 ++------------
 2 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.17.0


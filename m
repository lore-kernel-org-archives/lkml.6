Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013BFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0252087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCOeJmPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0252087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeH1PL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:11:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44839 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeH1PLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:11:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so592196pgp.11;
        Tue, 28 Aug 2018 04:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HpceU0oLMX/N4fM279jk3FPRdI+msJs42Hh+cmRV4BI=;
        b=rCOeJmPhCHPAqW8RAmKC/BV6//lBIoYLvdwo8Y1ZWDr3nN76/Joq6VYhBDsADg/Mpt
         db3WuQC8GgM+PH0qZNVzerVwAN2jPSNeaQ7uVkhz4ecZsVmioaihbG+bWWgeKemqxeBW
         otm0bCjbzFWQQeZ3UVcL7N2i4jJSbm6MIvABQ8mTumDGS5B0Hey3BrFDnbydAujpgtHW
         NSCwqSI/C1hQ7i/v6cCbizecOJk3ugzTyRlEIKLdrw1gD1Acrl4WAc6IGn6z1hcm/kY3
         ISaczXQDzH2bJkWy41h3hjtidGRrssowW7e7L7ixtm2yu8RORhxgNUqjM3BMkoAEKU8B
         ix6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HpceU0oLMX/N4fM279jk3FPRdI+msJs42Hh+cmRV4BI=;
        b=Y1es079ZXmyJunlFb6YIDU0q46RLxjL58q/RlbabzbXLClFW+KBbGXR4E9eOYDntVq
         bLEYchDZ8viium4F/IP13huv0AwkjKVEtoPZBGl2H7Fv7RagXsGTdvjUAcIeJd2NAVLz
         GGVAgzG05ZIeNJHpuoA2JSw8cXy8EeB9lrZtW/svrbSF7rJw2GTrqLupTcBa5cVZKGlP
         c23oVvhl1eqRSSoccv9EcxVAQzRQt5wcDpiCriB+1/3aaM5tZuNfm1tLY7UDbT+J3BdJ
         P6B0DVYdD3sYqslHjkhjyLJ70o4IrYoxal7mSf9UZa+KPpqaoqUxDUqdAoiEqk+KB0SV
         YUyw==
X-Gm-Message-State: APzg51AWOI7zqm9qkHvb2RW2U6b51fSNat4mrTD1lNSYOPAwZiR2EiIL
        30KPMYdl7LTz8o4v+eFQFK0=
X-Google-Smtp-Source: ANB0Vdai8Ai69HuwiXJTCOM6FwviEsNLOgxvvBfhgZWOpPuuHrpa5AYPntmrzA0tO/7LlVzXvZDHYQ==
X-Received: by 2002:a62:c9:: with SMTP id 192-v6mr1077949pfa.99.1535455245223;
        Tue, 28 Aug 2018 04:20:45 -0700 (PDT)
Received: from roar.au.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id s3-v6sm3287917pgj.84.2018.08.28.04.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 04:20:44 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] mm: dirty/accessed pte optimisations
Date:   Tue, 28 Aug 2018 21:20:31 +1000
Message-Id: <20180828112034.30875-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches that didn't get much comment last time. It
looks like x86 might benefit too though, so that might get people
interested. 

I improved changelogs and added some comments, but no real logic
changes.

I hope I didn't get the x86 numbers wrong, they're more significant
than I expected so it could quite well be a problem with my test
(corrections welcome). Any data from other archs would be interesting
too.

Andrew perhaps if there aren't objections these could go in mm for
a while. 

Thanks,
Nick


Nicholas Piggin (3):
  mm/cow: don't bother write protectig already write-protected huge
    pages
  mm/cow: optimise pte dirty/accessed bits handling in fork
  mm: optimise pte dirty/accessed bit setting by demand based pte
    insertion

 mm/huge_memory.c | 24 +++++++++++++++---------
 mm/memory.c      | 18 ++++++++++--------
 mm/vmscan.c      |  8 ++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

-- 
2.18.0


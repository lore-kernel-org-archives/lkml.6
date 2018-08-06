Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4DC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73C421A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZU0TtRPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73C421A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeHFOO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:14:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41200 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbeHFOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:14:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so6766438pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CYHr8bxbzmwfyNpyR5kVPMrpeSRAGPS261fVJrY1BOI=;
        b=ZU0TtRPbAa5ODch9yjh/E5z2/Et5NEkvF3XTB4scurX06NZ9IATHNnbd4Xm9k+QLQK
         dTM1Yt66H7Y76lm0lKyVi2uTmZ7MePiZ1M6yFutRbs9D0vnZ/Wd0Mpf9HmeJaQL8zIqp
         IFpI21oDKn01DlQ3kadZGBuJ3sxwFhZlQmNnJZ6gJKsKinggLrInkEdGgTdXKMl7WhZ+
         eT7jqzwdl1JL8ckvGkHdR7LwemdQtoG3Y2DkXyjCdrHsNAi3GeW0zI+QPmWu4/7I+7Kg
         h3Hrz5iamqcMKmmvV3eU3y1QL15SGpbIK+NBMqcFvhfQ0/x4Kv6BZTNB8nZagbxB4LaP
         JxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CYHr8bxbzmwfyNpyR5kVPMrpeSRAGPS261fVJrY1BOI=;
        b=UxPYNP505KBkR12EbHxNt0RdRNuWMHrtb8yNMfexCbLsP891sSoH+EjwXMU60Tp+ID
         o/d7XyJRYrh05M2oVrjZ95jj82iyZnkrdRva1Hq/s3505LZa2BXhs5jc9wpcHCdcRpVi
         yy6S/anGbwxpWo8LfflY6gcIm6SGwB5RV/VfYKzBQNTYycIXoD74CE28C5rU+j/64mgn
         M5PAXpQKVxcwKHx1bbF03HY3vXyYZR8mk63hHOUrIWu1h/wJIdkBgZkimDZ6UMRnkegF
         FlGS/knjLPjqSsdPNgZDNjnTLzGjB1TvE+U/KgKLrN0DauG7qRYhhm7wlyZ13YOLn96J
         wqmQ==
X-Gm-Message-State: AOUpUlGjQVEgZB7bqYOQlFZv84Pbgmv9YnQx7J3vvEMacqWppUzdEDFj
        0h0hgmvkV9Bz2yxTE56Gl2Hz+CH2FyikdhqFzssQJw==
X-Google-Smtp-Source: AAOMgpcPCkXGAMPUdv2fHmd58OpBX0NR6x/WsD+iPDAtTem+dFovgUrHe6QYTU5YN5jnF0vigNlv3g4EatvzUkQn0EY=
X-Received: by 2002:a62:d10d:: with SMTP id z13-v6mr16757700pfg.98.1533557140281;
 Mon, 06 Aug 2018 05:05:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 6 Aug 2018 05:05:19
 -0700 (PDT)
In-Reply-To: <0413df4d-262d-fee8-f1a3-99ccf1d3a441@embeddedor.com>
References: <20180804220827.GA12559@embeddedor.com> <CACT4Y+arVJ4qt54LzKKoyh9+NKA+fjyCShKi82NanbovhK_mmQ@mail.gmail.com>
 <0413df4d-262d-fee8-f1a3-99ccf1d3a441@embeddedor.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Aug 2018 14:05:19 +0200
Message-ID: <CACT4Y+YDD2M4Z1XodDxOm-SQszGhMvS+7Tzuiq2FKCG8JK2uLA@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan/kasan_init: use true and false for boolean values
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 1:39 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Hi Dmitry,
>
> On 08/06/2018 04:04 AM, Dmitry Vyukov wrote:
>> On Sun, Aug 5, 2018 at 12:08 AM, Gustavo A. R. Silva
>> <gustavo@embeddedor.com> wrote:
>>> Return statements in functions returning bool should use true or false
>>> instead of an integer value.
>>>
>>> This code was detected with the help of Coccinelle.
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>
>> Hi Gustavo,
>>
>> I don't see this code in upstream tree. Is it against some other tree? Which?
>>
>
> Yep. It's against linux-next.

See it now.

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks

> Should I use [PATCH next] in the subject next time?

I dunno. I just find this part of kernel development process strange
and confusing. Say, how should testing of kernel patches work? Usually
today base commit is just captured by review system.

> Thanks
> --
> Gustavo
>
>> Thanks
>>
>>> ---
>>>  mm/kasan/kasan_init.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
>>> index 7a2a2f1..c742dc5 100644
>>> --- a/mm/kasan/kasan_init.c
>>> +++ b/mm/kasan/kasan_init.c
>>> @@ -42,7 +42,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
>>>  #else
>>>  static inline bool kasan_p4d_table(pgd_t pgd)
>>>  {
>>> -       return 0;
>>> +       return false;
>>>  }
>>>  #endif
>>>  #if CONFIG_PGTABLE_LEVELS > 3
>>> @@ -54,7 +54,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
>>>  #else
>>>  static inline bool kasan_pud_table(p4d_t p4d)
>>>  {
>>> -       return 0;
>>> +       return false;
>>>  }
>>>  #endif
>>>  #if CONFIG_PGTABLE_LEVELS > 2
>>> @@ -66,7 +66,7 @@ static inline bool kasan_pmd_table(pud_t pud)
>>>  #else
>>>  static inline bool kasan_pmd_table(pud_t pud)
>>>  {
>>> -       return 0;
>>> +       return false;
>>>  }
>>>  #endif
>>>  pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
>>> --
>>> 2.7.4

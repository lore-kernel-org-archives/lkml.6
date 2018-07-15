Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89206ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4074F2089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvXvm1BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4074F2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbeGOCrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:47:01 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33066 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731985AbeGOCrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:47:01 -0400
Received: by mail-io0-f196.google.com with SMTP id z20-v6so34649131iol.0;
        Sat, 14 Jul 2018 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o7Uj+8OHr/w92FSAO+0rbmG2vNuuu8yFVUa8EREwXEE=;
        b=lvXvm1BYY1CkHypyukRfwIfRiQ9Xc7eL2XVbTzwBmLODpXk3HmF5iJ+fHddx5mny7t
         FcKcmitv+vAeKOSGBf5j70FRFuRfOP2gIT/fWkC9tpz2Jrc1l//2uLVr3Z/Cn5OZubsu
         bbdt7x0Fwxt+JgsOGp2ILCAt2SxLMlMFgmdTC8nZmbjCy5gbFuR+PDnhxmImQwKftU6j
         WcrsxlJj7swVEMWc9azO/bRXTQfLR7th9gXlT736ps9f4Us26s2odUg4oM5yngMDGWBH
         xKlQwX0ybatD6E3ZpSljseTtBtltUh0PnnzRpw3yk4nYZn9cutdbOn6Iy0azgYVhNBav
         x7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o7Uj+8OHr/w92FSAO+0rbmG2vNuuu8yFVUa8EREwXEE=;
        b=s2rfmjBly60MC/0gDUZ9GjSXn6OfIEUODE4Ml5Z7hJsx7S9FGY3kBYPr7cDnw1OuGW
         ksOpiEwEiBvIS64/ciAwSwe35rFObxw+V4ZU1U+89bK2N2/VHtTchTMIt+qOqkGZtBWA
         p10Fn2Fv8qdLtWGkIldau/DLlCSkNu4qg3QzosFMW461ly5khVBOsBxHHi8Oda8cv8p5
         9osaz6IoRVDLJzU6bsdAnt9zvnaV3vzHnDDm5TVyPLzYNYNPQLBoQlwiClVv3rTsS8Z2
         NsyrKic6j3qUP5pERvSFzvWOlMdWce5Ut4hgC0L6Uu5hG1lzIyv0teWC07xsqvRm8foY
         jkig==
X-Gm-Message-State: APt69E30g4R4AECp/dHH6bUm4GhjAL2Jl7zhRAiVjnJJnPofHqxRIxLk
        eAP7qbTbefIjd6S1ValICaOEi4THQ8OOsGozTzU=
X-Google-Smtp-Source: AAOMgpeZOoC3eUp2/uaENnigtLCwFxgCFsaMdBeojxqRYlaHvEMG3TjP3BZFlSXcGLhuk6GLFgY4KUjY/cCHcEW4Z3M=
X-Received: by 2002:a6b:c8c8:: with SMTP id y191-v6mr35537933iof.295.1531621550139;
 Sat, 14 Jul 2018 19:25:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7a47:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:25:09
 -0700 (PDT)
In-Reply-To: <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com>
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
 <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com> <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 15 Jul 2018 10:25:09 +0800
Message-ID: <CALOAHbA__E8oCYpGvKg-ZMpeQ1tOT5V2ShxLhuozZSSnDNh2XQ@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:10 AM, Yafang Shao <laoar.shao@gmail.com> wrote:
> On Sat, Jul 14, 2018 at 11:38 PM, Shakeel Butt <shakeelb@google.com> wrote:
>> On Sat, Jul 14, 2018 at 1:32 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>
>>> try_charge maybe executed in packet receive path, which is in interrupt
>>> context.
>>> In this situation, the 'current' is the interrupted task, which may has
>>> no relation to the rx softirq, So it is nonsense to use 'current'.
>>>
>>
>> Have you actually seen this occurring?
>
> Hi Shakeel,
>
> I'm trying to produce this issue, but haven't find it occur yet.
>
>> I am not very familiar with the
>> network code but I can think of two ways try_charge() can be called
>> from network code. Either through kmem charging or through
>> mem_cgroup_charge_skmem() and both locations correctly handle
>> interrupt context.
>>
>
> Why do you say that mem_cgroup_charge_skmem() correctly hanle
> interrupt context ?
>
> Let me show you why mem_cgroup_charge_skmem isn't hanling interrupt
> context correctly.
>
> mem_cgroup_charge_skmem() is calling  try_charge() twice.
> The first one is with GFP_NOWAIT as the gfp_mask, and the second one
> is with  (GFP_NOWAIT |  __GFP_NOFAIL) as the gfp_mask.
>
> If page_counter_try_charge() failes at the first time, -ENOMEM is returned.
> Then mem_cgroup_charge_skmem() will call try_charge() once more with
> __GFP_NOFAIL set, and this time if If page_counter_try_charge() failes
> again the '
> force' label in  try_charge() will be executed and 0 is returned.
>
> No matter what, the 'current' will be used and touched, that is
> meaning mem_cgroup_charge_skmem() isn't hanling the interrupt context
> correctly.
>
> Pls. let me know if I miss something.
>
>

Maybe bellow change is better,
@@ -2123,6 +2123,9 @@ static int try_charge(struct mem_cgroup *memcg,
gfp_t gfp_mask,
                goto retry;
        }

+       if (!gfpflags_allow_blocking(gfp_mask))
+               goto nomem;
+
        /*
         * Unlike in global OOM situations, memcg is not in a physical
         * memory shortage.  Allow dying and OOM-killed tasks to
@@ -2146,9 +2149,6 @@ static int try_charge(struct mem_cgroup *memcg,
gfp_t gfp_mask,
        if (unlikely(task_in_memcg_oom(current)))
                goto nomem;

-       if (!gfpflags_allow_blocking(gfp_mask))
-               goto nomem;

Thanks
Yafang

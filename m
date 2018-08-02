Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEADEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9670A2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkIb1cwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9670A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbeHBTSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:18:20 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37225 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbeHBTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:18:20 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so3197461qtl.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KwYD+47x7qvQTWci8ElMEZISbIN/EuE4/PSXuYpk0bc=;
        b=bkIb1cwpW0Q8ZzP+wa4++ypiYKb/cXKBE+8rTAIqJqTG4ZuJb/3nDz+h/qW9LawGjl
         3SI47Jh8SyLuCRCQCEloPzZQ1nnouG+F+OGc0NIaYY3z/PaxgouI16dULRmoOLkxIWMc
         BhOevJdWjnHCMZ01NApNJKUyvdUYZaNzuVIRxEUCm8yZ3NzvgY+ZDQo6y+0e4WiD5UBn
         wFo5iyVT2wPwoRhKxfRQrGiNmIaXAQiSOg7NlTNjqHoo+x/bOkgN6jwsUaVkPxjsCqHG
         7FgD9Q7bujKAFDsoIt1ve/oXmcNv4dmeAF1CGeoKONK2UOGUo+S8JgyC95iCrZOAfvty
         wsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KwYD+47x7qvQTWci8ElMEZISbIN/EuE4/PSXuYpk0bc=;
        b=T0jmlNkr53Rfh10931+jTtPt5u1gi2jWYvKqwO3Dt0DdPL+GG6YwGRnnmK4ZkaIvUs
         TrInwI6kp7BEjYBER1WB0Kpp4uWzHCCrfkEMphHxkGAQ8phWrs2LTT2vywViRG2WzLwT
         0CHTTnvETELLk6psIYSGHu2Pi81K9JoSz9ykieDZPlPZyLZmpWt8YIbPAdbMICEM7kZF
         mB5eKCadDx9jt6E9YG2mdumLJnYo6FJdk3M6rs7HXQKlCn2gYT87tF3rgVbP2QjH9UiH
         pdkCD4dSg/MEetjqyvFrRCYqEDKCZcp8cup74aiZyKyx40f4yOihDClc2yGdcoAQ34NK
         JFbg==
X-Gm-Message-State: AOUpUlG951bf69gR+sSuI+xSIikw3OOgOoZr5yfQ3Baw8OTS/ELLmQFD
        sxuNxrjtiEe66E6TkrNQx5GOyo8d761cFIH4BkU=
X-Google-Smtp-Source: AAOMgpdApRUCJW5dFuFEu5ow9bIgZ3nzipgLDCBK2OW8S28Frhjf+6vMc6nZ9c3K5u5M574kuhTf3hRJObzBz/Jxy6g=
X-Received: by 2002:a0c:df14:: with SMTP id g20-v6mr375817qvl.183.1533230774809;
 Thu, 02 Aug 2018 10:26:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2a83:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 10:26:14 -0700 (PDT)
In-Reply-To: <CALvZod6cUJktTAGrc-q7XPRTykdWR6MfgyPXE1B=AZq9U7P31g@mail.gmail.com>
References: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
 <CAHbLzkpBnNN4RBMHXzy09x1PZw4m5D99jANmjD=0GT=1tkxniQ@mail.gmail.com> <CALvZod6cUJktTAGrc-q7XPRTykdWR6MfgyPXE1B=AZq9U7P31g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 2 Aug 2018 10:26:14 -0700
Message-ID: <CAHbLzkpexLdg=eEudwxV-ztF81gs2a4HeyYb2zeAWZmV45ja4w@mail.gmail.com>
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to do_shrink_slab()
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Huang Ying <ying.huang@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>, jbacik@fb.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 9:54 AM, Shakeel Butt <shakeelb@google.com> wrote:
> On Thu, Aug 2, 2018 at 9:47 AM Yang Shi <shy828301@gmail.com> wrote:
>>
>> On Thu, Aug 2, 2018 at 4:00 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>> > In case of shrink_slab_memcg() we do not zero nid, when shrinker
>> > is not numa-aware. This is not a real problem, since currently
>> > all memcg-aware shrinkers are numa-aware too (we have two:
>>
>> Actually, this is not true. huge_zero_page_shrinker is NOT numa-aware.
>> deferred_split_shrinker is numa-aware.
>>
>
> But both huge_zero_page_shrinker and huge_zero_page_shrinker are not
> memcg-aware shrinkers. I think Kirill is saying all memcg-aware
> shrinkers are also numa-aware shrinkers.

Aha, thanks for reminding. Yes, I missed that memcg-aware part.

>
> Shakeel

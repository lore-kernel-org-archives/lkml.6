Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF2BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAABA21531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nmoq84F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAABA21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeHBSq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:46:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37005 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeHBSq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:46:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so2828462wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0fYkYAYTMM4nAr6rG/cSlc04PmmDgzykaeGmSzKMqY=;
        b=Nmoq84F++Xah3ORCdPd7l4c04f16e6RhkfMkqR6tUhHLicAN8SikzLuHCjftaOMxwI
         7QKbTjU87r0++4L/1Qs20XqcRxn9rDvpCyc5nflavecN6W1ial3HVu9U3yZfjgsspafw
         vBxjFEzeP+NyJlrfnvB4mAk1N6KLQeNADPDUjKU9w8xGPeRCQViE8OrEkNZE8fr3Yxy6
         ry5HAf1wNBClLy86TgRYwVbHRc4NziYWi5xphdmyNTFrkCI6qb9suyWiJuFv4yrc3M60
         6IqaqcEShuybyqzQx0nqu9l/rFgYR/rOePk6X6uHDdG93sp0OiLmtQTtRGenPeZLCLlN
         jibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0fYkYAYTMM4nAr6rG/cSlc04PmmDgzykaeGmSzKMqY=;
        b=pckvppCNpETq4naax+Hf9jDHSwZroeByKQHAjKUQba7fGa++uJG7nBJ7jb6LpscjOO
         3PjQXKeKQR4pTW5IK0O15GAn1xWIlWbVftQcWp6s4wtvIangXqBiupH1lCobxeIbM3Kx
         8r6pY/NKlk4B82lz6dutMUYlNaiOJvLFrDS1oFSwim4p8aL3k1gAsj5ApWIoqmWxeZy+
         SN1NaZVKTrfX2p+nm7UVGsYhPYtNfhTdz3Q3LzxTXjMy3YAtR6ody/3KPt63mf/RtxZv
         47pt53WieDZBjG7cP8zi9p60NPj7+tjCcHmvgcJLlI24ny5uEyKmBtLhQ6pEU3eVPyVt
         7oFA==
X-Gm-Message-State: AOUpUlHeP7Z5F5Z5t/pTjFWVjm0JsEXs3PLIuImxsPlFmz2aMnj2SfUb
        P8kFW9jp5NnxOl7s4thCJZOYaMxeW8DC4sUDQSXGzQ==
X-Google-Smtp-Source: AAOMgpetPayRj8uHbqMmZb/cnvjj3V1zTF0qXtnTM8CuLZtP8guIkbHt/izMiFY3wl7f0524cLhvsmaN9XiAJc/P/Lo=
X-Received: by 2002:adf:9527:: with SMTP id 36-v6mr166389wrs.99.1533228900669;
 Thu, 02 Aug 2018 09:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
 <CAHbLzkpBnNN4RBMHXzy09x1PZw4m5D99jANmjD=0GT=1tkxniQ@mail.gmail.com>
In-Reply-To: <CAHbLzkpBnNN4RBMHXzy09x1PZw4m5D99jANmjD=0GT=1tkxniQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Aug 2018 09:54:49 -0700
Message-ID: <CALvZod6cUJktTAGrc-q7XPRTykdWR6MfgyPXE1B=AZq9U7P31g@mail.gmail.com>
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to do_shrink_slab()
To:     shy828301@gmail.com
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

On Thu, Aug 2, 2018 at 9:47 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Aug 2, 2018 at 4:00 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > In case of shrink_slab_memcg() we do not zero nid, when shrinker
> > is not numa-aware. This is not a real problem, since currently
> > all memcg-aware shrinkers are numa-aware too (we have two:
>
> Actually, this is not true. huge_zero_page_shrinker is NOT numa-aware.
> deferred_split_shrinker is numa-aware.
>

But both huge_zero_page_shrinker and huge_zero_page_shrinker are not
memcg-aware shrinkers. I think Kirill is saying all memcg-aware
shrinkers are also numa-aware shrinkers.

Shakeel

Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A290BC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDF620875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zpg7avSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDF620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbeGIPAK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:00:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34841 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932903AbeGIPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:00:09 -0400
Received: by mail-it0-f67.google.com with SMTP id l16-v6so26826540ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Vtcl7bW8s9nMyA3kb86pmtRoEXWWpeCeD6YMwVsuOc=;
        b=Zpg7avSZQdJfPbaAs1pMsbx5QxxmutPK0K95yVhpISUs8HVsg2hWcoVOgGPnQYX9D/
         Uwh7jG/blLhJLzCVHA9DVi5rRECaxxJ/lSs3g8tVH67lqAtzan15Jpt7tv0vSZ4afhO6
         06WGtPa3hDlpE4oTc9OK/j66rfDgpu1fd4X5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Vtcl7bW8s9nMyA3kb86pmtRoEXWWpeCeD6YMwVsuOc=;
        b=SiSU34cdIt6dq6pnmZKFnEYqFjsf1Pp9GYXhiF6tQApOscpm8VElEk29WJ83rxnNNR
         loSrIBNepxgTOOCHcymskYvDkS9H0MNJYbljg1mcqiPq5AeWpgyBQ9ybDChn3svXnTqe
         GJW1YXhf9SjAqdRld36bL12uj0JBWDyv9S0cXAe7runFIlUMKzteAkaJjJxxSP/YIpP4
         fZIPR+2jGcddXWagN8KPK/J4IKT5jAfIRbHjhn8wlWYfVtDXhIiPhwX31vWWx8jjl/YI
         pfn+M/7nhzikE4vpGvZhUJVUIbEJekBceK4i/8dy4SHOgSe/vFNMjLW8lU5Tr39AUgyK
         1VrA==
X-Gm-Message-State: AOUpUlFfqUB2yVCS1YbU+o5/pdcPZh8sziHXtRP/3ykghfaynIRU98OW
        /LYxOMGvp3LOq+B0qDWJQrM+tydDpMWtNbvO8AYktg==
X-Google-Smtp-Source: AAOMgpctehKfq7V7H+mDb3tgMgYMho4hzbMBxkaD0o+HcAFuysJJ+JzVFkebS+dyJ2QW+v93KgPNvITW60iMY4DZxrA=
X-Received: by 2002:a24:558a:: with SMTP id e132-v6mr5592669itb.2.1531148408326;
 Mon, 09 Jul 2018 08:00:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 08:00:07 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <20180709103656.GH2476@hirez.programming.kicks-ass.net>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch> <20180709103656.GH2476@hirez.programming.kicks-ass.net>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 9 Jul 2018 17:00:07 +0200
Message-ID: <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] sched: use for_each_if in topology.h
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 12:36 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Jul 09, 2018 at 10:36:49AM +0200, Daniel Vetter wrote:
>> Avoids complaints from gcc about ambiguous else clauses.
>
> Is that a new thing? I'm fairly sure I've never seen it do that,
>
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>  include/linux/topology.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index cb0775e1ee4b..4fba5a5b148d 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -40,7 +40,7 @@
>>
>>  #define for_each_node_with_cpus(node)                        \
>>       for_each_online_node(node)                      \
>> -             if (nr_cpus_node(node))
>> +             for_each_if (nr_cpus_node(node))
>
> Not having gotten any of the other patches, I'm not really sure what
> this does and such, but improve readability it does not :/

Patch 1 in this series, which I dumped onto lkml as a whole:

https://lkml.org/lkml/2018/7/9/179

Imo it does improve readability for the if (!cond) {} else pattern.
And (assuming my grep fu isn't too badly wrong) most places in the
kernel do use this pattern in for_each macros, so I guess its a real
thing. We've definitely hit it plenty in drm iterators (but we seem to
like if() checks in iterator macros maybe a bit too much).

I'm happy to drop this patch tough if you deem it offensive.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

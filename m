Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AD8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E2A214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXUzJLoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E2A214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeHVJYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:24:55 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44452 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeHVJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:24:54 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so279314ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQtEyXxZ1vRMeSyyXegCzOsE5Pyarvaimev5VP7caPQ=;
        b=SXUzJLoqEkyWa1WYNNnJX2CJwuJcYW9sP2xSp3+AalH0jJxWNI6Y6bGlvjkQYFKWA8
         B4Ra6IekWm4A+V/AQqIrZtWAuULZ6KiGkvytDomytdaWjlCwtkt6P1F7gQS0LHSILq/b
         D5SrfyzuR3fHORAqHzwZYPUCJYXTC5YwMsnfiEJgy4AiSy//1YwQ/rRvcAX9ELBalX/C
         gdoDqmcyX0qfp4iWJljYTerMYvUy7ULYWDxqkYMCml9bKRgZE8qXeT8UyOFcTIxNaiRX
         BM3j24iX099y1Pbpi6ZDhW+aXjMSOtfcWJ6WPXBHIGiPWZqXBstCRCmxelBXUZXafCZD
         zLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQtEyXxZ1vRMeSyyXegCzOsE5Pyarvaimev5VP7caPQ=;
        b=rq3omKUJiHe2UmPCHhOQGoCA1LH1shNQaa93rBFyMesqmRAG53xhiwl5QGt7Mbia+0
         3Q3WMUIb/w33uRw6R9XZjtDKILvIeo2ycsB8cVRTz6Pbex/q/OuAcOCgqCQtBpEdnPBx
         Ctr0UHlb0N4QUfyi67kRoJo2yVEA8Jh/53KG5SKORvmQWwLgKCI4eXUuhz3gf4xW8Oa6
         c7r4d5r04GxA8xhmNKdEHkf/aXND/EpxQt+Md19F7izfGPTdQeYzXYbRFhkkI8+x1qeB
         86nEVP9rm7dZYptPrhzmALsDR0N5fbWAj9pHAlCe+LR53rURFehUAbcgNrMfLlRzKI38
         5pog==
X-Gm-Message-State: AOUpUlEaFiR8gkUPP3Qjwdsof9h6/an1rrhzzocQsuiDZBMrfYsTRCdh
        kVVYLcY4zcj2RT/ogZWkOSUCC5QKYB0+Z+zil7k=
X-Google-Smtp-Source: AA+uWPytzlCzy4ljF6OJnbGsmUsoV+vwAYPmVDYuR+QG7MAIT7PIAJFYPWZsHYCk+q563lUPcpOs5Fh+PZwWdYA03dA=
X-Received: by 2002:a25:5092:: with SMTP id e140-v6mr14658328ybb.44.1534917691797;
 Tue, 21 Aug 2018 23:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180817231834.15959-1-guro@fb.com> <20180818012213.GA14115@bombadil.infradead.org>
 <CALYGNiOf_0fR4R747J11JNROO7_FW_9u16Bg09f+CdWPiFwGvw@mail.gmail.com> <20180821171555.GA16545@cmpxchg.org>
In-Reply-To: <20180821171555.GA16545@cmpxchg.org>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Wed, 22 Aug 2018 09:01:19 +0300
Message-ID: <CALYGNiMO973zcp85i5yd=Fa-Jo7SdObXH6sPuogoO3hnB-GgRA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: don't miss the last page because of round-off error
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 8:15 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> On Tue, Aug 21, 2018 at 08:11:44AM +0300, Konstantin Khlebnikov wrote:
>> On Sat, Aug 18, 2018 at 4:22 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> > On Fri, Aug 17, 2018 at 04:18:34PM -0700, Roman Gushchin wrote:
>> >> -                     scan = div64_u64(scan * fraction[file],
>> >> -                                      denominator);
>> >> +                     if (scan > 1)
>> >> +                             scan = div64_u64(scan * fraction[file],
>> >> +                                              denominator);
>> >
>> > Wouldn't we be better off doing a div_round_up?  ie:
>> >
>> >         scan = div64_u64(scan * fraction[file] + denominator - 1, denominator);
>> >
>> > although i'd rather hide that in a new macro in math64.h than opencode it
>> > here.
>>
>> All numbers here should be up to nr_pages * 200 and fit into unsigned long.
>> I see no reason for u64. If they overflow then u64 wouldn't help either.
>
> It is nr_pages * 200 * recent_scanned, where recent_scanned can be up
> to four times of what's on the LRUs. That can overflow a u32 with even
> small amounts of memory.

Ah, this thing is inverted because it aims to proportional reactivation rate
rather than the proportional pressure to reclaimable pages.
That's not obvious. I suppose this should be in comment above it.

Well, at least denominator should fit into unsigned long. So full
64/64 division is redundant.

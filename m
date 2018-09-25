Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E871EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D982206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wq1FBMT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D982206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeIYNq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:46:29 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40045 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeIYNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:46:29 -0400
Received: by mail-it1-f194.google.com with SMTP id h23-v6so13989803ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zkjPu8sqVqVlLQn3HHnoX4VB3fNmHWl+/O0NQYXKt7s=;
        b=Wq1FBMT3PMs5fbM/J0OhPdOEHu5hLONYqafU9CU7IOD2bCDwjHFhc0U3JvNpACtlgL
         OTopbEkiUZ3CHQ6M3pH4a9YfspKwqE+ZxlYV/ALUmeXji0Jfc3y3QQ48QCDCG+lHrSzE
         8LTmwhQonFwnOSv4CEFyXzPoKmv2BFGGqlijW84MX3y9fBhginYPCbYjoWJPUCFoBAzz
         XwdBf7usAJcbboLjAt9EHdfPobv98DwuU23ekKyGV3MSkRDrrv4vEZvp0sMuPxN1wZpk
         b2TcJwhM9OpRnaD/U97G3d+d4Jr9/dT+L7d82bTsTHB6ZGUP/22Uqw1XPeEFKOBkqfhV
         13sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zkjPu8sqVqVlLQn3HHnoX4VB3fNmHWl+/O0NQYXKt7s=;
        b=k/79exvfNcWyOBe4/UOlRVpr37aHn8JyPu2r/l5EB2TPT0V9iJPArd4Cl/8T87OiaC
         zBm6bU3NfoJ05NTo8atNAWw2pSv89sIAn0m0m9lv1Mc7rZh2rJLK+iVpYBN72GWkgvTV
         QRKAU1rwXLXYrgVEtRaXwera2plpWU3Z8vHyv19hnsZOF4fC51SZNEwryTLbmSW2Wf4q
         GfP0jfZY+hIZGXKzilJu+Q1C5r0k5AuUZ/bSJsqIhi8189k/UbkiG+qk9ulXMvxgoox5
         pfc2vA8d/WZ131ysNlIDJVs08mW2HE2eMdt4FBrfAP2T2GL73jAKT6sUvA//IOOA0aMm
         8O1Q==
X-Gm-Message-State: ABuFfogbWucC4IBSOqevZx+9eTa5vdGOhjypEBPCVfGHQBTsVWsoFf2E
        red0PiSjtXYweD2mvEaB8dS+53JCGj5hzLlp74pC+g==
X-Google-Smtp-Source: ACcGV60O9aQuEZTl5/5TokULzu8a8dZU/LwJOcL32n4gboyT6E7FW34x2aVDdMCpvDKCP6jOYmZlLp8eSgo/gdsHT8g=
X-Received: by 2002:a24:c0c5:: with SMTP id u188-v6mr527094itf.57.1537861213087;
 Tue, 25 Sep 2018 00:40:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 00:39:52
 -0700 (PDT)
In-Reply-To: <20180924184158.GA156847@dtor-ws>
References: <000000000000e5f76c057664e73d@google.com> <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
 <20180924184158.GA156847@dtor-ws>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Sep 2018 09:39:52 +0200
Message-ID: <CACT4Y+ZPrngv8GTC-Cw68PBDxZ2T5x1kKMNXL3DmP24Xd0m_5g@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Christopher Lameter <cl@linux.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 8:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Sep 24, 2018 at 03:55:04PM +0000, Christopher Lameter wrote:
>> On Mon, 24 Sep 2018, Dmitry Vyukov wrote:
>>
>> > On Mon, Sep 24, 2018 at 5:08 PM, Christopher Lameter <cl@linux.com> wrote:
>> > > On Sun, 23 Sep 2018, Dmitry Vyukov wrote:
>> > >
>> > >> What was the motivation behind that WARNING about large allocations in
>> > >> kmalloc? Why do we want to know about them? Is the general policy that
>> > >> kmalloc calls with potentially large size requests need to use NOWARN?
>> > >> If this WARNING still considered useful? Or we should change it to
>> > >> pr_err?
>> > >
>> > > In general large allocs should be satisfied by the page allocator. The
>> > > slab allocators are used for allocating and managing small objects. The
>> > > page allocator has mechanisms to deal with large objects (compound pages,
>> > > multiple page sized allocs etc).
>> >
>> > I am asking more about the status of this warning. If it fires in
>> > input_mt_init_slots(), does it mean that input_mt_init_slots() needs
>> > to be fixed? If not, then we need to change this warning to something
>> > else.
>>
>> Hmmm.. kmalloc falls back to the page allocator already?
>>
>> See
>>
>> static __always_inline void *kmalloc(size_t size, gfp_t flags)
>> {
>>         if (__builtin_constant_p(size)) {
>
> It would not be a constant here though.
>
>>                 if (size > KMALLOC_MAX_CACHE_SIZE)
>>                         return kmalloc_large(size, flags);
>>
>>
>> Note that this uses KMALLOC_MAX_CACHE_SIZE which should be smaller than
>> KMALLOC_MAX_SIZE.
>>
>>
>> How large is the allocation? AFACIT nRequests larger than KMALLOC_MAX_SIZE
>> are larger than the maximum allowed by the page allocator. Thus the warning
>> and the NULL return.
>
> The size in this particular case is being derived from a value passed
> from userspace. Input core does not care about any limits on size of
> memory kmalloc() can support and is perfectly happy with getting NULL
> and telling userspace to go away with their silly requests by returning
> -ENOMEM.
>
> For the record: I definitely do not want to pre-sanitize size neither in
> uinput nor in input core.

Christopher,

Assuming that the size is large enough to fail in all allocators, is
this warning still useful? How? Should we remove it?

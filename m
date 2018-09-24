Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92188ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE6A2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCpGUd4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE6A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbeIYApd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:45:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeIYApc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:45:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so9562871pgp.9;
        Mon, 24 Sep 2018 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GoIeO8bXjKM7x9bySHS8IWgy1hg5fcicbTVb281PNWQ=;
        b=jCpGUd4ikkKkCPlSbydVbwbkb6UyrHXdqN8seQ9496Hx6XgBuZXpPNymM02nl8+1bS
         i6qGQ2wAxGNklhvsTK6c4bT04rN5lxqgQSvHedr1vIw9f61g/t1f21wVKYGoPYOFaK8I
         A2pWN9WSAqZyDCY+IsZzu5wBA2hvNnr0To30NG6cERg5g+45EpAEyak9kxtWULMmT7I4
         hMd0d6AxBGh1I0pmlSw1nw8gTei8OlCPn5eeDpTU3MTG9vBv1aHIf/U1PG9Fh3BUzGOE
         Wa4hDuh/62Kxyf0RZMnx6G3KulBu2oWgECwUjla/ChewDEdQZ6snCi0pywwDWx9dZDqZ
         HJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GoIeO8bXjKM7x9bySHS8IWgy1hg5fcicbTVb281PNWQ=;
        b=m08TYxJgeeDNnO4N4g0qJTu7SPksyKsj/EvgsLPYtuzuZ/rAUVpWUTwhpFnCthQLxj
         hieaSBux8T6KtgN4oyiB6MYfnk2Kg0HudohnEy26tBQlZsJf7WxECIni7vf2t/BLaIoi
         kUqkjvCwahvWechuIpA4XQZ3kNZe7X+JFwfpxDJI/0bG7dWU0KoKZoGsb9qHjNRdRjHO
         fRvpT6plZdDpVR/z5Gr0KUfn8zUBz+NUKqmPbiKVAjE0sj5FMPaq7VDRS9MjPwby1f58
         nqzEK9ejBz/iQz5sZEa2cgEsO6O7XcJYoEXyQ+LixgEFm0mXwG0PDYDt2PU+P17zgpTk
         HCtQ==
X-Gm-Message-State: ABuFfojzuzW1hAZ9enSh0GD5GXNZd6JyF/JNYNgQRvAALh2f69dVpP/y
        md/FkarV2HKCf7Ijz7/oDW4=
X-Google-Smtp-Source: ACcGV603EIeni1xN6df5H2V3pSI9pr4gcDTnUjAT2EHqrJdN0WeStyuiCl2KbMWgBtfZWMhL0bUvYg==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr125983pfa.96.1537814521765;
        Mon, 24 Sep 2018 11:42:01 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w23-v6sm60667pgi.18.2018.09.24.11.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 11:42:00 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:41:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+87829a10073277282ad1@syzkaller.appspotmail.com,
        Pekka Enberg <penberg@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: WARNING: kmalloc bug in input_mt_init_slots
Message-ID: <20180924184158.GA156847@dtor-ws>
References: <000000000000e5f76c057664e73d@google.com>
 <CAKdAkRS7PSXv65MTnvKOewqESxt0_FtKohd86ioOuYR3R0z9dw@mail.gmail.com>
 <CACT4Y+YOb6M=xuPG64PAvd=0bcteicGtwQO60CevN_V67SJ=MQ@mail.gmail.com>
 <010001660c1fafb2-6d0dc7e1-d898-4589-874c-1be1af94e22d-000000@email.amazonses.com>
 <CACT4Y+ayX8vzd2JPrLeFhf3K_Quf4x6SDtmtkNJuwNLyOh67tQ@mail.gmail.com>
 <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001660c4a8bbe-91200766-00df-48bd-bc60-a03da2ccdb7d-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:55:04PM +0000, Christopher Lameter wrote:
> On Mon, 24 Sep 2018, Dmitry Vyukov wrote:
> 
> > On Mon, Sep 24, 2018 at 5:08 PM, Christopher Lameter <cl@linux.com> wrote:
> > > On Sun, 23 Sep 2018, Dmitry Vyukov wrote:
> > >
> > >> What was the motivation behind that WARNING about large allocations in
> > >> kmalloc? Why do we want to know about them? Is the general policy that
> > >> kmalloc calls with potentially large size requests need to use NOWARN?
> > >> If this WARNING still considered useful? Or we should change it to
> > >> pr_err?
> > >
> > > In general large allocs should be satisfied by the page allocator. The
> > > slab allocators are used for allocating and managing small objects. The
> > > page allocator has mechanisms to deal with large objects (compound pages,
> > > multiple page sized allocs etc).
> >
> > I am asking more about the status of this warning. If it fires in
> > input_mt_init_slots(), does it mean that input_mt_init_slots() needs
> > to be fixed? If not, then we need to change this warning to something
> > else.
> 
> Hmmm.. kmalloc falls back to the page allocator already?
> 
> See
> 
> static __always_inline void *kmalloc(size_t size, gfp_t flags)
> {
>         if (__builtin_constant_p(size)) {

It would not be a constant here though.

>                 if (size > KMALLOC_MAX_CACHE_SIZE)
>                         return kmalloc_large(size, flags);
> 
> 
> Note that this uses KMALLOC_MAX_CACHE_SIZE which should be smaller than
> KMALLOC_MAX_SIZE.
> 
> 
> How large is the allocation? AFACIT nRequests larger than KMALLOC_MAX_SIZE
> are larger than the maximum allowed by the page allocator. Thus the warning
> and the NULL return.

The size in this particular case is being derived from a value passed
from userspace. Input core does not care about any limits on size of
memory kmalloc() can support and is perfectly happy with getting NULL
and telling userspace to go away with their silly requests by returning
-ENOMEM.

For the record: I definitely do not want to pre-sanitize size neither in
uinput nor in input core.

Thanks.

-- 
Dmitry

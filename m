Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B5EC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483A020827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujzdOS6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483A020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbeKGL6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:58:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52099 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeKGL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:58:17 -0500
Received: by mail-it1-f196.google.com with SMTP id h13so20937179itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 18:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D5dO5U7xUR43RpvzcZ2rmGU+/p/HCB+fIKQOcJYLgGU=;
        b=ujzdOS6xFW2hiVk1V9AYvhElBp2d4T9sskfhOC6OYbJzdgz66piwQmGF6XuNSeUgxO
         PwmIQiSx2Jkz/XN8gSXfa5UxeoYRd5tRuUt5qGC8G7KIDs+PTD9qDDlZ5hjX1Y9WfDuC
         b6bqcMOmjwmtSNp05APgv+4BhNxH+am98CVnzlTSBWh5Xg7gBx4kv9xSgmsP5/SEnkpE
         P/EF0wTj77JAk6AQ3Yv1FvL4RWcr7iCXLcVnVY09TDVhrBW/oReX79CtUQd0nQ+pEhX/
         j8Ah2hHzWcKcdQpAhvNjsNZuNYxq7wmbO+ARHaKyYSkLx9ag/v35ijjXduKpJ5jLmGNb
         YMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D5dO5U7xUR43RpvzcZ2rmGU+/p/HCB+fIKQOcJYLgGU=;
        b=pZjWGI8k2/OUQHa/QWY3Xu3UYxzMOWsoshLRa7cH/H2F7fbf/BkifB5gaNU3tXOMpq
         s0p8htqbI120JmUTFpd9LqWYS6a10JBJM3Q8wapa8UX/p9a8y8i76DvW+QKBszXDifsb
         c6Q89Y4W+BZ/LdBg5AzvB7mXpLqtgJl3IqDBwU4iL0fDwzforw0l+5KwrDWxVVWSfyUq
         1QNKDyA/shfy8xt784kELpi+ywOxKwJL0n7FoagLegfw/fLJBN8pIOWBZNJmoqaBcd26
         3epkkIkwBqlVMWAm6Gr2UGfD3EH/DbuIoMstpOIlOyWSPjw+hkpTt+kYY2olc4QTB8JC
         +82Q==
X-Gm-Message-State: AGRZ1gKn54QXxXNq3Rve2W3d5hCxMh8rUD0R9zzEK2u6LvSjeMyhvDgy
        KKxkfB71aOgT12FMastAmJB23qMkRjbbecqZ0umPVA==
X-Google-Smtp-Source: AJdET5e8YiHm82qjnZrilIPJI5ZCerRJLY2FakH0j/cYgGSx3/8hsyxbL4qMfgG6XM6Z+4OI/NFYR4QVilRHdSkkZ74=
X-Received: by 2002:a24:bd84:: with SMTP id x126-v6mr342898ite.144.1541557797313;
 Tue, 06 Nov 2018 18:29:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 18:29:36 -0800 (PST)
In-Reply-To: <20181102223908.GA9565@nautica>
References: <0000000000009d4c780579b04ee4@google.com> <20181102223908.GA9565@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 6 Nov 2018 18:29:36 -0800
Message-ID: <CACT4Y+bu52epUKjx5PEQBmhuvjA-wk8xbO4XpeAYHHZZkxAn3w@mail.gmail.com>
Subject: Re: WARNING in kmem_cache_create_usercopy
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     syzbot <syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:39 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> syzbot wrote on Fri, Nov 02, 2018:
>> RIP: 0010:kmem_cache_create_usercopy+0xad/0x240 mm/slab_common.c:473
>> Code: 44 89 f0 25 00 60 de 04 45 85 ed 89 45 cc 75 0b 8b 45 d0 85 c0
>> 0f 85 8e 01 00 00 44 39 eb 72 0a 89 d8 44 29 e8 3b 45 d0 73 7e <0f>
>> 0b c7 45 d0 00 00 00 00 4c 8b 45 10 44 89 fa 89 de 4c 89 e7 8b
>> RSP: 0018:ffff8801bc23f5d0 EFLAGS: 00010213
>> RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000006
>> RDX: 0000000000000000 RSI: 0000000000000020 RDI: ffffffff88b04b20
>> RBP: ffff8801bc23f608 R08: fffffbfff1283a2d R09: fffffbfff1283a2c
>> R10: ffff8801bc23f5c0 R11: ffffffff8941d167 R12: ffffffff88b04b20
>> R13: 00000000fffffffd R14: 0000000000000000 R15: 0000000000000000
>>  p9_client_create+0xa58/0x1769 net/9p/client.c:1054
>
> No lower bound on msize, the reproducer gives a reply from the
> pseudo-server with msize=8 and we happily take it, underflowing the
> msize - 11 (hdr+4) argument to kmem_cache_create_usercopy...
> This probably never worked anyway, but we now get a warning :)
>
>
> We need to add a sane lower bound to msize as well as the current upper
> bound set in the transport.
> We have some header sizes in 9p.h for IO header overhead (P9_IOHDRSZ to
> 24 for example) but I think that's too low in practice; stuff like
> readdir will require more than this to get a single entry... We can
> request the server to ask for at least 4k?
> 9p would probably work with less (e.g. 1k; I'd rather not have to
> figgure the minimum length we need to get each messages to work in its
> minimal form) but honestly even with 4k the perforamnces will be
> terrible, so tempted to go with that...
>
> I'll send a patch imposing 4k next week unless someone else does first,
> or replies indicate different preferences.
>
>
> @Dmitry: semi-related, the C reproducer (
> https://syzkaller.appspot.com/x/repro.c?x=1701f831400000 ) has a lot of
> "readable" letters spelled out as "\x63..." or chars as 0x3d - it's fine
> for generated code and that might be easier for the intermediate
> representation syzkaller works with, but do you know something handy
> that would help convert these to readable strings?
> e.g. "\x63\x61\x63\x68\x65\x3d\xc0\x6d\x61\x70" could be written
> "cache=\xc0map", and 0x3d as '=' (hm I guess the later would not always
> make sense to convert so probably best left as is, but it gets annoying
> pretty fast with longer strings)


Hi Dominique,

I've filed https://github.com/google/syzkaller/issues/792 for this.

Thanks for the feedback.

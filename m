Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EABDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE47320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4q9lpIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE47320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbeGWD1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:27:05 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40743 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731168AbeGWD1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:27:04 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so6717402ybm.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EgOePrnes0wjZT2VaatlFaotLIhX1CKbMrncMhKZJcs=;
        b=I4q9lpIuC1TAWCm9iDIRj1AJ2/sF3H1Y6pnBFG/BgvYos3A/VLsKOAyv8LWWAfGRX4
         N+M47h+VOEFbfpzlGFeHh5BKn0FvvloCwiniLj7sfNnKo+00V9Ny63v67nZtWYOzmpmx
         04PeUp3bKkfKxwXrIb5C6d9ZX9A82Suq7aGGFm4IipCsk+J82PxwVzpWYAEVkuGIfw0f
         wX8cBTaTgL2HISpeeY+a4AyMliXhq80QM1TF8qVnjZ+AiG7HOIgKS0oji9SFIccDDZZD
         rjrLfTniWBBMAoywN8JVGXlAwXXP3nsx0iX30rhmFmwR/zzlUK7KcqIkntw9kwZBz0G5
         RhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EgOePrnes0wjZT2VaatlFaotLIhX1CKbMrncMhKZJcs=;
        b=mbW8k7O0Xlo+DH/sdYXRI+yIcY9a19DdF/E7NNCR8hZP2SO819fEw9AlHSB5+3hTDC
         tVIG+5UMxbqv6cj9I7+uNOFZkXHE0wtnEbNtv4IFa2RN8+H4L/YknOk+/PXas3zIn8tl
         qsTR/P2QEgm1HviSrumq76OzfojMSiGqrvn8uhfvfA+V/4JiQM4IXp6VzgoDS+z/skKD
         YOkytd71hFJQ1rLtRsbsf7jf0n2TWBwqJpMKuJuak5pS1FrVePefWSeNg7mXLIGMaZcc
         7FUb3EFPtGHoi+AnHOb2lnUU57C+zs+Hy5hKnAaM6+BNlMe+9A7d3wEaW1oFSvMzAnMb
         +uwQ==
X-Gm-Message-State: AOUpUlEBCmnzSPGe52RK75mAA+Y6dcMyRNdR+EtBMQNBetWtsJsUYtoV
        nldj0QvB7WmJHJsVnRytzRUpjw==
X-Google-Smtp-Source: AAOMgpdlN2kDREEv+Con0v20b4HFzNSv+LctX+uxf4jTZ7v1DA6JzgteGHd64Fx9JTrG4UGl03S54A==
X-Received: by 2002:a25:b489:: with SMTP id o9-v6mr6011681ybj.128.1532312891826;
        Sun, 22 Jul 2018 19:28:11 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h188-v6sm3941770ywb.2.2018.07.22.19.28.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 19:28:10 -0700 (PDT)
Date:   Sun, 22 Jul 2018 19:28:01 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
In-Reply-To: <20180709143610.GD2662@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.1807221856350.5536@eggly.anvils>
References: <000000000000d624c605705e9010@google.com> <20180709143610.GD2662@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Matthew Wilcox wrote:
> On Fri, Jul 06, 2018 at 06:19:02PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    526674536360 Add linux-next specific files for 20180706
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=116d16fc400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b8e0dfee3fd8c9012771
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=170e462c400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f1ba2c400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com
> 
> #syz fix: shmem: Convert shmem_add_to_page_cache to XArray

I don't see the patch, but I do see a diff in shmem_add_to_page_cache()
between mmotm 4.18.0-rc3-mm1 and current mmotm 4.18.0-rc5-mm1,
relating to use of xas_create_range().

Whether or not that fixed syzbot's kernel BUG at mm/shmem.c:815!
I don't know, but I'm afraid it has not fixed linux-next breakage of
huge tmpfs: I get a similar page_to_pgoff BUG at mm/filemap.c:1466!

Please try something like
mount -o remount,huge=always /dev/shm
cp /dev/zero /dev/shm

Writing soon crashes in find_lock_entry(), looking up offset 0x201
but getting the page for offset 0x3c1 instead.

I've spent a while on it, but better turn over to you, Matthew:
my guess is that xas_create_range() does not create the layout
you expect from it.

Thanks,
Hugh

Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D96C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C6A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tl9QQK+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBTPnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:43:00 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50914 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfBTPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:42:59 -0500
Received: by mail-it1-f196.google.com with SMTP id m137so16286600ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIqHhAXdqVKrR+ff/TSZR/2yyklS8F5+xjZ4N+dafQQ=;
        b=tl9QQK+dRlYI8EUJwcOmiVGZ80U94pVw+zThBoRK7LD0MWiMg2IKf6uAWTtMAKkrSp
         yXAwZvo4RRYBRbxzCeuaR4p8AgEFAsAfj0m+wbTXcQlvKOmbjO4V1vHV6H7xuphqUJ48
         m87BMj9drYlon/qtwxAPABeJZ/NjT6AxqKvh/MUtCbfmTR8j7Gw7QOrqDsztq6CJBChb
         MtCAS0dK/mBqzR3O8hpMiKe2O8bjV0gS71pu0pn02NCPiUlo7/TtSFWBsxq9inS+/m2i
         B7CC5CE553V5pumIXlQJmqgzDB5B98ifbbGe/l5ZCqDy86nNsS5WgPbf8LAz3AC3UAW1
         6UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIqHhAXdqVKrR+ff/TSZR/2yyklS8F5+xjZ4N+dafQQ=;
        b=Exzc0bI6cEXmwyb4dNbE/d1VOPOCaDX8O8yjsY5AkEtigAox8TdcO7m2Mbpwogu2/4
         5pJb8HGjMOuiRuIMLuDNHpJKe63fEI7/CBzTlVQqlWJ+rRVp9L6CPO+JSO/lRVvJPql0
         ud6UlF03shMz9S37qYZWIpMDFuZfA9cZNkwkaPnQjoNjGoOhV9ZpXeLnSG1Q4V6HSCLc
         ZEITkepg5sIqCRC79oUF0BVprVrJsPYtQ7uEObxPLqpcuFtf0s9WyrLiptMMGxyZ6jVI
         z/BgRJfy3pEk4cUtI0V9HrWUebXt7MyZZPEpJC5A2UBJPabmNUEBt8UGU5ZlA4WO9P/g
         lI4g==
X-Gm-Message-State: AHQUAuaC9yb1+dmuSvRK++gSCwAyjEqIJWX7Xb2YS0eAcfIP6HRg809M
        q7Kem2gxpOHrlTg4PGvrPYTNoz1sqGGt4xRnAiCRVw==
X-Google-Smtp-Source: AHgI3IYylyqHGOH0nhMrRsLowgQq7QqF9avxGvgrN/wZI4QkO3R2gjZgAg7GI0M5vK+dezz96bxHuG6C0uhXseJbroY=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr20106810ior.11.1550677378644;
 Wed, 20 Feb 2019 07:42:58 -0800 (PST)
MIME-Version: 1.0
References: <089e0825fc78410eaa056845781e@google.com> <20180513230237.GG677@sol.localdomain>
 <CAL1RGDVNaJ8OG+4ajmCZN1GnvsZUAqY3LXMRPv57mGSPJyhwAQ@mail.gmail.com> <20180704232629.GJ725@sol.localdomain>
In-Reply-To: <20180704232629.GJ725@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Feb 2019 16:42:47 +0100
Message-ID: <CACT4Y+bm_nO=+Jzwr=d0j1u9F59BJB9fu8_5pY9n5ia4fU+y+A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __list_add_valid (5)
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Roland Dreier <roland@purestorage.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, rds-devel@oss.oracle.com,
        syzbot <syzbot+db1c219466daac1083df@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 1:26 AM Eric Biggers <ebiggers3@gmail.com> wrote:
>
> On Tue, May 15, 2018 at 01:49:23PM -0700, Roland Dreier wrote:
> > > Still reproducible on Linus' tree (commit 66e1c94db3cd4e) and on linux-next
> > > (next-20180511).  Here's a simplified reproducer:
> >
> > Thanks!  That's a fantastic test case.
> >
> > The issue is a race where rdma_listen() sees invalid state in the
> > middle of an rdma_bind_addr() call that will ultimately fail.  I'll
> > send a proposed patch shortly.
> >
> >  - R.
>
> Ping; there's still no fix merged for this.  The reproducer also works as an
> unprivileged user.

I don't see any patch similar to the tested one being merged. But this
stopped happening, so let's do:

#syz fix: ucma: fix a use-after-free in ucma_resolve_ip()

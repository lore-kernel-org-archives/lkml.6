Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D123C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B65120874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4fmE9zW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeLRMeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:34:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50610 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:34:19 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so3874238iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXDNPof5uV3UGislf87gb1NcbfYgNg3HRg2PaytvV28=;
        b=k4fmE9zWVZwGlFkkIBjCWhcdOxlDBjuF88zXyorjwYmUCcUAH3019S0PKZSxRHK+/b
         FyLQXnpu8+1ooHaiNLNgxqiseZJoAqh1Di7Pv1EA0YKykXzxujkWdaUukPCdN3GENGjN
         hFkKLRoDV5zsaJ5uq7WQN7bGtqF3Ho8B8y+0Mz4yg9+J8I5wrtRXs59BULWZkWBAoWd/
         8K3vZ4VmFqiNpaYi6xCuuIIQZkBNcnF09j6J6DfVTUii9ceXzN4jum0F7cRwmN3MlWr+
         +AywuAKj2lNA9eaj5dsMShuF77LwZOLWczIIyIutKFZmHTenPHp11VH3pPEF4AKjINCP
         Mj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXDNPof5uV3UGislf87gb1NcbfYgNg3HRg2PaytvV28=;
        b=noydg0kOclYmvUEuV3ScvI2g1EZFwsjiqtuSZI1ZwihJCpr+YLdZl8mpg1MgNpCo1Z
         xyh39cqAPZOIFYdH5hl1G56qcahIkRdwH+pmhTqftuRxeO0B9K3GQ7MFviY0ttGeQA8l
         XkKhkCNrajtnaiwfAl/tRfwjHszTUj2LLjBfHvWNsfmZu39k9fuaxoRCDqjMVFn/dzAz
         hRMA3rSPxX/TJtZAnVMz8l10QdvEti661KlYC8IC64SBo9Jt8dPtGRjrzRJ3pkQFwKYl
         65GlzdmhtKlxzaWzuyY1O1Uad0sh9Wj3G7OtQWYCYRlvqCkEYoOno/holRUhNFnEkiY4
         YjZg==
X-Gm-Message-State: AA+aEWbjuD7FhaUKGSCnI6HWe+7GplgXuxearMFs9wchcWPs+goGiRyy
        pXrNqzwxJunxgpVdEO/7f/bxKqd4nuZZiDqSIlFIJQ==
X-Google-Smtp-Source: AFSGD/Vq6xm/BGVRqjNNh+pfU6UOytYvYKw0EK13R9i2WVe6vRxIvacpfturEkKo61kXKiY6Me+640WHVQufi9DycyM=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr2394129itl.144.1545136458608;
 Tue, 18 Dec 2018 04:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
In-Reply-To: <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 18 Dec 2018 13:34:07 +0100
Message-ID: <CACT4Y+agU6AOn0OQQKaemBBLFBTBD_dYY8+HhV+KBXsLFpZ1gA@mail.gmail.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 7:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 17, 2018 at 10:13 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Hi Linus, please consider applying this patch.  It's been ignored by the
> > keyrings maintainer for a month and a half with multiple reminders.  It
> > fixes an easily reachable stack corruption in the new keyctl operations
> > that were added in v4.20.  It was immediately reached by syzbot even
> > without any definitions for the new keyctls yet.
>
> The getoptions() code in security/keys/trusted.c has exactly the same
> buggy pattern, and seems to actually be the source of that idiocy.
>
> Mind fixing that one too and getting rid of this incorrect code entirely?
>
> Also, maybe the right fix is to do the "check for duplicate tokens"
> only *after* all the other validation (ie after the switch())?
>
> Or maybe just remove it entirely, since it's clearly entirely
> incorrect from the very start.
>
> Finally, the code was actually originally introduced in commit
> 5208cc83423d ("keys, trusted: fix: *do not* allow duplicate key
> options"), this second place you found is just pattern matching from
> that original garbage, that was acked and "reviewed" by several
> people.

... also acked by 0 tests added by that commit.

> The fix should have that clarification. Commit 00d60fd3b932
> wasn't the _origin_ of this bug, even if it made a copy of it.
>
> Looking around, nobody else has picked up that incorrect pattern.
>
>                    Linus
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAHk-%3Dwhmh8WdcKHdYjioJNjyeewv%3DfO1H0hxXqDh6kiX0YvzmQ%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

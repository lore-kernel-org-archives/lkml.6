Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E608AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B806920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="el/lwQT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbeLQSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:43:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42554 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLQSny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:43:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so10222512lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJ5UZOLwv1yUvtold2LMz2hBHZwYA3bbBp1oD+GMYPs=;
        b=el/lwQT9dAAAgZetUHNS9cZk5WaBVHPYMrhSo5jBzXpg+UOBR+Fg3j/H8025eT+evp
         kYkAkXzS6MGdjfEjb0Jyqq0dX6gPOrQoDKktZVlqQHJZcbVFW1DO/ZNE2JNmT4YUZP7N
         6CJaoXCVqvWRRs6tTFkldSzu2uMa0ESvfjiqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJ5UZOLwv1yUvtold2LMz2hBHZwYA3bbBp1oD+GMYPs=;
        b=UqjTqRqhCqsh54B/xgQXnPiBMxgN5yXb2sEt41E0jqP3B8fsjQXh02hdTeCErMxHRG
         Gj74vXyrCY4t9HbC84iXj5+zQeikaEc4ipaUPzffvScgG/ITmaNDYUG12sLXxdmzUnJh
         2DdXziYk/uKQcMhpwFfYJPEywi7aRYRwxDiJ7reOR+ECqxnDrKkDbqi+pTrl2RwK1Kq1
         htcQxYDZTYavPO9tuc2Jys8pSnCFCyobmf+RpBZPgn8zES6T7u+4yZ1RF3Ax/fAPcXM8
         NbzeepoJe++eN8shS7Tf7sTigkHrF2vz7DvybYk/uA1dz5oF4NzgdB8ATbjs0ABWMxvu
         oqUA==
X-Gm-Message-State: AA+aEWakyym7lLGsXXyY7kyb52GBNmvc2KFS8RxrMLGESQrBMcgvj4sI
        RziB6Z8Dbqso1jiR/lHGQittI97e5To=
X-Google-Smtp-Source: AFSGD/VMGCmY/vg5X92Udj3M+jdKDWqM46tiIylo/oG8rY5QUe3IVy6LPAndxk19umh6X7X6KAxMdQ==
X-Received: by 2002:a19:d381:: with SMTP id k123mr8361282lfg.101.1545072232267;
        Mon, 17 Dec 2018 10:43:52 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z6sm2764026lfa.87.2018.12.17.10.43.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:43:51 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id x85-v6so11954331ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:43:50 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr8972213lji.133.1545072230566;
 Mon, 17 Dec 2018 10:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
In-Reply-To: <20181217181244.220052-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 10:43:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
Message-ID: <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
To:     ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:13 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi Linus, please consider applying this patch.  It's been ignored by the
> keyrings maintainer for a month and a half with multiple reminders.  It
> fixes an easily reachable stack corruption in the new keyctl operations
> that were added in v4.20.  It was immediately reached by syzbot even
> without any definitions for the new keyctls yet.

The getoptions() code in security/keys/trusted.c has exactly the same
buggy pattern, and seems to actually be the source of that idiocy.

Mind fixing that one too and getting rid of this incorrect code entirely?

Also, maybe the right fix is to do the "check for duplicate tokens"
only *after* all the other validation (ie after the switch())?

Or maybe just remove it entirely, since it's clearly entirely
incorrect from the very start.

Finally, the code was actually originally introduced in commit
5208cc83423d ("keys, trusted: fix: *do not* allow duplicate key
options"), this second place you found is just pattern matching from
that original garbage, that was acked and "reviewed" by several
people. The fix should have that clarification. Commit 00d60fd3b932
wasn't the _origin_ of this bug, even if it made a copy of it.

Looking around, nobody else has picked up that incorrect pattern.

                   Linus

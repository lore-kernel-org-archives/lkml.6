Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF680C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A576218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GnyUKvr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfABNnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:43:31 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52618 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfABNnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:43:25 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so40867778itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=z0IEYMlCFQ3fQw6tpC+uFNCr9CXFPvxgMCkoH1I9Q9k=;
        b=GnyUKvr6j0b4Wg2YxX7L5kav07HvMfPOTjZqIh/Wo0lFIufQR46Z3i0gzNIhqc8BWp
         7hE3DC9jPp6Y83fp+UL6JsQA/T8t1+x4Wt0wn/wciaUMb72a6aj2KBOh3+yISUUZlQj+
         A4YFwwlovSJz8c37Xfxf2zFQpfhU0L3ctVBGrsEnnlrFE34YB9LDzvYtV5RHElvRyiRa
         bDKlbNeEEKMATl38kh85SxHonIog+YLxk8IdrduhUWWe9qsdR04f/RmrMEu7k+0f7olV
         dOHsjntdoG+GTnxvzVSiQA8B2sQwWZEDU92QlL3n3sGQmXVm4IGb9Tevem5snwQKBWJ9
         CCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=z0IEYMlCFQ3fQw6tpC+uFNCr9CXFPvxgMCkoH1I9Q9k=;
        b=sM4aRTxfbXskGy+8J1BdtcWFF45jlG/FgyxfF8dRi5VV6piiuFM0VgR9O+hh1ZvomG
         VsKvwCaqZ826cd9rjS6yuKDRzDfST8BEyaGNiNk7eeZ1LojIHs2JtOVKrXekZnbKKFCt
         LrP/FAM5CILFX3V2NAYADKivI61/OKQ3uJ53M/gWDKoA1QP8/Ner0zr5p1GB3pGbUqOM
         iEQE5jhjvLGj40+nOWCDAQkIgdlF80kE8XWszpaNvUb2dT6CEFUoR8jnHpCDdsUpdjnp
         zBV4JqMqtxnSz4rJUvQ8p1wvsnaGtnEItcoBNwNJp9LvUJPDfE5ITiDlok5Ro5/4pXp6
         wppw==
X-Gm-Message-State: AJcUukc2WzHcZ58L3sewVaacGs/DtI3vce/sxdSluSjzFSNyBlJ3dOai
        1KbEeKxF3XWhqsm9OIEhhjn/s8MVo7uoaxOKb+zSCA==
X-Google-Smtp-Source: ALg8bN5Xy+Yv8MIQFQL+2KpFi8QMB2tWfjlIUwTrCXhZz6cNNVOTvXjifH4MIwby5uPUR7lfn9ziABKNC069XO9a9Wc=
X-Received: by 2002:a24:6511:: with SMTP id u17mr5835585itb.12.1546436603675;
 Wed, 02 Jan 2019 05:43:23 -0800 (PST)
MIME-Version: 1.0
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
 <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com> <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
 <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com>
 <CACT4Y+YRs3HLf7-0AhMPMuvHGvKHge_7R5Qo6Q9H1A2w1fQ39A@mail.gmail.com> <20181228221308.ev2mjvnh273qcrml@gmail.com>
In-Reply-To: <20181228221308.ev2mjvnh273qcrml@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 14:43:12 +0100
Message-ID: <CACT4Y+Ytm0h83GeH2LLQDddOBPsPmkfLCzGCn_Bic447Gu+bdQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dledford@redhat.com, KVM list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wei Wu <ww9210@gmail.com>, Kostya Serebryany <kcc@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chris Mason <clm@fb.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Olof Johansson <olofj@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Tso <tytso@google.com>, Tim.Bird@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:13 PM Joey Pabalinas <joeypabalinas@gmail.com> wrote:
>
> On Fri, Dec 28, 2018 at 10:43:11AM +0100, 'Dmitry Vyukov' via syzkaller wrote:
> > On Thu, Dec 27, 2018 at 6:00 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > Nobody reads the kernel mailing list directly - there's just too much traffic.
> >
> > As the result bug reports and patches got lots and this is bad and it
> > would be useful to stop it from happening and there are known ways for
> > this.
>
> What are the "known ways"? The only effective way I can think of is to
> setup personal email filters for specific topics, and while this is
> useful and something I do myself, it requires a lot of up front work.
>
> I don't think it's realistic to expect others to be doing this
> instead of just subscribing to the topic lists.

Hi Joey,

I mean using a bug tracking system.

E.g. here are all open KASAN bugs regardless of when they were filed:
https://bugzilla.kernel.org/buglist.cgi?bug_status=__open__&component=Sanitizers&list_id=1010485&product=Memory%20Management

Here are all open syzkaller bugs:
https://github.com/google/syzkaller/issues

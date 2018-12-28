Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A4420856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ek1jzMb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeL1VJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:09:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43581 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeL1VJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:09:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so15252695lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+N99Peg6Xsje00K42wv93SrPxmExDsvI3BTZkgwa58=;
        b=ek1jzMb3yV4H2WmYL9SIIP1Qf1e3xywQ3YEXiJyW8hwvACsa1SRfY98iDpG0288Ufd
         7QBlQpHT4wxB33uvfmhSa/hYssEm7GOH4+0/Uyk303DDyr6AgskrNHbhE/5EbmxIu5i2
         JbMD+TOx9wv7zdiOD57zynZlG647jDKof2ETc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+N99Peg6Xsje00K42wv93SrPxmExDsvI3BTZkgwa58=;
        b=Xpp2wSegK4tKzs3Y1rtMEHlPLbzJWxjsofBh+V2MY6ubkty2GsBCU780tyg4+3y6/+
         W7NoRa4KfXlmpYj7FmB1AZq9S7iEqw18Ohno/fyQFsegQ7vEI9AeGvXQT/fCZW/m1TXp
         typHCudV+mwVtiyoAqNXdcuI+Vyc18gmBK719lj1q0H+cLu68+9HG6WI2iasyYrOXRm2
         pFt3qLXE1hVD7WI/uGXuAgdqpWQnls3TBKUnCe7l8fGxJUhwdJXPtVneIPjaMuykOin4
         DFcEmkOrbGTFZuvo0gvC8+Ga46HPrSD5akYWPm5P8+vWibhKtM/oZ4Cq9QXkv18hIbWD
         7iSQ==
X-Gm-Message-State: AA+aEWYr29MADFvW1cu0lUY/60zHZe9ycTTtpXrGVE9x9A0aUjqLvT7j
        T1jDng9ewMZROyQIUll4YS+TKv1lbKI=
X-Google-Smtp-Source: AFSGD/VmnKtUjL/jwKm42AGYpPXfBrK38IKX0BJCGRhIycd/cA6Hmng/E+z/wJPXDibSDpD40EJhrw==
X-Received: by 2002:a19:9fcd:: with SMTP id i196mr14720989lfe.82.1546031346976;
        Fri, 28 Dec 2018 13:09:06 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 12-v6sm8771054ljs.29.2018.12.28.13.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 13:09:05 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id q2-v6so19594447lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:09:05 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr11608679ljj.120.1546031345296;
 Fri, 28 Dec 2018 13:09:05 -0800 (PST)
MIME-Version: 1.0
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com>
 <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com> <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
 <CAHk-=whZ3_T9b=pac=H1tvdjgX0vjE7FDsC=LfQYDmiY5Aq_kg@mail.gmail.com> <CACT4Y+YRs3HLf7-0AhMPMuvHGvKHge_7R5Qo6Q9H1A2w1fQ39A@mail.gmail.com>
In-Reply-To: <CACT4Y+YRs3HLf7-0AhMPMuvHGvKHge_7R5Qo6Q9H1A2w1fQ39A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 13:08:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjS8MG+xcHgjx-BTcAdyh7fugbHQkdJFcwBk=6QEGVKnw@mail.gmail.com>
Message-ID: <CAHk-=wjS8MG+xcHgjx-BTcAdyh7fugbHQkdJFcwBk=6QEGVKnw@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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

On Fri, Dec 28, 2018 at 1:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > Nobody reads the kernel mailing list directly - there's just too much traffic.
>
> As the result bug reports and patches got lots and this is bad and it
> would be useful to stop it from happening and there are known ways for
> this.

Well, let me be a  bit more specific: you will find that people read
the very _targeted_ mailing lists, because they not only tend to be
more specific to some particular interest, but also aren't the flood
of hundreds of emails a day.

And don't get me wrong: I'm not saying that lkml is useless. Not at
all. It's just that it's really more of an archival model than a
"people read it" - so you send your emails to a group of people, and
then you cc lkml so that when that group gets expanded people can be
pointed at the whole thread. Or, obviously, so that commit messages
etc can point to discussion.

But that does mean that any lkml cc shouldn't be expected to cause a
reaction in itself. It's about other things.

> syzbot not doing bisection is not the root cause of this

Root case? No. But if you do bisection, it means that you can now
target things much better. So then it's not lkml and "random
collection of maintainers", but a much more targeted group.

And that targeted group also ends up being a lot more receptive to it.

Again, look at the raw syzbot email and the email by Wanpeng Li. Yes,
the syzbot email did bring in a reasonable set of people just based on
the oops (I think it did "get_mainainter" on kvm_ioapic_scan_entry()).
But Wangpeng ended up sending it to the *particular* people who were
directly responsible.

> 2. syzbot reports are not worse then average human reports, frequently better.

No, they really aren't.

They are better in a *technical* sense, but they are also very much
obviously automated, which makes the target people take them much less
seriously.

When you see lots of syzbot emails, and there are lots of more or less
random recipients that may or may not be correct, what's the natural
reaction to that?

Look up "bystander effect".

> 3. Bisection is useful, but not important in most cases.

No.

Exactly because of the problem syzbot has. It's too scatter-shot.
People clearly ignore it, because people feel it's not _their_ issue.

The advantage of bisection is that it makes the problem much more
specific. Right now, you'll find that many developers ignore syzbot
simply because it's not worth their time to chase down whether it's
even their problem.

See what I'm saying?

It's the whole "data vs information" issue. Particularly when cc'ing
maintainers, who get hundreds of emails a day, you need to convince
them that this email is _relevant_.

                  Linus

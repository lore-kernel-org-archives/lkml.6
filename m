Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C51C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E2720882
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIpc23qB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbeL0O2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:28:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42098 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbeL0O2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:28:17 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so14631588ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvYk1Ccto8f5RQj4IZoV7E3ihNnWct61zvYBnVEZKak=;
        b=BIpc23qBMKexzqxCY+93Muedv4bK5JjI7oDuMXQK4xCeaEeBxtsxd1XGpi+7wvZZJd
         VR7SqeYQSdpAF46LNLB/H18rzZxM+S13RfQZj00YuLhxjkaYRiWGe80PLEAA5fVscEiP
         S5u91arb13+uzVOswtB9HJMJLSaFbjXj5dDSrYrG3YJ/FwOgairxUFCxfKwyai368PiC
         zCQ9sTq/cFhnYN9vrH/0LKYT3/4wnoe35xBf/Ll6Z7ZhsajpRe09gsEVpBC88suNsTAT
         u83z66yLj1Zmi21sxQfSfE9leCx3+AJZCnxNccJjjHFP1UXl8z+HbUoXIyeb/kC+enas
         qalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvYk1Ccto8f5RQj4IZoV7E3ihNnWct61zvYBnVEZKak=;
        b=F6oYqD5+mCRsp6mDSlwhIchre9BBEzQx6JtAWEKu9AHfwl986Y6y8BioMBoYOzwCw3
         yxQu6Vb77RRaC4uw4zEQbr7vyf9Ioeur+zWeipa2V/g07gVbgd0vWCT6HR08SP41rx8s
         dGIRipL0ci1oQ+0nWNrMHdYwRCHyhE+YGstrLrSK2uDXq3FSDxda+3Bl/HX9CZjZq/6p
         xfjEEiO+wfZXy09zatVxrRNSW7AJzr9uZFThDwtyJBnW4C7IYQxeD52Xls93UWhUXlxX
         UKBOU6Ep9x1F2xx6TSCyL+EA2c2oN9XBAcOB7D7RRez+wexqcwd9VemZOm96DjNO6/MC
         dtLA==
X-Gm-Message-State: AJcUukemw7CpHYICbb8CHVtkz2IyRMam1ducPcoiXDRL4FtSlSqT72k1
        lukFc0RsjKayOCEwl3r5AzFajl7Cfuhp/0J0pjI2kg==
X-Google-Smtp-Source: ALg8bN6aXmlv6k3nOY8DVcJPZRq/f4Uh19Xtf/B43rQAaJTxxF3fXXPdDzL7BBhSMd7ydZ70MwfIJkNwySaQmxoiOdw=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr16337069iom.11.1545920896418;
 Thu, 27 Dec 2018 06:28:16 -0800 (PST)
MIME-Version: 1.0
References: <1542702858-4318-1-git-send-email-wanpengli@tencent.com> <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com>
In-Reply-To: <442fc8ca-f92c-eded-9ede-c800a03bf39a@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Dec 2018 15:28:05 +0100
Message-ID: <CACT4Y+Z_wqpUoLDdTdAoSHSXEYRR8PFpGOzLC0kS4Y52c3QmPw@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix scan ioapic use-before-initialization
To:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <kernellwp@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dledford@redhat.com
Cc:     KVM list <kvm@vger.kernel.org>,
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

On Sun, Nov 25, 2018 at 6:31 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/11/18 09:34, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> > ...
> > This patch fixes it by bailing out scan ioapic if ioapic is not initialized in
> > kernel.
> > Reported-by: Wei Wu <ww9210@gmail.com>

+Linus, Greg

I want to point out that this was reported more then 3 months ago by syzbot:
https://groups.google.com/forum/#!msg/syzkaller-bugs/cPT7tmaz-gQ/SzOyhM0YBAAJ
then the report was lost on kernel mailing lists and then re-reported
by somebody else:
https://www.spinics.net/lists/kvm/msg177705.html
and only then fixed.

Lots of kernel bug reports routinely get lost on mailing lists, which is bad.

Another bug was reported by syzbot in April:
https://groups.google.com/forum/#!msg/syzkaller-bugs/-9XIT9gwq7M/sqvBXSZWBgAJ
then get lost and then re-reported in November:
https://www.spinics.net/lists/kvm/msg177704.html
and only then fixed.

Not specific for KVM, another bug in kernel/trace reported by syzbot,
lost for months, then re-reported and fixed:
https://groups.google.com/forum/#!msg/syzkaller-bugs/o_-OeMyoTwg/Ugh432hlAgAJ
https://bugzilla.kernel.org/show_bug.cgi?id=200019

And, no, it's not that people ignore just syzbot reports. It's just
that syzbot reports can be tracked so it's easier to spot such cases,
for manually reported bugs nobody usually knows anything after few
weeks. Here is an example of bug report by a human, which was even
replied but then slipped from somebody's attention set for a moment
and then complete oblivion. Months later happened to be re-reported by
syzbot and then fixed:
https://groups.google.com/forum/#!msg/syzkaller-bugs/wFUedfOK2Rw/waUrQYOxAQAJ

Re-reported a year later bugs can cause security problems and large
amounts of work to backport the fix to thousands of downstream kernel
forks. Not re-reported bugs are even worse as they are just not fixed.

This Plumbers I was approached by Doug Ledford from Redhat, who said
literally that there was a bunch of syzbot reports in rdma subsystem
but since they were reported some time ago, now nobody knows
what/where are they. So while the bugs are still presumably there, now
they are completely unactionable and kernel development process is
incapable of dealing with this. While syzbot reports have some chances
of being recovered, this equally applies to human-reported bugs and
they can't be easily recovered.

This does not looks like how things should be for the most critical
and fundamental software project in the world. Lost bugs/patches
should not be a thing. There are known working solutions for this in
the form of tooling and procedures, namely bug tracking. Any bug
tracking systems allows to answer the main question: what are the
active bugs, sorted by priority, in subsystem X/assigned to me; and
lots of other useful questions.

And, yes, I know we have bugazilla. But it's not being used as a bug
tracking system as of now. And when used, sometimes cause more trouble
because nobody expects bugs to be there:
https://lwn.net/ml/linux-kernel/20181208115629.GA3288@kroah.com/

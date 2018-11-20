Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E150C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F6120870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhZYC1En"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F6120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbeKTLQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:16:02 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43164 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeKTLQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:16:02 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so98239vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQb3tWVI8yrFAFsceP90VsnGvbNX6EyDf3TzM0jwSVY=;
        b=IhZYC1EnzFCFO6JV6fq/YWB5vjm5xHKSp83t81ToOImuLCSpbHwhY/t13JyDpC/39t
         1R6QqzIevsBxaPsG9XP+EDR/JPmlps2ueV6MLs5L/fIc1SaiDsgAlLRkgX9tL74Pd4p7
         xPVPyTICxz/zF4v6GyWGjmqMxe+Rf6XHb5PxKpbMlevNzskyci6rtwkuuL57b7JQc6UU
         MohODpLNmFfnOlqZcPdR1lJs6x25gw36r9JrBni0LEOqof7ThXfKMrZYUVT+C205rldY
         IYRdPoRa3ldArjzJiz1mQITXNcqOFbaYOwf2mcdyLOydQUzhgKgAXhgyFWrqdeQ1zuxk
         V8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQb3tWVI8yrFAFsceP90VsnGvbNX6EyDf3TzM0jwSVY=;
        b=he9gmtJakXtbs9wBqU6RtTvnS+U7opILu1o1rCSdChzflAvl26PmA2x/IwxcHdAJP+
         uEWxmHAirnEchs/CV9HndKbiF+nViDYQyNXnUQyUbb7f5/IH+OcesM4mvgS+GmD8+gU6
         GdsUyicNWxwHn4X2QZij25Kb9iMnHHkPvNABVmAao0j/ua7YiybYlQPOIkLmBRYqnqMz
         H+9j7tPQvJrOZlJfzi76J///GZCJcqGGi4Z1OHkRu96loWPp5pM/u/vE0/6NMNE0Rks8
         jeJ/kEc2NDRvyxVcQPWWoxOZCPVd+pjDcxsvFaUvCnXUHCWjX409mX6Jgz+zj5DwzOGo
         cj/w==
X-Gm-Message-State: AGRZ1gKxBLNMaERFxC8ke0gbeOArQk9rsnG27qaRsOCnZzqg8weqHJ+E
        Ztjga3wHZtLQRdY2aS0fXIu+eK/9iOfwWKWg54/XEQ==
X-Google-Smtp-Source: AJdET5dEXIw33BNGNKHqM+gy9COi1o4/6h7DPOnLeIB4RPUWW2t4Skl8c1KMgXw8tNVWjoSsbxnwdvRNSW6IHkXZn/o=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr10328262vsc.171.1542674978310;
 Mon, 19 Nov 2018 16:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <20181119223954.GA4992@cisco> <CAKOZuetQDziWeRLydHbDNv1abGM3LyF=WohLFvbzmtdT_+nBdg@mail.gmail.com>
 <20181119230709.GB4992@cisco> <CALCETrWyuQvTtksN1J1XbCFPka_rLOaFqa5W==EvGQvoaf9f3Q@mail.gmail.com>
In-Reply-To: <CALCETrWyuQvTtksN1J1XbCFPka_rLOaFqa5W==EvGQvoaf9f3Q@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 16:49:26 -0800
Message-ID: <CAKOZueu20C7A0qAuhSkyfqTGLFcVddb8Me=GLUZPDb4pzMoYWg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 4:28 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Nov 19, 2018 at 3:07 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > These tools also care about ioctls. Adding a system call is a pain,
> > > but the solution is to make adding system calls less of a pain, not to
> > > permanently make the Linux ABI worse.
> >
> > For user-defined values of "worse" :)
> >
>
> I tend to agree with Tycho here.  But I'm wondering if it might be
> worth considering a better ioctl.
>
> /me dons flame-proof hat
>
> We could do:
>
> long better_ioctl(int fd, u32 nr, const void *inbuf, size_t inlen,
> const void *outbuf, size_t outlen);
>
> and have a central table in the kernel listing all possible nr values
> along with which driver they belong to.  We could have a sane
> signature and get rid of the nr collision problem.

The essential difference between a regular system call and an ioctl is
that in the former, the invoked kernel-side code depends on the
operation number, and in the latter, the invoked kernel-side code
depends on the operation number and file descriptor type. By creating
a new kind of collision-free ioctl, all you've done is re-invent the
system call, but with a funky calling convention and less operand
space. It makes no sense. Previous system call multiplexers --- e.g.,
socketcall --- are widely regarded as mistakes, and there's no reason
to repeat these mistakes.

System call numbers are not scarce, and your other proposal to clean
up the x86 numbering will make wiring up a new system call less
annoying. The *only* purpose of an ioctl is to solve the system call
numbering coordination problem --- if the invoked kernel-side code
depends on (DRIVER, OPERATION_NUMBER), and DRIVER can vary out-of-tree
with ioctl, ioctl lets out-of-tree code expose interfaces. For in-tree
code, this problem doesn't exist, so there's no reason to use the
awkward ioctl workaround!

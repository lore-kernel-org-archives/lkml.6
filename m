Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80549C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD5E2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EQn9AEWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD5E2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbeITBiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:38:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36053 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeITBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:38:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id j192-v6so8379111wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5dYuiAJe0LGk8w22Jjl6t5Q1u907i2TV0msVFMGjF4s=;
        b=EQn9AEWFrgCG++NmXDxJoY7cd4iEfL2tUO/tOSNCPR0caPK6oPf6JVLYl1KYVYUfGs
         49r8UiroC68mDO/VQxcWb9Cnr5UC0owGU4xRE7w2yIX76rX8Q13QSH7gEo9WtzTDUB2S
         OBTKoogjBeXt6Rw3cyp88+8ebY9HWrEjrwMnNmtThnBuu6W0gu9zc6AqPwM9Xkh9FPcK
         erJoBdyARjD1QjF5jGIz8XOKOsNxDk7eehiwkqC7wZyek377bOq9HUOQ9qL8Ext7bHMB
         rdGILk66fqKFwastoqp/2UZ0a4PThJhb3h+mPf7+3ZbcPTu3xCFBlZulah/FpT9NTRDg
         GZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5dYuiAJe0LGk8w22Jjl6t5Q1u907i2TV0msVFMGjF4s=;
        b=nJkopMASZyzzf8t5SqNtCp4ll3ViQkfSxoLRqDHkv4JXrMFC6mU5GnBoD1zRC4nMIE
         kuTFjewazefNSq/F4Pfxv9nETGRq514+1fm3Wh/AzgwFSx6OSH6LYWyY7TMokplHfLQW
         bEkbA9Pl5akggx4Bj9DdbcrdzBvdaJ1DLEiMOu0f3ljC7POTGCtgwFekOTBLi/J8XH9V
         L28ogt/zzGtAOWO0jFzGEvIoWO1VVYCbyz8ZJTsPaF5/GvTGknslv119PF0j2phAvX5W
         6pro3m96wNz/5ejL+00vbKB+5ME9N608tJ55HIxVLl6fzbrw+OeWFPKdQSqXeaqrDDrY
         ZWCA==
X-Gm-Message-State: APzg51AsQNv3JgUCU/lUMzTX1Twp0kfjbP3TQ46CH/SSOp1PKIJtfkxk
        3YE5gD/E6XIzUS+bn0VatrfZybF/ABFE0jetipdtHA==
X-Google-Smtp-Source: ANB0VdY8gEO6fPe285g5FOy2BzF0B+NC12XDWB2uObj5lkLv9WpxYBsjH2Kw1aVWwqt0Ns5SX5TeZqvs0JK9dConWto=
X-Received: by 2002:a1c:ac04:: with SMTP id v4-v6mr5645774wme.51.1537387121558;
 Wed, 19 Sep 2018 12:58:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 12:58:20
 -0700 (PDT)
In-Reply-To: <20180919143842.GN4672@cisco>
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-5-tycho@tycho.ws>
 <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
 <20180919095536.GM4672@cisco> <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
 <20180919143842.GN4672@cisco>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 19 Sep 2018 12:58:20 -0700
Message-ID: <CALCETrVuP0nQ5B01-iWrcQ87hisz7=jA08-Uisqud_r+zc74NQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via USER_NOTIF
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 7:38 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Wed, Sep 19, 2018 at 07:19:56AM -0700, Andy Lutomirski wrote:
>>
>>
>> > On Sep 19, 2018, at 2:55 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>> >
>> >> On Wed, Sep 12, 2018 at 04:52:38PM -0700, Andy Lutomirski wrote:
>> >>> On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> wrot=
e:
>> >>> The idea here is that the userspace handler should be able to pass a=
n fd
>> >>> back to the trapped task, for example so it can be returned from soc=
ket().
>> >>>
>> >>> I've proposed one API here, but I'm open to other options. In partic=
ular,
>> >>> this only lets you return an fd from a syscall, which may not be eno=
ugh in
>> >>> all cases. For example, if an fd is written to an output parameter i=
nstead
>> >>> of returned, the current API can't handle this. Another case is that
>> >>> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netl=
ink
>> >>> ever decides to install an fd and output it, we wouldn't be able to =
handle
>> >>> this either.
>> >>
>> >> An alternative could be to have an API (an ioctl on the listener,
>> >> perhaps) that just copies an fd into the tracee.  There would be the
>> >> obvious set of options: do we replace an existing fd or allocate a ne=
w
>> >> one, and is it CLOEXEC.  Then the tracer could add an fd and then
>> >> return it just like it's a regular number.
>> >>
>> >> I feel like this would be more flexible and conceptually simpler, but
>> >> maybe a little slower for the common cases.  What do you think?
>> >
>> > I'm just implementing this now, and there's one question: when do we
>> > actually do the fd install? Should we do it when the user calls
>> > SECCOMP_NOTIF_PUT_FD, or when the actual response is sent? It feels
>> > like we should do it when the response is sent, instead of doing it
>> > right when SECCOMP_NOTIF_PUT_FD is called, since if there's a
>> > subsequent signal and the tracer decides to discard the response,
>> > we'll have to implement some delete mechanism to delete the fd, but it
>> > would have already been visible to the process, etc. So I'll go
>> > forward with this unless there are strong objections, but I thought
>> > I'd point it out just to avoid another round trip.
>> >
>> >
>>
>> Can you do that non-racily?  That is, you need to commit to an fd *numbe=
r* right away, but what if another thread uses the number before you actual=
ly install the fd?
>
> I was thinking we could just do an __alloc_fd() and then do the
> fd_install() when the response is sent or clean up the case that the
> listener or task dies. I haven't actually tried to run the code yet,
> so it's possible the locking won't work :)

I would be very surprised if the locking works.  How can you run a
thread in a process when another thread has allocated but not
installed an fd and is blocked for an arbitrarily long time?

>
>> Do we really allow non-=E2=80=9Ckill=E2=80=9D signals to interrupt the w=
hole process?  It might be the case that we don=E2=80=99t really need to cl=
ean up from signals if there=E2=80=99s a guarantee that the thread dies.
>
> Yes, we do, because of this: https://lkml.org/lkml/2018/3/15/1122
>

I'm still not sure I see the problem.  Suppose I'm implementing a user
notifier for a nasty syscall like recvmsg().  If I'm the tracer, by
the time I decide to install an fd, I've committed to returning
something other than -EINTR, even if a non-fatal signal is sent before
I finish.  No rollback should be necessary.

In the (unlikely?) event that some tracer needs to be able to rollback
an fd installation to return -EINTR, a SECCOMP_NOTIF_CLOSE_FD
operation should be good enough, I think.  Or maybe PUT_FD can put -1
to delete an fd.

--Andy

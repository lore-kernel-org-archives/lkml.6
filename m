Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1142023-1526320387-2-12909254501731590503
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526320386; b=XXJKpBAEhChp4SQblNoou9S/Lqz3DLHrvZ0wBD16NNhYboNbC5
    SMl9M3XpXO2AC3Nf6NSbSKTPTh4uZ7AIcWijFUCCEIVb7+GEmAtlI0UHZw1ckSeQ
    o7k65LyEbBWx04C2WeYK6GhSLHeU24iWR4svYPX/iCsPpyibcIZ3b17hCU5CyFw9
    e400boERP1l41g0OTD5LLokH/K/hxquqqtk6lj8tmAtNhCRjwGyv1qyIhAS3b0o6
    dJyKzIMV7AiSX+tfHKZVP2lz3fjAHE5QI8NjgwL4D6sfc+V73v87hBPzWeJ/R5vZ
    7S0TrSCTvel+/GZRVfcirvQcvBhL6tXq+UpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526320386; bh=4cD7PKtBwIer62pJR3jKWOSzcXDQVFPf9wm1u83fdP
    o=; b=Wz9veMCPZO0ye4AzH14v6LOGcUAdyjQPISZgvShpTRA9lSjrV/epsZFk5+
    Pc5M9qvEAovBtVvu2dUiebHKw++l8xcR1B9VvjkqSysyqnc8blGaaoIR3ApXzJEx
    6KpUAPNhEePyycCeni4iXdgNqyCBcf6Yc/08iMLBNzjeTFxLYPuuqIfgNOY3QApM
    UAfz8DOytwtwCsxRy4LPoCc+p1ESDx9kPBv1xVnbG+MzzCzp8EOs+mOcqkpHACJm
    0tYQvKpQnJwOm2nIQUKFMYvqtnpv9FGRFL8J5beBBYWOi4FiuphxiH8U3wLoTv2j
    uljJHREm61kXs2q1FAm6U7pxpocw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=PodnQBBL
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=CpVercGc x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pKnySalF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=PodnQBBL
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=CpVercGc x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pKnySalF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK7fyl7sBsePmZd06oD6EHwxFCNdwgYTY8WXJVEgRzl6ux1r3M3aBaP9rkpk2we6Cmg3xLGaEhh8EA3QnmhrpU1RfYd8VXqInyS8HrE1jvVEnIZK2GA1
    kjda4tBizGB6TGp9OLnP8u22TmAyTsVb4DESvjxrHsqibnlGBdU/+LSdoKA3IHR+OjLmC6cq8XcadmVDdvc+jXTEJE9+u6FJ52GR83VvtXY26cXh9tRnoeGH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=D19gQVrFAAAA:8 a=YxHwGcqMQUBlnA65QCYA:9
    a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeENRxE (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 13:53:04 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37748 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeENRxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 13:53:03 -0400
X-Google-Smtp-Source: AB8JxZrOuuPCDlW3qiahvBQyaRtqE8p0RvBRuo2xNjtqiUHD2LSqsYut9JYwz/tkSUejfF/ruQYRgtSktud6hIUyz5s=
MIME-Version: 1.0
In-Reply-To: <CABeXuvrO5XLD5QhBPui-v_G6JX=FgcaZLOL0C6B40f4oCyqOWg@mail.gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
 <20180512045921.18311-7-deepa.kernel@gmail.com> <CAGXu5jLFHSE12La25QEvZawdBm84cLavtTD5LAA6MqeqBmbYuw@mail.gmail.com>
 <CABeXuvpi_dm6TE3pH_KGehgNwW177hJFBmR8u29w6KJH1aA1Kg@mail.gmail.com>
 <CAGXu5jJpO+z8k_=UuVY9WAeiEgABQg4gWE6nz82BX0_UhaPUWw@mail.gmail.com> <CABeXuvrO5XLD5QhBPui-v_G6JX=FgcaZLOL0C6B40f4oCyqOWg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 14 May 2018 10:53:00 -0700
X-Google-Sender-Auth: D2ud8DrnNF5SLU_awYJbtlinwRw
Message-ID: <CAGXu5jLdPMK_EN5wekwbusaKzYOwsFCsFmy7coOEqxB-sGv+JQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] vfs: change inode times to use struct timespec64
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        anton@tuxera.com, Felipe Balbi <balbi@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        David Sterba <dsterba@suse.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mike Marshall <hubcap@omnibond.com>, Jan Kara <jack@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, Jiri Slaby <jslaby@suse.com>,
        Mark Fasheh <mark@fasheh.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nicolas Pitre <nico@linaro.org>,
        reiserfs-devel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Sage Weil <sage@redhat.com>, Steve French <sfrench@samba.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        "Ted Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 10:25 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Mon, May 14, 2018 at 9:30 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Sun, May 13, 2018 at 9:05 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>> Kees mentioned that he wants to merge a patch to pstore that changes
>>> it to use timespec64 internally for 4.17:
>>> https://lkml.org/lkml/2018/5/13/3
>>
>> I'm still working on a v2 for pstore. What is the correct
>> cross-architecture format string for timespec64's tv_sec? In your
>> other patches, you're using %lld and a (long long) cast. I'd really
>> like to avoid the need for casts.
>
> We cannot really avoid it for now.
> struct timespec64 is defined this way for now:
>
> struct timespec {
> __kernel_time_t tv_sec; /* seconds */
> long tv_nsec; /* nanoseconds */
> };
>
> #if __BITS_PER_LONG == 64
> /* this trick allows us to optimize out timespec64_to_timespec */
> # define timespec64 timespec
>
> #else
>
> struct timespec64 {
> time64_t tv_sec; /* seconds */
> long tv_nsec; /* nanoseconds */
> };
>
> #endif
>
> This will all lead to tv_sec being long on a 64 bit architecture and
> long long on a 32 bit architecture.
> So there is no way of avoiding the cast for now.
>
> We plan to get rid of this trick and to have a single definition for
> timespec64. But, that cleanup is planned for later when we cleanup all
> struct timespec uses internally.

Can we do something like:

#if __BITS_PER_LONG == 64
# define TVSEC_FMT "%ld"
#else
# define TVSEC_FMT "%lld"
#endif

so we can do stuff like:  sprintf(buf, "seconds: " KTIME_FMT, time->tv_sec)

? It seems easier to clean up than casts.

-Kees

-- 
Kees Cook
Pixel Security

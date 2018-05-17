Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1127333-1526519591-2-3654369371780537213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526519591; b=iT+PCRtARvdGKHHgJ7aRZGhHbgA9tUYENqZ9Xffmlyi0DMx6YP
    LO6fBPgii8DwCFbxDz3/7D+IwOsSH9XLFPlGm0ulSbKQidKN+0gwWyD9o5MIVsNL
    BZGzcII2ctcjOM827CNkcMfs7c68L+ua5M0m3RgIWguIULfE2z79LbryvTTg2Zd4
    Psff/6Guqz6ZMrTUInqL9NZHRDVcnIEof84jrq9up1Vgkf0JwmwDa/DnpWuCvqhr
    AzKxJBI4j65FqN+9WV8Umg3EP3Y2htC7+EBMgYHiU821SAclGsei03+fJJucgboT
    LY/NXTy4qhrE8+St+h2H6vyjbDqGIUwAONyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526519591; bh=XwK4G7sLLHgZWTVSPkYAMgOchcQRKswxmnx7hCJVTm
    U=; b=A29kyfT6BzcgqGahlyyEW/7J2PSqctNM5UASCwgEaxRBWEzzLPoYuZqCTv
    8wPSFn6MFzNvo9QFLRJWiGQt5gJZYqR3peu3KX96fg9D7YPewWhRo4tKAXhf7sCd
    uejrAWmaWlB9ZVE3VEKwjLC6HmwasIiWJzUVndrrNbz2dq+7ZvZYKHBezhRD4O57
    qdThPx8oJzdYbu11W1cWSYMUuqfCbLNvYyolkXJRgoYw+enNSbWo4r2DLOmFyQga
    jZX5qRv1W8X9+HCGM57xX9j0Xd2QzoJiaVqL2+uSUaXnKNT2vxd7ja8Ni1FWw/5V
    VsrnNezkx30Gi4lPs8X/6MDbscjA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=M5mRYzJG x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=nbqO0rZi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=M5mRYzJG x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=nbqO0rZi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF16k358VhQtbnmB4BS/gGonYYOH7JiWE+xhF/7D/tGipMnNUMKXZzMExa4s67rfr6xg2c2xKqotTO+1G6i5mnd8WEsturUtb4eFn3SQGquDV1+ZhZ5r
    QNRnzmAuIzblrL6PkBXkNSB3QSIWsWHECY1+4tnov6PQfcQL9aYnwqy2hJP8qSUEnNqQIcJxdAYGb2Rw7Me6UYTJUIRg5Q22lJ9okGamjUfd0+dOUReOVWNz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=xKRjlNz-unHWlBu2KHIA:9 a=QEXdDO2ut3YA:10
    a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeEQBNI (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 21:13:08 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40762 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeEQBNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 May 2018 21:13:07 -0400
X-Google-Smtp-Source: AB8JxZrV5+At5n8nKNFtNnD6Jg65wOCUTHgTqf8Rpg5YIuNvZue3lBV3b+3H4ADdRetJi+L21wT46qCtH56L4ILNwXI=
MIME-Version: 1.0
In-Reply-To: <CABeXuvomY6EYxdPrbMymqBkw0fnYernvOhU0R9By0aKihHYTuA@mail.gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
 <20180512045921.18311-7-deepa.kernel@gmail.com> <CAGXu5jLFHSE12La25QEvZawdBm84cLavtTD5LAA6MqeqBmbYuw@mail.gmail.com>
 <CABeXuvpi_dm6TE3pH_KGehgNwW177hJFBmR8u29w6KJH1aA1Kg@mail.gmail.com>
 <CAGXu5jJpO+z8k_=UuVY9WAeiEgABQg4gWE6nz82BX0_UhaPUWw@mail.gmail.com>
 <CABeXuvrO5XLD5QhBPui-v_G6JX=FgcaZLOL0C6B40f4oCyqOWg@mail.gmail.com>
 <CAGXu5jLdPMK_EN5wekwbusaKzYOwsFCsFmy7coOEqxB-sGv+JQ@mail.gmail.com> <CABeXuvomY6EYxdPrbMymqBkw0fnYernvOhU0R9By0aKihHYTuA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 May 2018 21:13:05 -0400
X-Google-Sender-Auth: 3qgPZw7EhIveaFYWlqogE3O_cwY
Message-ID: <CAK8P3a0d6j2KF+pSZQ5uM3jQ7=OZQXnc+ZjPb--52kdBV=k_vQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] vfs: change inode times to use struct timespec64
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Mon, May 14, 2018 at 2:23 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Mon, May 14, 2018 at 10:53 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Mon, May 14, 2018 at 10:25 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>> On Mon, May 14, 2018 at 9:30 AM, Kees Cook <keescook@chromium.org> wrote:
>>
>> Can we do something like:
>>
>> #if __BITS_PER_LONG == 64
>> # define TVSEC_FMT "%ld"
>> #else
>> # define TVSEC_FMT "%lld"
>> #endif
>>
>> so we can do stuff like:  sprintf(buf, "seconds: " KTIME_FMT, time->tv_sec)
>>
>> ? It seems easier to clean up than casts.
>
> We have already introduced these casts in many places now.
> It would be easier to do the clean up if they all follow a similar
> pattern. ( I could probably write a coccinelle script that is not very
> long).
> But, it would be not much trouble if you wanted to follow this for pstore.
>
> We also contemplated adding a format specifier for time. But, I think
> we deferred it until we have a uniform way of using time internally.

I have recently submitted a patch to completely remove the hack that
leads to 'timespec64' and 'timespec' being aliases for the same type on
64-bit architectures. Once that goes in, we can just remove the type casts
that got added over time, and won't need a format macro.

        Arnd

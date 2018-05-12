Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-916731-1526107489-2-5633015396227004089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526107489; b=NoPCotyPJZckWngfO06Punfg4l/w+i9lNmEWLGhkQuPKBSQ4fI
    9u7txVwMjdcPz/PXOydZGj0S9ylZ68tYeoPwhyXj5TYvLV6XLF97BFAJakGWTopA
    weANPvHh3B95vDU7CyxrqkSDjFUlTiwbZzMy1rLOG3xGKq7RgU9RA1TPOcyxsGZL
    Jp56NACEI840C5J4o78s54ygmNhUP/wWTlkd9lgPJncZiCaIa3B5g5dl9tmm/jks
    tbdm8yXMC7jARU5TcALOlminHgr+fGD3bX3eotojChvQ/p50odoOMUcu+t3gOAvq
    dudx4LoWMggQ+EJCyQYTI/+LWvodm7vlMt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526107489; bh=7UjbymJ3RnrK+DE6iNZLi9WLEDGWDgogJUvwOyJI28
    Y=; b=OYMlCuwwL1l9jIb1wKBDqlJu53QOMEgsc+7od7pJU1K6qGFjUefmLp+k77
    23U3huWKvosISX/v/jsQ1eAbp8WGJIxk3ix2t4ZSMcKrHdBxo0cC1BpJowDnO62M
    nuNEJULTfisPu4rziUED/r1nf1RzXPaD49KacaI4yRd259YUmOdO9Q6pSjooVvbe
    LpDNXGsVdLyd83nxx+ub38HycLFeFoZEUWlHb/HuVxxK4lLfDZ5JJ06aNYDkzFRg
    j/2Op5gmscyDK4/QHznheVE/TR/9nrDhIgGfOfBZ0E4k7RPKRRDCl6nVmbmc8iGv
    9F+2d3umNAxkVyEbifgMgvSt4QuA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=jlgYa7vg
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=E9n667zm x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KXI2tfaT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=jlgYa7vg
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=E9n667zm x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KXI2tfaT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOmvCz6nPHgOez9b2TiIDvjaECIsthnwQ9Wkir6f5fPh7EfAT2jKAaUiHG5gAykhCcixJuIQP955DF15cKovYJf7TNUl9TfpHCFitNHVNAwj12PWTdAR
    qSYr38g9Tc9JbA+KySP3o6eHkUYhraPwsOwhf9HauGbzL6VDxwTmEgH0Yg+IVfRJaeFYbOeum03RanOuyJpG2hWhsl/suYGS9FlNV72mqKhqEZLnmCbr04Zu
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=LSM78zJSh9ue3JDJlBAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeELGoq (ORCPT <rfc822;linux@kroah.com>);
        Sat, 12 May 2018 02:44:46 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41426 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeELGop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 May 2018 02:44:45 -0400
X-Google-Smtp-Source: AB8JxZr8mXb38U+1dJrt2Rw2Ji9TsNP4vobrxcY5s2HCQXothSOcHqGfv89mgBQnGQcFuuZrkVLFzA/xjFINB0UIvJA=
MIME-Version: 1.0
In-Reply-To: <20180512045921.18311-7-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com> <20180512045921.18311-7-deepa.kernel@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 11 May 2018 23:44:43 -0700
X-Google-Sender-Auth: 5OiftaFCjemkt4WuKRV6r6t-Org
Message-ID: <CAGXu5jLFHSE12La25QEvZawdBm84cLavtTD5LAA6MqeqBmbYuw@mail.gmail.com>
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
        Christoph Hellwig <hch@lst.de>, hirofumi@mail.parknet.co.jp,
        hubcap@omnibond.com, Jan Kara <jack@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, jaharkes@cs.cmu.edu,
        Jiri Slaby <jslaby@suse.com>, mark@fasheh.com,
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

On Fri, May 11, 2018 at 9:59 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 5fcb845b9fec..fb681d302bb3 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -392,7 +392,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>         inode->i_private = private;
>
>         if (record->time.tv_sec)
> -               inode->i_mtime = inode->i_ctime = record->time;
> +               inode->i_mtime = inode->i_ctime = timespec_to_timespec64(record->time);
>
>         d_add(dentry, inode);

I'm fine to just convert pstore internally to timespec64 right now. Is
it correct to say that I should use timespec64_to_timespec() here
until this flag day patch? And I'd need to do this as well, yes?

fs/pstore/platform.c:     record->time =
ns_to_timespec64(ktime_get_real_fast_ns());

Thanks!

-Kees

-- 
Kees Cook
Pixel Security

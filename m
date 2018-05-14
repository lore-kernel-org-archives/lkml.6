Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-52765-1526270764-2-12459958512373129242
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526270763; b=bOIh06p9IJIJ88ruGZXI24E98tWq2ZhVbRnLhGtFfHd5nLvtMw
    nzw6eLSxU/d9IYUp4nbJEe7tU0b9Lc048BBAdi1GEUxQ/UUXA1TA09TXNu+9jJNd
    rKjXzjjBrDQb5+tlgCB1k1m6knFXu3ZHL+j2KbZB8nKKbOtOqHC4Vy27MnDaLurO
    wsj3Gc/sUOjh5iMhEsqUs4cjbhF95GoGQUJP8IZmXXIqccQmrPw7A5WMc9b9nMOs
    UwkdzP1AAlF2ePM2736sMoYrNfyXT4gQLpx8haTU7chJjPLWZZ/Qv2ZFg/O0LUHL
    qqsnXmRRsS4/lnZv012Ari7FpPe32Et0FTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526270763; bh=jDh+i07Pe9WEAalJkpyiaZWn9LJ6rsESkWXJWFyZxQ
    4=; b=hFUj0vyewmo1RRnvPQpy4ldqSYKudJ+PhaPnFqyotQmQyMsvbATvYUma6F
    mR7lN3BXR2kKEvQWPVKb/yOD1Bto3dqgZdS+nVnM8FdPxNqgBxk02EaEDnDoWTEy
    PH2NrCV26jCzeDWLtmidksxmRz91qRkjN9d5m4KEQInvRQrY0hhCCiK1u9dsRCO1
    VB8Ki4jNvolswHxd04GYlFpU8zNbYcieSX4uUwDEdjSswXyJfTl8nmIn4YGctDmu
    VuDktpTd+Xwf8kvUYcTTMkByFvtVm/Gt12pa7rHzRH5mfnxdBgeNlmIOzOsyinGn
    Q15RjV3Zvw4bn6TlrfeKqXtEAsQQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=BMxkfupR x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=UKSRLqZe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=BMxkfupR x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=UKSRLqZe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH+DFLLBByHl2Db3WmEDO56CPEgGXBH5zQzgBOxV/dK4dklGKjWnWWdK7AQNWwu2Eul6im3ylWgU756rjnGV8z76vpd0IjX7DXlEg3RoTlf5v2nrt5ci
    rlwu7t1U+7M7Al2JM8CTceZZegFbYcBMKLXy+s35YHgnGoKFlrj+ZMsHbmJRz/i1MmhFxFhZaoc8fAafi8qdJShp244b9T4qAYrZLfJhtRkvlk5c95y3KFyP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=uVShTw-VqmsA:10 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8 a=cm27Pg_UAAAA:8
    a=pGLkceISAAAA:8 a=yFAjnQmEBhT3Ed7f_j4A:9 a=QEXdDO2ut3YA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeENEGA (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 00:06:00 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38857 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeENEF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 00:05:59 -0400
X-Google-Smtp-Source: AB8JxZp0nrZXZ+bSx9sL1oNS09DDgC+GQl4S6I5AVChuGuYatt6IW51+V77Cg1+zZDtN33NcxLiJ3RQVDGRy3kKZq2Y=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLFHSE12La25QEvZawdBm84cLavtTD5LAA6MqeqBmbYuw@mail.gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
 <20180512045921.18311-7-deepa.kernel@gmail.com> <CAGXu5jLFHSE12La25QEvZawdBm84cLavtTD5LAA6MqeqBmbYuw@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sun, 13 May 2018 21:05:58 -0700
Message-ID: <CABeXuvpi_dm6TE3pH_KGehgNwW177hJFBmR8u29w6KJH1aA1Kg@mail.gmail.com>
Subject: Re: [PATCH 6/6] vfs: change inode times to use struct timespec64
To: Kees Cook <keescook@chromium.org>
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

Al,

Are you ok with this approach to changing vfs timestamps?

Kees mentioned that he wants to merge a patch to pstore that changes
it to use timespec64 internally for 4.17:
https://lkml.org/lkml/2018/5/13/3

I'm not sure how we usually merge such flag day patches. Should this
be targeted for 4.17 or 4.18? The above might or might not be a
problem based on when this series is merged.

If you are ok with this approach, I could post a v2 with a couple of
requested fix-ups.

-Deepa

On Fri, May 11, 2018 at 11:44 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, May 11, 2018 at 9:59 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
>> index 5fcb845b9fec..fb681d302bb3 100644
>> --- a/fs/pstore/inode.c
>> +++ b/fs/pstore/inode.c
>> @@ -392,7 +392,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>>         inode->i_private = private;
>>
>>         if (record->time.tv_sec)
>> -               inode->i_mtime = inode->i_ctime = record->time;
>> +               inode->i_mtime = inode->i_ctime = timespec_to_timespec64(record->time);
>>
>>         d_add(dentry, inode);
>
> I'm fine to just convert pstore internally to timespec64 right now. Is
> it correct to say that I should use timespec64_to_timespec() here
> until this flag day patch? And I'd need to do this as well, yes?
>
> fs/pstore/platform.c:     record->time =
> ns_to_timespec64(ktime_get_real_fast_ns());
>
> Thanks!
>
> -Kees
>
> --
> Kees Cook
> Pixel Security

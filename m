Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964852089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BebyAMPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964852089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeKKFlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 00:41:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42782 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKKFlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 00:41:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so2276021pgq.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 11:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jiigZMjCDbHcRQBbEfBJrG2SpZnMvpQe/kVZJTi6EME=;
        b=BebyAMPhfNbjsp26GZu+NAZbLe0CUnxKLKPTi4Mmh3ii07BoYAYjsneZMzrFWKwnFo
         4F+7Sz/pRpu5MjdXmNxfnzhzLuHhChBO47tpvdnbM6Cg9dmEpZyXhmwPC1vowbz5tz9P
         wW7Y+ywXylzX5Wpvhz+isDdZYD9FL86dxgATVF9uQmPdpL33n73SkRjem2c3UKUGv3IC
         XA0ERVbyGjLN531vXzuJpEIJkhggZljGo+BiNcjsQh25CCaWA/kx5g29kOI+PSehMifa
         +RQmxJJURUc4YR5GKkDNKkRco8eXfzZJR4JvCD5j3zu9m+FEDUk+/lM5qucW6+SQUVZo
         o+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jiigZMjCDbHcRQBbEfBJrG2SpZnMvpQe/kVZJTi6EME=;
        b=KC8X01emKj8+OV7DH5bWSNh89WwvRYwo/GWGdvoLV9FLkHAUNJVmcsW+x1ivjsdApi
         ZFL13vcfYVgf7uceSRBqISGEY1M+oMWxHG/2iyNhYnZJbft/nIekCLaNKn87PUz+XGyY
         yD5k7MbdYfb/UEw7Fz0hYuItiruwd7HCZMs20v44fJOK4AVkaqqa/Z28BOmi8mFQp6nn
         im9V4FGa+5wQ4RT1qFDMKBZe86gv5jLgx9lqOhHe1rZZK2CgZClQ2bi36+p5RQK0gNj/
         EHV6MY4mv7K/m5uRBRpO1eMP72Ah+zEsgTYE+U30AvNC1ZAbpsUWCiNJ0lasREKV02H2
         k/XA==
X-Gm-Message-State: AGRZ1gIjDZqQCgW/+v9bMsKnWz9xwWneBHtVQ6Dg4S/+oz1zDypCL6yc
        krgwy2n4KQZ/D+PFdleh9rVHQ+8FE7o=
X-Google-Smtp-Source: AJdET5dsTSMqVRwFo15FkWm0owSMJe2yVeDl2tFdVAeHnckJfbvGq3J7fsHGZASXyzkCPmLoBnwX9w==
X-Received: by 2002:a62:5285:: with SMTP id g127-v6mr13877288pfb.128.1541879713073;
        Sat, 10 Nov 2018 11:55:13 -0800 (PST)
Received: from ?IPv6:2600:1010:b011:f816:90f9:2c3c:c10b:2a0? ([2600:1010:b011:f816:90f9:2c3c:c10b:2a0])
        by smtp.gmail.com with ESMTPSA id s37sm7162035pgm.19.2018.11.10.11.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 11:55:12 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAKOZueum8MtNvJ5P=W7_pRw62TdQdCgyjCwwbG1wezNboC1cxQ@mail.gmail.com>
Date:   Sat, 10 Nov 2018 11:55:10 -0800
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6C5D673-4A94-4A79-B5E9-B7DC847F84D1@amacapital.net>
References: <20181108041537.39694-1-joel@joelfernandes.org> <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com> <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com> <20181110032005.GA22238@google.com> <69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net> <20181110182405.GB242356@google.com> <CAKOZuesQXRtthJTEr86LByH3gPpAdT-PQM0d1jqr131=zZNRKw@mail.gmail.com> <CAKOZueum8MtNvJ5P=W7_pRw62TdQdCgyjCwwbG1wezNboC1cxQ@mail.gmail.com>
To:     Daniel Colascione <dancol@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 10, 2018, at 11:11 AM, Daniel Colascione <dancol@google.com> wrote:=

>=20
>> On Sat, Nov 10, 2018 at 10:45 AM, Daniel Colascione <dancol@google.com> w=
rote:
>>> On Sat, Nov 10, 2018 at 10:24 AM, Joel Fernandes <joel@joelfernandes.org=
> wrote:
>>> Thanks Andy for your thoughts, my comments below:
> [snip]
>>> I don't see it as warty, different seals will work differently. It works=

>>> quite well for our usecase, and since Linux is all about solving real
>>> problems in the real work, it would be useful to have it.
>>>=20
>>>> - causes a probably-observable effect in the file mode in F_GETFL.
>>>=20
>>> Wouldn't that be the right thing to observe anyway?
>>>=20
>>>> - causes reopen to fail.
>>>=20
>>> So this concern isn't true anymore if we make reopen fail only for WRITE=

>>> opens as Daniel suggested. I will make this change so that the security f=
ix
>>> is a clean one.
>>>=20
>>>> - does *not* affect other struct files that may already exist on the sa=
me inode.
>>>=20
>>> TBH if you really want to block all writes to the file, then you want
>>> F_SEAL_WRITE, not this seal. The usecase we have is the fd is sent over I=
PC
>>> to another process and we want to prevent any new writes in the receiver=

>>> side. There is no way this other receiving process can have an existing f=
d
>>> unless it was already sent one without the seal applied.  The proposed s=
eal
>>> could be renamed to F_SEAL_FD_WRITE if that is preferred.
>>>=20
>>>> - mysteriously malfunctions if you try to set it again on another struc=
t
>>>> file that already exists
>>>>=20
>>>=20
>>> I didn't follow this, could you explain more?
>>>=20
>>>> - probably is insecure when used on hugetlbfs.
>>>=20
>>> The usecase is not expected to prevent all writes, indeed the usecase
>>> requires existing mmaps to continue to be able to write into the memory m=
ap.
>>> So would you call that a security issue too? The use of the seal wants t=
o
>>> allow existing mmap regions to be continue to be written into (I mention=
ed
>>> more details in the cover letter).
>>>=20
>>>> I see two reasonable solutions:
>>>>=20
>>>> 1. Don=E2=80=99t fiddle with the struct file at all. Instead make the i=
node flag
>>>> work by itself.
>>>=20
>>> Currently, the various VFS paths check only the struct file's f_mode to d=
eny
>>> writes of already opened files. This would mean more checking in all tho=
se
>>> paths (and modification of all those paths).
>>>=20
>>> Anyway going with that idea, we could
>>> 1. call deny_write_access(file) from the memfd's seal path which decreme=
nts
>>> the inode::i_writecount.
>>> 2. call get_write_access(inode) in the various VFS paths in addition to
>>> checking for FMODE_*WRITE and deny the write (incase i_writecount is neg=
ative)
>>>=20
>>> That will prevent both reopens, and writes from succeeding. However I wo=
rry a
>>> bit about 2 not being too familiar with VFS internals, about what the
>>> consequences of doing that may be.
>>=20
>> IMHO, modifying both the inode and the struct file separately is fine,
>> since they mean different things. In regular filesystems, it's fine to
>> have a read-write open file description for a file whose inode grants
>> write permission to nobody. Speaking of which: is fchmod enough to
>> prevent this attack?
>=20
> Well, yes and no. fchmod does prevent reopening the file RW, but
> anyone with permissions (owner, CAP_FOWNER) can just fchmod it back. A
> seal is supposed to be irrevocable, so fchmod-as-inode-seal probably
> isn't sufficient by itself. While it might be good enough for Android
> (in the sense that it'll prevent RW-reopens from other security
> contexts to which we send an open memfd file), it's still conceptually
> ugly, IMHO. Let's go with the original approach of just tweaking the
> inode so that open-for-write is permanently blocked.

This should be straightforward. Just add a new seal type and wire it up. It s=
hould be considerably simpler than SEAL_WRITE.=

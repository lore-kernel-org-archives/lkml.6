Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB1CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B47F2600C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQP7AO/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B47F2600C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964879AbeFYSQh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:16:37 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36856 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934772AbeFYSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:16:35 -0400
Received: by mail-ot0-f196.google.com with SMTP id c15-v6so16122603otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CONBH8n6eVeoBUtGmJgHd1C1ub/CJQXsEchm4r49+R8=;
        b=uQP7AO/2rIodoSCmqpttu3oscEyl2xsamUfxN/FtcrL//4nSVtelRMVUlEMnquaPPD
         aRt6MaQ9mqPAsusFfrEWg7RAFtHQJNW5XIguR7qg70SbCzkzg9Jd9c4clEoXLSNHw3eC
         TSfMTA/bz8AB/ih3jBqmKgxS/U5YIJ0xccuz3RukSCeRM+IS6/B7UvC9hEN1Y/W6Gj7Q
         bgssrkQxyPW6lLaPELj24jakCGpNcZuHRc5ZuQvvJz2ntrmptMV4OLb8jmIQDB9lwFMY
         otqyqzXNOsfRg692S89ThPGQeUv6spyltb5Sh/cQhd/dfnTZ0YooKUNnEN2GVoXuo/bN
         ZkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CONBH8n6eVeoBUtGmJgHd1C1ub/CJQXsEchm4r49+R8=;
        b=icwopYJ6ixSYxr/I8PgcC2qXiYCSO/8qTvzBEAZ0g1aGxz4i343hRZG5sS7zbh9n7p
         0jmXRZG0LdmSpfWTsAhN5AMMYZN8v/VkB1h+Il8wV48AJhlgjofudAhMKjpS565eS7rN
         uZG1Uf1V0RZXSXj2yY7Tf60n+3WCQsPir7xbzBY6Z13+m19mvP8Aymmpz7OVYCr9TIzC
         He3NlmxG68oONE+1UQhAyGnopVGnErEFpqcokTxCl8qZEobZlR8m1Pmgl/rR+xfUL5Wx
         YpU3IHIhG/XPzLPis2c1WJ8e8m9AUEzO/1AX4YD+SVuTiTamOeomjXuDp8CoCKj8Zk91
         pfFg==
X-Gm-Message-State: APt69E1l7u0CTe+KKB8PoodJyX8lPCVrV+Wps/2eSDecDT4L63f4JN+z
        0aOMxY8bYSK79pIUkZV65JcHRyxLWi1TpQ042DFNBg==
X-Google-Smtp-Source: AAOMgpcO4f+dgjKZChioLsJlGzwIqO3JkDTXHClYPUvpjqqULfKgxFr9yqDNlokwE8LwusKDvdKgsT1FsXmUdNxTi4s=
X-Received: by 2002:a9d:350a:: with SMTP id o10-v6mr7597420otc.247.1529950594409;
 Mon, 25 Jun 2018 11:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163410.216168-1-jannh@google.com> <20180625164109.GF30522@ZenIV.linux.org.uk>
In-Reply-To: <20180625164109.GF30522@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Jun 2018 20:16:22 +0200
Message-ID: <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com>
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        security@kernel.org, Christoph Hellwig <hch@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 6:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:
>
> > +     char tmp[32];
> >
> > -     if (namelen > 32)
> > +     if (namelen < 0 || namelen > 32)
> >               namelen = 32;
> >
> >       down_read(&uts_sem);
> >       kname = utsname()->domainname;
> >       len = strnlen(kname, namelen);
> > -     if (copy_to_user(name, kname, min(len + 1, namelen)))
> > -             err = -EFAULT;
> > +     len = min(len + 1, namelen);
> > +     memcpy(tmp, kname, len);
> >       up_read(&uts_sem);
> >
> > -     return err;
> > +     if (copy_to_user(name, tmp, len))
> > +             return -EFAULT;
>
> Infoleak, and similar in a lot of other places.

I don't see a problem. copy_to_user() copies "len" bytes from "tmp".
The preceding memcpy() filled exactly those bytes, so I'm not leaking
stack memory. And "len" is bounded to "namelen", which is bounded to
32, which is smaller than __NEW_UTS_LEN, so I'm not leaking memory
from outside the bounds of utsname()->domainname.
And the contents of the "struct new_utsname" are completely
user-accessible (including bytes behind null terminators); you can see
that e.g. sys_newuname() copies the whole struct to userspace; this
seems to be intentional, if you e.g. look at how sys_sethostname() is
implemented.
I went over this function with a fine comb and didn't spot anything wrong:

SYSCALL_DEFINE2(osf_getdomainname, char __user *, name, int, namelen)
{
        int len, err = 0;
        char *kname;
        char tmp[32];

        if (namelen < 0 || namelen > 32)
                namelen = 32;
        // namelen in range 0..32

        down_read(&uts_sem);
        kname = utsname()->domainname;
        // kname points to a 65-byte buffer that userspace is permitted to read
        len = strnlen(kname, namelen); // strnlen() is bounded to
first 32 bytes of 65-byte buffer
        // len is in range 0..32
        len = min(len + 1, namelen);
        // min([0..32] + 1, [0..32]) = min([1..33], [0..32]) is in range 0..32
        memcpy(tmp, kname, len); // writes up to `len` bytes into tmp;
len<=32, sizeof(tmp)==32; len<=32, sizeof(utsname()->domainname)>32
        // userspace is permitted to read first `len` bytes of `tmp`
        up_read(&uts_sem);

        if (copy_to_user(name, tmp, len)) // first `len` bytes of
`tmp` are exposed to userspace
                return -EFAULT;
        return 0;
}

Can you please explain why there is an infoleak here?

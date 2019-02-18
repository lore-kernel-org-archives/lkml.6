Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14161C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F9321773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ithBob/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbfBRTQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:16:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34305 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfBRTQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:16:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so19668403wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5cP2CGgOXfPj9TTqTqQEWeAFjzM0TbBZoBIYIzxeKc=;
        b=ithBob/oq7e0QYOkBoE2Fxh5S53iYVCwyYZdm8kKgMDiSMBW9Knf/UAubUMwwTx9Rx
         Yhf0Xx0sfgdt3oHyAih75arDYonVb3iA0jbw6aJj1xIPsPvx9aaEgDxQehMXoMF5bku7
         ucwrSeLimtb2PtD2HthcgJHn9ZfmE9YgK6o4rhpLfJ3EkTyiIkvkis2sAdsemZgg9A+n
         yvizfrb1DC7WWb2NWaJxvGcOIKWSxb46R2KJkZ5VBqttcL0BROIukmve5BmKKqUtPOsx
         Fez7i8k9d2UoOFHLIlRK/6h0GbVepuoffB00N/ThMVC6LB90UeCiY32mTpN9XgM9xkdU
         VZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5cP2CGgOXfPj9TTqTqQEWeAFjzM0TbBZoBIYIzxeKc=;
        b=LvAf9nXpTgxNSBzD+eoKM7zHPwxfN74rxewd2kCvBhhTyheabjTCpJ00jAvRsMEcH7
         iRz42QnC/tRdyT5kFuCtjxl9rVd4PWMjXLIGglFSsiL7Qz2Cm/RBUt3UG4KG+1TEsRlY
         yeXz7n8DHSvF5LygL9BaU9D6Gg2qLRFtzocHc4RWXIxS7rJ/rX7uNjaBTQ6VPqpfaR+n
         CoQ4HohRyXQ9aiyZdPsFm3HOTjMu9nfUQBWqEU8LUB6gm9yGq5QwYmlK17u4nvh+9T9C
         Dv25jGB/EiHsakDOL7FFuzDe/cZ3SMg+jxCQGPachGlPVZeWYeyWy38Gc616PRT0AYcW
         UZwg==
X-Gm-Message-State: AHQUAuaKNc/Mn0oq/1uNYN/SacfNDJnlyHICEdbHt4g9ClFkoxOs35Q5
        KIAJG9Yngpm1uDvOtDcDYgBDglvq71RPdgmsNVPdfA==
X-Google-Smtp-Source: AHgI3IZTwV0LraBn8juwtDZiOOvNkos6FC722yZYjrGl+jg7AuryWaM1VRi8U8DaZ0kSK+2l+sWMiRzVk/FiUNhOaY0=
X-Received: by 2002:adf:9dc4:: with SMTP id q4mr2309831wre.330.1550517358531;
 Mon, 18 Feb 2019 11:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20190215235901.23541-1-baloo@gandi.net> <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net> <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany> <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 18 Feb 2019 11:15:44 -0800
Message-ID: <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Arthur Gautier <baloo@gandi.net>, Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Content-Type: multipart/mixed; boundary="0000000000005fda6b05822ff4e5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005fda6b05822ff4e5
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 18, 2019 at 5:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> > Another would be to have the buffer passed to flush_buffer() (i.e.
> > the callback of decompress_fn) allocated with 4 bytes of padding
> > past the part where the unpacked piece of data is placed for the
> > callback to find.  As in,
> >
> > diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
> > index 63b4b7eee138..ca3f7ecc9b35 100644
> > --- a/lib/decompress_inflate.c
> > +++ b/lib/decompress_inflate.c
> > @@ -48,7 +48,7 @@ STATIC int INIT __gunzip(unsigned char *buf, long len,
> >       rc = -1;
> >       if (flush) {
> >               out_len = 0x8000; /* 32 K */
> > -             out_buf = malloc(out_len);
> > +             out_buf = malloc(out_len + 4);
>
>   +8 actually.
>
> >       } else {
> >               if (!out_len)
> >                       out_len = ((size_t)~0) - (size_t)out_buf; /* no limit */
> >
> > for gunzip/decompress and similar ones for bzip2, etc.  The contents
> > layout doesn't have anything to do with that...
>
> Right. That works nicely.
>

This seems like it's just papering over the underlying problem: with
Jann's new checks in place, strncpy_from_user() is simply buggy.  Does
the patch below look decent?  It's only compile-tested, but it's
conceptually straightforward.  I was hoping I could get rid of the
check-maximum-address stuff, but it's needed for architectures where
the user range is adjacent to the kernel range (i.e. not x86_64).

Jann, I'm still unhappy that this code will write up to sizeof(long)-1
user-controlled garbage bytes in-bounds past the null-terminator in
the kernel buffer.  Do you think that's worth changing, too?  I don't
think it's a bug per se, but it seems like a nifty little wart for an
attacker to try to abuse.

On brief inspection, strnlen_user() does not have an equivalent bug.

--0000000000005fda6b05822ff4e5
Content-Type: text/x-patch; charset="US-ASCII"; name="strncpy.patch"
Content-Disposition: attachment; filename="strncpy.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jsaps62u0>
X-Attachment-Id: f_jsaps62u0

ZGlmZiAtLWdpdCBhL2xpYi9zdHJuY3B5X2Zyb21fdXNlci5jIGIvbGliL3N0cm5jcHlfZnJvbV91
c2VyLmMKaW5kZXggNThlYWNkNDE1MjZjLi43MDlkNmVmZTBkNDIgMTAwNjQ0Ci0tLSBhL2xpYi9z
dHJuY3B5X2Zyb21fdXNlci5jCisrKyBiL2xpYi9zdHJuY3B5X2Zyb21fdXNlci5jCkBAIC0xMCwx
MiArMTAsNyBAQAogI2luY2x1ZGUgPGFzbS9ieXRlb3JkZXIuaD4KICNpbmNsdWRlIDxhc20vd29y
ZC1hdC1hLXRpbWUuaD4KIAotI2lmZGVmIENPTkZJR19IQVZFX0VGRklDSUVOVF9VTkFMSUdORURf
QUNDRVNTCi0jZGVmaW5lIElTX1VOQUxJR05FRChzcmMsIGRzdCkJMAotI2Vsc2UKLSNkZWZpbmUg
SVNfVU5BTElHTkVEKHNyYywgZHN0KQlcCi0JKCgobG9uZykgZHN0IHwgKGxvbmcpIHNyYykgJiAo
c2l6ZW9mKGxvbmcpIC0gMSkpCi0jZW5kaWYKKyNkZWZpbmUgSVNfVU5BTElHTkVEKGFkZHIpICgo
KGxvbmcpKGFkZHIpKSAmIChzaXplb2YobG9uZykgLSAxKSkKIAogLyoKICAqIERvIGEgc3RybmNw
eSwgcmV0dXJuIGxlbmd0aCBvZiBzdHJpbmcgd2l0aG91dCBmaW5hbCAnXDAnLgpAQCAtMzUsMTQg
KzMwLDM5IEBAIHN0YXRpYyBpbmxpbmUgbG9uZyBkb19zdHJuY3B5X2Zyb21fdXNlcihjaGFyICpk
c3QsIGNvbnN0IGNoYXIgX191c2VyICpzcmMsIGxvbmcKIAlpZiAobWF4ID4gY291bnQpCiAJCW1h
eCA9IGNvdW50OwogCi0JaWYgKElTX1VOQUxJR05FRChzcmMsIGRzdCkpCisJLyoKKwkgKiBGaXJz
dCBoYW5kbGUgYW55IHVuYWxpZ25lZCBwcmVmaXggb2Ygc3JjLgorCSAqLworCXdoaWxlIChtYXgg
JiYgSVNfVU5BTElHTkVEKHNyYytyZXMpKSB7CisJCWNoYXIgYzsKKworCQl1bnNhZmVfZ2V0X3Vz
ZXIoYywgc3JjK3JlcywgZWZhdWx0KTsKKwkJZHN0W3Jlc10gPSBjOworCQlpZiAoIWMpCisJCQly
ZXR1cm4gcmVzOworCQlyZXMrKzsKKwkJbWF4LS07CisJfQorCisJLyoKKwkgKiBOb3cgd2Uga25v
dyB0aGF0IHNyYyArIHJlcyBpcyBhbGlnbmVkLiAgSWYgZHN0IGlzIHVuYWxpZ25lZCBhbmQKKwkg
KiB3ZSBkb24ndCBoYXZlIGVmZmljaWVudCB1bmFsaWduZWQgYWNjZXNzLCB0aGVuIGtlZXAgZ29p
bmcgb25lCisJICogYnl0ZSBhdCBhIHRpbWUuICAoVGhpcyBjb3VsZCBiZSBvcHRpbWl6ZWQsIGJ1
dCBpdCB3b3VsZCBtYWtlCisJICogdGhlIGNvZGUgbW9yZSBjb21wbGljYXRlZC4KKwkgKi8KKyNp
Zm5kZWYgQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05FRF9BQ0NFU1MKKwlpZiAoSVNfVU5B
TElHTkVEKGRzdCArIHJlcykpCiAJCWdvdG8gYnl0ZV9hdF9hX3RpbWU7CisjZW5kaWYKIAogCXdo
aWxlIChtYXggPj0gc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKSB7CisJCS8qCisJCSAqIHNyYyArIHJl
cyBpcyBhbGlnbmVkLCBzbyB0aGUgcmVhZHMgaW4gdGhpcyBsb29wIHdpbGwKKwkJICogbm90IGNy
b3NzIGEgcGFnZSBib3VuZGFyeS4KKwkJICovCiAJCXVuc2lnbmVkIGxvbmcgYywgZGF0YTsKIAot
CQkvKiBGYWxsIGJhY2sgdG8gYnl0ZS1hdC1hLXRpbWUgaWYgd2UgZ2V0IGEgcGFnZSBmYXVsdCAq
LwotCQl1bnNhZmVfZ2V0X3VzZXIoYywgKHVuc2lnbmVkIGxvbmcgX191c2VyICopKHNyYytyZXMp
LCBieXRlX2F0X2FfdGltZSk7CisJCXVuc2FmZV9nZXRfdXNlcihjLCAodW5zaWduZWQgbG9uZyBf
X3VzZXIgKikoc3JjK3JlcyksIGVmYXVsdCk7CiAKIAkJKih1bnNpZ25lZCBsb25nICopKGRzdCty
ZXMpID0gYzsKIAkJaWYgKGhhc196ZXJvKGMsICZkYXRhLCAmY29uc3RhbnRzKSkgewpAQCAtNTQs
NyArNzQsOSBAQCBzdGF0aWMgaW5saW5lIGxvbmcgZG9fc3RybmNweV9mcm9tX3VzZXIoY2hhciAq
ZHN0LCBjb25zdCBjaGFyIF9fdXNlciAqc3JjLCBsb25nCiAJCW1heCAtPSBzaXplb2YodW5zaWdu
ZWQgbG9uZyk7CiAJfQogCi1ieXRlX2F0X2FfdGltZToKKwkvKgorCSAqIEZpbmlzaCB0aGUgam9i
IG9uZSBieXRlIGF0IGEgdGltZS4KKwkgKi8KIAl3aGlsZSAobWF4KSB7CiAJCWNoYXIgYzsKIAo=
--0000000000005fda6b05822ff4e5--

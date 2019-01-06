Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D57C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D1920830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TMNxFH5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfAFTS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:18:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37959 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfAFTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:18:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so36370963lja.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4Gq4tuj76gbo0nB23LaTjgF1hC0FzDTe7Gn1GXGF0U=;
        b=TMNxFH5dqoIPaDSFIaz3s9zhAvlBl03WQe1IMuHNOJl/+h1RUVbzA4Keb2Xq4PLBln
         hj7oHyWeim39Y6NO/Ercv7JERklDNaDA92iIeXVpPfnyc9n8ArPh1I73pEs/d0MrxLEk
         HX+tw/akh/tVZhyHXdi5tF3bGO0AM53RQ2Ik8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4Gq4tuj76gbo0nB23LaTjgF1hC0FzDTe7Gn1GXGF0U=;
        b=ft8U2UEm9PsNO9tB34qKK+Wg4qvmkEI8l/SMro48+JgKyScolnEd3ETWtq0OekR5ym
         qjcL/sYe+Y8KZyVq7B6MBSmO2Qk7dhlFAEaIL0B1363/naGL0WZYQDpt2eeD51QOd654
         b7vjEvwH/CUPSnrpKqM4Q7cCQFrH1/GwfeXI7CtMbW9huXdkzJjs55Nj5sc6P23mdmLl
         lSHK+G+vNGrfABU2vX8BlSDv+AqLZQ+cSy87pB7CkFJqSCIo8E265LpBmQObgFLkGPhc
         OnlatEKKIG0urFP6ZjVT1u9xYr2jX1dYZuacy8bMEGBsE8xXIwKNvHbDQyl9Yu5k1yGs
         MzJw==
X-Gm-Message-State: AJcUukfk5UB22exIsY5jQLZx25j90rAJKc9rFMzhRh0ToBtEBOzXnpzW
        PrCgj1fp0QchMzVvR3Ic7w9lnXFdXRg=
X-Google-Smtp-Source: ALg8bN4s7Ytpzal8rBbPkr++c++un2oiIa++xDYWjt5MCYTPYFI4CvlSx20mfQka4d1DcJnXN+ZKYA==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr1736995ljj.43.1546802303598;
        Sun, 06 Jan 2019 11:18:23 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r7-v6sm13516556ljc.10.2019.01.06.11.18.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 11:18:22 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id s5-v6so36322035ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:18:22 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr11604704ljh.59.1546802301874;
 Sun, 06 Jan 2019 11:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20190106180927.GA11993@roeck-us.net> <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
In-Reply-To: <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jan 2019 11:18:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHe4dNHKpE4oGhwwmy23jNTuuFQAgWTGCjjxyOVYjG_w@mail.gmail.com>
Message-ID: <CAHk-=wiHe4dNHKpE4oGhwwmy23jNTuuFQAgWTGCjjxyOVYjG_w@mail.gmail.com>
Subject: Re: [PATCH] make 'user_access_begin()' do 'access_ok()'
To:     Guenter Roeck <linux@roeck-us.net>,
        Matt Turner <mattst88@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000bdece7057ecef90c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bdece7057ecef90c
Content-Type: text/plain; charset="UTF-8"

[ Re-sending the message because my first reply bounced - Guenther had
mis-typed the lkml address ]

On Sun, Jan 6, 2019 at 10:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> All alpha and sh4 (big and little endian) images fail to boot in qemu
> with this patch applied. Reverting it fixes the problem.

Funky. 99% of that patch is a complete no-op on non-x86.

The one exception is the strncpy_from_user() and strnlen_user() cases,
which didn't use to do access_ok() at all, and now essentially do.

But I think I see what may be the problem. I think the alpha version
of "access_ok()" is buggy.

Lookie here:

  #define __access_ok(addr, size) \
        ((get_fs().seg & (addr | size | (addr+size))) == 0)

and what it basically tests is of any of the high bits get set (the
USER_DS value is 0xfffffc0000000000).

And that's completely wrong for the "addr+size" check. It's off-by-one
for the case where we check to the very end of the user address space,
which is exactly what the strn*_user() functions do.

Why? Because "addr+size" will be exactly the size of the address
space, so trying to access the last byte of the user address space
will *fail* the __access_ok() check, even though it shouldn't.

So it's not really that that commit is buggy in itself, but it
triggers that off-by-one error in access_ok().

Side note: that alpha macro is buggy for another reason too: it
re-uses the arguments twice.

And SH has almost the exact same bug:

  #define __addr_ok(addr) \
        ((unsigned long __force)(addr) < current_thread_info()->addr_limit.seg)

so far so good: yes, a user address must be below the limit. But then:

  #define __access_ok(addr, size)         \
        (__addr_ok((addr) + (size)))

is wrong with the exact same off-by-one case: the case when
"addr+size" is exactly _equal_ to the limit is actually perfectly
fine.

The SH version is actually seriously buggy in another way: it doesn't
actually check for overflow, even though it did copy the _comment_
that talks about overflow.

So it turns out that both SH and alpha actually have completely
buggered implementations of access_ok(), but they happened to work
(although the SH overflow one is a serious serious security bug, not
that anybody likely cares about SH security)

Ho humm.

Maybe something like the attached patch? Entirely untested, I don't
have a cross-build environment, much less a boot setup.

It isn't trying to be clever, the end address is based on this logic:

        unsigned long __ao_end = __ao_a + __ao_b - !!__ao_b;    \

which basically says "subtract one unless the length was zero".

For a lot of access_ok() users the length is a constant, so this isn't
actually as expensive as it initially looks.

Does that fix things for you?

                   Linus

--000000000000bdece7057ecef90c
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jql9zyvk0>
X-Attachment-Id: f_jql9zyvk0

IGFyY2gvYWxwaGEvaW5jbHVkZS9hc20vdWFjY2Vzcy5oIHwgOCArKysrKy0tLQogYXJjaC9zaC9p
bmNsdWRlL2FzbS91YWNjZXNzLmggICAgfCA3ICsrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FscGhhL2lu
Y2x1ZGUvYXNtL3VhY2Nlc3MuaCBiL2FyY2gvYWxwaGEvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCmlu
ZGV4IGU2OWM0ZTEzYzMyOC4uY2Y0YWM3OTFhNTkyIDEwMDY0NAotLS0gYS9hcmNoL2FscGhhL2lu
Y2x1ZGUvYXNtL3VhY2Nlc3MuaAorKysgYi9hcmNoL2FscGhhL2luY2x1ZGUvYXNtL3VhY2Nlc3Mu
aApAQCAtMzAsMTEgKzMwLDEzIEBACiAgKiBBZGRyZXNzIHZhbGlkIGlmOgogICogIC0gImFkZHIi
IGRvZXNuJ3QgaGF2ZSBhbnkgaGlnaC1iaXRzIHNldAogICogIC0gQU5EICJzaXplIiBkb2Vzbid0
IGhhdmUgYW55IGhpZ2gtYml0cyBzZXQKLSAqICAtIEFORCAiYWRkcitzaXplIiBkb2Vzbid0IGhh
dmUgYW55IGhpZ2gtYml0cyBzZXQKKyAqICAtIEFORCAiYWRkcitzaXplLShzaXplICE9IDApIiBk
b2Vzbid0IGhhdmUgYW55IGhpZ2gtYml0cyBzZXQKICAqICAtIE9SIHdlIGFyZSBpbiBrZXJuZWwg
bW9kZS4KICAqLwotI2RlZmluZSBfX2FjY2Vzc19vayhhZGRyLCBzaXplKSBcCi0JKChnZXRfZnMo
KS5zZWcgJiAoYWRkciB8IHNpemUgfCAoYWRkcitzaXplKSkpID09IDApCisjZGVmaW5lIF9fYWNj
ZXNzX29rKGFkZHIsIHNpemUpICh7CQkJCVwKKwl1bnNpZ25lZCBsb25nIF9fYW9fYSA9IChhZGRy
KSwgX19hb19iID0gKHNpemUpOwkJXAorCXVuc2lnbmVkIGxvbmcgX19hb19lbmQgPSBfX2FvX2Eg
KyBfX2FvX2IgLSAhIV9fYW9fYjsJXAorCShnZXRfZnMoKS5zZWcgJiAoX19hb19hIHwgX19hb19i
IHwgX19hb19lbmQpKSA9PSAwOyB9KQogCiAjZGVmaW5lIGFjY2Vzc19vayhhZGRyLCBzaXplKQkJ
CQlcCiAoewkJCQkJCQlcCmRpZmYgLS1naXQgYS9hcmNoL3NoL2luY2x1ZGUvYXNtL3VhY2Nlc3Mu
aCBiL2FyY2gvc2gvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCmluZGV4IGRlZWJiZmFiNTM0Mi4uNWZl
NzUxYWQ3NTgyIDEwMDY0NAotLS0gYS9hcmNoL3NoL2luY2x1ZGUvYXNtL3VhY2Nlc3MuaAorKysg
Yi9hcmNoL3NoL2luY2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtMTYsOCArMTYsMTEgQEAKICAqIHN1
bSA6PSBhZGRyICsgc2l6ZTsgIGNhcnJ5PyAtLT4gZmxhZyA9IHRydWU7CiAgKiBpZiAoc3VtID49
IGFkZHJfbGltaXQpIGZsYWcgPSB0cnVlOwogICovCi0jZGVmaW5lIF9fYWNjZXNzX29rKGFkZHIs
IHNpemUpCQlcCi0JKF9fYWRkcl9vaygoYWRkcikgKyAoc2l6ZSkpKQorI2RlZmluZSBfX2FjY2Vz
c19vayhhZGRyLCBzaXplKQkoewkJCQlcCisJdW5zaWduZWQgbG9uZyBfX2FvX2EgPSAoYWRkciks
IF9fYW9fYiA9IChzaXplKTsJCVwKKwl1bnNpZ25lZCBsb25nIF9fYW9fZW5kID0gX19hb19hICsg
X19hb19iIC0gISFfX2FvX2I7CVwKKwlfX2FvX2VuZCA+PSBfX2FvX2EgJiYgX19hZGRyX29rKF9f
YW9fZW5kKTsgfSkKKwogI2RlZmluZSBhY2Nlc3Nfb2soYWRkciwgc2l6ZSkJXAogCShfX2Noa191
c2VyX3B0cihhZGRyKSwJCVwKIAkgX19hY2Nlc3Nfb2soKHVuc2lnbmVkIGxvbmcgX19mb3JjZSko
YWRkciksIChzaXplKSkpCg==
--000000000000bdece7057ecef90c--

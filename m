Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E38CC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7B920883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n7ju5MIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfAHVOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:14:41 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44853 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfAHVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:14:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id z23so3398590vsj.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OWEgAtYm9ccvWmLV8AYycOen3jNVVZL7snbVRoC2Jsg=;
        b=n7ju5MISRSee7cLJdLngz1Mdb6LlSBCNk8BK8mRbvDLCmqIsKwDKgdHG/wpLbfSBDJ
         SslGEZS8PDhaSwt3lQpLhP4l0PkbnC4k65ZU+BViOEDXcmtKOLwmBcFkBtFv2VfDWijN
         PUwrTtMH0L7MMnQ5Ibrdde0Pe3QpqRMBUt234=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OWEgAtYm9ccvWmLV8AYycOen3jNVVZL7snbVRoC2Jsg=;
        b=r730cgybpQXluauaIQFKiLknwZ1a6cYl0GHDuL+iwa2LvfqWdQZEHfqsjvF/AoszB2
         PQ1aWeCwKjlWgMcnN+2Cj3PlQCfMXhoYXb+13jtsG1ikFDNBOiDevvhFAqNKJQLxzRG2
         L5Mc68Q1WnahG8zSfOnsdF4Gefgj/0pEfW8n9W74kvgOUVbvGRoPkrI/CjRP1Zw5oCje
         lihm8h7n8fcrYhg4zkowPzvbTUFAGe6M8BPfo9GypokcqkiGALuMhIRnW7mH44X4Ozw0
         JvsVSCEis7hysQpIUkfxLu73rDTHkDZQmSEChxtgMn/olmcmNKHr6Pk2tfalBMOEvdZf
         AJDQ==
X-Gm-Message-State: AJcUukcAgRsrSu2v+hLm3Nmk275biPbSBS/EfsgMkD8jaZTp7sLx8YA1
        y5ZTVWjfxS2sLDPZ3IWmc0xUgXgVY0w=
X-Google-Smtp-Source: ALg8bN7k5L/kSFlvGNf6n2XGgRxMA4bEsM9W1mXERzzw+vmZ/imJ9D9U0MUHzaQ8sXwfiwfVIwH5yQ==
X-Received: by 2002:a67:e983:: with SMTP id b3mr1396151vso.231.1546982078943;
        Tue, 08 Jan 2019 13:14:38 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id a187sm40090428vkf.26.2019.01.08.13.14.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 13:14:37 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id t127so1193288vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:14:37 -0800 (PST)
X-Received: by 2002:a1f:4982:: with SMTP id w124mr1240075vka.4.1546982076925;
 Tue, 08 Jan 2019 13:14:36 -0800 (PST)
MIME-Version: 1.0
References: <0b0db24e18063076e9d9f4e376994af83da05456.1546932949.git.christophe.leroy@c-s.fr>
 <20190108114803.583f203b86d4a368ac9796f3@linux-foundation.org> <19c99d33-b796-72df-4212-20255f84efa0@c-s.fr>
In-Reply-To: <19c99d33-b796-72df-4212-20255f84efa0@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 13:14:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+8XqMu596gtzRAjV=7cv2rThcE5-Wy6QTmNzdht3k66w@mail.gmail.com>
Message-ID: <CAGXu5j+8XqMu596gtzRAjV=7cv2rThcE5-Wy6QTmNzdht3k66w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: add probe_user_read()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:11 PM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>
>
>
> Le 08/01/2019 =C3=A0 20:48, Andrew Morton a =C3=A9crit :
> > On Tue,  8 Jan 2019 07:37:44 +0000 (UTC) Christophe Leroy <christophe.l=
eroy@c-s.fr> wrote:
> >
> >> In powerpc code, there are several places implementing safe
> >> access to user data. This is sometimes implemented using
> >> probe_kernel_address() with additional access_ok() verification,
> >> sometimes with get_user() enclosed in a pagefault_disable()/enable()
> >> pair, etc. :
> >>      show_user_instructions()
> >>      bad_stack_expansion()
> >>      p9_hmi_special_emu()
> >>      fsl_pci_mcheck_exception()
> >>      read_user_stack_64()
> >>      read_user_stack_32() on PPC64
> >>      read_user_stack_32() on PPC32
> >>      power_pmu_bhrb_to()
> >>
> >> In the same spirit as probe_kernel_read(), this patch adds
> >> probe_user_read().
> >>
> >> probe_user_read() does the same as probe_kernel_read() but
> >> first checks that it is really a user address.
> >>
> >> ...
> >>
> >> --- a/include/linux/uaccess.h
> >> +++ b/include/linux/uaccess.h
> >> @@ -263,6 +263,40 @@ extern long strncpy_from_unsafe(char *dst, const =
void *unsafe_addr, long count);
> >>   #define probe_kernel_address(addr, retval)         \
> >>      probe_kernel_read(&retval, addr, sizeof(retval))
> >>
> >> +/**
> >> + * probe_user_read(): safely attempt to read from a user location
> >> + * @dst: pointer to the buffer that shall take the data
> >> + * @src: address to read from
> >> + * @size: size of the data chunk
> >> + *
> >> + * Returns: 0 on success, -EFAULT on error.
> >> + *
> >> + * Safely read from address @src to the buffer at @dst.  If a kernel =
fault
> >> + * happens, handle that and return -EFAULT.
> >> + *
> >> + * We ensure that the copy_from_user is executed in atomic context so=
 that
> >> + * do_page_fault() doesn't attempt to take mmap_sem.  This makes
> >> + * probe_user_read() suitable for use within regions where the caller
> >> + * already holds mmap_sem, or other locks which nest inside mmap_sem.
> >> + */
> >> +
> >> +#ifndef probe_user_read
> >> +static __always_inline long probe_user_read(void *dst, const void __u=
ser *src,
> >> +                                        size_t size)
> >> +{
> >> +    long ret;
> >> +
> >> +    if (!access_ok(src, size))
> >> +            return -EFAULT;
> >> +
> >> +    pagefault_disable();
> >> +    ret =3D __copy_from_user_inatomic(dst, src, size);
> >> +    pagefault_enable();
> >> +
> >> +    return ret ? -EFAULT : 0;
> >> +}
> >> +#endif
> >
> > Why was the __always_inline needed?
> >
> > This function is pretty large.  Why is it inlined?
> >
>
> Kees told to do that way, see https://patchwork.ozlabs.org/patch/986848/

Yeah, I'd like to make sure we can plumb the size checks down into the
user copy primitives.

--=20
Kees Cook

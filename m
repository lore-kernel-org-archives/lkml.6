Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D8E2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="notYrHAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D8E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeGRXx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:53:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36292 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbeGRXx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:53:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id d14-v6so2908433pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IY69uNKKfVBh8CVIgaAnblNpwxIfKZ0/BtqqoI1mty0=;
        b=notYrHAESF86WWvvdnAeBOhdONL75V6RYE/rf3wAMRY19/bDcPlYkQ19PyD9yyiJga
         0DLZtuZ+5N6Y1KC3j3ti5MGCdu+lOyAlHCz2WLYsua/9GpZK9qn7316MgLaC/l+4ffBp
         1PG3OQ95lG0uoaMregTdwHPU33SBmfW22ZwFKi2sq9lpkqUM+pWYxwpwyN5O7h9wvxNZ
         NrWeHOgVb4q+Zqf4aCYgZPuPETILrietNXevUQygVhlZ9+mX3xSpvDcL4HCiiIR723Wa
         rq1ENnx5ahEnYtwD7fYQDGpbME2am24o425oRfhfnyKteyR1oGphW4Drfv+RgcBqs/DI
         p1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IY69uNKKfVBh8CVIgaAnblNpwxIfKZ0/BtqqoI1mty0=;
        b=ce8UXtqazCGPQQ5KU+sMbcLRu4scKQJhV1vYETmfO6n61kHeOiXSf6piJsOSASKgQM
         SqiFMSgogX1vr3Bbm24u1Do2LLdU22bWRpCX5soED+wEzWk+SgEGC2qHG43lsAth6sYf
         hHoNA+6DCsY84MNofTo7KJCUW1VJPQ8CycXbTVcSKUq4jQ5jADSni9LIiaCL6IRgUXY+
         ZZahEi0cYGUlivG4N2pXi4Nw6gJPX7PJEHnnhhbrP6M6uhTmO3es2oTEXnTLeyeO7hGg
         1KcLonrp+rTLAHdXwFMfSnGHr+AXteVCNkkhp8kekxVSW4Y6WxiOEIDjCZR3M9Hz8ESP
         RIhw==
X-Gm-Message-State: AOUpUlFooxzVu5haT2eMAT7tT5mVv7pbapKeJ/lSP1/rURw21y2dUTOr
        NQc/zulc839k3GiQBKDobq3v8Q==
X-Google-Smtp-Source: AAOMgpeb3EnL67QeX3XFLXidfKw7ot3Vjc1DREquM0UXfvDpMVaoh5GX+8Tn2hiPzgI7JSynrnx2rg==
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr7103940pfa.45.1531955596753;
        Wed, 18 Jul 2018 16:13:16 -0700 (PDT)
Received: from ?IPv6:2600:1013:b009:1d4b:8412:9700:89b0:afa9? ([2600:1013:b009:1d4b:8412:9700:89b0:afa9])
        by smtp.gmail.com with ESMTPSA id a62-v6sm11801055pfc.14.2018.07.18.16.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:13:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
Date:   Wed, 18 Jul 2018 13:13:13 -1000
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
References: <20180716190337.26133-1-riel@surriel.com> <20180716190337.26133-5-riel@surriel.com> <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com> <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
To:     Rik van Riel <riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 18, 2018, at 10:58 AM, Rik van Riel <riel@surriel.com> wrote:
>=20
>=20
>=20
>> On Jul 17, 2018, at 4:04 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>>=20
>> I think you've introduced a minor-ish performance regression due to
>> changing the old (admittedly terribly documented) control flow a bit.
>> Before, if real_prev =3D=3D next, we would skip:
>>=20
>> load_mm_cr4(next);
>> switch_ldt(real_prev, next);
>>=20
>> Now we don't any more.  I think you should reinstate that
>> optimization.  It's probably as simple as wrapping them in an if
>> (real_priv !=3D next) with a comment like /* Remote changes that would
>> require a cr4 or ldt reload will unconditionally send an IPI even to
>> lazy CPUs.  So, if we aren't changing our mm, we don't need to refresh
>> cr4 or the ldt */
>=20
> Looks like switch_ldt already skips reloading the LDT when prev equals
> next, or when they simply have the same LDT values:
>=20
>        if (unlikely((unsigned long)prev->context.ldt |
>                     (unsigned long)next->context.ldt))
>                load_mm_ldt(next);
>=20

Read that again?  It will reload if there=E2=80=99s an LDT, even if it=E2=80=
=99s the same one.

> It appears that the cr4 bits have a similar optimization:
>=20
> static inline void cr4_set_bits(unsigned long mask)
> {
>        unsigned long cr4, flags;
>=20
>        local_irq_save(flags);
>        cr4 =3D this_cpu_read(cpu_tlbstate.cr4);
>        if ((cr4 | mask) !=3D cr4)
>                __cr4_set(cr4 | mask);
>        local_irq_restore(flags);
> }
>>=20
>> Hmm.  load_mm_cr4() should bypass itself when mm =3D=3D &init_mm.  Want t=
o
>> fix that part or should I?
>>=20
> Looks like there might not be anything to do here, after all.

But if init_mm and the thread that just went idle have different selected cr=
4 values, we=E2=80=99ll still write it.  With your lazy TLB work, it=E2=80=99=
s less of a big deal, but still.

I=E2=80=99m happy to fix this myself, though.

>=20
> On to the lazy TLB mm_struct refcounting stuff :)
>=20

Which refcount?  mm_users shouldn=E2=80=99t be hot, so I assume you=E2=80=99=
re talking about mm_count. My suggestion is to get rid of mm_count instead o=
f trying to optimize it.=

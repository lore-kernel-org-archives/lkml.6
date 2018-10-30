Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C6ECDE46
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0B220664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAHOK+aP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0B220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeJaIOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:14:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39339 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeJaIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:14:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so6415241pgv.6;
        Tue, 30 Oct 2018 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CjH2DEehf+DuQGNael1Ja6nkn4Mmmqo+8dIZYTYzohI=;
        b=RAHOK+aPbmG/XDyB6DrwMn3uUrgFe/oXhnm1PTi9SMFqTL1irBpzRLP2EWnYzT/Wzw
         mcFnyC9ZZqAghI0nmaYnvnbsEF4IV3CgyW7gPC3t2TA5zcJmZRV7nlj271zY57WuIm0j
         +3g24LPlfQWdKyNfhnuorLrbEq/BXMYvL/dZEoOTlYFF/AfXfY7N/DEfWMJUgHUFPkJg
         dEGseG7wxedwWwiFZ/jEHNbohnKwQdfFFOgyPT6GcGzbE6hGWuyb/8MToL1vw1NBWYNu
         dHFKDmyc+jrT3gPA+ZGKfT9WxjXiCNGFk6FwwVf0XL/w3DJq7yiPO6fTlKsD762PII+J
         AzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CjH2DEehf+DuQGNael1Ja6nkn4Mmmqo+8dIZYTYzohI=;
        b=TJPY3H7LCJNLVXyS9K5sKLKyBdfNoqlrqRUsbwRBV/RWWJJdv9UOa1WePC2S3vvXQr
         aP/5lWKv2EG616XbyMELFPvpmvmE+/AG412nWzdsUnZ7Wk8Ow+3XFGfK0c6glo66DlaE
         J6WLn4JhUAtkCzFXAx9O6dUlPH1Wi0j97oxjZi8KtkQZ1IQ4gu+Oygw5JT5JUUz/wPgI
         NmqU6SrCc9/IEWlARTmcYidnPOKscS1WXRSSJzSfk9HlTZWXYamOPGJOnAEq9l0A62MF
         z5v2JrDSJQymgCir51pqwwNX+G3STgofeqoJ3OcDzC/djtvdZ1ZjujrGDukoU4pRnLOm
         b2xg==
X-Gm-Message-State: AGRZ1gLSpDVGGLfoSaSKoJArv7UF4WsjdnwMz0inQzkQ6VRfHeQSdFeo
        wvnkm7BpeTNWG8G+ruvNj5Q=
X-Google-Smtp-Source: AJdET5eS3+25CFI0agUCVS10k/r5/aiKSporwPitrRsG/Xy6YaYezIWGlEsq7+CWF89jU8QXpVJjJg==
X-Received: by 2002:a63:4450:: with SMTP id t16mr708522pgk.102.1540941524006;
        Tue, 30 Oct 2018 16:18:44 -0700 (PDT)
Received: from [10.2.51.78] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id b18-v6sm18506266pgg.88.2018.10.30.16.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:18:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
Date:   Tue, 30 Oct 2018 16:18:39 -0700
Cc:     Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAC99157-7A9B-4AC6-BA41-EAA7A99FE53D@gmail.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski
Sent: October 30, 2018 at 6:51:17 PM GMT
> To: Matthew Wilcox <willy@infradead.org>, nadav.amit@gmail.com
> Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra =
<peterz@infradead.org>, Igor Stoppa <igor.stoppa@gmail.com>, Mimi Zohar =
<zohar@linux.vnet.ibm.com>, Dave Chinner <david@fromorbit.com>, James =
Morris <jmorris@namei.org>, Michal Hocko <mhocko@kernel.org>, Kernel =
Hardening <kernel-hardening@lists.openwall.com>, linux-integrity =
<linux-integrity@vger.kernel.org>, linux-security-module =
<linux-security-module@vger.kernel.org>, Igor Stoppa =
<igor.stoppa@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>, =
Jonathan Corbet <corbet@lwn.net>, Laura Abbott <labbott@redhat.com>, =
Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport =
<rppt@linux.vnet.ibm.com>, open list:DOCUMENTATION =
<linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas =
Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH 10/17] prmem: documentation
>=20
>=20
>=20
>=20
>> On Oct 30, 2018, at 10:58 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>>=20
>> On Tue, Oct 30, 2018 at 10:06:51AM -0700, Andy Lutomirski wrote:
>>>> On Oct 30, 2018, at 9:37 AM, Kees Cook <keescook@chromium.org> =
wrote:
>>> I support the addition of a rare-write mechanism to the upstream =
kernel.
>>> And I think that there is only one sane way to implement it: using =
an
>>> mm_struct. That mm_struct, just like any sane mm_struct, should only
>>> differ from init_mm in that it has extra mappings in the *user* =
region.
>>=20
>> I'd like to understand this approach a little better.  In a syscall =
path,
>> we run with the user task's mm.  What you're proposing is that when =
we
>> want to modify rare data, we switch to rare_mm which contains a
>> writable mapping to all the kernel data which is rare-write.
>>=20
>> So the API might look something like this:
>>=20
>>   void *p =3D rare_alloc(...);    /* writable pointer */
>>   p->a =3D x;
>>   q =3D rare_protect(p);        /* read-only pointer */
>>=20
>> To subsequently modify q,
>>=20
>>   p =3D rare_modify(q);
>>   q->a =3D y;
>>   rare_protect(p);
>=20
> How about:
>=20
> rare_write(&q->a, y);
>=20
> Or, for big writes:
>=20
> rare_write_copy(&q, local_q);
>=20
> This avoids a whole ton of issues. In practice, actually running with =
a
> special mm requires preemption disabled as well as some other stuff, =
which
> Nadav carefully dealt with.
>=20
> Also, can we maybe focus on getting something merged for statically
> allocated data first?
>=20
> Finally, one issue: rare_alloc() is going to utterly suck =
performance-wise
> due to the global IPI when the region gets zapped out of the direct =
map or
> otherwise made RO. This is the same issue that makes all existing XPO
> efforts so painful. We need to either optimize the crap out of it =
somehow
> or we need to make sure it=E2=80=99s not called except during rare =
events like
> device enumeration.
>=20
> Nadav, want to resubmit your series? IIRC the only thing wrong with it =
was
> that it was a big change and we wanted a simpler fix to backport. But
> that=E2=80=99s all done now, and I, at least, rather liked your code. =
:)

I guess since it was based on your ideas=E2=80=A6

Anyhow, the only open issue that I have with v2 is Peter=E2=80=99s wish =
that I would
make kgdb use of poke_text() less disgusting. I still don=E2=80=99t know =
exactly
how to deal with it.

Perhaps it (fixing kgdb) can be postponed? In that case I can just =
resend
v2.


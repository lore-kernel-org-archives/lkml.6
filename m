Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C363CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857562245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVDtcw+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857562245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbeKMXYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:24:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35012 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMXYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:24:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so10270782oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hSIuAY46XEKEeOgrKoYRGkRlvY23N/Sz5TToB8r/bOE=;
        b=PVDtcw+e2i+5/xT3riAMB9BLYZ9t7sVb0LgAyEjREu9rsVrMoMsT0yuioyB7j/Fw1p
         yblIzMM+YK2Xt8dmaVC4cjBKa9Wtc5O6QbG3XNbLRECjERILt8p/zZ8SPPFpNnC7p1XU
         p4mNr32RzNO2Z0Y8ZEelqo/RV0CwpPbHLZi2Pp64Q5/Hd5N6/thYgGmLxVLgilFETbey
         9Dw1gxD5puPCtXBIFVr/Jasu9+L9/iixPkg7/7sdTAQyCIyW2WTCU5xpathFRa45mcRB
         bef1KD1GKJ+S5hloVhqcaJSxZXkFT6rZaO3QFvRtU97bvWFArHmMaDBLgXMdVWNO+koD
         Q88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hSIuAY46XEKEeOgrKoYRGkRlvY23N/Sz5TToB8r/bOE=;
        b=okNdSVrFePYDGoSn1jDxwMcoXs5/JWG6p4OlU4b1NRxTz5GgX7J/pmxCXdY+1ieKzQ
         kTszlbRXA3UFS3N/nvPoqg70uXSVN1NYVIhKxgSyBy9GrGl2keFHbIVc+e+S50zpTf32
         hvZarraBguP7HUrT8MJKRPuRSkjY7trEsaTtC8/YN2c13Ic64BQwJgEsvUctbwJQ3kPL
         2J6M3nnZuBaZ7EnkPQoTFPWnHJTbFfxCZW+LQ+Ik/SCU4rv//MCs3lXAGmXWZjyxU5t8
         bOw4KMru29QieNev55YQT+7srmJUeqx8ATSuhAaf+3K3gFo491WWbDr8NJfjszEeZL3y
         04DQ==
X-Gm-Message-State: AGRZ1gLIqS3G07oBg2DQ+Ysab+LkYwdAFGF+LotJ+ncNyZ4nZfH13Yxn
        FrF7n7FwALXqYgaKAAGOmO/xuBR0zGWxBjwoz6PPWQ==
X-Google-Smtp-Source: AJdET5eEThror9lA2DT5F3WG3NhWCDRvL45JQNR46C6sMhCyYyyvSCRuB3pX6dN6Ngi61KePzLWM6qzT6/GL8Hm5Czs=
X-Received: by 2002:a54:4607:: with SMTP id p7-v6mr2845907oip.126.1542115565358;
 Tue, 13 Nov 2018 05:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20181112231344.7161-1-timofey.titovets@synesis.ru>
 <CAG48ez0VRmRQckOjQhOeaf6bLYkfi45ksdnzuCKPwBYTM+As1g@mail.gmail.com> <CAGqmi75MShkwHTiSLPiOoQuYORmYTBJVqMKXm7pKhoNg9PT3yw@mail.gmail.com>
In-Reply-To: <CAGqmi75MShkwHTiSLPiOoQuYORmYTBJVqMKXm7pKhoNg9PT3yw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 13 Nov 2018 14:25:38 +0100
Message-ID: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     timofey.titovets@synesis.ru
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 1:59 PM Timofey Titovets
<timofey.titovets@synesis.ru> wrote:
>
> =D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 14:57, Jan=
n Horn <jannh@google.com>:
> >
> > On Tue, Nov 13, 2018 at 12:40 PM Timofey Titovets
> > <timofey.titovets@synesis.ru> wrote:
> > > ksm by default working only on memory that added by
> > > madvise().
> > >
> > > And only way get that work on other applications:
> > >   * Use LD_PRELOAD and libraries
> > >   * Patch kernel
> > >
> > > Lets use kernel task list and add logic to import VMAs from tasks.
> > >
> > > That behaviour controlled by new attributes:
> > >   * mode:
> > >     I try mimic hugepages attribute, so mode have two states:
> > >       * madvise      - old default behaviour
> > >       * always [new] - allow ksm to get tasks vma and
> > >                        try working on that.
> >
> > Please don't. And if you really have to for some reason, put some big
> > warnings on this, advising people that it's a security risk.
> >
> > KSM is one of the favorite punching bags of side-channel and hardware
> > security researchers:
> >
> > As a gigantic, problematic side channel:
> > http://staff.aist.go.jp/k.suzaki/EuroSec2011-suzaki.pdf
> > https://www.usenix.org/system/files/conference/woot15/woot15-paper-barr=
esi.pdf
> > https://access.redhat.com/blogs/766093/posts/1976303
> > https://gruss.cc/files/dedup.pdf
> >
> > In particular https://gruss.cc/files/dedup.pdf ("Practical Memory
> > Deduplication Attacks in Sandboxed JavaScript") shows that KSM makes
> > it possible to use malicious JavaScript to determine whether a given
> > page of memory exists elsewhere on your system.
> >
> > And also as a way to target rowhammer-based faults:
> > https://www.usenix.org/system/files/conference/usenixsecurity16/sec16_p=
aper_razavi.pdf
> > https://thisissecurity.stormshield.com/2017/10/19/attacking-co-hosted-v=
m-hacker-hammer-two-memory-modules/
>
> I'm very sorry, i'm not a security specialist.
> But if i understood correctly, ksm have that security issues _without_
> my patch set.

Yep. However, so far, it requires an application to explicitly opt in
to this behavior, so it's not all that bad. Your patch would remove
the requirement for application opt-in, which, in my opinion, makes
this way worse and reduces the number of applications for which this
is acceptable.

> Even more, not only KSM have that type of issue, any memory
> deduplication have that problems.

Yup.

> Any guy who care about security must decide on it self. Which things
> him use and how he will
> defend from others.

> Even more on it self he must learn tools, what he use and make some
> decision right?
>
> So, if you really care about that problem in general, or only on KSM side=
,
> that your initiative and your duty to warn people about that.
>
> KSM already exists for 10+ years. You know about security implication
> of use memory deduplication.
> That your duty to send a patches to documentation, and add appropriate wa=
rnings.

As far as I know, basically nobody is using KSM at this point. There
are blog posts from several cloud providers about these security risks
that explicitly state that they're not using memory deduplication.

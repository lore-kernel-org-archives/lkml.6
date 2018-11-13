Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB83223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="rPurDtgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB83223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbeKNIlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:41:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33272 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:41:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so6509799otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=59XTU/1FusSKXFkvEPaYaji3QWEZkqsgHRvl+nXWhwc=;
        b=rPurDtgTQX8CLRIOfmvUNufqcwKFxrI0CsmuiyryyvVktaP6yNYacQq7jpva4f6yTH
         1c5MRfRYRBbX91DlfJpAB/MToJOG08KHkchMXCQTmCMt5xZCZbdfybtbwxvREDX1zqF3
         dvUyFBg2nBEohmZxEqpw9WEH70d3wffWak34kSks6IZAtBJpY6+opyb3u7ALByqqtWi4
         cKFGPZkSkDFWirnzgY8YqPD7iqnyIxZ56KckJ6kif3/FTCHMcOY4UT/ndCkPVggXpw+C
         0MtQ4ce2v2LvYbD/f3hYBR4XvpcVrR7wo04hWWtD+y7ndPAoAMRAZPLZy0m6Nf3cOMfR
         iNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=59XTU/1FusSKXFkvEPaYaji3QWEZkqsgHRvl+nXWhwc=;
        b=pKxdUmR1iw+6dbgx+2NWcE2BHXDRv56bzKmwOKq1Un7+S6+Aypa9xgr0GYaMjYFf3Q
         BP5A/M4+i2lUoWngf2YtGH5jxNfHUgUODsSwwGehNbqT6wKQzX6n3ZH/0PMjdU7nt9im
         yKx4kGQriZc211FwhGD4CoUCGu4HQPFO7bIMFxNkXpC33wppSssuK7xIbLopDQ5ev8ay
         oh+CFF0lYHWyV0TsOTLYjScXkv1YzYunVPJZkXZSKGjm5/hqFPPn4yBBTkvQKK0AFfdt
         aZIwK4Rc9gKKhqYNaO+bZlhDYlyV7yIRbIDPQKgRB4OgUN5gazKZyaJ68wbNoZy8WDAK
         gQLQ==
X-Gm-Message-State: AGRZ1gLS91N5o0pZFzaxdEfppDjiDpAxfmfDC5qzdJkpENBWxUxVCTsh
        C+7Uc3XrR/ZAs57NZ/ftI4R1eg==
X-Google-Smtp-Source: AJdET5cEhTuucKIDyxEKICduLwdXWkMqXRWHJomHqc/KHu91LGhA2JQinJ3FO7+rO9E59PRHKEtCLw==
X-Received: by 2002:a9d:7653:: with SMTP id o19mr4209626otl.12.1542148848223;
        Tue, 13 Nov 2018 14:40:48 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id s184-v6sm3774070oib.23.2018.11.13.14.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 14:40:47 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id t5so13004303otk.1;
        Tue, 13 Nov 2018 14:40:47 -0800 (PST)
X-Received: by 2002:a9d:3208:: with SMTP id t8mr4209224otc.312.1542148846775;
 Tue, 13 Nov 2018 14:40:46 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
 <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name> <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi74gpvJv8=B-3pVSMrDssu-aYMxW9xM7mt1WNQjGLjMZqA@mail.gmail.com>
 <20181113183510.5y2hzruoi23e7o2t@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi763e4sZj1NHAk2fAjtPtb-kAZfcPq=KTH8B3sE-oDVvGw@mail.gmail.com> <20181113191653.btbzobquxtwt47z4@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
In-Reply-To: <20181113191653.btbzobquxtwt47z4@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Wed, 14 Nov 2018 01:40:10 +0300
X-Gmail-Original-Message-ID: <CAGqmi77JMyxU9L4bZHPv4Nt=tyQsEZDQcMVMRfQ7de_LjZg+-Q@mail.gmail.com>
Message-ID: <CAGqmi77JMyxU9L4bZHPv4Nt=tyQsEZDQcMVMRfQ7de_LjZg+-Q@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 22:17, Pavel=
 Tatashin <pasha.tatashin@soleen.com>:
>
> On 18-11-13 21:54:13, Timofey Titovets wrote:
> > =D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 21:35, P=
avel Tatashin <pasha.tatashin@soleen.com>:
> > >
> > > On 18-11-13 21:17:42, Timofey Titovets wrote:
> > > > =D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 20:5=
9, Pavel Tatashin <pasha.tatashin@soleen.com>:
> > > > >
> > > > > On 18-11-13 15:23:50, Oleksandr Natalenko wrote:
> > > > > > Hi.
> > > > > >
> > > > > > > Yep. However, so far, it requires an application to explicitl=
y opt in
> > > > > > > to this behavior, so it's not all that bad. Your patch would =
remove
> > > > > > > the requirement for application opt-in, which, in my opinion,=
 makes
> > > > > > > this way worse and reduces the number of applications for whi=
ch this
> > > > > > > is acceptable.
> > > > > >
> > > > > > The default is to maintain the old behaviour, so unless the exp=
licit
> > > > > > decision is made by the administrator, no extra risk is imposed=
.
> > > > >
> > > > > The new interface would be more tolerable if it honored MADV_UNME=
RGEABLE:
> > > > >
> > > > > KSM default on: merge everything except when MADV_UNMERGEABLE is
> > > > > excplicitly set.
> > > > >
> > > > > KSM default off: merge only when MADV_MERGEABLE is set.
> > > > >
> > > > > The proposed change won't honor MADV_UNMERGEABLE, meaning that
> > > > > application programmers won't have a way to prevent sensitive dat=
a to be
> > > > > every merged. So, I think, we should keep allow an explicit opt-o=
ut
> > > > > option for applications.
> > > > >
> > > >
> > > > We just did not have VM/Madvise flag for that currently.
> > > > Same as THP.
> > > > Because all logic written with assumption, what we have exactly 2 s=
tates.
> > > > Allow/Disallow (More like not allow).
> > > >
> > > > And if we try to add, that must be something like:
> > > > MADV_FORBID_* to disallow something completely.
> > >
> > > No need to add new user flag MADV_FORBID, we should keep MADV_MERGEAB=
LE
> > > and MADV_UNMERGEABLE, but make them work so when MADV_UNMERGEABLE is
> > > set, memory is indeed becomes always unmergeable regardless of ksm mo=
de
> > > of operation.
> > >
> > > To do the above in ksm_madvise(), a new state should be added, for ex=
ample
> > > instead of:
> > >
> > > case MADV_UNMERGEABLE:
> > >         *vm_flags &=3D ~VM_MERGEABLE;
> > >
> > > A new flag should be used:
> > >         *vm_flags |=3D VM_UNMERGEABLE;
> > >
> > > I think, without honoring MADV_UNMERGEABLE correctly, this patch won'=
t
> > > be accepted.
> > >
> > > Pasha
> > >
> >
> > That must work, but we out of bit space in vm_flags [1].
> > i.e. first 32 bits already defined, and other only accessible only on
> > 64-bit machines.
>
> So, grow vm_flags_t to 64-bit, or enable this feature on 64-bit only.

With all due respect to you, for that type of things we need
mm maintainer opinion.

I just don't want get situation, where after touch of other subsystems,
maintainer will just refuse that work by some reason.

i.e. writing patches for upstream (from my point of view),
is more art of communication and making resulte code acceptable by communit=
y.
Because any code which written correctly from engineering point of view,
can be easy refused, just because someone not found it useful.

Thanks.

> >
> > 1. https://elixir.bootlin.com/linux/latest/source/include/linux/mm.h#L2=
19

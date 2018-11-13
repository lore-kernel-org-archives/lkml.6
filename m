Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A0421780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="ZSEhQYcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A0421780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeKNEyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:54:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43746 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeKNEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:54:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id j202-v6so11272028oih.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n1M0m2M7bdd1rQZPbKY5xhYiWj5+GTZhmA61kUfSgeE=;
        b=ZSEhQYcqJAqK1WTLGSC+JqY9F23q/Uige6x7Qrj5GK3FI2n1sbHx7TYZCstGptY7D8
         1A48ERsF+Ce912QqjQZtNS9o6FCfqda/t1hYMRDromH65JhAMHDTe7ZD2dLZzFYeiMzq
         0u6IaphFqhLIGwHxbVSBDb2F3P7IJ+J74e0ov587dTBNmOfUSS3rqmNl/T2iO9ubSXbQ
         irzF0An/uVhnK0YjmaGfrqXEL2wAsLoPw0hJo6IK5kwmAuob//gcHRAtmzktzOVvFWYd
         NKQZcC3n26LKBU6gSFHUGhS1r7WmQ5RXIBTXeNx7ce8ogcTsW92Rdnjrdvd/t7Rg1lqB
         kdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n1M0m2M7bdd1rQZPbKY5xhYiWj5+GTZhmA61kUfSgeE=;
        b=QwKFe5YgxGgeG6z1lha/MGJKw+MX1xnJ4fQJQ8xOvjWduIDsZfthuIhN13UhIUpjT2
         IVs8Zr4e+ZantPYRCgSVOFIHP6dk+6AHtoRQWE/J4V+b8Ew1xQUTb1pvfwiERQreiM/t
         x0wX9Usa+AXOU2U8+SJvIoprGZ6+qShlS0hgkXsl/foyEDyB2jnyfJg9cqn0qB+Voi1L
         yt88s0fDTwbq2at9ZUrYGriixYB0qKoKBeU/+MCz35LmWB2DTShp5lRhSOaKEmj0mfL0
         71JbLT19bVVwxmu95dr+zSwQqZOer7WzWkxuMhc3J9PpoHrqAOSJG0fgRm1aNJZn1x9/
         U6PA==
X-Gm-Message-State: AGRZ1gIYawRjMHplpB1rvhZUzHPDlHFwCMYdv4FIGaoFV81c7UpLHskm
        tqTWkS90t7WUSvfdnlLIMHtJ4g==
X-Google-Smtp-Source: AJdET5fqirj9YcMxtQDOZNMJdWbBCNgTVDI+3lPoJxfeprEaWXLwYJWcn7cN9kntXfQqXyyQ0IdpOQ==
X-Received: by 2002:aca:6155:: with SMTP id v82-v6mr3488848oib.270.1542135292002;
        Tue, 13 Nov 2018 10:54:52 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id l71-v6sm9545413oih.34.2018.11.13.10.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:54:51 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 40so12353378oth.4;
        Tue, 13 Nov 2018 10:54:50 -0800 (PST)
X-Received: by 2002:a9d:738a:: with SMTP id j10mr3975973otk.188.1542135289720;
 Tue, 13 Nov 2018 10:54:49 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
 <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name> <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi74gpvJv8=B-3pVSMrDssu-aYMxW9xM7mt1WNQjGLjMZqA@mail.gmail.com> <20181113183510.5y2hzruoi23e7o2t@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
In-Reply-To: <20181113183510.5y2hzruoi23e7o2t@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Tue, 13 Nov 2018 21:54:13 +0300
X-Gmail-Original-Message-ID: <CAGqmi763e4sZj1NHAk2fAjtPtb-kAZfcPq=KTH8B3sE-oDVvGw@mail.gmail.com>
Message-ID: <CAGqmi763e4sZj1NHAk2fAjtPtb-kAZfcPq=KTH8B3sE-oDVvGw@mail.gmail.com>
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

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 21:35, Pavel=
 Tatashin <pasha.tatashin@soleen.com>:
>
> On 18-11-13 21:17:42, Timofey Titovets wrote:
> > =D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 20:59, P=
avel Tatashin <pasha.tatashin@soleen.com>:
> > >
> > > On 18-11-13 15:23:50, Oleksandr Natalenko wrote:
> > > > Hi.
> > > >
> > > > > Yep. However, so far, it requires an application to explicitly op=
t in
> > > > > to this behavior, so it's not all that bad. Your patch would remo=
ve
> > > > > the requirement for application opt-in, which, in my opinion, mak=
es
> > > > > this way worse and reduces the number of applications for which t=
his
> > > > > is acceptable.
> > > >
> > > > The default is to maintain the old behaviour, so unless the explici=
t
> > > > decision is made by the administrator, no extra risk is imposed.
> > >
> > > The new interface would be more tolerable if it honored MADV_UNMERGEA=
BLE:
> > >
> > > KSM default on: merge everything except when MADV_UNMERGEABLE is
> > > excplicitly set.
> > >
> > > KSM default off: merge only when MADV_MERGEABLE is set.
> > >
> > > The proposed change won't honor MADV_UNMERGEABLE, meaning that
> > > application programmers won't have a way to prevent sensitive data to=
 be
> > > every merged. So, I think, we should keep allow an explicit opt-out
> > > option for applications.
> > >
> >
> > We just did not have VM/Madvise flag for that currently.
> > Same as THP.
> > Because all logic written with assumption, what we have exactly 2 state=
s.
> > Allow/Disallow (More like not allow).
> >
> > And if we try to add, that must be something like:
> > MADV_FORBID_* to disallow something completely.
>
> No need to add new user flag MADV_FORBID, we should keep MADV_MERGEABLE
> and MADV_UNMERGEABLE, but make them work so when MADV_UNMERGEABLE is
> set, memory is indeed becomes always unmergeable regardless of ksm mode
> of operation.
>
> To do the above in ksm_madvise(), a new state should be added, for exampl=
e
> instead of:
>
> case MADV_UNMERGEABLE:
>         *vm_flags &=3D ~VM_MERGEABLE;
>
> A new flag should be used:
>         *vm_flags |=3D VM_UNMERGEABLE;
>
> I think, without honoring MADV_UNMERGEABLE correctly, this patch won't
> be accepted.
>
> Pasha
>

That must work, but we out of bit space in vm_flags [1].
i.e. first 32 bits already defined, and other only accessible only on
64-bit machines.

1. https://elixir.bootlin.com/linux/latest/source/include/linux/mm.h#L219

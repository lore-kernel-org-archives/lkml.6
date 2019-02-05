Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A127C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377B3217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQgL++7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfBEPph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:45:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41040 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfBEPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:45:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so1536546pgq.8;
        Tue, 05 Feb 2019 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEco+pDVHYSJzSZvnAlXaj2YOqIbT2SVEKF9v3Ks658=;
        b=aQgL++7ElUNx+pEPr/9KjBGZlK52ssqaAKOor9UIGzVrNhmXgI/9iYriqWjFRgldlc
         nswOCD4RJU8ojKXYKqpzOpmKlBEGMEQZqeFDuzvy5bxQmENU0eHpvjtkhzX2K8agX7Ns
         kUNi1MSXrb0xIxILAzhpj9ILMRwIA22CAXfZpGh6r7IEhDfbN68FOMjG3W6QwRnGgn7f
         f6A618cJwBaSdKHimrxcG/bXMbXBoNZaTCOCW5TR927cvMIkOJe8JbuLVJ9/BF9CsV99
         8oayWxHcqUB3GUMzoqnRf+h57wXWlViGMSu2ZjQlg7ma1QBO9EdpZptFUgM3/EPlifrt
         lLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEco+pDVHYSJzSZvnAlXaj2YOqIbT2SVEKF9v3Ks658=;
        b=URHFPFQBNkD1ySeC8Zk5mdP0LeIMrcGjvzzX4kviIgOLvRj4LaXHN5dh/0YKGwNida
         GUk82fDdkivuEexYCluqvZ6SZKIr/COmgwuqf9JEU5YJM3VLPjKY4epl2n0u6NMb5b1b
         1QQAxzMDKlzEWRcfV9gRp3wBzmKvvFSlBfjTFtH3ZAGflHdJ1zc5Gk8ETSo4qdJoucFR
         PkVDwXBeJsl9ESvGr40Lk9HpKvhvcoQlYsno2DN5wDlX6uZULXAhStsgtMDX+yIkZWei
         UMPKDQzbKMN+cyoYWO9rvxkCrGeMUm57Uez3xvuBR8xngov0DrhMhyRgcKuhVZn7P0tQ
         TC1w==
X-Gm-Message-State: AHQUAublmCHQNXBWQL82Z4bIu553RegC8GnIGncqYF6Baqo8Vh6HtX7X
        t2Y+xEZVnq4ii/8h/2qXT6UCARlj0+4+0VCs6CADkVdb
X-Google-Smtp-Source: AHgI3Ia1/Cg/PckbCVIzudoeo42vzIi25lyEobA1+hMLV006Ivg7neymX797GyraC3WvsmclY4wNrmIPnbBpEXrOtos=
X-Received: by 2002:a62:c711:: with SMTP id w17mr5690320pfg.50.1549381536427;
 Tue, 05 Feb 2019 07:45:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548860212.git.2pi@mok.nu> <ae59210f24d66516a0af38c03fd0da923dd0e7da.1548860212.git.2pi@mok.nu>
 <CAHp75VcLizx+jtMrbc3Ev-HcJVEjH2naFC0sj=7fX5nZSCGc8Q@mail.gmail.com> <20190203190423.lmsix5la6ioyawwi@mok.nu>
In-Reply-To: <20190203190423.lmsix5la6ioyawwi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 17:45:25 +0200
Message-ID: <CAHp75Vdtggmg7POfcdvd8RykPW+wZ5wGKBWE8_Y_5qWY_MGL0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        michal.lkml@markovi.net, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 9:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> On 2019-01-30, Andy Shevchenko wrote:
> > On Wed, Jan 30, 2019 at 5:15 PM Mattias Jacobsson <2pi@mok.nu> wrote:

> > > +       if (len < 0 || len >= 500) {
> >
> > Would it even possible to get a negative number here?
> > Same for any other number than slightly bigger than 36.
>
> snprintf returns a negative number on error. BTW AFAIU the code from
> file2alias.c gets dynamically linked against a libc.

OK.

> > So, what about simple
> >
> > {
> >  DEF_FIELD_ADDR(...);
> >  size_t len;
> >
> >  len = strlen(*guid_string);
> >  if (len != ...) {
> >   ...
> >  }
> > sprintf(...);
> > return 1;
> > }
> >
> > ?
>
> Then we are missing the check that we are within the bounds of alias

I don't see how. By checking a length of string we be sure, that the
result would have a non-arbitrary length.

> as well as the negative code from s*printf(). snprintf() does this nicely
> for us.

This one I agree with, means in the above example we may do

return sprintf(...);

if callers recognize just a sign, or

len = sprintf(...);
if (len < 0)
 return len; // -1? 0?

return 1;

otherwise.

-- 
With Best Regards,
Andy Shevchenko

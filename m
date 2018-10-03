Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D68C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F120878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKZ2X55U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7F120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJCI0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:26:20 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52602 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeJCI0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:26:20 -0400
Received: by mail-it1-f195.google.com with SMTP id 134-v6so6261947itz.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 18:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k27ZAsrfok5lqbiX1m5u8MlcU7L7zjUrrltAsSQGuuw=;
        b=GKZ2X55UeaFV0AdF8+Cpd8bjbxoXA++BYiVzKJKJlWPqgQLvorJaOGTSovoxmc9f6w
         FqJHT6PGedkG+HsnFkCe4UUAPu1ClH67JiitMJwb2WpJmD10J9MqHw7YldmtqNzNYs6G
         mSbmr8jvud708Aku0fBfZAq3xbXf9NWqWT5hfYAAR64FV9QkkNL+hK/sFmjLlhGBzJFO
         caeve0qsjr93Rhz71l1zrZxMRlpehnlN1a5J8ebMzw6ouzt4ZZccLPs4YenQLE7d409p
         dP+WHVh7ez22jUzglHfegvUaCCknHx9bJ+ruXxeJHch7Uf+tacWQGsAHp4zjWeK6/lWA
         GflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k27ZAsrfok5lqbiX1m5u8MlcU7L7zjUrrltAsSQGuuw=;
        b=HRnbTHyg6XUfjwY/XI4Q9Mou1gmATMbY/TXJT+ILZiKYKae1k7JbnR6MkAzs5A4BGL
         aLkhh3+xT4xnOfb/DR3KP5TRsARDEQRUavcPxtWldXxlQMvV4643Oejd1Bgrjs2HTUo/
         1E5d7MRjQeuNlg2Jc5kim0WDJIlkFC2F0Qf+6nfZZ6z3Xhb8LuwIe8CaeH1nKLSR/611
         FkZVO62kNv3IMh2f/7v7w8IhECZeCm/7kLdDWWOvBnWYYK1Tkl3grcA2IGc0IHxzAu0g
         1nfK1Nqv+OvX7+lNDzANBBzuENEChYBhYLXhy1dUJ/dR6e66JcwH1ItNucOu+PA5ZlUI
         RmnA==
X-Gm-Message-State: ABuFfojo4iDfI3ycMuLWoZ1JzWJbkLrwwOJn2UICc73VudD2rnwL2hpW
        qgTE9vl9ioCMZ9bTr37YlXLGktCjXPCTLXm2ibU=
X-Google-Smtp-Source: ACcGV63PjrGEVeVEd5xZDWu0Tnm44mJMNNJlgGWddHCiMODFdT9OJV6xawfnFVN2fSGIZ70keHZLfqgWOposXh7BH8M=
X-Received: by 2002:a02:a505:: with SMTP id e5-v6mr13791346jam.63.1538530809035;
 Tue, 02 Oct 2018 18:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181002145041.GC3889@infradead.org> <mhng-2b0c98e6-298b-4fc4-842c-809002de3451@palmer-si-x1c4>
In-Reply-To: <mhng-2b0c98e6-298b-4fc4-842c-809002de3451@palmer-si-x1c4>
From:   Zong Li <zongbox@gmail.com>
Date:   Wed, 3 Oct 2018 09:39:58 +0800
Message-ID: <CA+ZOyajMbaUrpPMeTgynyJpBtLh-19=VR=t0rq=bGcTmh0LF1w@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     hch@infradead.org, aou@eecs.berkeley.edu,
        Zong Li <zong@andestech.com>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@sifive.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=882=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:02=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, 02 Oct 2018 07:50:41 PDT (-0700), Christoph Hellwig wrote:
> >> The udivmoddi4 and umoddi3 are copies from libgcc in gcc. There are ot=
her
> >> functions use the udivmoddi4 in libgcc, so I separate the umoddi3 and
> >> udivmoddi4 for flexible extension in the future.
> >
> > Can you please mention which exact version of an external projected
> > you imported things from?  That will generally help if/when someone
> > has to dig into diverging versions.
> >
> >> +++ b/lib/udivmoddi4.c
> >> @@ -0,0 +1,310 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +/*
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License as published =
by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, see the file COPYING, or write
> >> + * to the Free Software Foundation, Inc.
> >> + */
> >
> > The SPDX tag was supposed to replace this boiler plate.  On the other
> > hand I'm surpriced there is no Copyright statement here - the FSF is
> > usually very good about having them uptodate in every GNU project.
>
> I suggested he import the gcc-4.2.1 version, which has a big copyright no=
tice
>
>     /* More subroutines needed by GCC output code on some machines.  */
>     /* Compile this one with gcc.  */
>     /* Copyright (C) 1989, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999=
,
>        2000, 2001, 2002, 2003, 2004, 2005  Free Software Foundation, Inc.
>
>     This file is part of GCC.
>
>     GCC is free software; you can redistribute it and/or modify it under
>     the terms of the GNU General Public License as published by the Free
>     Software Foundation; either version 2, or (at your option) any later
>     version.
>
>     In addition to the permissions in the GNU General Public License, the
>     Free Software Foundation gives you unlimited permission to link the
>     compiled version of this file into combinations with other programs,
>     and to distribute those combinations without any restriction coming
>     from the use of this file.  (The General Public License restrictions
>     do apply in other respects; for example, they cover modification of
>     the file, and distribution when not linked into a combine
>     executable.)
>
>     GCC is distributed in the hope that it will be useful, but WITHOUT AN=
Y
>     WARRANTY; without even the implied warranty of MERCHANTABILITY or
>     FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>     for more details.
>
>     You should have received a copy of the GNU General Public License
>     along with GCC; see the file COPYING.  If not, write to the Free
>     Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
>     02110-1301, USA.  */
>
> so it looks like something went wrong here.  Zong: did you go back and
> re-construct this function from the GPLv2 source?

Yes, I re-construct this function from GCC 4.2.1. The copyright part,
I referred to the other GCC routine copies in kernel such as ucmpdi2,
muldi3, ashldi3 and so on, I found they removed the 'GCC' string, so I
use the same copyright from these files.
I will re-write the copyright part and submit the next version. Thanks
to all for help.

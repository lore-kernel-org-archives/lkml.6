Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A569C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D492083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5IIXnst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D492083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeIYIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:25:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37608 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeIYIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:25:17 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so19272483iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 19:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ats3+gpwbZ5gzRUR6x1QFognv12Bup3QDkm7l/izQDE=;
        b=C5IIXnstkqMWL8n+UDcgE4W3LDFlLPyAk/KqIBISFWhKu21RNf4M6NvLz+WKFS/IQN
         CPJyxh+MJb4q89RpvUzpuBrqxJAfogtnreGy4MdIOFpSKVK9ztL+ticn4ur2uLAKTS7+
         mAusmeCupu6j1aPbYN9Jd/R0WGwlE6j0tmIjyXdEy+5awukMfYXrrBEUfYVRF9Mwi+mH
         0OsOzooKqZtT2lVjzSEflctKifs4oSBjU2fdTWVRxPyYg5FTprhOr1PszooQyzwg8Vgu
         vT+6i/n4GhEPk6vjILSv65ua52FDxCaKvAsy8mfdk4/MIrqB7pVOmRlD1ZT3HZNALR8P
         HIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ats3+gpwbZ5gzRUR6x1QFognv12Bup3QDkm7l/izQDE=;
        b=R6QX2INItKuMTed1Jt5qFhHIceUzJbeC9pdUTJftpY33XaIkhF1fXACFx3XjupxfbX
         BuhTX2ZUeWwbisMlSMal7WZ3dYQg5BSRkzt+p3E1U5BFodQrB2/MoGD2z7wTmkZ94/3O
         sydYls8XNDAD7AZDJOyy8WewX8O122urlJviWvq2kB8EI3rL9I5b8L1nHa+Rbtz+QzkY
         xXVS42E8hurPMTjnF3G1zogZYl0blWDS+UT080vsmtmNDUJgr8AnVtwypF+GWl68eal6
         keKFMY5TEX6hgKuEgYwx6Pp1HvWxrOAtX+es1bZ7fXOzU5ufZaLs0PtkEdDAQAATXo9S
         KlEQ==
X-Gm-Message-State: ABuFfojMPpGR0eeEkiImQlHHgyMaFkJSfx40gd4tJlqF/T9x18zy4fnO
        BUNWV11IlKJkkCGXDsbL6tiqA6udBoAKOmsWleA=
X-Google-Smtp-Source: ACcGV63uiDRlTWF/ppOFgTC7sAfwDqSWYeKMvIiW+0GDiBjKQsOEK2AuI1pH9mxhLmRQSj6hueyJL8PPJqi4BUhEFLI=
X-Received: by 2002:a6b:9ace:: with SMTP id c197-v6mr1348095ioe.63.1537842006814;
 Mon, 24 Sep 2018 19:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537260207.git.zongbox@gmail.com> <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
 <20180921070006.GC8401@infradead.org>
In-Reply-To: <20180921070006.GC8401@infradead.org>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 25 Sep 2018 10:19:55 +0800
Message-ID: <CA+ZOyaiJv-NZWk3ec_3zhRTSn7G-NGgyaiPTXOmuWfTWD7KSJw@mail.gmail.com>
Subject: Re: [PATCH 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
To:     hch@infradead.org
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, vincentc@andestech.com,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> =E6=96=BC 2018=E5=B9=B49=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:00=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, Sep 18, 2018 at 05:19:15PM +0800, Zong Li wrote:
> > Add umoddi3 and udivmoddi4 support for 32-bit.
>
> This probably wants a better explanation of why you need them.
>
> > index 0000000..69f2d36
> > --- /dev/null
> > +++ b/lib/udivmoddi4.c
> > @@ -0,0 +1,291 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Who wrote this code, where does it come from?

The RV32 need the umoddi3 to do modulo when the operands are long long
type, like other libraries implementation such as ucmpdi2, lshrdi3 and
so on. I encounter the undefined reference 'umoddi3' when I use the in
house dma driver, although it is in house driver, but I think that
umoddi3 is a common function for RV32. The udivmoddi4 and umoddi3 are
copies from libgcc in gcc. There are other functions use the
udivmoddi4 in libgcc, so I separate the umoddi3 and udivmoddi4 for
flexible extension in the future.

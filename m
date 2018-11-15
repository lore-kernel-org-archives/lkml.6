Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C5FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667F220883
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="XEthsVL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667F220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbeKPGhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:37:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38065 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:37:13 -0500
Received: by mail-it1-f195.google.com with SMTP id k141-v6so31217243itk.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 12:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cafcOmuLYw/QUgVJslWZRnzNm+HBqhgujYm2tJCmbX4=;
        b=XEthsVL8wm6O5L+a6JpBLmCNep8SfInq6yj1zz3eh1XbRQ43NWG56YH96KXtp0TPCN
         4BR6EYlCGzDWrnHoMfUD/7nryFIZWiFI7PKm5P33WH12TyB7E0/OegXjGjyZD96sFU/8
         J1rpAA2KlyJbCtAodl4CeG7Q+lH/IjzYWhU72+EUZRX3onToBlu/uVSwTxg0y0YAcxG1
         aQFrTuyuurxFIK5iZPmN4fPAp7rh2CmONXpUh5Yx44EKTGGYVwpdksm5U9PpP+eoDRpL
         eFSwkE3NcDGoH2F5leI8jywPKmVgdbfbfDfyBTY6GwfPDq9VpRLLXZXMk+0EW+tOKlSN
         5Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cafcOmuLYw/QUgVJslWZRnzNm+HBqhgujYm2tJCmbX4=;
        b=HbSsOLTkd55wBBbLahBzBizEvEqXciUqpG1f1F6jzSgAtO9FA7o3sh3pd9cQ1DmKGh
         UvuVJQ01zKUbzLXxROSwVCI9Mwn/fWySZpu+iWRawEF9k6Ot0QhrKFiFO+E+cIhhUvLT
         /DXgOWOA2Snun5D5Bn+gOqkp5gVXixrXwJNmffTtbMKlGUqsM2AbSvGAVnR2vI7c9WQz
         qLsO9B0Tek67USKM+4VJzVl4Ou5Wvr6BJJYjOU69oFaiAOQeoDE6RU8gktXHrzl1+WDo
         yqR5zQLivhp3aXHnogyLaBptwjLFbKvPk/qZtSJifxA1Agex9KlL5viHVkXNpjJP9+vH
         /kJg==
X-Gm-Message-State: AGRZ1gKlKqEA8RVId7ef3rAOWA0bB7GZcsVP2xgdQGlZVM5qd827pHz8
        HNZsaWA78Mct2tD6G+cFrx3x1rG1ok0zM03wA3noEw==
X-Google-Smtp-Source: AJdET5fj58LY7c8mSvxcWVowcMbBbAhv7v6PervL0csf1W8ikXXqOKtpviOHETrBeM5F5M45gb0d2unWfDljDkrMNtM=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr7008396jak.10.1542313673351;
 Thu, 15 Nov 2018 12:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20181115002755.24195-1-olof@lixom.net> <mhng-4c28d7f1-e034-4506-9ace-40fc2abd1668@palmer-si-x1c4>
In-Reply-To: <mhng-4c28d7f1-e034-4506-9ace-40fc2abd1668@palmer-si-x1c4>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 15 Nov 2018 12:27:42 -0800
Message-ID: <CAOesGMgCM57JNn2_MV8PL+zu6h2i3=saawbdmA3rgEJBUOfreQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix raw_copy_{to,from}_user()
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 6:59 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 14 Nov 2018 16:27:55 PST (-0800), Olof Johansson wrote:
> > Sparse highlighted it, and appears to be a pure bug (from vs to).
> >
> > ./arch/riscv/include/asm/uaccess.h:403:35: warning: incorrect type in argument 1 (different address spaces)
> > ./arch/riscv/include/asm/uaccess.h:403:39: warning: incorrect type in argument 2 (different address spaces)
> > ./arch/riscv/include/asm/uaccess.h:409:37: warning: incorrect type in argument 1 (different address spaces)
> > ./arch/riscv/include/asm/uaccess.h:409:41: warning: incorrect type in argument 2 (different address spaces)
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  arch/riscv/include/asm/uaccess.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> > index 473cfc84e412f..8c3e3e3c8be12 100644
> > --- a/arch/riscv/include/asm/uaccess.h
> > +++ b/arch/riscv/include/asm/uaccess.h
> > @@ -400,13 +400,13 @@ extern unsigned long __must_check __asm_copy_from_user(void *to,
> >  static inline unsigned long
> >  raw_copy_from_user(void *to, const void __user *from, unsigned long n)
> >  {
> > -     return __asm_copy_to_user(to, from, n);
> > +     return __asm_copy_from_user(to, from, n);
> >  }
> >
> >  static inline unsigned long
> >  raw_copy_to_user(void __user *to, const void *from, unsigned long n)
> >  {
> > -     return __asm_copy_from_user(to, from, n);
> > +     return __asm_copy_to_user(to, from, n);
> >  }
> >
> >  extern long strncpy_from_user(char *dest, const char __user *src, long count);
>
> Oh, no idea how I missed that one.  This looks like it's been in for a long
> time, so I'm surprised anything works at all!

Actually, it boils down to a memcpy either way, it's just that
exceptions and access control isn't handled right. So as long as you
always do valid copying you'll luck out.

> I'm going to add a stable CC and PR this to Linus this week, assuming I get
> some time to at least give it a minimal test.
>
> Thanks for catching this!

Cool, sounds good.


-Olof

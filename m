Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2BEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1DC214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="RpRn4gfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1DC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJJOyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:54:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42873 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:54:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id g15-v6so4446066wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uDoXhOY1HKxBE1+olcKcA5kZ/y41yfT31fitnlAFeAk=;
        b=RpRn4gfUjvF20X1JdDc2ttnjQzMxKEhmd01peFCPIoManLVFdTqwXc7FaDOCJumJpM
         dGgjeNc7k0Zo5YViSwO/wm2FwhgAIEV5+bawb5cxHGgAQp9M85FnsWcxiwq34e1xiTIG
         mTABgWRPdUDlXmSuxxI84sViU8s/1vGADLuglIjqv3kE6sOytXZ8hNYAsTy5Zgubh4Jo
         5kxAVCNdtQsOPyBkbHOuAlXaYZLtsQVBxkETyq3qCQE1oVbGGsThKCEhJ3LERSrAPcZL
         Z1aIJ/6USPaDH3/z5+sPFYfRqhpRwkjmD8/eoX4BN+iGs8X+BZLm+S/RVFVNX+PTa2VE
         oLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uDoXhOY1HKxBE1+olcKcA5kZ/y41yfT31fitnlAFeAk=;
        b=fbqsnbLX357GeKedtzEr65sR4UdOwAHOlTZmhCHS3U4yayto/OaXRc6lY3Uwp5ui41
         l/efi6j5WW2NhQNoXLUf0DqyyaBKAp1QB38+oebgIOXWzBK726ixZnM0A8xXQ5PkUslZ
         9c+HuBdlbdIemfz7XEuuHGrdwtfay/KbDOi4oBHAG6c6zg5uWPltRUw+tX5vwr6/43DT
         QP8QVse/Wln3WN4PleYRHt/poM7hCvf7OiJdqERvpQPZOM2g8uLPaSnjZA5RZJa9QMSb
         syUR/v0TYCTHVZnuQxwHX0/Od+HsSnZ3TlhK1RJBgfiBUM8xunZ/ah1mhZMKSvYYeCCl
         dTSQ==
X-Gm-Message-State: ABuFfogth19aSi+2jEQgj8a6j1LGxzWFO+AfaEtoDJU3Z/clsB6Emv/Q
        bLG6H+kAaIQN3xAbbr0K5/m6DC+NpI0fDC/j2mQHfw==
X-Google-Smtp-Source: ACcGV63X7UnUymPvFfyglyP+nho6zA32RMZaOL8TQqAB1bN0XPJ0CD5ioGElkBrfEzQMHRmTP0GKOtlsqn5kmOpuVhU=
X-Received: by 2002:adf:e94b:: with SMTP id m11-v6mr22961145wrn.126.1539156797628;
 Wed, 10 Oct 2018 00:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <1539095291-9926-1-git-send-email-jinpuwang@gmail.com> <20181009161336.1abf11d48a9adf40486c30eb@linux-foundation.org>
In-Reply-To: <20181009161336.1abf11d48a9adf40486c30eb@linux-foundation.org>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Wed, 10 Oct 2018 09:33:05 +0200
Message-ID: <CAMGffEn-ojiO7+T6Y=e5V=CkowF4g05iG2cB7wv1_1f0FypwXw@mail.gmail.com>
Subject: Re: [PATCH] lib: memcmp optimization
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wang Jinpu <xjtuwjp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Florian=2DEwald_M=C3=BCller?= 
        <florian-ewald.mueller@profitbricks.com>,
        linux-kernel@vger.kernel.org, jannh@google.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 1:13 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Tue,  9 Oct 2018 16:28:11 +0200 Jack Wang <xjtuwjp@gmail.com> wrote:
>
> > From: Florian-Ewald Mueller <florian-ewald.mueller@profitbricks.com>
> >
> > During testing, I have configured 128 md/raid1's and, while under
> > heavy IO, I started a check on each of them
> > (echo check > /sys/block/mdx/md/sync_action).
> >
> > The CPU utilization went through the ceiling and when looking for
> > the cause (with 'perf top'). I've discovered that ~50% of the time
> > was spend in memcmp() called from process_checks().
> >
> > With this patch applied, it drops to 4% - 10%.
>
> Which CPU architecture?  Most important architectures appear to define
> __HAVE_ARCH_MEMCMP.
x86_64 is our case, I should have documented it more clearly.
>
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -852,7 +852,7 @@ EXPORT_SYMBOL(memmove);
> >   * @count: The size of the area.
> >   */
> >  #undef memcmp
> > -__visible int memcmp(const void *cs, const void *ct, size_t count)
> > +static inline int __memcmp(const void *cs, const void *ct, size_t coun=
t)
>
> What the heck does __visible do?
>
> >  {
> >       const unsigned char *su1, *su2;
> >       int res =3D 0;
> > @@ -862,6 +862,20 @@ __visible int memcmp(const void *cs, const void *c=
t, size_t count)
> >                       break;
> >       return res;
> >  }
> > +__visible int memcmp(const void *cs, const void *ct, size_t count)
> > +{
> > +     const uint64_t *l1p =3D cs;
> > +     const uint64_t *l2p =3D ct;
> > +
> > +     while (count >=3D sizeof(*l1p)) {
> > +             if (*l1p !=3D *l2p)
> > +                     return __memcmp(l1p, l2p, sizeof(*l1p));
> > +             count -=3D sizeof(*l1p);
> > +             ++l1p;
> > +             ++l2p;
> > +     }
> > +     return __memcmp(l1p, l2p, count);
> > +}
>
> This is going to do bad things if the incoming addresses aren't
> suitably aligned.
>
Right, as you said, this is easy to fix.
> Certainly, byte-at-a-time is a pretty lame implementation when the
> addresses are suitably aligned.  A fallback to the lame version when
> there is misalignment will be simple to do.  And presumably there will
> be decent benefits to whoever is actually using this code.  But I'm
> wondering who is actually using this code!
>
I found recent discussion about why x86-64 is using generic string
function here:
+cc John, x86
https://lkml.org/lkml/2018/10/3/818


--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens

Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C1CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CB02080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpwOqZD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CB02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJ3Sbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:31:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35854 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeJ3Sbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:31:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so12641083qth.3;
        Tue, 30 Oct 2018 02:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D7sRCRfkLjX59rxFaCLiPuM4AbNsja0oLNKnwplcX3Y=;
        b=FpwOqZD9jVZkKySblM8uKwFcgaXzpGxgwj8mFrGLyErZO5VhtkzgxuEzGIiqCsJb92
         xdpDGvUqVHu9hVtfJLfP2FkedG894BXpqc+eeVXvLyTeFhD7U3xeqDJ/MW04q0lTrPz5
         g4o4ezMvk00wccC4UyGN45iGtBFDgA1KW0Iicr1ygGpE58fNQklYuJzKK8IIoUlWKgsl
         z0LAjMDzoYrBNT3txBRAQfGhEHUu16eAylUYkggnH6TIq4dlIRe1BhIdZIiEG9/SzkKh
         gRwbIcQKRb475sGVNTWoRipZJYjo3oz+CuTX1rAhcq4vXGeDXdjiZittu4bFxaxm2hiR
         X7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D7sRCRfkLjX59rxFaCLiPuM4AbNsja0oLNKnwplcX3Y=;
        b=pPKnCZnA97Q5dXoOkn1gmgygdMqWWNKPGhpzaseQbVT9E19Y/Zkl0q7dQHgsG6Ue4+
         cJuJJy/IXYVxRf9igB434+jiqZnokbEbkbWJO81uJzFrBzk0xgLZk5MRx8zsbMJkTrOk
         D4vkK8jjBozhkbeFcm28HOgbM1Kry2YDXzDWRkgi/GMxdZtpyOKZmBXElNzGg/gWmPKl
         pmO8ljcOW8x47B2RTVY2UkhS0BA34Fkttq61+6n4IaXmMLaHCn2Cq4eP8ewcY6lbgFrK
         h60w/8JbB6hdsdjBmtqjii+FF/6A3PgXqtWqxhxdG5K5cjPizHz8hQBaUFayewXbCx9g
         K/cg==
X-Gm-Message-State: AGRZ1gJDuaUiQx3N0bfF8SPrbGb6HJTnfQ4ITqSPXn9qs+kAbVBd7kWn
        fek82/Ns4M/GC2J3hLCSelbvjuc3TM1LRiB1lbc=
X-Google-Smtp-Source: AJdET5fONHZ/A7ez0Zu3dk1CJ9IpCFW7koVQ6ypXQ/jPVVU8qgltvEAF6KRZiKSRJpWC1VUVQWBrJ7PgIB8yuL4UERE=
X-Received: by 2002:aed:3b4b:: with SMTP id q11-v6mr1496289qte.229.1540892351454;
 Tue, 30 Oct 2018 02:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
 <20181006065113.669-3-rajneesh.bhardwaj@linux.intel.com> <CAHp75VcLN6g-6FJsVgxPZRV675N6YQzxsbm19BWgKhpiYfmG3w@mail.gmail.com>
 <7d7d59a3-241d-9753-24e0-74a8f0fc9df6@linux.intel.com>
In-Reply-To: <7d7d59a3-241d-9753-24e0-74a8f0fc9df6@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 11:39:00 +0200
Message-ID: <CAHp75VdXCXHYGuM8+iT13MdPrndTDoXUF8B_Hyb-uo8RXRHsoQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 9:40 AM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:

> Thanks for your review. My comments below.
>
> If you agree then i can quickly send v3 addressing all suggestions so we
> can make it in time for 4.20 merge window.

I don't like `quickly` part =E2=80=94 usual way to make the last minute mis=
takes.
How long does testing take?

> On 19-Oct-18 6:04 PM, Andy Shevchenko wrote:
> > On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> The LTR values follow PCIE LTR encoding format and can be decoded as p=
er
> >> https://pcisig.com/sites/default/files/specification_documents/ECN_Lat=
encyTolnReporting_14Aug08.pdf
> >>
> >> This adds support to translate the raw LTR values as read from the PMC
> >> to meaningful values in nanosecond units of time.
> > While I have pushed this to my review and testing queue, it needs a
> > bit more work. See my comments below.

> >> +       u32 scale =3D 0;
> > Redundant, see below.

> >> +       if (val > 5)
> >> +               pr_warn("Invalid LTR scale factor.\n");
> > if (...) {
> >   pr_warn(...); // Btw, Does it recoverable state? What user will get
> > with returned 0 as a multiplier?
> >   return 0; // Btw, is 0 fits better than ~0? How hw would behave with
> > this value?
> > }
>
> We show 0 LTR for invalid scale as PMC output is junk sometimes.

> >> +       else
> >> +               scale =3D 1U << (5 * (val));
> >> +
> >> +       return scale;
> > return 1U << (5 * val);
>
> We intend to return 0 so for invalid LTR scale. This will make retuen
> non zero and we dont want that.

And my example, if being read carefully, doesn't alter that.

> >> +}
> >>          for (index =3D 0; map[index].name ; index++) {
> >> -               seq_printf(s, "IP %-2d :%-32s\tRAW LTR: 0x%x\n", index=
,
> >> -                          map[index].name,
> >> -                          pmc_core_reg_read(pmcdev, map[index].bit_ma=
sk));
> > We use 32 characters for the names. Here are two minor issues:
> > - inconsistency with the rest
>
> intentional.

I understand that, but this is not like the rest is printed.
OK, this is bikeshedding, it's your call, but keep in mind the
avoidance of ping-pong programming.

> > - ping-pong style of programming (you changed 32 to 24 in the same
> > series where you introduced 32 in the first place).
>
> This is because the formatted output looks better with this width. I
> used 32 for the earlier patch because its consistent with rest and also
> does not look bad on screen.

See how it looks like with my proposals below.

> > After you remove the index, it would give you 4 more characters,
> > though it 4 less than 8 you got from reducing 32 to 24.
>
> I plan to keep the index as is. Reason for this is mentioned in previous
> patch that introduces this index.

No, please don't. We have a numerous userspace tools which are doing
this pretty well.

> >> --- a/drivers/platform/x86/intel_pmc_core.h
> >> +++ b/drivers/platform/x86/intel_pmc_core.h
> >> @@ -177,6 +177,11 @@ enum ppfear_regs {
> > It might be good idea to include linux/bits.h here.
>
> Certainly. Luckily 0day bot didnt complain about randconfigs etc so is
> it really needed as it will increase size?

You are lucky because of ordering of inclusions. This is fragile.
Since you are using macros from bits.h better to explicitly show this
dependency.

--=20
With Best Regards,
Andy Shevchenko

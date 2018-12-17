Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3235EC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008FD2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="XNGLOS8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbeLQQbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:31:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37210 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeLQQbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:31:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so6624480pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vcCz+tZEuR+GAAEezOii7FCCv5K+K+Thbrld+WbJel8=;
        b=XNGLOS8IJetpsHz47/xIHOYwP7ULYi4EaZIRxT66+u0MDlmG6EU+RQLfGWdvQ/8PPa
         agQeTU1m8Mgsfg1KyktkrgFojdTpfPnEersV3IyyL3a5mbd+/UF2Oz1f9kU4dMstsPUt
         S1QUOGFwrIkG7m6lz6c/jUzCE1Q0rru39jJAARe+eObJGVL+pWd23fSwRbuBKj7qfUco
         hOP1hpwPFAZD21WEPCGVCdkVAZDCCT1AsDQ2Ej0ZEHreS9/b35U42RVT/6beZEZql68p
         GcQP/hfPZAAkMRjyaTDQUwDIgmFZws6FeI1l4tt9Jh+AyrEQCgBHDfR3+pplZrCZBX+L
         ZiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vcCz+tZEuR+GAAEezOii7FCCv5K+K+Thbrld+WbJel8=;
        b=n277J3RYg6c8Djb5CVIF1acws5sFaqPRgKj/L5u+n28TVKHdNnKNPTMjHz1ALx8q55
         0KChyutxMuz7zvi1xFDeXlwdIhISUIiElVo9Ft7D6ITwtNpt1NiJ+a8JvHgL3bQ6S+eL
         c4pPDNtTAbg8aWj61NeZQmB39+nZ6X3ZtseVw5LWB59RuotyJG+wcEVvvLqZ+sOAkGkf
         TMJGDTKIuZZZEn24JP6GdSy7C6R5FfecUGlk8tc92IYNBqUlHlippCVbY6KesOrpND6m
         4il7r91ordRIp5BNdR2bm8pH1IaTt8I/WV2Hc8ILnm/369pY7SVZeP0E9EGQhPjYkXB3
         T3nw==
X-Gm-Message-State: AA+aEWawm7ddmI+e2jVZP+SBqIelHEJ+lWN+dh5ziUM8qbAMcStT4pDX
        FEaxVBLCEOWlRdVC3zCwklMeKuXyqGEtZYsBiDmzzo0YrGQ8tQ==
X-Google-Smtp-Source: AFSGD/X+aUlS5pBoU6qeYqdjNQgayb7myuwarMjXKPbSAKCK1CfNOcPn07G5TVgkMimRiEHpR3k7JeHBn+iHQa+TqXQ=
X-Received: by 2002:a63:a002:: with SMTP id r2mr12517212pge.212.1545064264409;
 Mon, 17 Dec 2018 08:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com> <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop> <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop> <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
 <20181216223510.hxsdotf332ousinh@pburton-laptop>
In-Reply-To: <20181216223510.hxsdotf332ousinh@pburton-laptop>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 17 Dec 2018 13:30:53 -0300
Message-ID: <CAAEAJfDHvGTPN9u4zwWRFvK1WmpLmz87CjsjzmyhcExTGHQPmA@mail.gmail.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"
To:     Paul Burton <paul.burton@mips.com>
Cc:     Marek Vasut <marex@denx.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018 at 19:35, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Ezequiel,
>
> On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
> > On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
> > > This helps, but it only addresses one part of one of the 4 reasons I
> > > listed as motivation for my revert. For example serial8250_do_shutdow=
n()
> > > also clearly intends to disable the FIFOs.
> > >
> >
> > OK. So, let's fix that :-)
>
> I already did, or at least tried to, on Thursday [1].
>
> > By all means, it would be really nice to push forward and fix the garba=
ge
> > issue on JZ4780, as well as the transmission issue on AM335x.
> >
> > AM335x is a wildly popular platform, and it's not funny to break it.
>
> Well, clearly not if it was broken in v4.10 & only just fixed..? And
> from Marek's commit message the patch in v4.10 doesn't break the whole
> system just RS485.
>

Careful here. It's naive to consider v4.10 as old in this context.

AM335x is used in hundreds of thousands of products, probably
"industrial" products.
Manufacturers don't always follow the kernel, and it's entirely
likely that they notice a regression only when developing a new product,
or when rebasing on top of a newer longterm kernel.

Then again, I don't have any details about what is Marek's original fix
actually fixing.

Marek: could you please post the test case that you used to validate your f=
ix?
I can't find that anywhere.

> > So, let's please stop discussing which board we'll break and just fix b=
oth.
>
> I completely agree that would be ideal and I wrote a patch hoping to do
> that on Thursday, but didn't get any response on testing. It's late in
> the cycle hence a revert made sense. Simple as that.
>
> Thanks,
>     Paul
>
> [1] https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-=
laptop/

Well, I think this patch a lot of sense. But since Greg wants to
revert Marek's fix,
it would make sense to collate both Marek's and Paul's in a single commit.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar

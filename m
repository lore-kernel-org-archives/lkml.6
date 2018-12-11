Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD430C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A501F20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lb+FixOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A501F20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeLKNBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:01:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35098 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeLKNBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:01:50 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wBBD1ksO004846;
        Tue, 11 Dec 2018 22:01:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wBBD1ksO004846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544533307;
        bh=No9xOhJADUYQeHm2q3q2ynI3sayEoRJ+pXaBMGBljCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lb+FixOrBgg97ttnpnivs5864b9r2MhlESMWaRu/vJ5TpGvgnZQEFx2xyLjcMYXDI
         TUQrJleNlffuVgth39BJ9HXSv24btz4yTALdIvlUqrAjsQRMDEiVGnBohqkqmV0ZlC
         62S41MTqd3RYiqhoxo8+aVzmLqSbh3tnb2npehRIzSECxntBWQX8LC/TPZv302vZWh
         fg2BmgoFZd+ktOcmAPqglkJjl3ZozzT0w0gpyVjnEfC0tz8meDhmLoxWmqPNFjK0OA
         BW1VGdQBhZFaiJ+n/hMuh3K07uCA8b26XDIAH4AZ/ktPwxo8UoSmAYim1JwlTz1wca
         vlAqIe1aVXchg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id n10so8776923vso.13;
        Tue, 11 Dec 2018 05:01:47 -0800 (PST)
X-Gm-Message-State: AA+aEWY4Y/GFpmqFW29jjHCK4RRP2uUxGitxYphWo6FuaAoplgwz+MB9
        xiM+Kecz2WxIJ8w5c29tCoOVios27/Cz9VjHGsA=
X-Google-Smtp-Source: AFSGD/XP7u3JBH12nJ0I5BYvwn3D60VRK66r/aWrfTZsLKYhiXSQayAnbl9E7N2yFafU4+fcRJUGlQ65tHVN9vjdi9I=
X-Received: by 2002:a67:485:: with SMTP id 127mr7388150vse.54.1544533305718;
 Tue, 11 Dec 2018 05:01:45 -0800 (PST)
MIME-Version: 1.0
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-2-git-send-email-yamada.masahiro@socionext.com> <20181206180459.GA19166@ravnborg.org>
In-Reply-To: <20181206180459.GA19166@ravnborg.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 11 Dec 2018 22:01:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8RjUkc57CWi_rnLopGSQQBtgerYJO+F7_0MD+p=NFxA@mail.gmail.com>
Message-ID: <CAK7LNAQ8RjUkc57CWi_rnLopGSQQBtgerYJO+F7_0MD+p=NFxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: generate asm-generic wrappers if mandatory
 headers are missing
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,


On Fri, Dec 7, 2018 at 3:06 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Dec 05, 2018 at 08:28:05PM +0900, Masahiro Yamada wrote:
> > Some time ago, Sam pointed out a certain degree of overwrap between
> > generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)
> >
> > I a bit tweaked the meaning of mandatory-y; now it defines the minimum
> > set of ASM headers that all architectures must have.
> >
> > If arch does not have specific implementation of a mandatory header,
> > Kbuild will let it fallback to the asm-generic one by automatically
> > generating a wrapper. This will allow to drop lots of redundant
> > generic-y defines.
> >
> > Previously, "mandatory" was used in the context of UAPI, but I guess
> > this can be extended to kernel space ASM headers.
> >
> > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Nice work!
>
> For the full series:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> Have you considered to warn if generic-y contains a header listed
> in mandatory-y - to prevent that they sneak back in.
> And to catch when we lift a header from available to mandatory.


Yes, I also thought of this,
and probably we should do it.





--
Best Regards
Masahiro Yamada

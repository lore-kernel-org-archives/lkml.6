Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F69C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D56206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNOw7caF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfAIUFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:05:19 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39230 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfAIUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:05:18 -0500
Received: by mail-vk1-f196.google.com with SMTP id s184so1959044vkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ir2gy1vI+QuEjLbaEs5X765OOqWePEa4uQXeCPwMJG4=;
        b=lNOw7caFXMuA6Gl7KQBr0CksbMGZLvtGfgLF74Td414lwed/G2VRgCI09yjhM454Dd
         hbPRb4NaqSNz4MMly3zdrmWJ5kHlN/oOEsKkzSRMkgNVgFoGYOEiFi2pka9FFNu+pvUq
         ZELyesivcCvJ7LJhPXU2JLBlBDhztkvan2Zjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ir2gy1vI+QuEjLbaEs5X765OOqWePEa4uQXeCPwMJG4=;
        b=PQfYXj4Tn6EwWTUMfyH4/xdN6hRppuRLWLoR72tfXEfmoD8z/vy+3PydBIctMtOVTh
         pNLIyBqqd7Llv9533jUEpdaRiRIh9HXwOD9nAtWJYFfrbytWBacDNp3cyWd9bVjEmZ30
         NMq261gXallG1k2R65a7rqAifAoY8+/P0tMqVoBlGSjS9pSyoMz/DI4pNWE5bQEeNAA8
         JGOwd4HlgDjj163BMW+7YIXnNCmTd/ulfpwh1QicKXUp4MpP1isj6SNrYBA/72YNLW9R
         TwB9Ir/k4zmj2tdz2swxsbT1YbsDly+sJR2FkcLKdZ+5SPhmug/PbUeXBK/OP0GhREdz
         O+lQ==
X-Gm-Message-State: AJcUukflcMrkLUL6kwz7503QYDiIIr/EhoD+oRc9o4pwXF/QyDVbQbUC
        BxDv06whuUuzkyJMqEmrQYfeOB3CXO8=
X-Google-Smtp-Source: ALg8bN7fgho/Dgt5ISTp4NzYEb1r6QFDtmwT/UFEMO2F6OYeSOdUzcHfkF/uqBvVtdUMf7s12n/qrQ==
X-Received: by 2002:a1f:a147:: with SMTP id k68mr2766979vke.1.1547064316598;
        Wed, 09 Jan 2019 12:05:16 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id l197sm22054560vke.18.2019.01.09.12.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:05:15 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id p74so5575916vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:05:15 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr3106997vsl.188.1547064314501;
 Wed, 09 Jan 2019 12:05:14 -0800 (PST)
MIME-Version: 1.0
References: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
 <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
 <2d2e8cef-dd12-75e8-4779-fe4437e2169c@c-s.fr> <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
In-Reply-To: <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 9 Jan 2019 12:05:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK1En85PMUgHbzHoO2U84FiNoJLPF0rUXeyPaoY6GXEEA@mail.gmail.com>
Message-ID: <CAGXu5jK1En85PMUgHbzHoO2U84FiNoJLPF0rUXeyPaoY6GXEEA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 7:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 8, 2019 at 10:31 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> >
> >
> >
> > Le 09/01/2019 =C3=A0 02:14, Kees Cook a =C3=A9crit :
> > > On Fri, Dec 14, 2018 at 7:26 AM Christophe Leroy
> > > <christophe.leroy@c-s.fr> wrote:
> > >>
> > >> Introduce lkdtm tests for NULL pointer dereference: check
> > >> access or exec at NULL address.
> > >
> > > Why is this not already covered by the existing tests? (Is there
> > > something special about NULL that is being missed?) I'd expect SMAP
> > > and SMEP to cover NULL as well.
> >
> > Most arches print a different message whether the faulty address is
> > above or under PAGE_SIZE. Below is exemple from x86:
> >
> >         pr_alert("BUG: unable to handle kernel %s at %px\n",
> >                  address < PAGE_SIZE ? "NULL pointer dereference" : "pa=
ging request",
> >                  (void *)address);
> >
> >
> > Until recently, the powerpc arch didn't do it. When I implemented it
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D49a502ea23bf9dec47f8f3c3960909ff409cd1bb),
> > I needed a way to test it and couldn't find an existing one, hence this
> > new LKDTM test.
> >
> > But maybe I missed something ?
>
> Okay, gotcha. You're getting more complete reporting coverage. Sounds
> good to me. Thanks!
>
> Acked-by: Kees Cook <keescook@chromium.org>

Applied to my lkdtm -next tree.

--=20
Kees Cook

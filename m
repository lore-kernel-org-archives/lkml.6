Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC77DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32D72081D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="reOBAk4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32D72081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeKIMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:34:52 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:54898 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeKIMew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:34:52 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA92u3rS015674
        for <linux-kernel@vger.kernel.org>; Fri, 9 Nov 2018 11:56:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA92u3rS015674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541732164;
        bh=K3uyO8zUpB0oX7XdAwUVCiDQgtMnUDjV4A4PYE8o7Ko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=reOBAk4qv9Ia7JFPTDd1TcNs+ZD3146s+2P5hNtTbCzTHnj3LsysRw8BI4CERWxsF
         BQll06tDCXfVz8wCSB7awiBveBh2OC9LgctmLftz8Z3T1KaAslJ+NjkXVMT/oWYHEE
         h4WpRJrhs6lq4strVJQ3fprL0794yevu/4LYyYmOugYXuK4vuQI5YM3hdrb473Qr6y
         SccCFl3qwQyZ1ZWbEmVNAr6C/nnmX3blZptobyV3LnXw8Ly4nD72qB7zf28aALVBSE
         Okh6ea0r5jeweMmWpeObUdhTfC4g8IDT5kkJj3P/imrQuasJjGoCpjbUx/CwodicM+
         0OELXZmndL9bw==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id d8so147084ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 18:56:04 -0800 (PST)
X-Gm-Message-State: AGRZ1gJCBLSzGqL/Cm+Kv8EOZ3oaajfZrIQ9Y7iPk0XJpAO+CutqZqDe
        IMGaHRB1xmnf9YtbsY3rXHPqpiJQv8HoIJ2tK4k=
X-Google-Smtp-Source: AJdET5csFxomhzoIZZ0jyQvHceOCN5B3beNmBX8NRTgbWbBVDEWQKfH/KfLKzoYKzsfnacgcNmtfgok21W1GnC9AO+M=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr3425576uam.89.1541732163017;
 Thu, 08 Nov 2018 18:56:03 -0800 (PST)
MIME-Version: 1.0
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org> <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
 <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com> <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
In-Reply-To: <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 9 Nov 2018 11:55:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
Message-ID: <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Brian Norris <briannorris@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>, Genki Sky <sky@genki.is>,
        Guenter Roeck <linux@roeck-us.net>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 12:20 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Nov 7, 2018 at 1:18 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Wed, Nov 7, 2018 at 1:07 PM Genki Sky <sky@genki.is> wrote:
> > > On Wed, 7 Nov 2018 12:55:14 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> > > > Ubuntu 16.04 ships with git version 2.7.4.
> > >
> > > Okay. I guess --no-optional-locks is a no-go then.
> >
> > In theory you could wrap it.  If passing git with
> > "--no-optional-locks" doesn't work you could fall back to the old
> > code?  That would mean only people with newer git would get your new
> > feature and everyone else would stick with the pre-existing behavior.
>
> +1, that's what I was going to suggest. Presumably older git would
> give non-zero exit status for unknown flags, and we take that as
> signal to try to the old way?


I also like this idea!

I will pick-up this revert patch soon.


Brian,
Could you please send a patch on top of that?


Thanks!


-- 
Best Regards
Masahiro Yamada

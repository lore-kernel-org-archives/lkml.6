Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74364C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3728120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIuKJG/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3728120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbeKLFsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51913 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbeKLFsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:51 -0500
Received: by mail-it1-f195.google.com with SMTP id m34-v6so9844099iti.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67T0JvgBXVpGJM0JhAkd9LTJMveyQlsOlw1svrrNXUs=;
        b=XIuKJG/qIpVxUUZ7zPBF3TpHhN/yOk5pNsRvq/mItdjsJHLbrZ1XK79nZjEiYznTz7
         UI+IlmybWS6/Rcfbq6nnbjwMbq8u1SpHoFtacLZNheh5UwoBSM+tq/X4BGe52V5cVPgE
         pyIB6CSapEdXDYDLVcDUp8O3lTseZBPuBUJ1eMlWi0ypzQVP+35fVaqByMdTF3Tpcq9M
         SxxRSEJpZuRZsyKPpVKlGOAhOdN4NhxlFHpeoMPM85h2hKLzBYwCR6lOaUMiN1Jlo+Bq
         +jtOso39TUiDq6p6FHpAG9M4rPMivW1j5wAHVXLZpa+QbxFqpOgWE3F2qy85AjPBlmPh
         L0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67T0JvgBXVpGJM0JhAkd9LTJMveyQlsOlw1svrrNXUs=;
        b=EsPSDMyHT8bOYUwFVow+Xkmaf8Cn0S1ONFZtlX2ciUJvl4UFaKerCFyGND2UME/d/4
         8v6n48YOQODG/vyKyoWkJKQHwy5jJAcTIqf1X3BVzc4npg60PDqbWOBt+YsFaHZOY7e6
         BDcI1nFqjMkdWn/UasdBZIguXO1bCPVUf7hRsMaBbmlFrgItZ91i50tuBOQ96MRfuZM3
         nO4KZZJP89jOjnB7Famp4KRY2vhkcKVzIxPmQqlM2facQRyeWj4gqnpZM4MwELvbW+gd
         4Bq7tbl9HU8G5s2MlH79St0rgO6J4QSFgfH+2uw0Kl3eneEMj9AJ7tLBy83PAwZuLiWd
         pA7A==
X-Gm-Message-State: AGRZ1gLfC3p33A9GQYShZqI88dbETVM/qMjSaqfYJ84qUI8QIBQ8F2Ds
        MGeBoJH2FWz27610of4sQiwspJ2sPchL9vu742l7QNGo/2g=
X-Google-Smtp-Source: AJdET5epaIrrWWZozN1VXrJEF64rsSyjC3IWlJn82SqaAHPQwXzd63OxUuFejHrSUCH0S6EW1Fnmomcm64KAWdyL07g=
X-Received: by 2002:a24:5e93:: with SMTP id h141-v6mr9891113itb.103.1541966362900;
 Sun, 11 Nov 2018 11:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20181107022156.GA254567@google.com> <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
 <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
 <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
 <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
 <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com> <20181111.174140.002789201@genki.is>
In-Reply-To: <20181111.174140.002789201@genki.is>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Sun, 11 Nov 2018 21:59:06 +0200
Message-ID: <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     sky@genki.is
Cc:     schwab@linux-m68k.org, briannorris@chromium.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        dianders@chromium.org, Guenter Roeck <linux@roeck-us.net>,
        lists@nerdbynature.de, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 7:41 PM Genki Sky <sky@genki.is> wrote:
>
> Hi Alexander,
>
> On Sun, 11 Nov 2018 16:48:38 +0200, Alexander Kapshuk <alexander.kapshuk@gmail.com> wrote:
> > Piping the output of the git command to grep and using the return status
> > of grep as the test condition within the if block, would be sufficient
> > to determine whether or not '-dirty' should be printed.
> >
> > Sample run:
> > % if git --no-optional-locks \
> >         status -uno --porcelain \
> >         2>/dev/null |
> >         grep -qv '^.. scripts/package'
> > then
> >         printf '%s' -dirty
> > fi
>
> I don't think this works well for us. We need to check whether
> --no-optional-locks is available before using the output to determine
> whether the tree is dirty or not. If it's not available, we have to
> fall back on diff-index. Let me know if I'm misreading you.

It was I who failed to read the proposed patch in its entirety in the
first place. I did not get the full picture as a result. My apologies.

Would something like this work for you?

local git_status
git_status=$(git --no-optional-locks status -uno --porcelain 2>/dev/null)
test $? -eq 0 ||
        git_status=$(git diff-index --name-only HEAD)
if printf '%s' "$git_status"  | grep -qv scripts/package; then
        printf '%s' -dirty
fi

Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECECC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F220856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7Ze14El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738F220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJDI2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 04:28:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38346 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJDI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 04:28:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id h15-v6so7574870otj.5;
        Wed, 03 Oct 2018 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuNsoZwTAh5hwJxz70Ax20g6nWN91thSOj9I0FaDBnI=;
        b=s7Ze14ElCAnFIlf1+vu+ugm+UKMuIDxF8JoXN8EqESW5DSifKf/FxEXBvqVL7W7QSw
         F1yqbih4nEUCaRM0/PP9U4IvI+ddfXZkF8eEbXt+JzUztSC3Lf53LBwQinQCzQmuYKZj
         52FnmZ5dBybXCAkpv+Mn8Q5ngAj11S9LmidPQrqCQji/NXeNC2GdyRK8O1DlHytQw/SD
         LMp2yBOm3Ep6Ey2wBNziSl18lsD/FtxSdZaAcyYWif4wZH7qLMnUzcFE2yfCJUSe3Txc
         OBGWxu7atRaI3L28G0fEYYvRLY4C6O5ra7XQwtvRX/q7PbPAyA2xzoiNMhr9B/0Rwzka
         qTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuNsoZwTAh5hwJxz70Ax20g6nWN91thSOj9I0FaDBnI=;
        b=YLUsSRQFoVtgyO+/RqX6oq7gGiMekh1gJCeRWPNDwdtdbgcAwPd6+rcLo1yRhLKTzG
         69KIHqb4vbX8DaLXx0JgOPEWtCmQP6MlSus7u2woAICayMp6GH6NCFaIfiiVDx1GsZus
         rNQnmlI3kxk0yQxyJarnQVnL78bJwnaaCT8IfCFc0/x4QzPrsNS/XSpVHGbq1pYlMyYU
         wEtB2sQSZqVqt2cu835r08V7WyIGMjK/4JhcvB+4TugUtVTP4O8IY+nqXxj4WT4aJwV7
         v9LAkqhcBL9pPyT4Mvl4K72p3A47Kh1DacRmTmi/j50CN6jBQRR+SKfWDdUevpI+SxQ+
         exzg==
X-Gm-Message-State: ABuFfoijXUq2yu8z6txzYIUkiMsiR3iFpA1J/YgOHk67/eEmbk1MAeHt
        f7eT3C2UsKkmT8EHkXgUolPVe8WGrk9+CD27EE8=
X-Google-Smtp-Source: ACcGV60sCHHWrxBPUhVd7TidY4wrMGSUmW7aJVvs3jQ7JuXYSqhpF24ys9ZRkoe4z3gPlB5piMNj5VBRg2dfJ8RXdhA=
X-Received: by 2002:a9d:2568:: with SMTP id j37mr2516279otd.263.1538617062494;
 Wed, 03 Oct 2018 18:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180928020816.11251-1-leobras.c@gmail.com> <20181001075607.GA3776@rric.localdomain>
 <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com> <alpine.LNX.2.21.1810040915040.8@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1810040915040.8@nippy.intranet>
From:   Leonardo Bras <leobras.c@gmail.com>
Date:   Wed, 3 Oct 2018 22:37:29 -0300
Message-ID: <CADvQ+rE8qQmSangHOCrJo7aAD-BJiN3Gt2hCi-3O8uRTgXnP-w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Remove errors building drivers/DRIVERNAME
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Robert Richter <rric@kernel.org>, lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 8:27 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Wed, 3 Oct 2018, Leonardo Bras wrote:
>
> >
> > Sorry, I was not very clear at my reasons why this change is important,
> > I will try to briefly explain the whole story.
> >
> > Some weeks ago I was trying to solve a task that needed to change some
> > compiling options, build the whole kernel (allyesconfig) and look for
> > errors. The problem was: It would take a long time to build everything
> > in my computer. And many friends with slimmer laptops would take much
> > longer.
> >
>
> It seems to me that you shouldn't need expensive optimization for
> continuous integration. In theory that could make a big difference though
> I admit to no experience of build farms.
>
> Have you looked at ccache? It will save you from having to recompile any
> files not changed.
>
> You could also leverage all of your laptops together using distcc.
>
> HTH.
>
> --

Both ccache and distcc seem very interesting,
I will take my time to study them better as they can solve some situations
I face. Thanks for sharing!

Still, I believe my patchset is relevant, as it would enable people to rebuild
the whole kernel (with build flags changes, for example) at the cost of only
git-pushing the changes to a fork of my Gitlab repo, and waiting 3 hours.

Thanks for helping!

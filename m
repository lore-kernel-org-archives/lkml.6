Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A752177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aDtx0Aho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfBRJLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:11:49 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:16625 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:11:48 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1I9BYGn001558;
        Mon, 18 Feb 2019 18:11:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1I9BYGn001558
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550481095;
        bh=txfw+3Qns2GH3Sq09dJPnwjs7epjRgsd0dgXtzWLrxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aDtx0Ahoa1n3PS+OcF+kct4QCe4vWhDHcEOtOyIDtHZhB6e3fvpWSSaPKduC17Cbv
         JOzTI9uczEvz/3JV2lWRF3Fbqrf2L9uoTLs8WGAw4MFWiNbiJ9ICGnPNi3tjhyILIW
         Sp67KNZ2RatY5IK5ueoWYS0hvCohJW6SLjmCdUvrV//0v18zQoo0pEEtlsGYVLym8w
         lLB4p1dpSneOOw5s0/ULbBOHv5j2oQ1RuWUtjkTxR9jgM3ovkzqNXqtMpEzvqO4WQa
         xdAU3t9hepFfgJUK/OTQAmdhIcF8vbmjTRIMFk1R00TRJSGOls4g4giZ0fbuvEiyXF
         kewu/E5RS9rrw==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id z24so5558058ual.8;
        Mon, 18 Feb 2019 01:11:34 -0800 (PST)
X-Gm-Message-State: AHQUAuZV+SZvD/sFihFW/3xt61cf8+0FX2XMqftHWmq7aXjdoA6QMYxk
        9QPjCJNSRwOPApbhs7i70n9vbUmpqgt6vaWxz/8=
X-Google-Smtp-Source: AHgI3Iak8OCODXwJ2jBxyqPjEqg2obJ12O2zVGgMOGFzi6prAEbn6anLjav+EZKCvkVdIl+keqQ6Aaqjm7OQWCCAUFE=
X-Received: by 2002:ab0:748a:: with SMTP id n10mr11662647uap.89.1550481093770;
 Mon, 18 Feb 2019 01:11:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic> <20190201103648.GF31854@zn.tnic>
 <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
 <20190201151139.GK31854@zn.tnic> <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
 <20190202144227.GC27822@zn.tnic> <20190206104729.GC7314@zn.tnic>
 <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
 <20190210123923.GA14948@zn.tnic> <20190218083008.GB4265@zn.tnic>
In-Reply-To: <20190218083008.GB4265@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Feb 2019 18:10:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_UfHcin1G_fqEX0qZ-AFe7=GHfnHZ2QZu1oe=dZW-aA@mail.gmail.com>
Message-ID: <CAK7LNAQ_UfHcin1G_fqEX0qZ-AFe7=GHfnHZ2QZu1oe=dZW-aA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav,


On Mon, Feb 18, 2019 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Feb 10, 2019 at 01:39:23PM +0100, Borislav Petkov wrote:
> > Please attach the diff or send it from another mail server.
>
> So you couldn't be bothered to send me an applicable version so I went
> and typed it in by hand. Thanks. ;-\

I admit I must fix my unfriendly attitude.
Sorry for annoying you.


> Anyway, this variant works too, pls queue it.
>
> Acked-by: Borislav Petkov <bp@suse.de>
> Tested-by: Borislav Petkov <bp@suse.de>

Could you send v2 as I suggested?
Your commit log describes your motivation perfectly.

(I lost the applicable patch because
I just modified the code locally and pasted it
into the previous email.)



> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada

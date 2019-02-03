Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3718C282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3C92083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EcQA28LE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfBCBKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 20:10:09 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26818 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfBCBKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 20:10:09 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x1319oBQ004634
        for <linux-kernel@vger.kernel.org>; Sun, 3 Feb 2019 10:09:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1319oBQ004634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549156191;
        bh=18FpYkDargDhx0MFo8zA8waZMuZYQy/EEujlhdO9/CM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EcQA28LE9Pk/TmzbOazRFiYbuGZAWk06SomNW8eQV1BHrxSIlJFBAmyzw/cu7I2N3
         fQV3Blf5brN2IgXUcAvPcxY6zl9IOippm/517L6qqvDAHvmnOmKJ4OZeVWLkVlmilb
         2RqI3UWLCDs5SMmnA6bwBaLXN5nlYYGGMwTuiQWjqcBPbw1ummPdN62W66IMwtOytr
         MGwapUcXc7/hFzNB8ueGrGGbTkEs5iZF4K3sAtsR0SBmXSoKkx8UfEyhH979Obcz2P
         8d6D5I6zfoMoZpIFPr4Sg6MT8vXionLsMJRkr7Iwrw6jjkmVwndt3iR+yEzPOssLYq
         w6XE7MYYTcw1w==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id n13so6561403vsk.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 17:09:51 -0800 (PST)
X-Gm-Message-State: AJcUukdvRdhRSdTbtPGksMi43l9l17NnqELX/xMZuWCLTIQ+Iee9Rpog
        FC+Q9sjNNwftLzwM7BvRF5qE0HDxyR1vTrpNnTk=
X-Google-Smtp-Source: ALg8bN4DOv4Kx7xdR7TbCmE22YoPSPMggibhiCHWulEHmcioJwbSDbh1SAlHjf6YKZHaN9YwIKMbGFY4rZTitz4nHVY=
X-Received: by 2002:a67:385a:: with SMTP id f87mr19534466vsa.179.1549156190397;
 Sat, 02 Feb 2019 17:09:50 -0800 (PST)
MIME-Version: 1.0
References: <1549123585-13800-1-git-send-email-yamada.masahiro@socionext.com> <20190202163105.GA28518@avx2>
In-Reply-To: <20190202163105.GA28518@avx2>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 3 Feb 2019 10:09:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbDOAei0spqUVa2u3buKwS4uEPD5fXMLpEqcB-UapLTw@mail.gmail.com>
Message-ID: <CAK7LNATbDOAei0spqUVa2u3buKwS4uEPD5fXMLpEqcB-UapLTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] linux/kernel.h: use 'short' to define USHRT_MAX,
 SHRT_MAX, SHRT_MIN
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 1:33 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Sun, Feb 03, 2019 at 01:06:24AM +0900, Masahiro Yamada wrote:
> > The log of commit 44f564a4bf6a ("ipc: add definitions of USHORT_MAX
> > and others") did not explain why it used (s16) and (u16) instead of
> > (short) and (unsigned short).
> >
> > Let's use (short) and (unsigned short), which is more sensible, and
> > more consistent with the other MAX/MIN defines.
> >
> > As you see in include/uapi/asm-generic/int-ll64.h, s16/u16 are
> > typedef'ed as signed/unsigned short. So, this commit does not have
> > a functional change.
>
> > -#define USHRT_MAX    ((u16)(~0U))
> > -#define SHRT_MAX     ((s16)(USHRT_MAX>>1))
> > -#define SHRT_MIN     ((s16)(-SHRT_MAX - 1))
> > +#define USHRT_MAX    ((unsigned short)(~0U))
>                                          ^   ^
>                                          +---+
>                                            unnecessary ()


Thanks, I will remove it in v2.




> > +#define SHRT_MAX     ((short)(USHRT_MAX>>1))
> > +#define SHRT_MIN     ((short)(-SHRT_MAX - 1))
>
> "short" and "unsigned short" are probably the most useless C types.
> I doubt their usage should be promoted.



-- 
Best Regards
Masahiro Yamada

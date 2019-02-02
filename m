Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D23C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB6520863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hJYiDpNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfBBNsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:48:45 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30299 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfBBNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:48:45 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x12Dmc40007748;
        Sat, 2 Feb 2019 22:48:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x12Dmc40007748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549115318;
        bh=doJ1M/XOHwQC+L/0JMoJ6ZHPOGZBYh7HylTQNs1/Eno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hJYiDpNtuZ0GiJ69JqOGtFk8PmjnIaiW8PCTYIlpQqPqbUReye7pXQQnhu6gs4Is2
         QvYAYlVCneECpq0hUkK3bZmwWSwv1p3pGcW4YtFc1vjj7+F2HBMveY8FicLyD3Q3OQ
         JFJ7P6cZom+lXSPD5AUN/m8L781HZJfthNtjxXEUFIbwzbQeLh76WaH7xyEMIOxkx8
         7SRZENMIQPSl4j+Txb5KuwC7enhLUv2mGPDG8ZmtSs1I/I8/n1qy80MiWkzq42CUqa
         csZyR38aAJCw97WXq+xjJ1MAsYFIXGt2NTXDtzS2Ehqr7jMV3R7KoIP+75Jv4a2zic
         Jv5NqzY2+xSDg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id t17so5958401vsc.8;
        Sat, 02 Feb 2019 05:48:38 -0800 (PST)
X-Gm-Message-State: AJcUukfykkCaHATN+l90GmLYZ91MKkRdH3GX2ftJWxwRv1gUKBvQtuHK
        tg/dUoxXSi6rbACFNqmyjR59/XpjgaYDpx4X5mw=
X-Google-Smtp-Source: ALg8bN6vkfp79Krm/MsJjZWEDfp+ue9JtQfadtj/DSnCT1EoISLmikeMIfV2FCIxMAC9RtBEVSbhTI4uLnXc1UEPBM4=
X-Received: by 2002:a67:385a:: with SMTP id f87mr18613720vsa.179.1549115317365;
 Sat, 02 Feb 2019 05:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20190121095338.8565-1-bp@alien8.de> <20190131115820.GF6749@zn.tnic>
 <CAK7LNATGUs0PPssA=WfHojEEPuztDcNHf0NdH6ohOdf8k8PZOQ@mail.gmail.com>
 <20190201094217.GB31854@zn.tnic> <CAK7LNARPq7Bj+zp7bYyH_uPOyJ9a1-hD-aSq6GDLb8YdqbA-+A@mail.gmail.com>
 <20190201103038.GE31854@zn.tnic> <20190201103648.GF31854@zn.tnic>
 <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com> <20190201151139.GK31854@zn.tnic>
In-Reply-To: <20190201151139.GK31854@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 2 Feb 2019 22:48:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
Message-ID: <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
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

On Sat, Feb 2, 2019 at 12:12 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 01, 2019 at 08:58:13PM +0900, Masahiro Yamada wrote:
> > Variables assigned with ':=' are evaluated just on parsing Makefile.
> >
> > The scripts/Makefile.build is parsed over and over again,
> > so the compiler is invoked hundreds times to test these four options
> > even when you are not actually building any new objects.
> >
> > It is mitigated by replacing ':=' with '=',
> > but they are still evaluated multiple times when generating asm-offset.
>
> Now that you mention it, how about ?=

'?=' is the same as '=' here.




> disable_extra_cc_dbg ?= $(call cc-option,-gno-as-locview-support)
> disable_extra_cc_dbg += $(call cc-option,-fno-dwarf2-cfi-asm)
> disable_extra_cc_dbg += $(call cc-option,-feliminate-unused-debug-symbols)
> disable_extra_cc_dbg += $(call cc-option,-gno-statement-frontiers)
>
> With it, the slowdown of the incremental build is ~0.2s (on an old laptop):
>
> defconfig without:      9.6128 +- 0.0327 seconds time elapsed  ( +-  0.34% )
>
> vs
>
> defconfig with:         9.8483 +- 0.0273 seconds time elapsed  ( +-  0.28% )
>
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada

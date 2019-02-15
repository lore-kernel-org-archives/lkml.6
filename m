Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A1C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A23206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NQ0eGso6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404938AbfBOJa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:30:57 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:64515 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBOJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:30:57 -0500
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1F9UktX020248;
        Fri, 15 Feb 2019 18:30:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1F9UktX020248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550223047;
        bh=v5CD2QsDxnxVejyPIDnfbiJ1pltYltlIlJJglB+jvf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NQ0eGso6oKLWfKf5cFvUyBYm2OHHA6KMFXxb4raGJ4xk9alAwE6b986gzBUM+NhXJ
         7DBOoEHgcydBqd66HIPfVc4IGD6owhhGMsMg7vel7aNIcFRL7kjpEJfVbrDs9CUz/l
         ysapVJjYa5w++SdewUAfTkQvgNL2YivGFbSizA5cT1adFaWjEjC4Hf9INDo2e5tswx
         FTHdhvVKRnLz/ku8BegAQSxM9MN7v/uSQkKYYitc5E6sTVTqkO17cTaxksidmNhP94
         M7rL+DFrSSgn7hVggMbmu1DQW/1/6NmVo+z79o2t0B1+hWDSFCoyHxRSXTF8rGFQ7m
         xpL2fn30+eDJA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id n10so5383028vso.13;
        Fri, 15 Feb 2019 01:30:46 -0800 (PST)
X-Gm-Message-State: AHQUAuZP7bkwhRifqOPNa+4DMU2YaWB1rlC0DfKDkZk2ekss01Ieg6Uf
        tABe5CblBJytpBQknt4FTV0NM/mJb/QfDV00Fyw=
X-Google-Smtp-Source: AHgI3Ia3aUMPs8A+f0S+OAOntXz63yvlxIZCcSZkHkAspWZKdCm1fRVczLmf1lM9pbiclIsGKkljQY6lvGdNXZnifOU=
X-Received: by 2002:a67:c913:: with SMTP id w19mr4362629vsk.179.1550223045823;
 Fri, 15 Feb 2019 01:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-2-hch@lst.de>
 <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr> <20190214170510.GC32441@lst.de> <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
In-Reply-To: <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Feb 2019 18:30:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnsMbciyEd-1HZZmb5A66-TBtq0R3X-=JPMNT6iADo4w@mail.gmail.com>
Message-ID: <CAK7LNATnsMbciyEd-1HZZmb5A66-TBtq0R3X-=JPMNT6iADo4w@mail.gmail.com>
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 5:18 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 14/02/2019 =C3=A0 18:05, Christoph Hellwig a =C3=A9crit :
> > On Thu, Feb 14, 2019 at 09:26:19AM +0100, Christophe Leroy wrote:
> >> Could you also remove the 'config GENERIC_CSUM' item in
> >> arch/powerpc/Kconfig ?
> >
> > All the separate declarations go away later in this series.
> >
>
> I saw, but the purpose of the later patch is to replace arch defined
> GENERIC_CSUM by a common one that arches select. For the powerpc you are
> not in that case as the powerpc does not select GENERIC_CSUM.
>
> So I really believe that all stale bits of remaining GENERIC_CSUM in
> powerpc should go away as a single dedicated patch, as a fix of commit
> d4fde568a34a ("powerpc/64: Use optimized checksum routines on
> little-endian")
>
> Regarding the #ifdef __KERNEL__ , I think we should do a wide cleanup in
> arch/powerpc/include/asm, not only asm/checksum.h
>
> Christophe


Please send such cleanups to PowerPC ML
instead of to me (Kbuild).


Christoph,
I think this one is independent of the rest of this series.
How about separating it if you volunteer to Powerpc cleansup?


--=20
Best Regards
Masahiro Yamada

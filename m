Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2E7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855082089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lJdeJbSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855082089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeKKH2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 02:28:41 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53860 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeKKH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 02:28:41 -0500
Received: by mail-it1-f195.google.com with SMTP id r12-v6so7800819ita.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M4eP4vYgLS5hC5vjkIc8iX1J5rc7dQzi6sxXQY0Vfc4=;
        b=lJdeJbSaVjJG36yeobFkrFjW5EgLOw/vQmOZqRaM2tLnwQ7NzpThW3xmgmlmv5WrKy
         eesaHHjAxC7E8JrA/9Fgk7dpbjQ0kqHLpaIc5WscWL4yzANKzMjwtAdIakTYkJajHBPH
         OEtAL+mZTsx5C9AD/wJTDs3WCtBUXmaLVKpob8/Vf2+OBhcnhRa2F2L3Na/y7rt1ZbYY
         ZcQxGVpPhPnVnbsE5d+joOP4BVBVga+MYopbTUi3ySqXW2NwMs598igUf7nO8lo8v9yL
         Tk20+ac/KmBjY+xatDW5pHHd5aRErUP2oXgaT3OaBbfrkOpBstR1XwX74zGdxFsddorv
         9Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M4eP4vYgLS5hC5vjkIc8iX1J5rc7dQzi6sxXQY0Vfc4=;
        b=fVJSrWFjVxM5L+mzwmkq011MbcUIYEi+H4sGGthAoC9dceRY61u4Bsoi6KpQ2kwr51
         2Ms24IQQhCKV0xNucbJNdS7vTAt9JKlvlfuer+36QRJUOiM2EDMUfzlSTSQwIom+adrz
         1JwbcijdW/+vD1g0nbhQ+cAeMTyBowf1LiMCdNe0lifRCe6bRFdjeVNYye7LmQ63lUxN
         1RlnNjkGN/7D4wmdxCbi9a7dYF6H+B4f/b6PyXVCZDvts0b9p4xa/8My0SZqBjyMr0jl
         6Tk0dYneJmQvkxMZnVkOiwSwSbUVw/W20FlZXhzbdhFznVEJCUZsvETZGZc7sMurZSpu
         vQWg==
X-Gm-Message-State: AGRZ1gLQCYBm/cJK41uqXOZYAxEc7zue9VnBDV9/wnup2+Y4CPp2hWdN
        xtNlcEKKom+N0W2f/6ponYcDjIsM0sy3jiQCOiib0A==
X-Google-Smtp-Source: AJdET5ek9fAXOvvXlB8JYY/h9fuzKRqaq5JDFwmXIFcmtPxd+pvNX5o9RtNEIZ12mXVV02gGNprkmAIonq5p3Rmf+FI=
X-Received: by 2002:a24:70ca:: with SMTP id f193-v6mr6630014itc.59.1541886135893;
 Sat, 10 Nov 2018 13:42:15 -0800 (PST)
MIME-Version: 1.0
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan> <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
 <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr> <877ej7urh3.fsf@concordia.ellerman.id.au>
 <7cf2d115-a58b-4585-37fc-7e58169a43a3@c-s.fr> <87zhw1srt4.fsf@concordia.ellerman.id.au>
 <ca845d92-674b-4ca2-3535-2621972bd13b@windriver.com>
In-Reply-To: <ca845d92-674b-4ca2-3535-2621972bd13b@windriver.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 10 Nov 2018 13:42:04 -0800
Message-ID: <CAOesGMiv3Qh52GhqmTXJ4LDNEfsoOp2BO_C2H_T3wsY2A6k5zQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, christophe.leroy@c-s.fr,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kgdb-bugreport@lists.sourceforge.net,
        stable <stable@vger.kernel.org>, me@tobin.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Oct 1, 2018 at 12:52 PM Jason Wessel <jason.wessel@windriver.com> w=
rote:
>
> On 09/28/2018 07:57 AM, Michael Ellerman wrote:
> > Christophe LEROY <christophe.leroy@c-s.fr> writes:
> >> Le 27/09/2018 =C3=A0 13:09, Michael Ellerman a =C3=A9crit :
> >>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> >>>> Le 26/09/2018 =C3=A0 13:11, Daniel Thompson a =C3=A9crit :
> >>>>
> >>>> The Fixes: and now your Reviewed-by: appear automatically in patchwo=
rk
> >>>> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D65=
715),
> >>>> so I believe they'll be automatically included when Jason or someone
> >>>> else takes the patch, no ?
> >>>
> >>> patchwork won't add the Fixes tag from the reply, it needs to be in t=
he
> >>> original mail.
> >>>
> >>> See:
> >>>     https://github.com/getpatchwork/patchwork/issues/151
> >>>
> >>
> >> Ok, so it accounts it and adds a '1' in the F column in the patches
> >> list, but won't take it into account.
> >
> > Yes. The logic that populates the columns is separate from the logic
> > that scrapes the tags, which is a bug :)
> >
> >> Then I'll send a v2 with revised commit text.
> >
>
>
> No need.  https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.gi=
t/commit/?h=3Dkgdb-next
>
> Since it is a regression fix, we'll try and get it merged as soon as we c=
an.

Looks like this didn't make it in yet, even with a merge window inbetween? =
:(

I know first-hand that time to do upstream work can sometimes be hard
to find. I also know that Daniel has shown interest in helping out
here, and is listed as a maintainer. May I suggest that he starts a
tree to collect patches and submit pull requests for a while, until
you find more time for it?

Having a tag-team maintainer setup like we have had for arm-soc has
been very useful especially when one of us get too busy for a while,
etc.


-Olof

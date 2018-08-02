Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC71C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B8D208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8D208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeHBJHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:07:18 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:43030 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHBJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:07:17 -0400
Received: by mail-ua0-f177.google.com with SMTP id x24-v6so776059ual.10;
        Thu, 02 Aug 2018 00:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiKIr8XOsAmJ8lXKL0ulr5wPc7w7B8DxxgemyPrIlbw=;
        b=Czit+U46khLlqfXZ8/JiGbEEu/TYX5hKj2gOeQGkpGUHuJAW+H8oSqW9ug4m6Iyoi5
         40DJ1/eTjEz0BsgQ0J+brtliAmIjg9wkwesrE8c+nhLkMOKmq4Kk5bfINF5VCchrCW9i
         z+Bo+aO+BcRNn3oK3gs/ciD25x5jXhHaOT7G8dX3UUmUQK8AA/ewzsvT7Lbmi/yLA7rh
         u6krdUDGJwUojVw0n/BwRE80GgzdOujiq06CCVlVrkqpkB20bFwWpOVj4x0afcjziytF
         gOkShs+Aa6DXXWwVJJkGvYqI4ue6MA5SkdwGw++c1jPo2CnxC/3Nm3nA1F0pMdEXKH1P
         0E0w==
X-Gm-Message-State: AOUpUlENeichaGslKmi68FNOtUIktOEbTHjJvQq8wgImVNLdij0ZL75z
        AhnRAjsrdwK6bGL0lT+vQ+QOSyVPMvk8cbY6+T6j4g==
X-Google-Smtp-Source: AAOMgpfC5bjFrS4eT+TdEiMU6eo64DYmbJuNwn9lKUo0Cul7Blg4iEaQ1Il0WQMU969dca91++3CWwfMJ8ieBj9ZYKk=
X-Received: by 2002:ab0:80e:: with SMTP id a14-v6mr1200980uaf.114.1533194248929;
 Thu, 02 Aug 2018 00:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180802092708.10e1a71d@canb.auug.org.au> <20180802094154.6d88f03c@canb.auug.org.au>
In-Reply-To: <20180802094154.6d88f03c@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Aug 2018 09:17:16 +0200
Message-ID: <CAMuHMdXTW8iSA+HnnDNzoNkMwUchLY1J6YBYCBCfGRT5UatBqg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the m68k tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Aug 2, 2018 at 1:42 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> [forgot the conflict resolution ...]
>
> On Thu, 2 Aug 2018 09:27:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the powerpc tree got a conflict in:
> >
> >   arch/m68k/mac/misc.c
> >
> > between commit:
> >
> >   5b9bfb8ec467 ("m68k: mac: Use time64_t in RTC handling")
> >
> > from the m68k tree and commit:
> >
> >   ebd722275f9c ("macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver")
> >
> > from the powerpc tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

Ah, now I remember Finn said he was going to rebase his series once the time64_t
patch has entered my tree...

> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@@ -90,11 -85,11 +90,11 @@@ static void cuda_write_pram(int offset
>   }
>   #endif /* CONFIG_ADB_CUDA */
>
> - #ifdef CONFIG_ADB_PMU68K
> + #ifdef CONFIG_ADB_PMU
>  -static long pmu_read_time(void)
>  +static time64_t pmu_read_time(void)
>   {
>         struct adb_request req;
>  -      long time;
>  +      time64_t time;
>
>         if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
>                 return 0;

Thanks, looks good to me!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

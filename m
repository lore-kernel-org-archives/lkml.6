Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p0XvN4PhHFtmewAAmS7hNA
	; Sun, 10 Jun 2018 08:30:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CC25260850; Sun, 10 Jun 2018 08:30:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C9DAA600D0;
	Sun, 10 Jun 2018 08:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9DAA600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeFJIaC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 04:30:02 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43534 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932307AbeFJI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 04:29:58 -0400
Received: by mail-vk0-f66.google.com with SMTP id d74-v6so10333782vke.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 01:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbwDoXHa2k6WJ0yqcvM35K2tCxHNTYgqVQK0liLN52Q=;
        b=FODjUzWbtn6BqCmUFxzm7C0nm8WV1JhFZ3V5N3fCTuyhtpTFJyTGslcqmFxZo9hWY0
         MDptv8uzUxaJgqpiHrwWVcfVzqtnykqaOJyC23JVAVfS0FKKRUfbA/8g01wXSDgfrcVp
         kTLvoIZSjyIjt654szM1SYhdzPYb3fJ8cUaLFS/nMEow1FUuuLGaL/Pul5FFd03WczhF
         aYBdcpXm0WWbvIZFk9yoRyE2ho3h4DGPINX1ILolu4kGRmXxhcGMv/51VUpAO+6LqLVi
         K0BVTcsPvqicTKKfMoUYkt0jMPtCa+sThGiOa9MsNWX4FuSEsvJHw29OVDTngyTM80nS
         SOcw==
X-Gm-Message-State: APt69E0aGFQwSL1sGJhz4g6yPOJ0FV9U4APT5DqztryscajRg2MG4wXS
        h3ZdZYfJ7ELwiZ9M5/zKScN4SAziXQcyNAImR8k=
X-Google-Smtp-Source: ADUXVKJ2yUp2Hran9rqrzEyUFNn/rImbxjbhrG7MKvJCIRvqStmWCYA4RmcXlx34OU201/qjN3kN1XlzQUNMq/vShOM=
X-Received: by 2002:a1f:644:: with SMTP id 65-v6mr4013489vkg.159.1528619397535;
 Sun, 10 Jun 2018 01:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com> <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com> <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Jun 2018 10:29:45 +0200
Message-ID: <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sat, Jun 9, 2018 at 2:20 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > > Is this enum used by any user space code? If so, perhaps rather
> > > > leave the PMU_68K_V1 in there to avoid upsetting that?
> > >
> > > It also changes the value of PMU_68K_V2, which is an ABI break.
> >
> > Yes, that's what I worry about - but do we know of any users of that
> > particular interface?
>
> There is no ABI issue AFAIK. The value of pmu_kind is visible to userland
> only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch
> series will make these UAPIs available on m68k, and for that reason I've
> chosen the value PMU_UNKNOWN for pmu_kind.

While /dev/pmu and /proc/pmu/* may not exist on m68k, definitions in
include/uapi/linux/pmu.h are part of the ABI, and cannot be changed or removed,
unless we are 100% sure there are no users.

If I would write a program interfacing with /dev/pmu and /proc/pmu/*, and
needing to check the PMU type, it would have a switch() statement with
all existing values defined in <linux/pmu.h>. So that would become broken
by your change.

Hence the enum is append-only.

> New pmu_kind values can be defined as and when the need arises. But that
> would imply a useful classification scheme for pre-PCI powerbooks, and I
> don't know what that scheme will look like because at this stage there is
> neither userland nor kernel code to support backlight, buttons and battery
> for pre-PCI powerbooks.
>
> In anycase, the "v1" and "v2" scheme is obviously inadequate when you
> consider the range of m68k powerbook models. Also, consider the

New values can be added at the bottom.

> out-of-tree adaptation of via-pmu by the Nubus-PMac project, which has
> this ABI break:
>
> diff --git a/include/linux/pmu.h b/include/linux/pmu.h
> index cafe98d9694..9882a185a52 100644
> --- a/include/linux/pmu.h
> +++ b/include/linux/pmu.h
> @@ -90,6 +90,7 @@ enum {
>          PMU_HEATHROW_BASED,     /* PowerBook G3 series */
>          PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
>          PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
> +        PMU_NUBUS_BASED,        /* 1400, 2300, 5300 */
>          PMU_68K_V1,             /* 68K PMU, version 1 */
>          PMU_68K_V2,             /* 68K PMU, version 2 */
>  };

That's bad.  But as long as the NuBus-PMac project is out-of-tree, the
enum values it uses are not part of the Linux ABI, IMHO.
During upstreaming, PMU_NUBUS_BASED should be moved to the bottom.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

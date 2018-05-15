Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeEOKy1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:54:27 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:42464 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeEOKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:54:25 -0400
X-Google-Smtp-Source: AB8JxZqpC2S7+DMgsjBOTZsihw3WLDcqIjXoDmzqMe8npTrHXBR2ZsbOB4BBZZTGb5M7xU1GLIEp8sO9uVLIZl1mtF8=
MIME-Version: 1.0
In-Reply-To: <20180508071756.grie5wln2lpo52un@breakpoint.cc>
References: <20180507105519.1d34f19e@canb.auug.org.au> <20180508102101.768d5c52@canb.auug.org.au>
 <20180508071756.grie5wln2lpo52un@breakpoint.cc>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 May 2018 12:54:22 +0200
X-Google-Sender-Auth: PEMVyTFHBTOb5S3CqUUquLzCjZ0
Message-ID: <CAMuHMdU0iUBbkPL5ZKxKuORnQA9ujX1J+5NLw=ft80hJh20VxQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the netfilter-next tree
To: Florian Westphal <fw@strlen.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, May 8, 2018 at 9:17 AM, Florian Westphal <fw@strlen.de> wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> On Mon, 7 May 2018 10:55:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> >
>> > After merging the netfilter-next tree, today's linux-next build (x86_64
>> > allmodconfig) produced this warning:
>> >
>> > ./usr/include/linux/netfilter/nf_osf.h:25: found __[us]{8,16,32,64} type without #include <linux/types.h>
>>
>> > Introduced by commit
>> >
>> >   bfb15f2a95cb ("netfilter: extract Passive OS fingerprint infrastructure from xt_osf")
>
> I'll send a fix for this, thanks for reporting.

+config NF_OSF
+       tristate 'Passive OS fingerprint infrastructure'

"There is no help available for this option."

Is this meant to be a user-visible symbol?
I noticed it is selected by NETFILTER_XT_MATCH_OSF.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

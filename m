Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E1BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD0C20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL88JZhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD0C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbeGWW0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:26:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33228 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388128AbeGWW0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:26:38 -0400
Received: by mail-oi0-f66.google.com with SMTP id l10-v6so3808073oii.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qncwc/CQn5Aas+EPEeumSODOVgvPP8/lwf5atRETs7M=;
        b=EL88JZhS9gpdUKXnEJGpia4A+OldeOyexiyWthnNibMUpyoJJgVuWxUmSgPS+MqMWk
         EoAlELzSasxJ6DsfFTFAzoqowxCQAYk+/idA1ywlnA7gTQ6w41zwNEjJb86DUgGbHwK7
         lnIFTtp45WpwpEfwhLm8RZdaC0+GYRlc+6yN1D4wFAAkANIlMq2ury/CLZBd8ixlUuq7
         oho2uhDius4l3TroOhSN3iPF688iCZ3iGpPm9nIwGuDjp56NE/k1yaHL/jhPxlKH8bkg
         RukXxltVk5q9TRjePB+umHsdoa2mAGKGMv7uBjednQk5nF/WfwWv5A8gZaVBxE/YxEn5
         6wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qncwc/CQn5Aas+EPEeumSODOVgvPP8/lwf5atRETs7M=;
        b=X86qKKxd+Rh68u2seMoACj1+icOagcofZIcbLFz6X1gDQ0VIS5ilCSvyym+dv8sA0c
         Do5PgVYLtPYVFef7wWFqY4wg1FoXFqZ0M/eV5UbSAWv2DBFRnNRSQh2y2qn9VKW1alZO
         CZdJcxVYjq+omeL2JkCgpdRED9mHQyhltUevjgn24W6upKLmJPFP+SGN/+avrlc6w0rW
         guoT+WP4ChHVf2LmvjgDDBf6Yng2PgfET0FZbM9+U6uw+OpQBPmhuAE6IABBGectj+vk
         3X4jJDEWFp0N+0MY3BEJDztbY/T5KybhqHvf2Abh0DbazhZnipg1RvNCxFo1dAY7gj8S
         yPEA==
X-Gm-Message-State: AOUpUlEqEKN0y0PRfMxvoIix5Xtl/BXeM57nkRWY1waVYAtV1+W+PwKa
        axqnsUVsHLMe/B7HkndTqOE=
X-Google-Smtp-Source: AAOMgpcfTSQppTr6g7clnX0jO/uDo/EpqRhQ/nG33fWbOEgTDwgzNsyMRZEWRb828Z83znv3cT6Agw==
X-Received: by 2002:aca:6ac8:: with SMTP id f191-v6mr463532oic.223.1532381012935;
        Mon, 23 Jul 2018 14:23:32 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i204-v6sm20049069oia.41.2018.07.23.14.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:23:31 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:23:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.18-rc6
Message-ID: <20180723212330.GA7441@roeck-us.net>
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
 <20180723204617.GA14487@roeck-us.net>
 <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:56:15PM -0700, Linus Torvalds wrote:
> Adding davem for the sparc issue, Martin for the s390 one.
> 
> On Mon, Jul 23, 2018 at 1:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > The s390 gcc plugins related build error reported previously has not really
> > been fixed; after feedback from the s390 maintainers, suggesting that it
> > won't get fixed in 4.18, I disabled GCC_PLUGINS for s390 builds. This is
> > not my preferred solution, but it beats not testing s390:allmodconfig
> > builds at all.
> 
> Martin - can we just remove the
> 
>          select HAVE_GCC_PLUGINS
> 
> from the s390 Kconfig file (or perhaps add "if BROKEN" or something to
> disable it).
> 
> Because if it's not getting fixed, it shouldn't be exposed.
> 
The problem only affects 4.18 - the code has been rearranged in -next.
Only, in my builders, I can't disable a flag for individual releases,
so I just disabled it completely for s390.

> > The sparc32 build error is still:
> >
> > In file included from
> >         ...
> >         from drivers/staging/media/omap4iss/iss_video.c:15:
> > include/linux/highmem.h: In function 'clear_user_highpage':
> > include/linux/highmem.h:137:31: error:
> >         passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type
> >
> > due to a missing declaration of 'struct page', as previously reported.
> 
> Hmm.  I assume it's
> 
>     arch/sparc/include/asm/cacheflush_32.h
> 
> that wants a forward-declaration of 'struct page', and doesn't include
> any header files.
> 
> The fix is presumably to move the
> 
>    #include <asm/cacheflush.h>
> 
> in drivers/staging/media/omap4iss/iss_video.c down to below the
> <linux/*> includes?
> 
Good idea.

> The old patchwork link you had for a fix no longer works, I think
> because the patchwork database got re-generated during the upgrade
> (and the patchwork numbering isn't stable).
> 

Looks like they dropped lkml completely. Odd.

My patch is also at

https://patchwork.ozlabs.org/patch/937283/

Also, there is now another patch from Randy Dunlap, pretty much
doing the same.

https://patchwork.ozlabs.org/patch/947434/

I'll submit separate patches to address the include file ordering;
it does make sense to do that. I'll do the same for android/binder.c;
it has the same problem, only there it only generates a warning.

Thanks,
Guenter

Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B98DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061A120868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6MhKC5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061A120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeK3DXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:23:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39675 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeK3DXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:23:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so2497065wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v29Av/O3k6yDuo4+kiDJ6V3r/5u6liE5o8KSDjhVItE=;
        b=d6MhKC5qeixE4tLfHfFhAfgXb/q27ysWfEif1XJPh+BsHoZD2NoKy2809JGPnTGNIR
         HyAr0zeTL7HUjISdSeiPUupYPMTSBC15YDSsho6E7uVZeEZR+ort4Q/5WdXW1ftuPmyy
         pMaGaQn2e72ZTObXyIDSGuv80c3Jw9Wdw7UgJnGmR5PZ2O4qNErUN4g3qOUaTb+9vuGl
         YZxrxf+PZvnsQfYkS/PK7Y8k4B3g9Btkp+VmWwcODS+nD2iJxKxwwR+pemhr1pkJ1+qN
         ITS/t7+B6UEgJR4Ae2I5bXD6F+IQ1G6KrSgCUtatF9W9jj3cxmemF6YtElrO4qmfg9W3
         2JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v29Av/O3k6yDuo4+kiDJ6V3r/5u6liE5o8KSDjhVItE=;
        b=Ykxd6i6dOZJqypjPvnUszFCA/mYYykliBs+R2Gl490Su/kMBY4lKnie2Ro710U27sk
         AhdN1xh01NG8mneoKD5xmK451el60UfBmbRSZMYRz2+ow9dkyQFxNyL73ICeGLZyzBuF
         AJDwInUcSWg3AqNTOcObWoCCGEW1jTOEeBp+Er6SF4yYFu7m0IWLT10htFdeuqceBNJ0
         uuGA6zk6GszgJPP7lwr3BKOrUY6IxK8T3O/X0qOwKHkhocXAebrkIpB/aVwQwTHjoSij
         Io6sb5L3fZnrHJUaNaNQkMfN82oEpGZ/eU9Un05wTFs/A1DcFx31ILBLKv98dkccqCTV
         eLYQ==
X-Gm-Message-State: AA+aEWb6FU9C2UnI5mY9ewEqLAgzgXWkPvYF+oBkpCLQTbysTPRZeKoS
        5iXIDWtBiRBjs20hReqPMpg=
X-Google-Smtp-Source: AFSGD/VU6RYIvuWrVCndfcB5AN4btA9SadYXfRhIegBj31ssGs4dZhgf8u18TFObeZ4+BegMm8lruw==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr2180732wru.245.1543508260736;
        Thu, 29 Nov 2018 08:17:40 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x136sm2753630wme.0.2018.11.29.08.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:17:40 -0800 (PST)
Date:   Thu, 29 Nov 2018 09:17:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Julien Thierry <Julien.Thierry@arm.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129161738.GA9805@flashbox>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com>
 <20181129161039.GA17063@flashbox>
 <20181129161337.GA21349@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129161337.GA21349@arm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:13:37PM +0000, Will Deacon wrote:
> On Thu, Nov 29, 2018 at 09:10:39AM -0700, Nathan Chancellor wrote:
> > On Thu, Nov 29, 2018 at 10:49:03AM +0000, Will Deacon wrote:
> > > On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> > > > On 29/11/18 04:19, Nick Desaulniers wrote:
> > > > > Fixes the warning produced from Clang:
> > > > > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > > > > register size specified by the constraint and modifier
> > > > > [-Wasm-operand-widths]
> > > > >         return readl(addr);
> > > > >                ^
> > > > > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> > > > >                                                           ^
> > > > > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > > > > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> > > > >                                                   ^
> > > > > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> > > > >         asm volatile("eor       %w0, %1, %1\n" \
> > > > >                                      ^
> > > >
> > > > Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> > > > The variable passed to the inline assembly for %0 is unsigned long, so
> > > > always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> > > > register for it?
> > 
> > Sorry, this was my fault, I accidentally added a w during testing to see
> > what constraints were valid (given that my assembly knowledge is nearly
> > non-existence so forgive the non-sensical experimentation) and I used
> > that message rather than the original one. This is the unadulterated one.
> 
> Aha, that explains it. Thanks for clearing that up.
> 
> > In file included from arch/arm64/kernel/asm-offsets.c:24:
> > In file included from ./include/linux/dma-mapping.h:11:
> > In file included from ./include/linux/scatterlist.h:9:
> > In file included from ./arch/arm64/include/asm/io.h:209:
> > ./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >         return readb(addr);
> >                ^
> > ./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
> > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> >                                                                        ^
> > ./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
> > ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> >                                                                ^
> > ./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
> >         asm volatile("eor       %0, %1, %1\n"                           \
> >                                     ^
> > 
> > >
> > > Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
> > > read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
> > > I wonder if the following fixes the problem:
> > >
> > 
> > This doesn't appear to work, I get this error:
> > 
> > In file included from arch/arm64/kernel/asm-offsets.c:24:
> > In file included from ./include/linux/dma-mapping.h:11:
> > In file included from ./include/linux/scatterlist.h:9:
> > In file included from ./arch/arm64/include/asm/io.h:209:
> > ./include/asm-generic/io.h:695:9: error: expected expression
> >         return readb(addr);
> >                ^
> > ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> >                                                                ^
> > ./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
> >                      : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
> >                                          ^
> 
> Can you try throwing another set of brackets around it, please?
> 
> 	((unsigned long)(v))
> 
> Will

Thanks, that fixes the warning as well.

Nathan

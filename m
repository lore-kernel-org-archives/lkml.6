Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70D2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8974F208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXj4s4kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8974F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeHBG5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:57:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBG5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:57:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so766471wrt.1;
        Wed, 01 Aug 2018 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiYSk5IQhAcSZUy8aWzLiQuUe14Rnzc05Q1tVhlQ0dk=;
        b=cXj4s4kMbGF7lmOXTG+oftzvrzWZUZhx4FK2qD5FlZuoYiChQIaM2HwBLyCkHgKfee
         nlf1IkGMkBLfDMqb+kk5yGr0i1mFKLfoTk7Es8tZJKAVvzrAVZ5Yns9NfiFLrU0cw9m+
         PyQH6sM9DzlNAqvFwD6IGAcveikq3OAs1rO1uXpVqgy8GAJWrZQQuVC5kmJEcPMCneGO
         7auyPSCZg904BFSHtjHFDMOiIJPlS68cobBOhDHIWelAUtXUUhp7X7we/ZyiswgXNgWg
         sULXHwRhsUAD7GXAZ3nBK6sBsuh1s0B/gUPgjasLW6PpUcRzrd2FVp2sScHBMt89meCI
         Y/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiYSk5IQhAcSZUy8aWzLiQuUe14Rnzc05Q1tVhlQ0dk=;
        b=bY0fOUIgUU77cn7KVtd5/H4jSXZB8FR9tUXL4vBIv642MaBIO28esqhTcOntB9kf7e
         hhtnGB/1LFmzOQCbeeqJYGQz4NsBj6JhrgyUApJCo/oarAKgAYR72G+XVAQOtiHRNAt1
         AZyHmCUsLWwj8b0OMSSf4oBdeRpckXwYA7wHJL5pQUDpMz1reNB1YPQtxtUbnb8gnB95
         Agk9GRrJOa4Vk9R+gii60/JSLAYPe5e62w0d+/GqroLiMukUgsPkUMqdWgZTaGtCe5tN
         Z3dJFoIOv98cDU+5dpwRBMqzWNMJvo28xJTWd+hQDZJuPj7GvLOCk78+T6DTQWaMuJM6
         MpNQ==
X-Gm-Message-State: AOUpUlGnAgNjjIn0CgX1AoCvZKgFGgJsMYqmGDkkZyVHPEAFZfeZR8XQ
        yWT/HlVYrpNLwsAPDo62LYs=
X-Google-Smtp-Source: AAOMgpfE7aR9UwAuIm5BBru+g3OJyq8lQGPuDrgSGuH8rPUfApJBuS0eLCppw/vrKH2ID37/ugBMXg==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr725701wrm.213.1533186500652;
        Wed, 01 Aug 2018 22:08:20 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s2-v6sm802494wrn.83.2018.08.01.22.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 22:08:19 -0700 (PDT)
Date:   Wed, 1 Aug 2018 22:08:18 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     ndesaulniers@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inet/connection_sock: prefer _THIS_IP_ to
 current_text_addr
Message-ID: <20180802050818.GA18742@flashbox>
References: <20180801215759.103758-1-ndesaulniers@google.com>
 <20180801.184208.776886134692058469.davem@davemloft.net>
 <20180802045825.GA16769@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802045825.GA16769@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:58:25PM -0700, Nathan Chancellor wrote:
> On Wed, Aug 01, 2018 at 06:42:08PM -0700, David Miller wrote:
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > Date: Wed,  1 Aug 2018 14:57:59 -0700
> > 
> > > -			 sk, what, when, current_text_addr());
> > > +			 sk, what, when, (void *)_THIS_IP_);
> > 
> > Is a fugly macro in all caps really better than a function()?
> > 
> > I'm really surprised that _THIS_IP_ is being chosen over
> > current_text_addr(), seriously.
> 
> Hi Dave,

Sorry for the second email so quick after the first, needed to clarify
two things.

> 
> current_text_addr is only used in five places in the entire kernel and
> this is the only non-architecture specific use.
> 
> include/net/inet_connection_sock.h:227:			 sk, what, when, current_text_addr());
> arch/sh/include/asm/kexec.h:64:		newregs->pc = (unsigned long)current_text_addr();
> arch/sh/kernel/dwarf.c:602:		pc = (unsigned long)current_text_addr();
> arch/x86/include/asm/kexec.h:135:		newregs->ip = (unsigned long)current_text_addr();
> arch/parisc/kernel/unwind.c:442:	r.iaoq[0] = (unsigned long) current_text_addr();
> 
> We're trying to merge it with _THIS_IP_ before for most architectures,

because for most...

> it is defined nearly identically to _THIS_IP_:
> 
> #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> 
> #define current_text_addr() ({ __label__ _l; _l: &&_l; })
> 
> * arc
> * arm
> * arm64
> * h8300
> * hexagon
> * m68k
> * mips
> * nds32
> * nios2
> * openrisc
> * powerpc
> * riscv
> * unicore32
> * xtensa
> 
> Ultimately, we're trying to turn off a new Clang warning in _THIS_IP_
> which requires some changes to work around what is believed to be a GCC
> bug (see https://lore.kernel.org/patchwork/patch/969101/).

and I should have mentioned that current_text_addr suffers from the
exact same issue so we're trying not to duplicate it 14 times across
the kernel.

> I guess the alternative to this patch is to just define current_text_addr
> as _THIS_IP_ for all of those architectures, I am not sure how that
> filters into Nick's plan (I think the goal of this was to try and avoid
> getting all of the architecture folks involved).
> 
> Thanks for your time!
> Nathan

Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C014DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654DC208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTxFzWrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654DC208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeHBGrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:47:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55087 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBGrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:47:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so929005wmb.4;
        Wed, 01 Aug 2018 21:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6bTvhP5+3LhemU0ZT/tPJEczBjran5yL56z8lJXiajs=;
        b=FTxFzWrci7aytuVMSeZsUUHGAge2+AxqfKl/cqPhRqO8H3a6caq+5LCddKmx2tjoeR
         5fU8aRg9qFxao0fIJ5RAD+bFZothAvJrd4nYPF3nHx12Hx/otR32k/SqpW2dFrLXASxo
         hyGnjb0w8zVy89Y36VHCnrn1SJblR+58DRaknjsoTdOWx/YoNZv+A9TjO3/L6xiXgvdn
         YYhL+DnqhPLW9cD56ShKKrzpOXKfGxG4O1YN5gczYXWCTSyo7EInC5W/1RX5nSCfS9Q3
         Zu1e4ZHUVurSiUptt8DssBvQR8NeG3xk7vxaw3GPtQcRYZuKYrZr87oDwFyeAdZxNeWC
         TOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6bTvhP5+3LhemU0ZT/tPJEczBjran5yL56z8lJXiajs=;
        b=qUr7cli9UD40XgDaIwXVm/s03Mi6wnwFarKj/GdzZoYb5ssCQnSKlnAWpdaMWO3SvH
         Yja5JwObyQiBUBorAOwb46eQVdbL8DVkV5RKK/NF+A10xrWJrnV0r+4Jo/w2p6ts5LXt
         Vnlm60m2p4b1Z0XaH8pim2AaUb6gLm5Hr/U6D/2CcZO2L+RCuZlZygH77XSCcmrnqBWn
         14Qj7D9Eu/whuDc05XvxyAgLBPpGtrjilg6+ubC6DgLI3MNr1z+ESIY/KRzJes8pDn8I
         I6/MzRcsnxwcvO9h1ScGN9lzi4n3R6qHyAALtCP7sXNiX3zEkNxZv95LWrhOkYvvrlzv
         dRww==
X-Gm-Message-State: AOUpUlHGdEiveA2l+1jy9SGiPO3bLgkvFFQtzeIDQiGOkwdVP/SehGi0
        r0gN7a159RaWejbO5cEHAoo=
X-Google-Smtp-Source: AAOMgpeH9b0XIQvtKeYXY+R+6qA0W2xvwvClqN/mCG9w8LCVDmyUD2tN3+1laZivR3Iqz85Cem1l3w==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr840067wmi.28.1533185908100;
        Wed, 01 Aug 2018 21:58:28 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t186-v6sm767692wmf.14.2018.08.01.21.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 21:58:27 -0700 (PDT)
Date:   Wed, 1 Aug 2018 21:58:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     ndesaulniers@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inet/connection_sock: prefer _THIS_IP_ to
 current_text_addr
Message-ID: <20180802045825.GA16769@flashbox>
References: <20180801215759.103758-1-ndesaulniers@google.com>
 <20180801.184208.776886134692058469.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801.184208.776886134692058469.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:42:08PM -0700, David Miller wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Wed,  1 Aug 2018 14:57:59 -0700
> 
> > -			 sk, what, when, current_text_addr());
> > +			 sk, what, when, (void *)_THIS_IP_);
> 
> Is a fugly macro in all caps really better than a function()?
> 
> I'm really surprised that _THIS_IP_ is being chosen over
> current_text_addr(), seriously.

Hi Dave,

current_text_addr is only used in five places in the entire kernel and
this is the only non-architecture specific use.

include/net/inet_connection_sock.h:227:			 sk, what, when, current_text_addr());
arch/sh/include/asm/kexec.h:64:		newregs->pc = (unsigned long)current_text_addr();
arch/sh/kernel/dwarf.c:602:		pc = (unsigned long)current_text_addr();
arch/x86/include/asm/kexec.h:135:		newregs->ip = (unsigned long)current_text_addr();
arch/parisc/kernel/unwind.c:442:	r.iaoq[0] = (unsigned long) current_text_addr();

We're trying to merge it with _THIS_IP_ before for most architectures,
it is defined nearly identically to _THIS_IP_:

#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })

#define current_text_addr() ({ __label__ _l; _l: &&_l; })

* arc
* arm
* arm64
* h8300
* hexagon
* m68k
* mips
* nds32
* nios2
* openrisc
* powerpc
* riscv
* unicore32
* xtensa

Ultimately, we're trying to turn off a new Clang warning in _THIS_IP_
which requires some changes to work around what is believed to be a GCC
bug (see https://lore.kernel.org/patchwork/patch/969101/).

I guess the alternative to this patch is to just define current_text_addr
as _THIS_IP_ for all of those architectures, I am not sure how that
filters into Nick's plan (I think the goal of this was to try and avoid
getting all of the architecture folks involved).

Thanks for your time!
Nathan

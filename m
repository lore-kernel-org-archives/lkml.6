Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A7C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E2F20661
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsZTIH20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E2F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeKCJIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:08:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41860 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKCJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:08:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id k13so1623014pga.8;
        Fri, 02 Nov 2018 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R5MBPeRu7QfQGvPgyyJ4MJCTqcfFzkvSC18QScHsYa0=;
        b=WsZTIH20MLjK1WiTWCRZyFBMbhxCjHBEGQM0XiOFcWN+VXyqIIlmaZZN+MUKZzz22j
         94J0kZpx6hB7RkBiIaB0Inp4Bfn93xS5GbCMKBGjhqRJC0JuCEwAj4GOKfFdGi8fEjuw
         7aO44b/GrX7ujm8UNOiLULpmwinBu1G6mlItR/jQsHj3Esl/RQiNwNaoiCeQOSOvJoJ6
         koOIF1VD5uioe6AXTBZE7y8N1XqsdV3b3wVnz/tp3zj/RX3cxBpqE+795NHwBwMnQTNH
         zOEqQgDOGFOu/XcqCj1TrYo/PU9jFUTutl+f4dQ8pzKa7YzMYn3lmzOanQ4Sm7RQdwIh
         r2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R5MBPeRu7QfQGvPgyyJ4MJCTqcfFzkvSC18QScHsYa0=;
        b=BEJfYM9O3qZkZjfUN27oNSPEEhsoXtiry5mEffmJJFPisj6aNnhmHOY0v3PITy90QU
         iUXDyol8UqhCJlCfnh/q/akBxtHXXCRcUtmri314Wg8EFzkPr004M8j8xGE9aTWsJwNj
         MB0Rmmnyc2YmnBvO8xRcHiH1oUCebUKCDFPNzILayeXWQQ4AeUQ4A0751HV8RLhfxJld
         aL11jS9bOxlt5gxC660VNzFzOrDDDhhXYsobk9EM4I+9ELPm9SSbRth9vi9BHbjTxvDE
         pGHNl+cLymMWPD/Tyenpk1j87r2Lq8Ifw4BjgZ5d9L2FUkt+S7e6UxGaxhK145/2/LBv
         Z18A==
X-Gm-Message-State: AGRZ1gIR2gHlEddMst9QgENsuQaFTsML6BeSGE2Wx2hOH341qFX1jTKI
        /L8D3SLPkpy5gqkoQsANSJg=
X-Google-Smtp-Source: AJdET5fhr/XdLcInTejuLbZs+f3SOorEIG4E7nRxTidbXftFGXwriWRaVK7DPLcmCdZJrYROuzeADw==
X-Received: by 2002:a63:5517:: with SMTP id j23-v6mr12367720pgb.208.1541203175692;
        Fri, 02 Nov 2018 16:59:35 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id n87-v6sm45461145pfb.62.2018.11.02.16.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 16:59:35 -0700 (PDT)
Date:   Fri, 2 Nov 2018 23:59:33 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Changbin Du <changbin.du@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
Message-ID: <20181102235731.smqhskmxv5mu43qq@mail.google.com>
References: <20181031145907.1ee2e866@canb.auug.org.au>
 <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
 <20181101142946.u5luuctqav6fec6k@mail.google.com>
 <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
 <CAK8P3a1w8p8OC-9_0mtMUxEojvyVfXvF8Ka4J7TnoyZ=gr2Fow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1w8p8OC-9_0mtMUxEojvyVfXvF8Ka4J7TnoyZ=gr2Fow@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:54:25PM +0100, Arnd Bergmann wrote:
> On 11/2/18, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > On Thu, Nov 1, 2018 at 11:32 PM Changbin Du <changbin.du@gmail.com> wrote:
> >> On Thu, Nov 01, 2018 at 12:32:48PM +0900, Masahiro Yamada wrote:
> >
> > How about clang?
> >
> > For clang, -Og might be equivalent to -O1 at this moment, but I am not
> > sure.
> >
> > In my understanding, Clang does not inline functions marked with 'static
> > inline'
> > for -Og (or -O1) optimization level.
> >
> > Theoretically, 'inline' keyword is a just hint for the compiler, after all.
> 
> I think this means that we cannot build the kernel in that configuration,
> at least with CONFIG_OPTIMIZE_INLINING=y. Without that option,
> every 'inline' becomes 'always_inline'.
> 
>        Arnd
I have verified the new configuration with GCC. CONFIG_OPTIMIZE_INLINING is a
whole different thing and I dont think it is so aggressive. Because many of
kernel functions marked as 'inline' must be inlined. Otherwise the kernel cannot
be compiled at all with CONFIG_OPTIMIZE_INLINING=y. If you wanna to try, just
remove the 'inline' keyword from some kernel functions to see what happens.

-- 
Thanks,
Changbin Du

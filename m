Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1843C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5052082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWP60m1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5052082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeKAXdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:33:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44943 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeKAXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:33:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so7353723plq.11;
        Thu, 01 Nov 2018 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUfiLHMM0xfVSHNOppcEGxJQPJqEgmL5MsAOyPO6JBM=;
        b=uWP60m1HHS64gAL9v1iZik1JDD7bRakvlyCF1AhDlHjt4xJYvmbYr4JkMzdpMMuA1b
         qJqjHkQ4Eak4iZURrBli3X5fxKGGs6Xf6ceSmGLJHdfN42KwtODhSLhVnkj07vSDmxAi
         hUvIdpqQwqNi3Gk7Rxl7vBLkQNFlp/qLYPSeH17uQ0PmDpxkVhCxqVtnEBBNtAErDJdW
         LrjZgcvOTFV2qiVtMZYzW3cGfbYrIP5DCnjp8fsO6tUA+P0s1yWlD0g/XyUOooVzQXT+
         OPeolSSzgVQJuqxHLxyxWNVFYFLHKZzmVywvrj5G9IpnQVYwlmDUHNKsO0RO+yGJ+0O4
         +x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUfiLHMM0xfVSHNOppcEGxJQPJqEgmL5MsAOyPO6JBM=;
        b=FZAVob8ll8H4WLJOrcxYEC714/J6UVEzCRROIGlrlBwfI+HtczrTFfx/xrRcsvMyPK
         w3UP5yjxsqtnAqg/6DDYKLzXuSFsbal434pJW1tjFKCxQ1B7Eo205wCde/Q6wDpyjXVa
         0rij+SfFP5WWgx4m5r2zcroADUrSJgFeyHbYfe6ZY6Jc6UjdfdZYt3tjXfq2sbuqif3b
         7jcu4RPG9FOCiQgV78sj4SCOLAp1M620IX1T2aIwqNmLIoYbrR1EDvuJdgXkQxSpHcPq
         fK2zeY31KlxDe7HzDv/liB2Dqhpd2AJue0DNouGILn2PqjXVhzoXH+L//xWReYplUvzX
         OZRg==
X-Gm-Message-State: AGRZ1gJ5Vtf7WFwPGmCI69yDXsNz5YykaLyvxo2C8cDH68LN6McJN0OY
        Jhk9M7S2+XouQxGHOcjgvRs=
X-Google-Smtp-Source: AJdET5dcCDCO/lLo/x7u5bb9cRPHraHLGSYSpM9dI9uFQCwB41WdGPhzWxi/NkgyFlVBx2YiNsT9Ew==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr7888538pld.217.1541082590534;
        Thu, 01 Nov 2018 07:29:50 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id g65-v6sm43067326pfg.98.2018.11.01.07.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:29:49 -0700 (PDT)
Date:   Thu, 1 Nov 2018 14:29:48 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
Message-ID: <20181101142946.u5luuctqav6fec6k@mail.google.com>
References: <20181031145907.1ee2e866@canb.auug.org.au>
 <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 12:32:48PM +0900, Masahiro Yamada wrote:
> Hi Arnd,
> 
> 
> On Thu, Nov 1, 2018 at 6:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On 10/31/18, Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 10/30/18 8:59 PM, Stephen Rothwell wrote:
> > >> Hi all,
> > >>
> > >> Please do not add any v4.21/v5.1 code to your linux-next included trees
> > >> until after the merge window closes.
> > >>
> > >> Changes since 20181030:
> > >>
> > >
> > >
> > > on i386:
> > >
> > > ld: drivers/virt/vboxguest/vboxguest_core.o: in function
> > > `vbg_ioctl_hgcm_call':
> > > vboxguest_core.c:(.text+0x212b): undefined reference to `vbg_hgcm_call32'
> > >
> > >
> > > Full randconfig file is attached.
> > >
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >
> > I ran into the same thing, and lots of others like it; they all go back to
> > the -Og compiler option introduced in commit 94c7dfd01652 ("kernel
> > hacking: support building kernel with -Og optimization level").
> >
> >
> > I have patches for most of these, but I'd prefer if we could leave
> > that patch out of 4.20 for now, and have it in linux-next for merging
> > into the next merge window, to give us more time to fix up all the
> > regressions. This particular instance is fixed by the patch below.
> 
> 
> Hmm, I was considering the -Og support for the current MW,
> but it might be better to postpone it for 4.21-rc1...
> 
> 
> 
> > Other symptoms caused by the change are tons of 'section mismatch'
> > warnings for functions that are no longer automatically inlined, and
> > sprintf format string overflow warnings when gcc fails to propagate
> > an upper bound on an integer argument that is printed into a fixed
> > length string.
> >
> >      Arnd
> > ---
> > From 8172e650c6797b9cc64c6f7b1c9e5433156290cc Mon Sep 17 00:00:00 2001
> > From: Arnd Bergmann <arnd@arndb.de>
> > Date: Wed, 31 Oct 2018 16:24:35 +0100
> > Subject: [PATCH] vbox: fix link error with 'gcc -Og'
> >
> > With the new CONFIG_CC_OPTIMIZE_FOR_DEBUGGING option, we get a link
> > error in the vboxguest driver, when that fails to optimize out the
> > call to the compat handler:
> >
> > drivers/virt/vboxguest/vboxguest_core.o: In function `vbg_ioctl_hgcm_call':
> > vboxguest_core.c:(.text+0x1f6e): undefined reference to `vbg_hgcm_call32'
> >
> > Another compile-time check documents better what we want and avoids
> > the error.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > diff --git a/drivers/virt/vboxguest/vboxguest_core.c
> > b/drivers/virt/vboxguest/vboxguest_core.c
> > index 3093655c7b92..1475ed5ffcde 100644
> > --- a/drivers/virt/vboxguest/vboxguest_core.c
> > +++ b/drivers/virt/vboxguest/vboxguest_core.c
> > @@ -1312,7 +1312,7 @@ static int vbg_ioctl_hgcm_call(struct vbg_dev *gdev,
> >                 return -EINVAL;
> >         }
> >
> > -       if (f32bit)
> > +       if (IS_ENABLED(CONFIG_COMPAT) && f32bit)
> >                 ret = vbg_hgcm_call32(gdev, client_id,
> >                                       call->function, call->timeout_ms,
> >                                       VBG_IOCTL_HGCM_CALL_PARMS32(call),
> 
> Right, but adding the CONFIG_COMPAT guard to both the caller and the callee
> looks a bit redundant...
> 
> 
> I think most cases causing this kind of problem
> rely on the assumption that 'static' functions are inlined.
> 
> We can force the compiler to do so
> by replacing 'static' with 'static __always_inline'
> 
Declaring it as normal 'inline' is enough. The inline functions are
still inlined by gcc. Thanks.

> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du

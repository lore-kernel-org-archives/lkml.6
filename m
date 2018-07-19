Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF9BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980CF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrmWGZ7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980CF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeGSXUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:20:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44673 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbeGSXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:20:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so5004869pgp.11;
        Thu, 19 Jul 2018 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qf1Hn5KUU+drF66O1KR8yYwoWVVaL9lmRNeH3v0A/YI=;
        b=JrmWGZ7zlOr90nq7KiIqHoYNTsy89ygjBwASt/Gg4Sd5KolxTCpoFT+2C+w8En1uzs
         qpFyzm2TZIKKJP40SPaUbyMGUPGDetHezscD1tO/jGXcphJeydhh5MkKn/ekWVeuGoOT
         w/pMxnChS/c2aWeDruZ1s+WweUXXK9tYI6GBMjZIG/KY534sq7c6oeFLB8YQG7F9lWbx
         XfjZUF9T0wp1XiL8we3QOLLAKf2FgSCxyOsgAZlohUtzXHjMy4iAo64QrN06hpUve7rp
         7yZqj19TaVKVA8Qj+aOPju4Vefi6P0w/mCTE6NFZytMv35ijXUJr475T+iKXtxaGDp0h
         555A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qf1Hn5KUU+drF66O1KR8yYwoWVVaL9lmRNeH3v0A/YI=;
        b=XYcEFKIl9pXrfOYilcdPgJIVVa1GEb3aBLr/Ik1kMe/zMGxynp9C3vWBa/hO9cVXLV
         NucUEWFuQc8XxZYu0MxpRdCsTdGUX1pIzYNSirtJ38ggyualiWyKRfLhyAYbP4PPnDy3
         HASXM33gZFkWY0//wvuOYy10B/PZGz9hymysxkquPigVJbpveg3S/inO0QmmRYzGl++u
         f0yl/UiuLRy7QmpaZu7XB3F8pLOTiOFPGQj0pmGfxu/TUbvbuzF8dCGjFnboSyh17vdp
         EHJz3NUjw7pSCKvfMX4PRE64fdNL/3EO8WlgKaECvxKrE2PQ3YilVU7igBD0HusITKL/
         qgQA==
X-Gm-Message-State: AOUpUlHu3cfhkgR5siL9ATH9u17O6iYpUpcTW2gSUA56lJOB3gFOUOgb
        g6K+XrRsl1WO05N9/KpAeeg=
X-Google-Smtp-Source: AAOMgpeZGzjv0Cdn9EWsyoFY5XQnVcdcEOPzy31XkPrq5Q6cCOFNDM4saYLtaNGCnj9+BzkUFKAOyA==
X-Received: by 2002:a63:d15:: with SMTP id c21-v6mr11860109pgl.322.1532039723508;
        Thu, 19 Jul 2018 15:35:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e82-v6sm346492pfd.40.2018.07.19.15.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 15:35:22 -0700 (PDT)
Date:   Thu, 19 Jul 2018 15:35:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20180719223521.GA30287@roeck-us.net>
References: <20180719120447.6e7ba23d@canb.auug.org.au>
 <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
 <20180719152940.0720e9c1@canb.auug.org.au>
 <6dabf12b-e3db-dfe8-101c-02772039e21a@roeck-us.net>
 <20180720080906.7a30c573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720080906.7a30c573@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 08:09:06AM +1000, Stephen Rothwell wrote:
> Hi Guenter,
> 
> On Thu, 19 Jul 2018 06:49:01 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 07/18/2018 10:29 PM, Stephen Rothwell wrote:
> > > 
> > > On Wed, 18 Jul 2018 20:52:56 -0700 Guenter Roeck <linux@roeck-us.net> wrote:  
> > >>
> > >> On 07/18/2018 07:04 PM, Stephen Rothwell wrote:  
> > >>>
> > >>> After merging the net-next tree, today's linux-next build (x86_64
> > >>> allmodconfig) produced this warning:
> > >>>
> > >>> *
> > >>> * Restart config...
> > >>> *
> > >>> ....
> > >>>
> > >>> This is output by my "make allmodconfig" and only started after merging
> > >>> the net-next tree today.  It has continued for further merges/builds.
> > >>>
> > >>> I suspect commit
> > >>>
> > >>>     1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
> > >>>
> > >>> which added an "imply" clause.
> > >>>      
> > >> I thought "imply" was better than "depends on HWMON || HWMON=n", but maybe
> > >> not. Is that a caveat when using "imply", and does it mean that "imply"
> > >> should better not be used ?  
> > > 
> > > I don't know, sorry.  It was just my best guess from what I could see
> > > had changed.
> > > 
> > > I wonder if it makes a difference that I am doing my "make
> > > allmodconfig" on top of a previous "make allmodconfig" and some symbols
> > > are marked as "NEW" (though they are not symbols related to the changes
> > > that happened during the net-next tree merge)?
> > >   
> > 
> > I tried to reproduce the problem, but I don't see the message.
> > 
> > What I do see, though, is that "make allmodconfig" on a clean tree,
> > followed by "make menuconfig", results in configuration changes.
> > Specifically,
> > 
> >  > CONFIG_ARC_EMAC_CORE=m
> >  > CONFIG_ARC_EMAC=m
> >  > CONFIG_EMAC_ROCKCHIP=m  
> > 
> > is removed by menuconfig, and a large number of "# ... is not set"
> > configuration lines are added. Weird and bad, since several of the
> > disabled configurations _should_ be enabled by "make allmodconfig",
> > and a large number of hwmon drivers are affected. Bisect does point
> > to "net: phy: sfp: Add HWMON support for module sensors", meaning
> > "imply hwmon" does have severe side effects and can not be used.
> > 
> > I'll try to find a fix.
> 
> OK, my mistake, the "make allmodconfig" works, the following "make"
> causes the config restart.  (I am actually doing cross builds and using
> an external object directory, in case that matters.)
> 
> I removed the "imply HWMON" line added by the above commit and the
> problem went away.  Also, using "depends on HWMON || HWMON=n" instead
> of the imply fixes it.

Yes, replacing imply with the dependency is what I did in the fixup patch.
Sorry, I should have copied you: https://patchwork.kernel.org/patch/10534925/

It is a bit different - imply was supposed to enforce HWMON={y,n} if SFP=y,
and the depends line enforces SFP={n,m} if HWMON=m. I have no idea why
imply doesn't work, but I think I'll stay away from it in the future.

Guenter

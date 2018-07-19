Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8737CECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC092084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnzBvR9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC092084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGTAWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:22:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35572 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeGTAWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:22:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so5133234pgv.2;
        Thu, 19 Jul 2018 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+L9gMdNbHGfB8zV/i3/n1R5LeLVaOKBd6qj/wQoTdOk=;
        b=GnzBvR9IjfrcQ2zLhT8O/UguHSrX5Z/g1vFeLAlrBHU1QLNzf3E6DdA3Iac6kJt/kw
         ST7kwrnOEhzT1RDSLYCH4nK239YQ9uJeMLaCvTxHonB65C1NNW33LqXoyB5gEGo75Z51
         dYBsp5Dgng23uW7PSyxeXbst8D3u5h0icmY/zUgQfhSUdEF2CeIzjKMVEiKMOEBlWQwi
         0ZQbimTbUfbhbsalSWF8WWsBkmWOFShCsZZCTJhd6wpJ+v1nQmr6qlcYBslPaYmHKnsJ
         pVx7pO8nt9T6h/cS3W04fcfz/Aaml3iibkEkHMMsNR5QQOWyLzpSBca5PrhGJnO6g5az
         eRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+L9gMdNbHGfB8zV/i3/n1R5LeLVaOKBd6qj/wQoTdOk=;
        b=Xp2AeLersGCGiIjyzoSboUbd9X1yXXPCbH7gOmOqh6xRYnzaVcvUxI6ilrMs7w850y
         vO4LIqQ066fi1raOoH0zwf3UUk+Cpu+VrOVZJ5tMy49aJ3XNSfRo/odRR0x9FCtjKOHK
         XMZfVjQUlwHDtA3xc1LNLXYf7x9jNaiTUg4GL1hgR4iXSoxMpsm7l6/39tpd937u1IrQ
         7m+feanUh4Aue0bkcF5FwkZAv0o1NjrAPP4oYlsB8mk5CLy5ozdXPtf46tkQjFlZ3Y40
         DbhK4iHbYN14wgLM3XM44Pz88HtuZJf+HTvO4IFekutCozLIuMUPPdOSxHh5UsI/1orr
         2glQ==
X-Gm-Message-State: AOUpUlEce3tIlG+Lys7spZsttavcBU2O0j6EfWsw7M3V00/Xzywlpmye
        Ot52M6Tc0eMa5hseeDdHSGbB+jBh
X-Google-Smtp-Source: AAOMgpdU251u+890BX6b3uE8f+EWf5BJzGgWnfn8IFjoAfpF23yqPCZHds4DTQGdQf41ifjYZW84gA==
X-Received: by 2002:a65:4249:: with SMTP id d9-v6mr11846208pgq.362.1532043432383;
        Thu, 19 Jul 2018 16:37:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e7-v6sm311770pgc.55.2018.07.19.16.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 16:37:11 -0700 (PDT)
Date:   Thu, 19 Jul 2018 16:37:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20180719233710.GA340@roeck-us.net>
References: <20180719120447.6e7ba23d@canb.auug.org.au>
 <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
 <20180719152940.0720e9c1@canb.auug.org.au>
 <6dabf12b-e3db-dfe8-101c-02772039e21a@roeck-us.net>
 <20180720080906.7a30c573@canb.auug.org.au>
 <20180719223521.GA30287@roeck-us.net>
 <CAK7LNARfZH=ZEdFuRq_g1HsJ+Pv1m=v343JLyE-6+uM_d+3eWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARfZH=ZEdFuRq_g1HsJ+Pv1m=v343JLyE-6+uM_d+3eWA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 08:19:34AM +0900, Masahiro Yamada wrote:
> 2018-07-20 7:35 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:
> > On Fri, Jul 20, 2018 at 08:09:06AM +1000, Stephen Rothwell wrote:
> >> Hi Guenter,
> >>
> >> On Thu, 19 Jul 2018 06:49:01 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >> >
> >> > On 07/18/2018 10:29 PM, Stephen Rothwell wrote:
> >> > >
> >> > > On Wed, 18 Jul 2018 20:52:56 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >> > >>
> >> > >> On 07/18/2018 07:04 PM, Stephen Rothwell wrote:
> >> > >>>
> >> > >>> After merging the net-next tree, today's linux-next build (x86_64
> >> > >>> allmodconfig) produced this warning:
> >> > >>>
> >> > >>> *
> >> > >>> * Restart config...
> >> > >>> *
> >> > >>> ....
> >> > >>>
> >> > >>> This is output by my "make allmodconfig" and only started after merging
> >> > >>> the net-next tree today.  It has continued for further merges/builds.
> >> > >>>
> >> > >>> I suspect commit
> >> > >>>
> >> > >>>     1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
> >> > >>>
> >> > >>> which added an "imply" clause.
> >> > >>>
> >> > >> I thought "imply" was better than "depends on HWMON || HWMON=n", but maybe
> >> > >> not. Is that a caveat when using "imply", and does it mean that "imply"
> >> > >> should better not be used ?
> >> > >
> >> > > I don't know, sorry.  It was just my best guess from what I could see
> >> > > had changed.
> >> > >
> >> > > I wonder if it makes a difference that I am doing my "make
> >> > > allmodconfig" on top of a previous "make allmodconfig" and some symbols
> >> > > are marked as "NEW" (though they are not symbols related to the changes
> >> > > that happened during the net-next tree merge)?
> >> > >
> >> >
> >> > I tried to reproduce the problem, but I don't see the message.
> >> >
> >> > What I do see, though, is that "make allmodconfig" on a clean tree,
> >> > followed by "make menuconfig", results in configuration changes.
> >> > Specifically,
> >> >
> >> >  > CONFIG_ARC_EMAC_CORE=m
> >> >  > CONFIG_ARC_EMAC=m
> >> >  > CONFIG_EMAC_ROCKCHIP=m
> >> >
> >> > is removed by menuconfig, and a large number of "# ... is not set"
> >> > configuration lines are added. Weird and bad, since several of the
> >> > disabled configurations _should_ be enabled by "make allmodconfig",
> >> > and a large number of hwmon drivers are affected. Bisect does point
> >> > to "net: phy: sfp: Add HWMON support for module sensors", meaning
> >> > "imply hwmon" does have severe side effects and can not be used.
> >> >
> >> > I'll try to find a fix.
> >>
> >> OK, my mistake, the "make allmodconfig" works, the following "make"
> >> causes the config restart.  (I am actually doing cross builds and using
> >> an external object directory, in case that matters.)
> >>
> >> I removed the "imply HWMON" line added by the above commit and the
> >> problem went away.  Also, using "depends on HWMON || HWMON=n" instead
> >> of the imply fixes it.
> >
> > Yes, replacing imply with the dependency is what I did in the fixup patch.
> > Sorry, I should have copied you: https://patchwork.kernel.org/patch/10534925/
> >
> > It is a bit different - imply was supposed to enforce HWMON={y,n} if SFP=y,
> > and the depends line enforces SFP={n,m} if HWMON=m. I have no idea why
> > imply doesn't work, but I think I'll stay away from it in the future.
> >
> > Guenter
> 
> 
> Hmm, this could be a Kconfig bug.
> 
> I will take a look.
> 
> 
> BTW,
> 'depends on HWMON || HWMON=n' is pointless
> because it is always true.
> 

I disagree. Its purpose is to enforce SFP=m if HWMON=m while still
permitting HWMON=n.

Guenter


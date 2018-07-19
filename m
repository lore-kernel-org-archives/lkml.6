Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2444ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B63720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HePdaSCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B63720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbeGTAF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:05:58 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:38780 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbeGTAF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:05:57 -0400
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6JNKFIC002074;
        Fri, 20 Jul 2018 08:20:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6JNKFIC002074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532042416;
        bh=L0LJaIAF8Vcn5wpIhzyLgcwsbh0R/yVeY5CwsoNKI60=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=HePdaSCXe5UXc6hwa3/aun0Vt27GyL7Su+9k1PSgeOji4PkQvHkOf4Cb6nhcQMFaN
         RxyWbXqHg5aB8NFZf8AfSJaBC8+uZ6ZpVlwrLRo85y4vbWC/Zt99IM8w6dvSCGXw4e
         XSqyVCHVdia9/89Boj4ABIcffGl+ryo6nXv1J+aW0pN8bg3HWIYDYnNkLHx3p0XMPJ
         udO4DM4ARkLhKspI43gkQwt8u1Y4q6NtT0du1vcQUdxROxlOR6pSZzVBmcCvBEnH5E
         BNBxakVVEdrNe9i6Zd8fBjn4HSili8FvnxLw2K5xH7Lnv4Mm6TLsPUdLqG1/YtjfE5
         +mFIlYLHNyW2w==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id s17-v6so5229112vke.10;
        Thu, 19 Jul 2018 16:20:15 -0700 (PDT)
X-Gm-Message-State: AOUpUlFM0n3JE80wXbsvfbDy6Vk7yqEgXDtq9fFCmOqHu0naHZLJLtAo
        M7B8R8grqexbz8+lpRsM8J4hxxE251zjg/oYxCY=
X-Google-Smtp-Source: AAOMgpf5h2wmP2+pUvhRkARZIa3Tv8WpoAjUVavIwOymuGu3e95pU33Q1CLI+IVWYgA3aBZ4ljf+Dm/nd27toHtOIR0=
X-Received: by 2002:a1f:420d:: with SMTP id p13-v6mr4688825vka.10.1532042414606;
 Thu, 19 Jul 2018 16:20:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 16:19:34
 -0700 (PDT)
In-Reply-To: <20180719223521.GA30287@roeck-us.net>
References: <20180719120447.6e7ba23d@canb.auug.org.au> <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
 <20180719152940.0720e9c1@canb.auug.org.au> <6dabf12b-e3db-dfe8-101c-02772039e21a@roeck-us.net>
 <20180720080906.7a30c573@canb.auug.org.au> <20180719223521.GA30287@roeck-us.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 20 Jul 2018 08:19:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfZH=ZEdFuRq_g1HsJ+Pv1m=v343JLyE-6+uM_d+3eWA@mail.gmail.com>
Message-ID: <CAK7LNARfZH=ZEdFuRq_g1HsJ+Pv1m=v343JLyE-6+uM_d+3eWA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 7:35 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:
> On Fri, Jul 20, 2018 at 08:09:06AM +1000, Stephen Rothwell wrote:
>> Hi Guenter,
>>
>> On Thu, 19 Jul 2018 06:49:01 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>> >
>> > On 07/18/2018 10:29 PM, Stephen Rothwell wrote:
>> > >
>> > > On Wed, 18 Jul 2018 20:52:56 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>> > >>
>> > >> On 07/18/2018 07:04 PM, Stephen Rothwell wrote:
>> > >>>
>> > >>> After merging the net-next tree, today's linux-next build (x86_64
>> > >>> allmodconfig) produced this warning:
>> > >>>
>> > >>> *
>> > >>> * Restart config...
>> > >>> *
>> > >>> ....
>> > >>>
>> > >>> This is output by my "make allmodconfig" and only started after merging
>> > >>> the net-next tree today.  It has continued for further merges/builds.
>> > >>>
>> > >>> I suspect commit
>> > >>>
>> > >>>     1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
>> > >>>
>> > >>> which added an "imply" clause.
>> > >>>
>> > >> I thought "imply" was better than "depends on HWMON || HWMON=n", but maybe
>> > >> not. Is that a caveat when using "imply", and does it mean that "imply"
>> > >> should better not be used ?
>> > >
>> > > I don't know, sorry.  It was just my best guess from what I could see
>> > > had changed.
>> > >
>> > > I wonder if it makes a difference that I am doing my "make
>> > > allmodconfig" on top of a previous "make allmodconfig" and some symbols
>> > > are marked as "NEW" (though they are not symbols related to the changes
>> > > that happened during the net-next tree merge)?
>> > >
>> >
>> > I tried to reproduce the problem, but I don't see the message.
>> >
>> > What I do see, though, is that "make allmodconfig" on a clean tree,
>> > followed by "make menuconfig", results in configuration changes.
>> > Specifically,
>> >
>> >  > CONFIG_ARC_EMAC_CORE=m
>> >  > CONFIG_ARC_EMAC=m
>> >  > CONFIG_EMAC_ROCKCHIP=m
>> >
>> > is removed by menuconfig, and a large number of "# ... is not set"
>> > configuration lines are added. Weird and bad, since several of the
>> > disabled configurations _should_ be enabled by "make allmodconfig",
>> > and a large number of hwmon drivers are affected. Bisect does point
>> > to "net: phy: sfp: Add HWMON support for module sensors", meaning
>> > "imply hwmon" does have severe side effects and can not be used.
>> >
>> > I'll try to find a fix.
>>
>> OK, my mistake, the "make allmodconfig" works, the following "make"
>> causes the config restart.  (I am actually doing cross builds and using
>> an external object directory, in case that matters.)
>>
>> I removed the "imply HWMON" line added by the above commit and the
>> problem went away.  Also, using "depends on HWMON || HWMON=n" instead
>> of the imply fixes it.
>
> Yes, replacing imply with the dependency is what I did in the fixup patch.
> Sorry, I should have copied you: https://patchwork.kernel.org/patch/10534925/
>
> It is a bit different - imply was supposed to enforce HWMON={y,n} if SFP=y,
> and the depends line enforces SFP={n,m} if HWMON=m. I have no idea why
> imply doesn't work, but I think I'll stay away from it in the future.
>
> Guenter


Hmm, this could be a Kconfig bug.

I will take a look.


BTW,
'depends on HWMON || HWMON=n' is pointless
because it is always true.



-- 
Best Regards
Masahiro Yamada

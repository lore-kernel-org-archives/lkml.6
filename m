Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99165C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EDE218E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m3RcVtXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EDE218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeHNJwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:52:06 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57042 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbeHNJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:52:06 -0400
X-Greylist: delayed 15492 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2018 05:52:04 EDT
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7E75mxf024494;
        Tue, 14 Aug 2018 16:05:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7E75mxf024494
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534230350;
        bh=BD7f7WjxSsCbcutuzOUDSaHWHFrRay3V5G/fJXX6CNk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=m3RcVtXwlftySozFymzJSRzwexcwnj2KflNF69xUiYQiczI/ckOYpMQCii82YhSNx
         ilY4c0xSh2pUaMS7G/B33+zNwV/B0RFS0UNHltdKpxeoqFqr1ue6SBdymdo5d5AS21
         8KD2FbsmVzWOVsr6jW5HjvvpMzrJorcQf63qe4rkw9lcg/t4Sosi8ohioLwKPGTPYt
         4kcsBhf33czLwKzHffbiHpxN7MPLmwIByJMSRrPhXS5C2YKuBmU3xJsRknxd7FftLz
         cHx2/YoSzklu4bnmTSd0Z0hWfhOifBeTQj7AsgnZxg4EX7dwWJsL6IXU/G7uyYPVNO
         z6g+M8auDMYrQ==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id q12-v6so12037658ual.2;
        Tue, 14 Aug 2018 00:05:49 -0700 (PDT)
X-Gm-Message-State: AOUpUlHcG+v5aQYc7qS5qwxKXhc/Yhda7gThAxWWZ4N9lWqH0LM6241z
        VhT8NsrHifZAdvnjDUfEBxoTJbqTvEN8enRhOHU=
X-Google-Smtp-Source: AA+uWPzrfyd+jNzigPgCdlz5CFwRp0MSB99iHdhZG3f0UdaZrdz4SklhC7M7jnveNorU2j6eduftKE80HW9xrxrOKnE=
X-Received: by 2002:ab0:290:: with SMTP id 16-v6mr13158544uah.144.1534230348234;
 Tue, 14 Aug 2018 00:05:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 00:05:07
 -0700 (PDT)
In-Reply-To: <CAK7LNARfZH=ZEdFuRq_g1HsJ+Pv1m=v343JLyE-6+uM_d+3eWA@mail.gmail.com>
References: <20180719120447.6e7ba23d@canb.auug.org.au> <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
 <20180719152940.0720e9c1@canb.auug.org.au> <6dabf12b-e3db-dfe8-101c-02772039e21a@roeck-us.net>
 <20180720080906.7a30c573@canb.auug.org.au> <20180719223521.GA30287@roeck-us.net>
 <CAK7LNARfZH=ZEdFuRq_g1HsJ+Pv1m=v343JLyE-6+uM_d+3eWA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 16:05:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgdqpi60eH-Sfnr+U9DKpwCL=wPdhJA6=hpv3cicVotw@mail.gmail.com>
Message-ID: <CAK7LNAQgdqpi60eH-Sfnr+U9DKpwCL=wPdhJA6=hpv3cicVotw@mail.gmail.com>
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

2018-07-20 8:19 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-07-20 7:35 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:
>> On Fri, Jul 20, 2018 at 08:09:06AM +1000, Stephen Rothwell wrote:
>>> Hi Guenter,
>>>
>>> On Thu, 19 Jul 2018 06:49:01 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>> >
>>> > On 07/18/2018 10:29 PM, Stephen Rothwell wrote:
>>> > >
>>> > > On Wed, 18 Jul 2018 20:52:56 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>> > >>
>>> > >> On 07/18/2018 07:04 PM, Stephen Rothwell wrote:
>>> > >>>
>>> > >>> After merging the net-next tree, today's linux-next build (x86_64
>>> > >>> allmodconfig) produced this warning:
>>> > >>>
>>> > >>> *
>>> > >>> * Restart config...
>>> > >>> *
>>> > >>> ....
>>> > >>>
>>> > >>> This is output by my "make allmodconfig" and only started after merging
>>> > >>> the net-next tree today.  It has continued for further merges/builds.
>>> > >>>
>>> > >>> I suspect commit
>>> > >>>
>>> > >>>     1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
>>> > >>>
>>> > >>> which added an "imply" clause.
>>> > >>>
>>> > >> I thought "imply" was better than "depends on HWMON || HWMON=n", but maybe
>>> > >> not. Is that a caveat when using "imply", and does it mean that "imply"
>>> > >> should better not be used ?
>>> > >
>>> > > I don't know, sorry.  It was just my best guess from what I could see
>>> > > had changed.
>>> > >
>>> > > I wonder if it makes a difference that I am doing my "make
>>> > > allmodconfig" on top of a previous "make allmodconfig" and some symbols
>>> > > are marked as "NEW" (though they are not symbols related to the changes
>>> > > that happened during the net-next tree merge)?
>>> > >
>>> >
>>> > I tried to reproduce the problem, but I don't see the message.
>>> >
>>> > What I do see, though, is that "make allmodconfig" on a clean tree,
>>> > followed by "make menuconfig", results in configuration changes.
>>> > Specifically,
>>> >
>>> >  > CONFIG_ARC_EMAC_CORE=m
>>> >  > CONFIG_ARC_EMAC=m
>>> >  > CONFIG_EMAC_ROCKCHIP=m
>>> >
>>> > is removed by menuconfig, and a large number of "# ... is not set"
>>> > configuration lines are added. Weird and bad, since several of the
>>> > disabled configurations _should_ be enabled by "make allmodconfig",
>>> > and a large number of hwmon drivers are affected. Bisect does point
>>> > to "net: phy: sfp: Add HWMON support for module sensors", meaning
>>> > "imply hwmon" does have severe side effects and can not be used.
>>> >
>>> > I'll try to find a fix.
>>>
>>> OK, my mistake, the "make allmodconfig" works, the following "make"
>>> causes the config restart.  (I am actually doing cross builds and using
>>> an external object directory, in case that matters.)
>>>
>>> I removed the "imply HWMON" line added by the above commit and the
>>> problem went away.  Also, using "depends on HWMON || HWMON=n" instead
>>> of the imply fixes it.
>>
>> Yes, replacing imply with the dependency is what I did in the fixup patch.
>> Sorry, I should have copied you: https://patchwork.kernel.org/patch/10534925/
>>
>> It is a bit different - imply was supposed to enforce HWMON={y,n} if SFP=y,
>> and the depends line enforces SFP={n,m} if HWMON=m. I have no idea why
>> imply doesn't work, but I think I'll stay away from it in the future.
>>
>> Guenter
>
>
> Hmm, this could be a Kconfig bug.
>
> I will take a look.


Today, I took a look at it.

The cause of the problem was the circular dependency.

Somehow, 'imply' is not checked in the circular dependency.

So, I wrote patches to report this.
https://patchwork.kernel.org/patch/10565061/
https://patchwork.kernel.org/patch/10565063/


If you apply those two patches on top of commit
1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
It is reported in allmodconfig stage, like this:


masahiro@grover:~/ref/linux-next$ make allmodconfig
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --allmodconfig Kconfig
drivers/of/Kconfig:68:error: recursive dependency detected!
drivers/of/Kconfig:68: symbol OF_IRQ depends on IRQ_DOMAIN
kernel/irq/Kconfig:63: symbol IRQ_DOMAIN is selected by REGMAP
drivers/base/regmap/Kconfig:6: symbol REGMAP is selected by SENSORS_ASPEED
drivers/hwmon/Kconfig:352: symbol SENSORS_ASPEED depends on HWMON
drivers/hwmon/Kconfig:5: symbol HWMON is implied by SFP
drivers/net/phy/Kconfig:214: symbol SFP depends on PHYLIB
drivers/net/phy/Kconfig:181: symbol PHYLIB is selected by ARC_EMAC_CORE
drivers/net/ethernet/arc/Kconfig:18: symbol ARC_EMAC_CORE is selected
by ARC_EMAC
drivers/net/ethernet/arc/Kconfig:24: symbol ARC_EMAC depends on OF_IRQ
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"

#
# configuration written to .config
#




>
>
> BTW,
> 'depends on HWMON || HWMON=n' is pointless
> because it is always true.



-- 
Best Regards
Masahiro Yamada

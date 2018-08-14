Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D09C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECED21741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL0lFsX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECED21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbeHNQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:15:29 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40273 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeHNQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:15:29 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so8313912plp.7;
        Tue, 14 Aug 2018 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DRrpz+iSPP+xrFDBb7J7EZIhj8m7B7IbW0REW4izP7A=;
        b=dL0lFsX/rH79PbXrDNJzgLrUHjDJyoPh1m5oxx6a88fkPpEk6GVwoLR6nGwIsjo3RN
         u873CC96q2bl5B4/3YqH8FmwfYinXsJDEINl5d6Pol/hmW+YT11qLiamyduBZa5pUcjR
         yUExycBuBQRDl0j8n4DXyWQ44F2I7q4lbSzhdtBFzns87SveMitsd/1+Lwtarw8IVs5f
         Sv9eRThiYTGECjVSiWof/iwdQpCXAA6gbuFZbmUISj1yYeAJnOTOjXBepw9AyaFPGjIv
         Jwl5Dgz2enWszGjvLRo4Tgl1Iz29Q+nWJiZRN+GETKNp02U1Scolfxgr4PpFIffsLatu
         Oh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRrpz+iSPP+xrFDBb7J7EZIhj8m7B7IbW0REW4izP7A=;
        b=XElQxApIcjpOdZV2cfCE9+FBIX8Jc00jp91ISFpB067wmUf1XdV143j1+fEfgc1fmT
         piwg42HbRa5JxU7Vw61UHCVUpC+LdgLpIP5z+WXCB7bcsi0Sl9AePXSEL5wu48upZ9Br
         qr9fYOR/7IrGqOOF/nkPJO9PZRqiz7S3MKXc2/+uyNQBaTZH52Jh+0rQbHQkl/6LpvqJ
         HpxMblB1CDsXYdoqHHuAQfEBi3IrKzhteO2UkjKhmdln8SqyWWS3TuOV7p2phQVcvrzU
         QhJKFlGmAvw2IxDnmRtG7bDHDxcDIrlS03Zcb/V+i2rn9wTcaUn4nz6B17vFyeGtirr1
         cCtw==
X-Gm-Message-State: AOUpUlEQv2hlVMpdhiR0u6jAMAWI4++MI0Bupz8kFNS2NvqQcQ/tzY6Z
        X9y2ot43P0gry4FrPiaOtXs=
X-Google-Smtp-Source: AA+uWPxIXYjFhpCjgkfQPKAMtUEY0VGrudg6pDy78uzJjeEdAXuWW9BijoIdc8qfADJb0aho0uk6kg==
X-Received: by 2002:a17:902:22e:: with SMTP id 43-v6mr20559743plc.118.1534253298457;
        Tue, 14 Aug 2018 06:28:18 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r23-v6sm37362510pfj.5.2018.08.14.06.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:28:17 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
References: <20180719120447.6e7ba23d@canb.auug.org.au>
 <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
 <20180719152940.0720e9c1@canb.auug.org.au>
 <6dabf12b-e3db-dfe8-101c-02772039e21a@roeck-us.net>
 <20180720080906.7a30c573@canb.auug.org.au>
 <20180719223521.GA30287@roeck-us.net>
 <CAK7LNARfZH=ZEdFuRq_g1HsJ+Pv1m=v343JLyE-6+uM_d+3eWA@mail.gmail.com>
 <CAK7LNAQgdqpi60eH-Sfnr+U9DKpwCL=wPdhJA6=hpv3cicVotw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2146bdab-2885-931a-b878-4aac10bb1897@roeck-us.net>
Date:   Tue, 14 Aug 2018 06:28:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQgdqpi60eH-Sfnr+U9DKpwCL=wPdhJA6=hpv3cicVotw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 12:05 AM, Masahiro Yamada wrote:
> 2018-07-20 8:19 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> 2018-07-20 7:35 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:
>>> On Fri, Jul 20, 2018 at 08:09:06AM +1000, Stephen Rothwell wrote:
>>>> Hi Guenter,
>>>>
>>>> On Thu, 19 Jul 2018 06:49:01 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> On 07/18/2018 10:29 PM, Stephen Rothwell wrote:
>>>>>>
>>>>>> On Wed, 18 Jul 2018 20:52:56 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>>
>>>>>>> On 07/18/2018 07:04 PM, Stephen Rothwell wrote:
>>>>>>>>
>>>>>>>> After merging the net-next tree, today's linux-next build (x86_64
>>>>>>>> allmodconfig) produced this warning:
>>>>>>>>
>>>>>>>> *
>>>>>>>> * Restart config...
>>>>>>>> *
>>>>>>>> ....
>>>>>>>>
>>>>>>>> This is output by my "make allmodconfig" and only started after merging
>>>>>>>> the net-next tree today.  It has continued for further merges/builds.
>>>>>>>>
>>>>>>>> I suspect commit
>>>>>>>>
>>>>>>>>      1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
>>>>>>>>
>>>>>>>> which added an "imply" clause.
>>>>>>>>
>>>>>>> I thought "imply" was better than "depends on HWMON || HWMON=n", but maybe
>>>>>>> not. Is that a caveat when using "imply", and does it mean that "imply"
>>>>>>> should better not be used ?
>>>>>>
>>>>>> I don't know, sorry.  It was just my best guess from what I could see
>>>>>> had changed.
>>>>>>
>>>>>> I wonder if it makes a difference that I am doing my "make
>>>>>> allmodconfig" on top of a previous "make allmodconfig" and some symbols
>>>>>> are marked as "NEW" (though they are not symbols related to the changes
>>>>>> that happened during the net-next tree merge)?
>>>>>>
>>>>>
>>>>> I tried to reproduce the problem, but I don't see the message.
>>>>>
>>>>> What I do see, though, is that "make allmodconfig" on a clean tree,
>>>>> followed by "make menuconfig", results in configuration changes.
>>>>> Specifically,
>>>>>
>>>>>   > CONFIG_ARC_EMAC_CORE=m
>>>>>   > CONFIG_ARC_EMAC=m
>>>>>   > CONFIG_EMAC_ROCKCHIP=m
>>>>>
>>>>> is removed by menuconfig, and a large number of "# ... is not set"
>>>>> configuration lines are added. Weird and bad, since several of the
>>>>> disabled configurations _should_ be enabled by "make allmodconfig",
>>>>> and a large number of hwmon drivers are affected. Bisect does point
>>>>> to "net: phy: sfp: Add HWMON support for module sensors", meaning
>>>>> "imply hwmon" does have severe side effects and can not be used.
>>>>>
>>>>> I'll try to find a fix.
>>>>
>>>> OK, my mistake, the "make allmodconfig" works, the following "make"
>>>> causes the config restart.  (I am actually doing cross builds and using
>>>> an external object directory, in case that matters.)
>>>>
>>>> I removed the "imply HWMON" line added by the above commit and the
>>>> problem went away.  Also, using "depends on HWMON || HWMON=n" instead
>>>> of the imply fixes it.
>>>
>>> Yes, replacing imply with the dependency is what I did in the fixup patch.
>>> Sorry, I should have copied you: https://patchwork.kernel.org/patch/10534925/
>>>
>>> It is a bit different - imply was supposed to enforce HWMON={y,n} if SFP=y,
>>> and the depends line enforces SFP={n,m} if HWMON=m. I have no idea why
>>> imply doesn't work, but I think I'll stay away from it in the future.
>>>
>>> Guenter
>>
>>
>> Hmm, this could be a Kconfig bug.
>>
>> I will take a look.
> 
> 
> Today, I took a look at it.
> 
> The cause of the problem was the circular dependency.
> 
> Somehow, 'imply' is not checked in the circular dependency.
> 
> So, I wrote patches to report this.
> https://patchwork.kernel.org/patch/10565061/
> https://patchwork.kernel.org/patch/10565063/
> 
> 
> If you apply those two patches on top of commit
> 1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
> It is reported in allmodconfig stage, like this:
> 
> 
> masahiro@grover:~/ref/linux-next$ make allmodconfig
>    HOSTCC  scripts/kconfig/conf.o
>    YACC    scripts/kconfig/zconf.tab.c
>    HOSTCC  scripts/kconfig/zconf.tab.o
>    HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --allmodconfig Kconfig
> drivers/of/Kconfig:68:error: recursive dependency detected!
> drivers/of/Kconfig:68: symbol OF_IRQ depends on IRQ_DOMAIN
> kernel/irq/Kconfig:63: symbol IRQ_DOMAIN is selected by REGMAP
> drivers/base/regmap/Kconfig:6: symbol REGMAP is selected by SENSORS_ASPEED
> drivers/hwmon/Kconfig:352: symbol SENSORS_ASPEED depends on HWMON
> drivers/hwmon/Kconfig:5: symbol HWMON is implied by SFP
> drivers/net/phy/Kconfig:214: symbol SFP depends on PHYLIB
> drivers/net/phy/Kconfig:181: symbol PHYLIB is selected by ARC_EMAC_CORE
> drivers/net/ethernet/arc/Kconfig:18: symbol ARC_EMAC_CORE is selected
> by ARC_EMAC
> drivers/net/ethernet/arc/Kconfig:24: symbol ARC_EMAC depends on OF_IRQ
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> 

Interesting; I thought that "implied" does not really select the symbol.
That means 'imply' just doesn't work for HWMON, and we'll have to stick
with the old "depends on HWMON || HWMON=n".

Thanks,
Guenter

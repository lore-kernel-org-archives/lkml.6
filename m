Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2241IIitC6TIEhVOD/JrbGbUdYRusrlzqRghC9RUt43AdE7d61+qw1YgrLLe4xxPxkWdoiNY
ARC-Seal: i=1; a=rsa-sha256; t=1519145556; cv=none;
        d=google.com; s=arc-20160816;
        b=U+Fx5O23MC/B9BJgpKzBoVo2GOtommqjatmMUhgHb6FohG2mm9De4/GM6SMpnqBOrU
         KMR75ULkE0vNeIlNgnXQydogHneYH2afYmtc7GVTiKR/VzBK7loF6+yzUUswVZdfA5RL
         PR3ELeq+x+9NQsVPaF/Dc1HA9X/rFCmuSbpwGgdEptCDaS5VHF4U+LMc4QszzvrRF5TP
         2zoFAnhuffy9x0E5VGY474gA3swdWL5go/lqpQnd0eSuQYnmJkGN/+gVmZJ5aj4dpB1X
         KwES2zhiRD9FR4VMIrs14mY/FyRjqI731+efQVrxOxtYHyU0U3Oj6I9TCbS0x+3LgyxS
         EITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=47L1W4ar+sIaSJ+7ujaOEoZGmsi72Dps2uHpNlRGfT4=;
        b=bNvgel8zAnUApVDmHjOB96SyDnzFiAuEtoz0Vo2UxL2QRa+VeiRCKjDHET/d1a7vhQ
         Fdtw8i47OzPuLiIc9hOXEv/TN+8SfBpdiB/5e6hVzi4PRoyFOYHDbNnPB2gSSda/fN2q
         KRcih93eYXfZgSoUWYawpL2byJuQ8IdgBPgniIcL5ioqaXYFBlIcRn4h7rKua/Q37lbj
         VOUSwjXdEBZmzo54LYXT20visY7oS1A3XR2YCoktzXZFSlgJ6yvSeFIFPysyi+FWC918
         sWATWsg6umRtPAPhfKAjSdPV9cDS5v7XEqTcEMVKHbu42F3MJLiKZOTO1F6z4HmRanYE
         i2Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=y2HFoXkW;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=y2HFoXkW;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1KGqBej023494
X-Nifty-SrcIP: [209.85.217.176]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2WYKQPJ_y9O_HpgbwN9-b9isKkYJH4niLA02MD2uH+2w@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-4-arnd@arndb.de>
 <CAK7LNAQVSVtXzWXjLRAQXynSvHHbiF1xYLhjLBwPfFOpnX_NRA@mail.gmail.com> <CAK8P3a2WYKQPJ_y9O_HpgbwN9-b9isKkYJH4niLA02MD2uH+2w@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 01:51:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmGVRZv0G2dg+TYhmK6-PXv0b0OMpkzLjuahsYUq+qjQ@mail.gmail.com>
Message-ID: <CAK7LNATmGVRZv0G2dg+TYhmK6-PXv0b0OMpkzLjuahsYUq+qjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kconfig: add a default allrandom.config
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595421999203989?=
X-GMAIL-MSGID: =?utf-8?q?1592939571150626023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-20 20:11 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 20, 2018 at 10:16 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> Building randconfig kernels frequently leads to build errors from
>>> drivers that have additional build dependencies, or that we don't
>>> want to build for compile-testing for some other reason.
>>
>> Can you fix the former case?
>
> I'm sure it can be done with runtime detection of the tools, not sure if that's
> a good idea. What we would need here is
>
> CONFIG_WANXL_BUILD_FIRMWARE: needs to check for as68k and ld68k
> CONFIG_AIC79XX_BUILD_FIRMWARE: needs flex, bison and berkeley db.
>         I have all those but it still failed to build for me.
> STANDALONE now (after the removal of sound/oss) only controls
>       ACPI_CUSTOM_DSDT_FILE, we could remove STANDALONE now
>       I think, it doesn't actually get in the way of anything. For the stable
>       kernels, I'd still need to deal with CONFIG_STANDALONE for the oss
>       drivers.
>
> My feeling right now is that we're better off making both STANDALONE
> and PREVENT_FIRMWARE_BUILD depend on !COMPILE_TEST,
> and then find a way to force that.
>
>>> We already have a couple of compile-time options that can deal with this
>>> problem, but the complete set is not documented well.  We also have a
>>> method to override some options during 'make randconfig' and a couple
>>> of other make targets. However, we don't yet combine those two.
>>
>>
>> From this statement,
>>
>> kernel/configs/compile_test.config
>>
>> would make more sense?
>
> My original thought was that the allrandom.config file name is already
> documented and I just wanted a more consistent behavior, not come
> up with something new.


I thought this would be used by merge_config.sh,
but I understood allrandom.config would be better.



>>> This adds a new allrandom.config file to turn on CONFIG_COMPILE_TEST,
>>> CONFIG_STANDALONE and CONFIG_PREVENT_FIRMWARE_BUILD for all randconfig
>>> builds. This in turn disables some other options that we already try
>>> to avoid in 'allmodconfig' builds and that make no sense in a general
>>> randconfig build.
>>>
>>> Building with 'make randconfig KCONFIG_ALLCONFIG=1' should now always
>>
>>
>> Can you type 'make randconfig compile_test.config', instead?
>>
>> (Or 'make allmodconfig compile_test.config' for full-build test)
>>
>>
>> The merge_config has a little bit different logic
>> from KCONFIG_ALLCONFIG=1, but I guess it leads to the almost same result.
>
> I suspect that one difference in a randconfig kernel is that all options that
> depend on CONFIG_COMPILE_TEST have a 50% lower chance of getting
> enabled that way, but eventually they will get enabled.
>

You are right.

The behavior is slightly different.


-- 
Best Regards
Masahiro Yamada

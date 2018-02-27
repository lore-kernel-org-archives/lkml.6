Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227RdXhHbp3GKcSNewHCnvrGpJeD6EIWPRsAk0lz+MWr6X9k8TcfEC09hRdTW7a7EZ28i20Q
ARC-Seal: i=1; a=rsa-sha256; t=1519727033; cv=none;
        d=google.com; s=arc-20160816;
        b=eRJGolWWgjsevu0p3rAdtKaJcXLMeZIM3jIpeoW1GkmSVzBEd2Sa+oTCQ851bUv+cE
         fSfmme88ZdsXNh53xsuWhQJNQgtmJESIr5Cw1RYUIzGeCsG3HLK+N8RqpSCGKv8fWfSD
         KXukaiWmOVHT8cy1w38+NdVmMu6njphguqtK+yaj3PldE2cnHQTeDPkwtXfAFpv0/9P9
         cgrecM5ohvCTaORkJEsa2SKckjh/hpr8sXfSvIRJzblN2G9vbW+8uVCB0lsmjVUGleow
         EnXIXxvJOJYlki/JSEdyq5z1Hwj3sg+d4SiGwLliUX3fgdewhSK3kSqbJ/W8tirqoKx+
         t8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=CnW6EjRvBLJy0UBl0bmPG5axcH4HtmvxGBl7hKiM2NE=;
        b=bXkXaz4CwmTkcIcpAzDhNy9hB1Au7vFxstSli4h6iXAGzFCtrMBOE7n2I6Gx9HAUAM
         7Z6Yw3x0iGWam7AbF+EgDauU51tpheAgOgVLRgx6n2SOItIinfDfStyWED+aCNqwkowP
         o32v3Wau4ktLMIaA54mZViSCpcKjfSAIWhaCPZdkcb+YY/1dlREVhmaT6pjLuA0TJ7Pr
         m7IZ/PM3YF7CAHUvrLr0Q0Y9o8wnjoLqs2TMBUBKmBLlvNIDdqfpa3YekdNAuOfN5yLA
         XnsW5slO1UIWKE3jW4mii81/tS+5NjkXeaksAbqQemySKxHZvarZrtOqv3eXtyaxxcKp
         NrSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=1kP9k+zP;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=1kP9k+zP;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1RANbG2023529
X-Nifty-SrcIP: [209.85.217.182]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1cEcBTiH7_gcUPZtsuRaeoOYaH3H4cYxkUBQiLMTMq=A@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
 <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
 <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com>
 <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com> <CAK8P3a1cEcBTiH7_gcUPZtsuRaeoOYaH3H4cYxkUBQiLMTMq=A@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 27 Feb 2018 19:22:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNASOzMdk_ej-U_T3_m-OtseJUOs+TqUv-BqZFLvS3e0kww@mail.gmail.com>
Message-ID: <CAK7LNASOzMdk_ej-U_T3_m-OtseJUOs+TqUv-BqZFLvS3e0kww@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593294329790174573?=
X-GMAIL-MSGID: =?utf-8?q?1593549294127030724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-27 18:03 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 27, 2018 at 1:46 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-26 21:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Mon, Feb 26, 2018 at 12:53 PM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2018-02-26 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
>>>>> <yamada.masahiro@socionext.com> wrote:
>>>>>> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
>>>>>> used with care - it forces a lower limit of another symbol, ignoring
>>>>>> the dependency.
>>>>>>
>>>>>> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
>>>>>> select it.
>>>>>>
>>>>>> This causes unmet dependencies for architecture without HAS_IOMEM.
>>>>>>
>>>>>>   $ make ARCH=score randconfig
>>>>>>   scripts/kconfig/conf  --randconfig Kconfig
>>>>>>   KCONFIG_SEED=0x27C47F43
>>>>>>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>>>>>>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>>>>
>>>>>> Use 'depends on' to observe the dependency.
>>>>>>
>>>>>> This commit was created by the following command:
>>>>>>
>>>>>>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>>>>>>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>>>>>>
>>>>>> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>>>>>>
>>>>>> Also, make MFD_SYSCON 'default y' because some defconfig files may
>>>>>> rely on someone select's MFD_SYSCON.
>>>>>>
>>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>>> ---
>>>>>>
>>>>>> If you have a better idea to fix 'unmet dependencies',
>>>>>> please suggest.
>>>>>
>>>>> Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
>>>>> of defconfig configurations, I'd rather not do that.
>>>>
>>>>
>>>> Could you explain why?
>>>>
>>>> I set 'default y' for MFD_SYSCON.
>>>>
>>>> Would it still break defconfig configurations?
>>>
>>> No, you are right, that would not break defconfigs, it would just mean one
>>> useless driver being enabled for many configurations that don't need it.
>>
>> If we are unhappy about this,
>> we can send per-arch patches
>> to add CONFIG_MTD_SYSCON=y to defconfigs that need it.
>>
>> But, we need to decide what the right solution is.
>
> I think for consistency, we should change the existing
> 'depends on MFD_SYSCON' to 'select MFD_SYSCON'. This
> matches what we do with REGMAP_MMIO.
>
> MFD_SYSCON is really a thin wrapper around REGMAP_MMIO,
> so I would keep using the same conventions here, even though
> we normally prefer to not 'select' any user-visible options.
>
> It might be possible to make MFD_SYSCON a silent symbol
> as well, but we'd have to make sure that all users select the symbol
> then.
>
>         Arnd


If we agree, I can send the following three patches.


[1] Add "depends on HAS_IOMEM"
    to all drivers selecting MFD_SYSCON
    (Unmet dependencies will be fixed by this)

[2] For consistency, convert existing "depends on MFD_SYSCON"
    to "select MFD_SYSCON" + "depends on HAS_IOMEM"

[3] Change MFD_SYSCON to user-unconfigurable option.
    But, for COMPILE_TEST, allow users to enable it independently.
    Like follows:

    config MFD_SYSCON
        bool "System Controller Register R/W Based on Regmap" if COMPILE_TEST
        select REGMAP_MMIO
        help
          Select this option to enable accessing system control registers
          via regmap.


Is this OK?


-- 
Best Regards
Masahiro Yamada

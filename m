Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519722231; cv=none;
        d=google.com; s=arc-20160816;
        b=zCClKN0Y7c1u9qItl6GO7ldy6+Dc00VoRloHuVoaBxfQ7OZuySVq4fnROnuvKbb980
         qJJdh4u22juQMoKE9ioepfHg556nu9s3dpDrRgzsmj4ufJZIg6UI5n1+aQ00edWp8w6G
         9HyfDqooG1nF+nEEalw8xkWeS4nHtTYg24LqXmTwcikOIhSPezQMryIvNriwWADwfi8y
         yL6gLLgojMdrXhrBl1Ruk0C5XnTXk2/nzzakfs6yOJbqvi1pcf2O7+puBFqO/i9bNc04
         +hS2ICX9wQ/WFZqnfPWJFGJLYJdbJdYW8cv5aetkydRMNL1b09Yh8N1KZ0wbsRdmk5fG
         9eTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=SYLc8bRIn9K/ucZH85dALN4Fk2eXiHfxuhH53ON72lk=;
        b=NxunC8RAI30gGgW3A0oihoGaYPmr8GrE4cxYMJ3SiDYgmcxPjYlCL6cDbXHqo7y/53
         2ye1hb0bh65EDdue76xnuKZ5sG+H+Fis9IzpQN0JAlWU0IxEQH7zefe8/flh6DfJ6ak5
         pEJDLnXlnNiDfHngBKLtisp2x0BAHDf+5MTrE1TJESzYsNyE37Hed6cCM7v/vnSY6JIs
         llMEX4EJ3PdLqfEoJYTZ2s7Ezp1u5z2ukeqEnTQLxY5ql6mB3FsDhmYsTsI8bPbzQaTm
         SQ339CPv++Jv9TOM58FYBsWOhjQ3h99WD/UxTiZB9C0Ikst/WJDQcP4YthYyOJqlFIDW
         2jeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uoGvtmQL;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uoGvtmQL;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELt7cz1Z0ko5TbQYSEfylQH+lEwiGlmTC/BDmWyXgwbZueAf67wE7XAWj0lIfKxCT+UTbmfMCoSCXCTp/9CQQEk=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
References: <1519483851-31135-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a26kkcmzT450326=xHXjynG=uNYi2w07w6T+T01zQOQag@mail.gmail.com>
 <CAK7LNAT8sRDNZKbcpXY+e98O+sJHw9vUM9bKvdmVZNuEEQoMdA@mail.gmail.com>
 <CAK8P3a3zMG4wV9SWg78NGmk=BU9yq5paxZvJ=coHCWxVgNhO2w@mail.gmail.com> <CAK7LNAQBLTk7rduT2eQQKRhRiGTw-8MRhpz2ZJdEwKTx=-zY-Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Feb 2018 10:03:50 +0100
X-Google-Sender-Auth: 8zinBAi4-u2uLCRUAzJ7EYjYYBE
Message-ID: <CAK8P3a1cEcBTiH7_gcUPZtsuRaeoOYaH3H4cYxkUBQiLMTMq=A@mail.gmail.com>
Subject: Re: [RFC PATCH] drivers: use 'depends on MFD_SYSCON' instead of
 'select MFD_SYSCON'
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593294329790174573?=
X-GMAIL-MSGID: =?utf-8?q?1593544258334715805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 1:46 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-26 21:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Feb 26, 2018 at 12:53 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> 2018-02-26 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>>> On Sat, Feb 24, 2018 at 3:50 PM, Masahiro Yamada
>>>> <yamada.masahiro@socionext.com> wrote:
>>>>> As Documentation/kbuild/kconfig-language.txt notes, 'select' should be
>>>>> used with care - it forces a lower limit of another symbol, ignoring
>>>>> the dependency.
>>>>>
>>>>> MFD_SYSCON depends on HAS_IOMEM, but several drivers with COMPILE_TEST
>>>>> select it.
>>>>>
>>>>> This causes unmet dependencies for architecture without HAS_IOMEM.
>>>>>
>>>>>   $ make ARCH=score randconfig
>>>>>   scripts/kconfig/conf  --randconfig Kconfig
>>>>>   KCONFIG_SEED=0x27C47F43
>>>>>   warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && ...)
>>>>>   selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>>>
>>>>> Use 'depends on' to observe the dependency.
>>>>>
>>>>> This commit was created by the following command:
>>>>>
>>>>>   $ find drivers -name 'Kconfig*' | xargs sed -i -e \
>>>>>     's/select MFD_SYSCON$/depends on MFD_SYSCON/'
>>>>>
>>>>> Then, COMMON_CLK_NXP and S3C2410_WATCHDOG were fixed up manually.
>>>>>
>>>>> Also, make MFD_SYSCON 'default y' because some defconfig files may
>>>>> rely on someone select's MFD_SYSCON.
>>>>>
>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>> ---
>>>>>
>>>>> If you have a better idea to fix 'unmet dependencies',
>>>>> please suggest.
>>>>
>>>> Changing 'select MFD_SYSCON' to 'depends on' will definitely break lots
>>>> of defconfig configurations, I'd rather not do that.
>>>
>>>
>>> Could you explain why?
>>>
>>> I set 'default y' for MFD_SYSCON.
>>>
>>> Would it still break defconfig configurations?
>>
>> No, you are right, that would not break defconfigs, it would just mean one
>> useless driver being enabled for many configurations that don't need it.
>
> If we are unhappy about this,
> we can send per-arch patches
> to add CONFIG_MTD_SYSCON=y to defconfigs that need it.
>
> But, we need to decide what the right solution is.

I think for consistency, we should change the existing
'depends on MFD_SYSCON' to 'select MFD_SYSCON'. This
matches what we do with REGMAP_MMIO.

MFD_SYSCON is really a thin wrapper around REGMAP_MMIO,
so I would keep using the same conventions here, even though
we normally prefer to not 'select' any user-visible options.

It might be possible to make MFD_SYSCON a silent symbol
as well, but we'd have to make sure that all users select the symbol
then.

        Arnd

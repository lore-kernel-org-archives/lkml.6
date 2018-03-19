Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521472884; cv=none;
        d=google.com; s=arc-20160816;
        b=WknV+SdDvkGN/GfEQqPu8taHnxiKPpqGbwDDOmpj1wyOQ4ov6xjOAdBqGMmi7iU9a1
         EzahHtC2Hc4HWOXkJfJpNvlKBQSAd20H7tdAYnTscxPJtF5pLfjJ3wufQIibB5saK61G
         BRoP0edazB/FbTdYrG4lGu7BqmmdYTFXpk/uK8eD2T1fkT39tv6VVpijs9gP3TiVaJE2
         m0IYIxB04uJ7jQpGRQLYl2yMdD+oE7v7LXmfn8D/tndGyR7/Vvz+W++lP6b5587WNogR
         9WqTDazspxYEz/USQS0wBV32+mYr3WArRa/0N7HjANAzxc3QoU2vG5fagD7nFyQS4pye
         xbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=maLRQFwWRFvWzxx/57OLTrUyesWSHv/zhMFp9wSP5+o=;
        b=w/BKOuSDJfrhJTyCheS1R/y6Z3S7L1+0kynAD2+XjG0SHSt3A3tExrEH1F3iV4UUm5
         WrAA1NSA7dNIVr66/6fe1zMzv/naOteFCgOKMffJeYVlSJ8BM44OFYj7skDMst7fqgPI
         vn0gL7Oj52QfJ9DIuckcfd4R0bsQ9FbQCjMqij8kByI72zUx2vpBzH+YFXbxlYQ6nSiM
         YgdG7HDgs20q1AI3sQRlLA4NSTMoLeVrlFauL9y7TIikBuvE+CLTqpUE2Mn8/wOiujEB
         X51DmMc30QezSoo2THe8odWWQBid/gAQf8wtx7fFnV5UlrdofZwLul0PNHyNaCqxnTvC
         lbuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=cqqpoCO8;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=cqqpoCO8;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELvj1lwZgc6GX7ZKlAOIn4r3ZZy7Jo6nZTPAR3+lgrbrs4xXfCbe28Lf5iv6i93aWikRHfIU1pZtfH1g8R4WWLI=
MIME-Version: 1.0
In-Reply-To: <CAHp75VevXq6NwpmvTU_2GzSdLjUQ47RLM__M3jNLBjZ1YoeQHw@mail.gmail.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <CAHp75VevXq6NwpmvTU_2GzSdLjUQ47RLM__M3jNLBjZ1YoeQHw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Mar 2018 16:21:23 +0100
Message-ID: <CAMRc=MdKor4Hb-VWqczVgiatLU+HKW-u6D-1=b_xnvz_QJhO9g@mail.gmail.com>
Subject: Re: [PATCH 00/21] eeprom: at24: driver refactoring
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357052478188626?=
X-GMAIL-MSGID: =?utf-8?q?1595379951458289339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-19 15:43 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Mon, Mar 19, 2018 at 11:17 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> This series contains what I hope to be a non-controversial refactoring
>> of the at24 eeprom driver.
>>
>> Most changes revolve around at24_probe() which became quite complicated
>> and hard to read.
>>
>> The only functional changes are: disabling the internal locking
>> mechanisms of regmap (since we already take care of that in the driver)
>> and removing an if checking if byte_len is a power of 2 (as we do
>> support models for which it's not true).
>>
>> All other patches affect readability and code structure.
>>
>> Tested with a couple models and different both for device tree and
>> platform data modes.
>
> Is there any available tree with that series applied?
> I would test it on Intel Galileo Gen 2 which has ACPI enumerated AT24
> EEPROM attached.
>

Yes, it's in my github tree:

    https://github.com/brgl/linux    topic/at24/refactoring

Thanks in advance for testing it!

Best regards,
Bartosz

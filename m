Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521643940; cv=none;
        d=google.com; s=arc-20160816;
        b=alAqiyu2cLKZFeSG2SJSKdCunHvaWsES2+vgkmQklv1Hr3n8qw2ZXu0+49mC4XPII7
         ICrl5O3fakAoYYN+5OydL1Hpxh7v7X7u0Qy6algluvp5+c9JReh8xOExTsX3M3TnXTs8
         3hTml+HPQkFO0Rf2MgK50cpA7Mx0HYYquYXbPDilG2bY+M8yqmS8NKXsKdyIujR+IzPw
         Dmiy2dbvqfT1nw5FZKP9CiqPDVmlZidCFEswawQoOhWiyMTCHAfFzYej/ozS3FonHBfc
         fr3fZurJZyHfTJRm9t/ivWmCV5a2Rer6xnfs8FDyg+H5Ao3gV3kJlDA+ikFQ6TPPgzcy
         aPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UPGpZU7886wiKpM1OxkZ2sZI2t9ZiRv3Lx4k7RWUuWQ=;
        b=h69ErBleizLkyC9zdelNAxvMguepAPoXDKtCCM0Txb2xMfQJR3i39o8PHUGTitOF1m
         JDlbUnLBbVzzjnRggunckb4eh5bS55dlXCB/EY65k+OJ4Ui8qS6qZyUSDB0s2DeGets6
         4NHjUkGfMkFDuYiU2zJ6nWNkDq75kpgdz6OBtS7Vk6eSQoIcVvGwcRMFydJ8TiWY2dED
         +WUHwJWNKDnuGlOdmST8L/fv354stifLb/y9fypOdxpdQSy1aIV3eiBNXiykjkcmEvip
         P7wFXultMrJfxhbcU5rY3CoN4PGgLL+kG3y0+/o3rz6d1gqLO5WtB16jTl6YDHBG8CJM
         uT6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fv4xZkMU;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fv4xZkMU;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtjh6HqWc8+g/DFPBOeg7ZKjduRJS/zmQPq+6OcGzmT/Em5PV63qMDFAvQk6UyPMzkYcL8+2bPAwuP4PsdOccY=
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdKor4Hb-VWqczVgiatLU+HKW-u6D-1=b_xnvz_QJhO9g@mail.gmail.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <CAHp75VevXq6NwpmvTU_2GzSdLjUQ47RLM__M3jNLBjZ1YoeQHw@mail.gmail.com>
 <CAMRc=MdKor4Hb-VWqczVgiatLU+HKW-u6D-1=b_xnvz_QJhO9g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Mar 2018 16:52:19 +0200
Message-ID: <CAHp75VfLzE===+4LpjyP5Zjzg7TCDiwf5udQEq-TtxjCbYXFpw@mail.gmail.com>
Subject: Re: [PATCH 00/21] eeprom: at24: driver refactoring
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357052478188626?=
X-GMAIL-MSGID: =?utf-8?q?1595559316552870108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 5:21 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-03-19 15:43 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> On Mon, Mar 19, 2018 at 11:17 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> This series contains what I hope to be a non-controversial refactoring
>>> of the at24 eeprom driver.
>>>
>>> Most changes revolve around at24_probe() which became quite complicated
>>> and hard to read.
>>>
>>> The only functional changes are: disabling the internal locking
>>> mechanisms of regmap (since we already take care of that in the driver)
>>> and removing an if checking if byte_len is a power of 2 (as we do
>>> support models for which it's not true).
>>>
>>> All other patches affect readability and code structure.
>>>
>>> Tested with a couple models and different both for device tree and
>>> platform data modes.
>>
>> Is there any available tree with that series applied?
>> I would test it on Intel Galileo Gen 2 which has ACPI enumerated AT24
>> EEPROM attached.
>>
>
> Yes, it's in my github tree:
>
>     https://github.com/brgl/linux    topic/at24/refactoring
>
> Thanks in advance for testing it!

At least this didn't break AT24 on Intel Galileo Gen 2 board in ACPI mode.

Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko

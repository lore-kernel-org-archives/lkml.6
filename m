Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081717-1527020471-2-6863772746878501030
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527020470; b=YmHugnzHm+14zzcQVw+Y/sYKjUzAedQLL/azsCJ9rZ3uvJwAMb
    ODqFCSy351fifuheNfsI2HWFpDmz3TxRcg+UaCZ8B7KHwDZUiQCV2o2FFLVtl9BD
    Qk0p8rrJcrL46+zl9G2diuZNMFeSAWkNTrC5XStVjBztI780Zb6xIF/nT3kLYqlF
    x3m+x8etIkYOLlYDsErxIdaGuxODrRciXn9eYCpXxJ5pN5MqhVA/IzyfNWHC07T2
    BXv5F4nB5lDW5nLVWpLPycQx5om7PPkPHYuh7mzDrIobWj1yk+mGAXJ2WtLF+E++
    62J46qFqgTS4SqbCsBIjGvzArJPqFRAB+aEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527020470; bh=47Yz/ngu2tIssk249MRd5j5Mraxr6/eaWDdusj5PP7
    I=; b=nPoEUCWP4lSyxlApLOt563YzTyF1NJM5SokTbIKQrt5cw1G/RX3jQR5pbY
    1OvLMLmJkouPWOYcUBAyRpAdAJnAAFH81C81LVhANhDbOkYO7oYQDLTzScpEOB5O
    IKsvFbHQaBSnhcl0tqeUEHOSThr8k/OptpuQIEhemDGV3m9yatFtlwf5ekvBwVK9
    PqTDQOP9UmD6WqxC70tE/3UO8MhrszpWBd/nDywudUrd99fBjVbQWoJux8iciPef
    bTL38Exd4U0OYSyaH6O5b4nY91TW/cnJethVNoW/DlYamb8+btVMIlas/v7aZ+Te
    i4HAvcLlOqFTBbW9sQGUhUqsAG2g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Ei1rj6ju x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=aDsoJfjb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Ei1rj6ju x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=aDsoJfjb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGhJfzj81rjO9AbLFBY7bwAeiiBFs1YZcVN3NiJhvn15GfDJyedO68avyz2d8s+APqAvwwAhOYNAczh+d7M3toAwCfHlwegdowXK+tvqduvXSTV7PuXm
    Xkf+A/aZVlKSOgIZ26K8AYdNta5V4nuaxxMuWW25OE/U/oUhZG2xaBvfAq/RWJ7SOgkDNXFbFxQw8RD6O/Bs2IbLQQPlJCjAnSdbNJnjERxOPJjGe/hPtHo+
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8
    a=k0NuQWpXet7YZnQywo8A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeEVUVJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:21:09 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:39357 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeEVUVH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 May 2018 16:21:07 -0400
X-Google-Smtp-Source: AB8JxZqy9+8heJJJxIA1eKkqzbot4V4qt+6YMYyzC4xajLo7Gb4RS+vvdwktd+Urg/xMrh8/Vp9xzb7Q2mIC82bcTew=
MIME-Version: 1.0
In-Reply-To: <AM5PR0501MB244981D83DD33BD29FD64924B1940@AM5PR0501MB2449.eurprd05.prod.outlook.com>
References: <1526394095-5069-1-git-send-email-oleksandrs@mellanox.com>
 <1526394095-5069-3-git-send-email-oleksandrs@mellanox.com>
 <CAHp75Ve7EYiWBiE73i0CmyJhPMOdSKsGzCr0SUvta3Uya=Ov1Q@mail.gmail.com> <AM5PR0501MB244981D83DD33BD29FD64924B1940@AM5PR0501MB2449.eurprd05.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 23:21:06 +0300
Message-ID: <CAHp75Vedcsbet3L0p0t5-=J0PmSe26VFXDbcRmk9943D9_FSqQ@mail.gmail.com>
Subject: Re: [patch v21 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
To: Oleksandr Shamray <oleksandrs@mellanox.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Tobias Klauser <tklauser@distanz.ch>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        system-sw-low-level <system-sw-low-level@mellanox.com>,
        Rob Herring <robh+dt@kernel.org>,
        "openocd-devel-owner@lists.sourceforge.net"
        <openocd-devel-owner@lists.sourceforge.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 6:00 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:


> Ok. Changed to:
> #define ASPEED_JTAG_IOUT_LEN(len) \
>                                (ASPEED_JTAG_CTL_ENG_EN | \
>                                ASPEED_JTAG_CTL_ENG_OUT_EN | \
>                                ASPEED_JTAG_CTL_INST_LEN(len))
>
> #define ASPEED_JTAG_DOUT_LEN(len) \
>                                (ASPEED_JTAG_CTL_ENG_EN | \
>                                ASPEED_JTAG_CTL_ENG_OUT_EN | \
>                                ASPEED_JTAG_CTL_DATA_LEN(len))

What about

#define _JTAG_OUT_ENABLE \
( _ENG_EN | _ENG_OUT_EN)

#define _IOUT_LEN(len) \
 (_ENABLE | _INST_LEN(len))

#define _DOUT_LEN(len) \
...

?

>> > +       apb_frq = clk_get_rate(aspeed_jtag->pclk);
>>
>> > +       div = (apb_frq % freq == 0) ? (apb_frq / freq) - 1 :
>> > + (apb_frq / freq);
>>
>> Isn't it the same as
>>
>> div = (apb_frq - 1) / freq;
>>
>> ?

> Seems it is same. Thanks.

Though be careful if apb_frq == 0.
In either case the hw will be screwed, but differently.

>> > +       if (xfer->direction == JTAG_READ_XFER)
>> > +               tdi = UINT_MAX;
>> > +       else
>> > +               tdi = data[index];
>>
>> > +                       if (xfer->direction == JTAG_READ_XFER)
>> > +                               tdi = UINT_MAX;
>> > +                       else
>> > +                               tdi = data[index];
>>
>> Take your time to think how the above duplication can be avoided.
>>
>
> In both cases data[] is different, so I should check it twice, but I will
> change it to, macro like:
>
> #define ASPEED_JTAG_GET_TDI(direction, data) \
>                               (direction == JTAG_READ_XFER) ? UNIT_MAX : data

Perhaps choose better name for data, b/c in the above you are using data[index].

>> > +               dev_err(aspeed_jtag->dev, "irq status:%x\n",
>> > +                       status);

>> Huh, really?! SPAM.

> I will review and delete redundant debug messages.

Just to be sure you got a point. This is interrupt context. Imagine
what might go wrong.


>> > +       err = jtag_register(jtag);
>>
>> Perhaps we might have devm_ variant of this. Check how SPI framework
>> deal with a such.
>>
>
> Jtag driver uses miscdevice and related  misc_register and misc_deregister
> calls for creation and destruction. There is no device object prior
> to call to misc_register, which could be used in devm_jtag_register.

Same question as per previous patch.

-- 
With Best Regards,
Andy Shevchenko

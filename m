Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1902BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA5C25B6E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFYwSUTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA5C25B6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeFZRSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:18:48 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46898 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeFZRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:18:45 -0400
Received: by mail-vk0-f65.google.com with SMTP id b134-v6so10481015vke.13;
        Tue, 26 Jun 2018 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qd7IBfbD+8QgVsZ9CMVKo2LVrrb3h1t1b2Bdx8BrQFY=;
        b=nFYwSUTV0nqO/x/a0tguZSj0g2kVRYj2cY93JjQW7XM6DpBP333AWSxTFrMxhAM+VH
         Xl3iicCKi/ZDRXMcCxYKgdhAclihZKkOHxNJjdXUKV10m7fgwkHzRLCYQIWcnadI2Kfw
         3PW+63oTCrzbNbg5JeFT7S0hhra5ZI9rB+s1wv9ptoAqT0mmUjurizC1FQtitpoxpHti
         1xCfj23ZjdFnkxIr3EM3RPbvGuibiljGYcGtggCqAhiu1Z3FYInqwN2Huj7yQZ2c4845
         M2JTuUCxwkKJVOF+2qWidqdJlGRIaZPgr+uPY5Nny+ygo6AUllft4uKlIg1rTLq0JO7S
         pyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qd7IBfbD+8QgVsZ9CMVKo2LVrrb3h1t1b2Bdx8BrQFY=;
        b=H8r5fLszFQfap32Lo08Oy1dYARmMD4xLPaTiOcyUmMPvwBUXseBCWXd7OAFYV5BNFJ
         kgPbrBa9T2npS0urVdln/KeW7i9Uney2xcpVsvda7z5DpamuEI8uk6KpGbgR6A163AMY
         IzBNdUOHaMnq9X1BMSvxcpvawCgbUXrsNbV4u9c1BjP6z0eZGfKO/Z1ZabxjyL1rXOGu
         YGBZJGekWoTpn1PQQWRR6mrb6IL1TNFebTn1HclX62H2xmOlcfwzsNyytyPdXV10vcWd
         lJDIIxjr9xES1FhPMdCRBMTkh2pJRryZ3Nqr68CLfZKybc1CM9C3X22uPlR4y3n1QBWw
         zYdg==
X-Gm-Message-State: APt69E0DJ38tNieo5KXp1FkYD1QS1eKvRC32DH7NC4PGj8srwvtBCq2b
        DkxdoxbQesTdkSNCtO71bhfUyFE7eGdfTVPgDiw=
X-Google-Smtp-Source: AAOMgpcGHSFKIIK7A7HUrXRrsV1TK3sS28nTXsPH+02bTwZugbfER8cutHw0sOTfW837lt6q/gElDD33AdseuECEZZI=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr1527297vkd.15.1530033524907;
 Tue, 26 Jun 2018 10:18:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 10:18:44
 -0700 (PDT)
In-Reply-To: <20180626170125.GB5241@Mani-XPS-13-9360>
References: <20180623161147.15672-1-manivannan.sadhasivam@linaro.org>
 <20180623161147.15672-6-manivannan.sadhasivam@linaro.org> <CAHp75Vf_JR6scrwnomiu62_x2idgCGH63UdMf2bhfy8VNaijXQ@mail.gmail.com>
 <20180626170125.GB5241@Mani-XPS-13-9360>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 20:18:44 +0300
Message-ID: <CAHp75VdR5UbGvM3AOu21+Hp1xqPgtSnjRSKyhnCeB8ebAmF7eQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] i2c: Add Actions Semi OWL family S900 I2C driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 8:01 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Mon, Jun 25, 2018 at 12:38:50PM +0300, Andy Shevchenko wrote:
>> On Sat, Jun 23, 2018 at 7:11 PM, Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:

>> > +#define OWL_I2C_REG_CTL                (0x0000)
>> > +#define OWL_I2C_REG_CLKDIV     (0x0004)
>> > +#define OWL_I2C_REG_STAT       (0x0008)
>> > +#define OWL_I2C_REG_ADDR       (0x000C)
>> > +#define OWL_I2C_REG_TXDAT      (0x0010)
>> > +#define OWL_I2C_REG_RXDAT      (0x0014)
>> > +#define OWL_I2C_REG_CMD                (0x0018)
>> > +#define OWL_I2C_REG_FIFOCTL    (0x001C)
>> > +#define OWL_I2C_REG_FIFOSTAT   (0x0020)
>> > +#define OWL_I2C_REG_DATCNT     (0x0024)
>> > +#define OWL_I2C_REG_RCNT       (0x0028)
>>
>> I don't understand why these have parents?
>>
>
> I'm not sure what you mean here! Can you please elaborate?

One has to read 'parens'. Sorry for confusion.

>> > +#define OWL_I2C_TIMEOUT                (msecs_to_jiffies(4 * 1000))
>>
>> Ditto.

> Same as above

Ditto.

>> > +       /* Wait until FIFO reset complete */
>> > +       do {
>> > +               val =3D readl(i2c_dev->base + OWL_I2C_REG_FIFOCTL);
>> > +               if (!(val & (OWL_I2C_FIFOCTL_RFR | OWL_I2C_FIFOCTL_TFR=
)))
>> > +                       break;
>> > +       } while (1);
>>
>> No way. Get rid of infinite loop.

> Okay. Can I change it to max of 50 retries with 1ms delay?

Whatever suitable for HW. Rely on datasheet or other source of
information about this timeouts.

>> > +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)

>> > +               dev_warn(&i2c_dev->adap.dev, "received NACK from devic=
e");
>>
>> And if it happens hundreds times in a row?

> Should I change it to dev_dbg?

>> > +               dev_warn(&i2c_dev->adap.dev, "bus error");

> Same as above?

ratelimit, another level, tracepoints, getting rid of them completely
=E2=80=94 your call.

--=20
With Best Regards,
Andy Shevchenko

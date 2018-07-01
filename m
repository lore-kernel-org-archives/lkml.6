Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27684C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86E524DF2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTBvkfTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86E524DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeGAJMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:12:00 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34755 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeGAJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:11:56 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so8342204uao.1;
        Sun, 01 Jul 2018 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rnpSVwa07LhELl46D2OlBK7qfJacJdPemLAdir67JNk=;
        b=iTBvkfTRrraC3s6y3p4eGD+mFqqv1O7HsALFv3fxoGGyNXBGxv/iOCOO66RfllokA3
         sZXpgfGsNH9pk4hM7Em1dKeDx3dMRxmTKJxmpgnHCEEjJJDxIIjsSlU2eJRnqXh2dR4R
         B8pb08dQ4vZDybNg3HN18jfiWwWujWO6LX1VZrEBqEa9Ql8c7p7cfR1ve8ewVPGN0eyz
         5c6kq+oMAnwx3QV9nx18Q9OKZ4yoQPtcJX0/TrjUgne7UumlsIG8U6cyszVYan2E4zIf
         w0ywBbO0eUA0YcXrmtGc5a4TCNIfIBOGLO7EhJSSmhdPB3tM2ZhqgHd/+uIZ4Aw7gM5A
         bjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rnpSVwa07LhELl46D2OlBK7qfJacJdPemLAdir67JNk=;
        b=LhjYInVoDRyZjBfkBG7yQfGPg56BHXwbRYOKaYiYQr/HACIFsSJJOH+oCCNyM5vT8s
         qQcVQ9JlgmbkhWIoEin3pFqh0e+FyNMwgj22ECiaOYV7DALpCqbtDk0zIEarz9x3cuIl
         Wxbv69Vj0+bmt8O1bMDLULGKixLkFGhhxmaNJvOjepwk5aukDDEJO3vBQRym2G9ZiKqX
         Ecr29IsT5FhyPXAR8yNshUJTvFmfsZpyfmkA5l/5LMzEpblfGAd9EVjeKzy4FOfqMfIH
         iUzchH14xTPAgWeSq9mOx+FCj6u6Ve8M8Fg1iU8ben+hhIuvQkmWi6NLUgQ8gZE362A3
         IAZg==
X-Gm-Message-State: APt69E04MSJ5LzJ7aQgwCtYlY0MDuy106C55C4RnJrWK5Vv+OWhtEIXX
        sGEpRPzOFV/39/yboVGx1m7MQNWEHcOTjFj8Ohk=
X-Google-Smtp-Source: AAOMgpeO63kCfxVLvxz/nzmvK3sVyVpFAMhxAjELs4iQok1j+x7V051q/oXOv2qMScXkwJSbra47PhxbiFjGmiMvJ+c=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr13311106uae.12.1530436315341;
 Sun, 01 Jul 2018 02:11:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 02:11:54 -0700 (PDT)
In-Reply-To: <20180701084140.GC28390@Mani-XPS-13-9360>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
 <20180630133330.23858-6-manivannan.sadhasivam@linaro.org> <CAHp75VcVNb51tJzKbCU3pqf0XYPCUZWpv38nfaV1711vyf2S0Q@mail.gmail.com>
 <20180701081333.GB28390@Mani-XPS-13-9360> <20180701084140.GC28390@Mani-XPS-13-9360>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Jul 2018 12:11:54 +0300
Message-ID: <CAHp75VcDK7U-x-W9-gaY9-2zAJqnawdwe5gor0ifX8iYe_p0_Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C driver
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 11:41 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Sun, Jul 01, 2018 at 01:43:33PM +0530, Manivannan Sadhasivam wrote:
>> On Sun, Jul 01, 2018 at 12:11:00AM +0300, Andy Shevchenko wrote:
>> > On Sat, Jun 30, 2018 at 4:33 PM, Manivannan Sadhasivam
>> > <manivannan.sadhasivam@linaro.org> wrote:
>> > > Add Actions Semiconductor Owl family S900 I2C driver.

>> > > +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
>> > > +{
>> >
>> > > +       mdelay(1);
>> >
>> > But now, since it's not used in atomic context, we may switch to
>> > usleep_range() / msleep() instead.
>> >
>>
>> okay, will use msleep()
>>
>
> Just realised, I have to use spinlock for the entire owl_i2c_master_xfer
> function, so can't use sleep* for delay.
>
>> > > +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>> > > +                               OWL_I2C_CTL_EN, true);
>> > > +
>> >
>> > > +       /* Wait 50ms for FIFO reset complete */
>> > > +       do {
>> >
>> > > +               mdelay(1);
>> >
>> > Especially in this case it's very important.
>> >
>>
>> Okay.
>
> Same here, but I'm not sure about the latency. What is your suggestion?

Look at other i2c bus drivers, check with data sheet you have, try to
refactor / redesign code that wouldn't need to sleep so long in atomic
context.


-- 
With Best Regards,
Andy Shevchenko

Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F34C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D93720844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODMck+Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D93720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeGZNVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:21:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36809 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbeGZNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:21:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id k15-v6so1272133edr.3;
        Thu, 26 Jul 2018 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zkRqpCjGg7rPRNsLsEwHWC9ODlw99RkmbOXrawqatZw=;
        b=ODMck+PeAEz8ruNnqfuhS07AX7pEK94Qu3dzk+j+3C3bL8XjrPe0FsCRUbGDHpqIZY
         Hlxu3GtEpL6qKjcLWExJ28ie0JHyYG8hWB1DwQMMYdfX7h0qjJ6j7KNC/XkeUN9HorsU
         P4Bk5qER/SU/z1iIGOujvA9olOdFNG6bI1JL8Cx/uRyKm/RbYfpbmyR0f8xTWBQ1C3P8
         vY4/ZPvH0RYFlo7lrwZ41G3piZAVS9+WkrFZ0poPnpLMrrZEaZ4nvipcVC0SmAJBiUbW
         PUMvG/0ev03BrZvy6xfr4PhYgtzCNvz6ApSIab7d738e6mLny85mu7SxjKJvD4gsdcnZ
         rl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zkRqpCjGg7rPRNsLsEwHWC9ODlw99RkmbOXrawqatZw=;
        b=NqSDsWsxOdRHrDMZ4mSqjLHqtpWA/gFsdKj0sp63thgx3I0I5pUZTQn4f1HmaPjI8Z
         WFn8D6R+4VGuBkTqJ0/PHozph2ldd4aCAyh+1kIDqwc1gKk0WMe2GpE9NHmeOc7G/jB8
         dcd3GvjI9Qs6VeefgbZqjxp0+yKgEIQfc7nJeEl2tjLQhwqc+m9A3vqQiDj61mJpk2jA
         JdGluwd3GQVbsk31dDEyE2HqPW3Tc0mCUXgY37XNSAng092ecVUMTpG4nZ/XyWWwCLKz
         nC50e18oZMTYiDbK7Rd7e0ek/zD1InQiIpZhpXiAYFX2l8P1Qls2VQG1un2mTzDgs/Hs
         lQGw==
X-Gm-Message-State: AOUpUlHzL1Ooyja0/u/SP7tE31oNaVowxXe1fNbOhvYw3ulJPDSM+YBM
        OqtO7TlxlQCrxy1nsHbDuJsObsvBOXZOe6FWlM8=
X-Google-Smtp-Source: AAOMgpf29ZXIdEM7sF+wStSYzGidNBwz3dhFFcXAwr4YV9/qbBiqFTJBhsS7tOEJMSIcHtypicr7KoZFB0mfspncx1s=
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr2380690ede.213.1532606675601;
 Thu, 26 Jul 2018 05:04:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 05:04:35
 -0700 (PDT)
In-Reply-To: <AM0PR04MB4211F722024F7F183774D592802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-2-o.rempel@pengutronix.de> <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
 <AM0PR04MB421178C5283BDCCF11F5E2AF802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1DQbGnWL=HZc=xPLdJjKgkpdvCHmm6Pr6_MvERR=D56Q@mail.gmail.com> <AM0PR04MB4211F722024F7F183774D592802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 26 Jul 2018 17:34:35 +0530
Message-ID: <CABb+yY2uLgrJ9-NUnoXYXCqQ7_sQyWxF=wRQFM+cja0HbBox4A@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal
 to 0
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 5:25 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>> -----Original Message-----
>> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>> Sent: Thursday, July 26, 2018 7:37 PM
>> To: A.s. Dong <aisheng.dong@nxp.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Shawn Guo
>> <shawnguo@kernel.org>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
>> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
>> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; Sudeep Holla
>> <sudeep.holla@arm.com>; Devicetree List <devicetree@vger.kernel.org>;
>> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; , Sascha Hauer
>> <kernel@pengutronix.de>; , linux-arm-kernel@lists.infradead.org, linux-
>> mediatek@lists.infradead.org, srv_heupstream <linux-arm-
>> kernel@lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be
>> equal to 0
>>
>> On Thu, Jul 26, 2018 at 4:30 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
>> >> -----Original Message-----
>> >> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>> >> Sent: Thursday, July 26, 2018 5:42 PM
>> >> To: Oleksij Rempel <o.rempel@pengutronix.de>
>> >> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
>> >> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
>> >> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>;
>> >> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>; Sudeep Holla
>> >> <sudeep.holla@arm.com>; Devicetree List <devicetree@vger.kernel.org>;
>> >> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; , Sascha
>> >> Hauer <kernel@pengutronix.de>; ,
>> >> linux-arm-kernel@lists.infradead.org, linux-
>> >> mediatek@lists.infradead.org, srv_heupstream <linux-arm-
>> >> kernel@lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
>> >> Subject: Re: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to
>> >> be equal to 0
>> >>
>> >> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
>> >> <o.rempel@pengutronix.de>
>> >> wrote:
>> >> > From: Dong Aisheng <aisheng.dong@nxp.com>
>> >> >
>> >> > Mailbox devices may have only one channel which means the
>> >> > mbox-cells at least 1 does not make sense for this type devices.
>> >> > Let's remove that limitation to allow the mbox-cells to be equal to 0.
>> >> >
>> >> OK
>> >>
>> >> But please realise that you'll have to write more code -- implement
>> >> your own
>> >> of_xlate() callback.
>> >> Most developers would prefer to call the only channel as channel
>> >> number 0, and use the common of_xlate implementation.
>> >>
>> >
>> > Yes, that's true because the common of_xlate assuming the mbox-cells is 1.
>> > And there's already such users:
>> > arch/arm/boot/dts/bcm283x.dtsi
>> >
>> You mean that is a good thing, right?
>
> No, I mean there's similar HW in kernel already that only has one channel.
> Are you suggesting even for one channel mailbox, we should still use
> Mbox-cells 1 and use 'mboxes = <&mailbox 0>' in devicetree?
>
As i said, I am ok with the mbox-cells to be 0.

But if you have two instances of the controller, one with 4 channels
and the other with 1 channel. Then you can/should not have different
bindings.

And, if the controller can have only 1 channel, then please feel free
to have mbox-cells=0 and implement your own of_xlate().

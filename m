Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D64C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48072409F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmYcKkad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48072409F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753691AbeGFGim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:38:42 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40412 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeGFGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:38:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id y200-v6so8904287lfd.7;
        Thu, 05 Jul 2018 23:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=vUi7/EnIvVa+gKLlq6GvSJxAECboNM/L5O6h/9KdYrs=;
        b=KmYcKkadHDKfZwGntQjbiLUNLCvTNjC+dGp2mwh6CF4Pq3Gq+OuRNo2a/LzEG/wht3
         Y1TR9ZUhNKpGcPrMQE7IQEOdW+HHUooMkxHXICZnqEVy7av0Y/ifRyGDCxvBVPsKAMaH
         +uUnEyHy3zohCA7tdpq3Fn6j+Tp6k03xCESclB7ouwzs0JtJXr9rAelYa16PXMW+6Zxx
         ea88NKkTBO2WHFj+fmWcLThbhLbOaR6sMHCbjkpIj3FKnUG7aEJHUgO49gHCGi9W8Zza
         YOICejmBAsJeMJAxMCPxxEYO5RBCWslcJSt/rmLjwOteQsD6axocu+UF6qpbSMjhxTvJ
         HFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=vUi7/EnIvVa+gKLlq6GvSJxAECboNM/L5O6h/9KdYrs=;
        b=LNkZepvTD3tEo0jZPsK2eDxkOvUUIUFCsRTYNLeu0ykSyRzuSdvnhvbuRP/nk1ru97
         EbCqTyiu2UyUK9seiI+69CHIfz6bIZA3U40Bx0f40wVLjDcrJZlBBZtGniXp5s29B0hE
         Ztjs56wNeo50fMVNX4PcJR4W6gaqipBgQ22ItORou37FqIeccu/H52f3wuba1V+B/tSP
         o5uAIprDjWE6ZW+34DZoigLe+4p7Tozi9JuhQGaAe00ARye+jOgzBXnEGwjBcKGThyIb
         zZouxKszTnsNQU56GR9JbriXw47TyexYz6+Qxhk7G+zdSM6H57NGWHwQgBSUtekbQp6S
         1AAA==
X-Gm-Message-State: APt69E1zePZEQFd6WsiBnZXLqSetWC8zjW8gGmeDOIfwLTQ6DErm/3mL
        DDOwKxHp/sZDK4jP9Jf1LnQ=
X-Google-Smtp-Source: AAOMgpdlWZMW+oqOCU67aBZwoSeiBghdmM/bqbVrqTZe1arPPivr71ChhGb11pCdu9NJg9Xp6hGppw==
X-Received: by 2002:a19:2593:: with SMTP id l141-v6mr6187189lfl.10.1530859118106;
        Thu, 05 Jul 2018 23:38:38 -0700 (PDT)
Received: from [172.18.124.87] ([194.186.220.141])
        by smtp.gmail.com with ESMTPSA id u20-v6sm1949899lfk.91.2018.07.05.23.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 23:38:36 -0700 (PDT)
Date:   Thu, 05 Jul 2018 23:38:35 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180705075650.GA7683@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com> <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com> <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com> <20180704145623.zgei3ehrwdpcu26r@penguin> <CAFqH_50UshTTc0Cv0wBhUoPdm0jZVgcvRKr3qzb=M-jCcMhdtA@mail.gmail.com> <20180705075650.GA7683@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <31712EE3-4FA5-4A52-8F84-0EDC1AEEF868@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 5, 2018 12:56:50 AM PDT, Matti Vaittinen <matti=2Evaittinen@fi=2Ero=
hmeurope=2Ecom> wrote:
>On Wed, Jul 04, 2018 at 06:57:39PM +0200, Enric Balletbo Serra wrote:
>> Missatge de Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom> del dia dc=
=2E,
>4
>> de jul=2E 2018 a les 17:10:
>> >
>> > Hi Enric,
>> >
>> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra
>wrote:
>> > > Hi Matti,
>> > >
>> > > Thanks for the patch, a few comments below, some are feedback I
>> > > received when I sent some patches to this subsystem=2E
>> > >
>> > > Missatge de Matti Vaittinen <matti=2Evaittinen@fi=2Erohmeurope=2Eco=
m>
>del
>> > > dia dt=2E, 19 de juny 2018 a les 12:57:
>> > > > +};
>> > > > +
>> > > > +/* bd71837 multi function cells */
>> > > > +static struct mfd_cell bd71837_mfd_cells[] =3D {
>> > > > +       {
>> > > > +               =2Ename =3D "bd71837-clk",
>> > > > +       }, {
>> > > > +               =2Ename =3D "bd718xx-pwrkey",
>> > > > +               =2Eresources =3D &irqs[0],
>> > > > +               =2Enum_resources =3D ARRAY_SIZE(irqs),
>> > > > +       }, {
>> > > > +               =2Ename =3D "bd71837-pmic",
>> > > > +       },
>> > > nit: no comma at the end
>> >
>> > Actually, trailing comma is preferred on structures/arrays without
>> > sentinels, because if one needs to add a new entry/new member, then
>in
>> > the diff there will have only one new line added, instead of one
>line
>> > being changed (adding now necessary comma) and one added=2E
>> >
>>=20
>> Many thanks for sharing your knowledge! That looks to me a good
>> reason=2E
>
>So in this specific ecample leaving the comma does not help=2E The
>opening
>brace for new array element would be added to same line where the comma
>is, right?

Ah, yes,  you are right=2E We usually have either:

        { /* element 1 */ },
        { / *element 2 */ },
        =2E=2E=2E

or:

        {
                /* element 1 */
        },
        {
                /* element 2 */
        },

but I do not think that it is codified in the CodingStyle=2E


Thanks=2E

--=20
Dmitry

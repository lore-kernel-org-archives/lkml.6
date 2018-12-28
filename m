Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A60C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0225F20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeL1Mb1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:31:27 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:50380 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeL1Mb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:31:26 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2018 07:31:26 EST
X-AuditID: c0a8fbf4-501ff700000014c1-91-5c261417fa5b
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 25.42.05313.714162C5; Fri, 28 Dec 2018 13:16:23 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0415.000; Fri, 28 Dec 2018 13:16:18 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: RE: [PATCH] regmap: irq: Make IRQ type support optional
Thread-Topic: [PATCH] regmap: irq: Make IRQ type support optional
Thread-Index: AQHUnqRGKs9BzB/bPUWmq6bo/vAbCKWUDcoV
Date:   Fri, 28 Dec 2018 12:16:17 +0000
Message-ID: <042F8805D2046347BB8420BEAE397A4066F2EFFE@WILL-MAIL001.REu.RohmEu.com>
References: <20181228112358.5914-1-ckeepax@opensource.cirrus.com>,<20181228115548.GM16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181228115548.GM16508@imbe.wolfsonmicro.main>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SS0wTQRjOdLfrUlgd+kjH+jiswEF5Gk16QAKeEDUhCtEgBhZZaIG2uG1J
        i4YQBU2rES8EKUVAAYEEo+gB5V3xAUSJWkD0gCjRCIJEMKKguMsG4TTfzPeayfwkJn8n1ZB6
        o4XljEwOTcjw7obFuyFqZVBy+J8HwdrS8QlC6y1uAdrXD92Edu5blzQaj21pchCxZe5lEDvX
        sj0eS/KNTGMseUf1mcawqFRfXX19DchtU9qe3J8HheAldAIfEsE9qK6kX+oEMlIOhwC6U9Us
        ETfPACpuXCCcgCQJGImcoxsEgxKmoJHPbkLQYLAIoJ6ZZalAKGA0crzowkVRDLpSXQpEvBt9
        KK+QCjk4DERlRSoBUvAIuvAzUVDI4Wl0e6BjxenDNy1WlqxUAbgNOQpnJALGoBq9naiSiHeG
        qLZ9EBOxCn35+FcqYhp1/BrHRX0wqm77Toh4F6qvmVrRU9Af9ZVP4FeByrUu1rXO4lpnca2z
        VAO8CSADo8/JZCxsRCjHWkM5k87AL6dMhhYgftJ8K1j2HPAASALaj8JHA5PlUibPbDd4wGZS
        QquoShl/tDHNlG7XMWZdCmfNYc0egEiMVlL0pqBkOZXO2PNZzrRKbSFxWk0lDf5OkkOhOZtl
        c1luld1KkjSioII3+nNsJmvL0OdY1mgJ6SOEyzRKM2tMZznGatGlCFORYubHQqD8+N5Of6HX
        nMsY+FPR2g8CyaeOH25MjhtNRlajpmLkvAgKIp3V+L9iEqj5lyqoEOEGfvzE/k+Y5MMlfHhV
        SIAQbmHWKE0hqGmOK5gaODk2akjbcaxxKZx73v5q3Nt50T5WcDlVlVoQlhh/JiEDe9S9dM1l
        Ar1e3Zu8Oht241wfe/B4gGZ4/lD7rUuPbffcAZ7DCcPuQdf+qLPLI3uzsL7um5/eVxBZ5xdm
        J1v9GuI02dXlPbITX/cFTg8pZol8rlbf2zjtvU7jZh0TsRPjzMw/mNgODG4DAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Charles,

Sending this mail form outlook web interface - so I won't inline any code :/

From: Charles Keepax [ckeepax@opensource.cirrus.com]
Sent: Friday, December 28, 2018 1:55 PM

> On Fri, Dec 28, 2018 at 11:23:58AM +0000, Charles Keepax wrote:
> > Currently only gpio-max77620 is using the type support in regmap IRQ,
> > but the implementation causes the irq_set_type operation to fail on all
> > other regmap IRQ chips. Avoid these regressions by skipping the type
> > handling on any chips that don't define a set of supported types.
> >
> > Fixes: 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add level-irq support")
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/base/regmap/regmap-irq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> > index 1bd1145ad8b5e..8c674f1ad0fc8 100644
> > --- a/drivers/base/regmap/regmap-irq.c
> > +++ b/drivers/base/regmap/regmap-irq.c
> > @@ -257,6 +257,9 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
> >       int reg;
> >       const struct regmap_irq_type *t = &irq_data->type;
> >
> > +     if (!t->types_supported)
> > +             return 0;
> > +
> >       if ((t->types_supported & type) != type)
> >               return -ENOTSUPP;
> >

I got the bug-report from Geert and sent this patch yesterday:
https://lore.kernel.org/lkml/20181227084443.GA23991@localhost.localdomain/

Looking at these two options, I wonder if we shuld return -ENOTSUPP if we do support type setting, but for example only for edge, not level active IRQs - and if LEVEL_LOW or LEVEL_HIGH is requested? Well, I have no strong opinion and both of these should fix the regressions - sorry for the hassle!

I still wonder whether we should do as I suggested and only set the irq_set_type callback for chips which have non zero type_registers? I suggested that here:
https://lore.kernel.org/lkml/20181228080533.GC2461@localhost.localdomain/

> + Matti Vaittinen, apologies for forgetting to include you on the
> original sending.

No problem. Thanks for adding me now =)

Br,
    Matti Vaittinen

--
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D34C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6056B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyYfHjiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfAQWU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:20:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52771 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfAQWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:20:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so2732446wml.2;
        Thu, 17 Jan 2019 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UF8iRbEUsqBp0oTF+nxcFGs7DS34F6tG7ACBFlq1xxo=;
        b=XyYfHjiQ9lnr/XEVKDuLmOTJbrpMhChd1vnPcbkqFDPEldh0Nr0BjR3j90u8NeCxbj
         Rnf9wIhygtmvMEe4uPLVfk5DMeMbWQNAveZnfhyGAXZKbfAPo00LWe6e5xqRQlg3rk69
         /luTHolLoTaxeMLqQ0ggIYrDAKqT4J0dzy8+5kPtd0BZgPQc5DinEJlDQ8NGJS4y3/CZ
         93NnSEU+fdXny24JD4+pszL3vvD+H/rPq9vBH5mBjXCICQA1pZwUr+/wK8CmtBBb3yAI
         d7Ux1Xai9PiUQIsUFypyxq9jIhYaAIxuZiG1qQKfsMoThECJirMa7DVaDGASYbUaHGH2
         PMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UF8iRbEUsqBp0oTF+nxcFGs7DS34F6tG7ACBFlq1xxo=;
        b=s0+IqGVOCwHeS6ez/51MHyk7dYZBnlD+/8V8dHCmNS1AHqeM0PPwERvS92+bUxTVLr
         kDeZea+TIioZ0RmGRE0VikqsttqkF5ZdyyHqDiqD95TlSNAXMIXaqfooV14zahsnN4Vg
         uPkVml4uVX/QpoYR+9aJKe6fNstXVZeNgrScYxB74236MDXyinBrbuBKY4jDPumpQ5MC
         cLNqXEo0ncJtzNYc1Pt53yw2lT/TciYzSbrss95ZcR0pMzcB1zXFmNeAluMfJ0i2/DLv
         kKCFEYESjLVaTDkcaghB9wDZ8Cx3jivSr8DJy3hFYlS3/RQjdIFDymx5IjpMCy6rXT30
         VKcw==
X-Gm-Message-State: AJcUukdvwICgqz99BxdYVHi92BQ4SMaEo2Q/pJFeMIVVXuViw6iG/S8g
        Xi3dlx1HEY063+V01pkh2SQz16RnegYRlmM1SXc=
X-Google-Smtp-Source: ALg8bN5tVl6LDZjgovWJDI1z77BzV/TAUOvTfZtSMi1dU0NqM+Gb4egyCQVR3t+MmYJEVw22grMnpfXhr1jydrQ2O6k=
X-Received: by 2002:a1c:760c:: with SMTP id r12mr12662014wmc.127.1547763653775;
 Thu, 17 Jan 2019 14:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-2-andrew.smirnov@gmail.com> <1547745380.4009.18.camel@pengutronix.de>
In-Reply-To: <1547745380.4009.18.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 17 Jan 2019 14:20:42 -0800
Message-ID: <CAHQ1cqHH=pg9QON-PZhr+DDz_JWOUYkzxwcb+xdWvnmB5US8+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] reset: imx7: Add plubming to support multiple IP variants
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:16 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Wed, 2018-12-19 at 17:06 -0800, Andrey Smirnov wrote:
> > In order to enable supporting i.MX8MQ with this driver, convert it to
> > expect variant specific bits to be passed via driver data.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/reset/reset-imx7.c | 62 +++++++++++++++++++++++++++-----------
> >  1 file changed, 45 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> > index 77911fa8f31d..3a36d5863891 100644
> > --- a/drivers/reset/reset-imx7.c
> > +++ b/drivers/reset/reset-imx7.c
> > @@ -17,14 +17,29 @@
> >
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset-controller.h>
> >  #include <linux/regmap.h>
> >  #include <dt-bindings/reset/imx7-reset.h>
> >
> > +struct imx7_src_signal {
> > +     unsigned int offset, bit;
> > +};
> > +
> > +struct imx7_src;
> > +
> > +struct imx7_src_variant {
> > +     const struct imx7_src_signal *signals;
> > +     unsigned int signals_num;
> > +     unsigned int (*prepare)(struct imx7_src *imx7src, unsigned long id,
> > +                             bool assert);
>
> Instead of adding a function pointer indirection, I'd prefer separate
> imx7_reset_ops and imx8m_reset_ops set by the variant, see below.
>
> > +};
> > +
> >  struct imx7_src {
> >       struct reset_controller_dev rcdev;
> >       struct regmap *regmap;
> > +     const struct imx7_src_variant *variant;
>
> This could then replaced with a direct pointer to the respective signals
> array.
>
> >  };
> >
> >  enum imx7_src_registers {
> > @@ -39,10 +54,6 @@ enum imx7_src_registers {
> >       SRC_DDRC_RCR            = 0x1000,
> >  };
> >
> > -struct imx7_src_signal {
> > -     unsigned int offset, bit;
> > -};
> > -
> >  static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
> >       [IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
> >       [IMX7_RESET_A7_CORE_POR_RESET1] = { SRC_A7RCR0, BIT(1) },
> > @@ -72,17 +83,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
> >       [IMX7_RESET_DDRC_CORE_RST]      = { SRC_DDRC_RCR, BIT(1) },
> >  };
> >
> > -static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
> > +static unsigned int
> > +imx7_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
> >  {
> > -     return container_of(rcdev, struct imx7_src, rcdev);
> > -}
> > -
> > -static int imx7_reset_set(struct reset_controller_dev *rcdev,
> > -                       unsigned long id, bool assert)
> > -{
> > -     struct imx7_src *imx7src = to_imx7_src(rcdev);
> > -     const struct imx7_src_signal *signal = &imx7_src_signals[id];
> > -     unsigned int value = assert ? signal->bit : 0;
> > +     const unsigned int bit = imx7src->variant->signals[id].bit;
> > +     unsigned int value = assert ? bit : 0;
> >
> >       switch (id) {
> >       case IMX7_RESET_PCIEPHY:
> > @@ -95,10 +100,32 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
> >               break;
> >
> >       case IMX7_RESET_PCIE_CTRL_APPS_EN:
> > -             value = (assert) ? 0 : signal->bit;
> > +             value = assert ? 0 : bit;
> >               break;
> >       }
> >
> > +     return value;
> > +}
>
> Instead of having a common imx7_reset_set and then calling the custom
> .prepare() through a function pointer, I'd suggest to have custom
> imx7_reset_set and imx8m_reset_set functions that contain the code from
> .prepare() and then call a common function to do the actual register
> access.
>

OK, makes sense, will give it a spin in v5.

Thanks,
Andrey Smirnov

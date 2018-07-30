Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20CEC46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6518920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6518920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG3DSq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 23:18:46 -0400
Received: from mx.socionext.com ([202.248.49.38]:54638 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbeG3DSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 23:18:46 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jul 2018 10:46:08 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id E53C918011F;
        Mon, 30 Jul 2018 10:46:08 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 30 Jul 2018 10:46:08 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id A631F4039D;
        Mon, 30 Jul 2018 10:46:08 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 6AED4120424;
        Mon, 30 Jul 2018 10:46:08 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Andy Shevchenko'" <andy.shevchenko@gmail.com>
Cc:     "Mark Brown" <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>,
        "linux-spi" <linux-spi@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "devicetree" <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Hayashi=2C_Kunihiko/=E6=9E=97_=E9=82=A6=E5=BD=A6?= 
        <hayashi.kunihiko@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com> <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com> <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com> <001b01d424c4$66e04230$34a0c690$@socionext.com> <CAHp75VfPozwBPpuP9HadSc2GVm7tbPpMxg+AtACZa9jzVGGT-Q@mail.gmail.com>
In-Reply-To: <CAHp75VfPozwBPpuP9HadSc2GVm7tbPpMxg+AtACZa9jzVGGT-Q@mail.gmail.com>
Subject: RE: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Date:   Mon, 30 Jul 2018 10:46:05 +0900
Message-ID: <002101d427a7$14516f90$3cf44eb0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUJK+Lb4PtBS+ckEWxak8O5zFtw6SgmfYAgACbT7D//7fvAIAGDv3w
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andy
> Shevchenko
> Sent: Thursday, July 26, 2018 10:44 PM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Cc: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Yamada, Masahiro/山田 真弘 <yamada.masahiro@socionext.com>; linux-spi <linux-spi@vger.kernel.org>; linux-arm
> Mailing List <linux-arm-kernel@lists.infradead.org>; devicetree <devicetree@vger.kernel.org>; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Hayashi, Kunihiko/林 邦彦 <hayashi.kunihiko@socionext.com>
> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> On Thu, Jul 26, 2018 at 12:38 PM, Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
> 
> >> > +       /* check if requested speed is too small */
> >> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
> >>
> >> > +               return -EINVAL;
> >>
> >> So, does this critical?
> >
> > If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
> > I don't change it to high frequency, and it is daringly an error.
> > On the other hand, when changing to low frequency, I will change it automatically.
> 
> No. My point is, if somehow user asks for that condition to be happened you bail out, while when using clamp_val()
> you may continue to work at maximum limit, though issue warning to user, for example.

Thank you. I understood what you pointed out. 
However, I found this code unnecessary as pointed out by Radu, 
so I will delete it.

> >> > +
> >> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
> >> > +               ckrat = SSI_MIN_CLK_DIVIDER;
> >>
> >> clamp_val()  / max() ?
> >
> > I will modify it to use max().
> 
> See above.

This is also the same as above.

> --
> With Best Regards,
> Andy Shevchenko

-----------------
Best Regards,
Keiji Hayashibara



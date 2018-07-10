Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314BEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6C2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeMGfzvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6C2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeGJK0Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:26:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54107 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeGJK0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:26:13 -0400
Received: by mail-it0-f67.google.com with SMTP id a195-v6so29715090itd.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=szoZfkQMNgN2mN40m6eGCgMtptQmHYDaqIg1UTrzvas=;
        b=eeMGfzvSdOt+GeNpkmujPnjEMmEitspqjq7CkMz9RgultGnFAicrycFqkQwZneunto
         wqqxjIdk0ywB0VJ/hkXVfQO60EiJEPYBblu0+SYemVdW8PehYMBG55+PIhNmr2EzAcIZ
         rT25F/joI2PzlWFEUNzwJjPDvZZXbXbNopEQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=szoZfkQMNgN2mN40m6eGCgMtptQmHYDaqIg1UTrzvas=;
        b=Txe9yGLMHuMh9w7mGb62PLSrECvc4gBnT0RPklxscxgvphJy7TD0ftrFtX1yJf+c4M
         IjnjXBoF4RriKeYXnjU1+wzBFs/9tMuZzepa7bHt228aRRgsvAPrxGoyw662jUhOIf5M
         ws0XOtwlOCfTxT1cBnb9vAK1wumX7E/ImXGp05Pnhm4MqR3uvIqBfR6/+UFHVr+rn08p
         /atKpYkvCfanL9DcbDrOytP2ifW0Mu39eJvLotJrBflca7r1biqe60gXpTkpAN5UlDVG
         5EGoNv3g2By4pGJI4yJPWO0ta2qw7QCiqrR5gNgAY9Nv+xUmZ09SDj8rtO+D0LktsZN9
         /llw==
X-Gm-Message-State: APt69E1/jl6BKvpk1hut7A98MMISlzrPdiTCmluDwt3fKZR36XH2xldA
        FoT3IM8YOXB8ED1thti7FrBosyprpK1Ar5KqwP5x+g==
X-Google-Smtp-Source: AAOMgpdgxf9pRPr81+nwVRvVJNTUrMRzRguIv6H+MRrlS6sJkxHYOgORdlx4SzwbXcFyPKaHtXom9uIYn79zE0+3cHw=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr20034274jad.107.1531218372975;
 Tue, 10 Jul 2018 03:26:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 03:26:12
 -0700 (PDT)
In-Reply-To: <e36fac6f4907288c58a7dfa112541e73de957d46.camel@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com> <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
 <1528468422.26356.20.camel@pengutronix.de> <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
 <1530607328.22468.102.camel@pengutronix.de> <e36fac6f4907288c58a7dfa112541e73de957d46.camel@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Jul 2018 12:26:12 +0200
Message-ID: <CAPDyKFqdJ72ad4Ljz95TFxuNs_T1npSzBU7VCqFLExpC+2DW6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 July 2018 at 16:59, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On Tue, 2018-07-03 at 10:42 +0200, Lucas Stach wrote:
>> Am Montag, den 02.07.2018, 17:18 +0000 schrieb Leonard Crestez:
>> > On Fri, 2018-06-08 at 16:33 +0200, Lucas Stach wrote:
>> > > Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
>> > > > On imx7d the phy is turned off in suspend and must be reset on resume.
>> > > > Right now lspci -v fails after a suspend/resume cycle, fix this by
>> > > > adding minimal suspend/resume code from the nxp vendor tree.
>> > > >
>> > > > This is currently only enabled for imx7 but the same sequence can be
>> > > > applied to other imx pcie variants.
>> > > > +#ifdef CONFIG_PM_SLEEP
>> >
>> > Another issue that should be discussed here is that on 6sx and 7d the
>> > gpc PCIE power domain is not defined correctly: the PCIE block is in
>> > the DISPMIX domain on both SOCs and it is only PCIE_PHY which has a
>> > separate power domain.
>> >
>> > This matters: enabling power-gating for displays will break pcie if
>> > this relationship is not taken into account. Here are some options:
>> >
>> > 1) Make &pd_pcie a child of &pd_disp by hacking into gpc probe
>> > functions and calling pm_genpd_add_subdomain. Not very nice.
>> >
>> > 2) Support nesting PGCs in GPC code? Lots of code and still an
>> > incorrect representation of hardware.
>> >
>> > 3) Set power-domains = <&pd_disp> and enable runtime PM on &pd_pcie?
>> >
>> > 4) Add separate devices for the pcie-phy. These would be mostly empty
>> > but still different, for example on imx6sx the PHY is not even
>> > accessible on the bus but only though PCIE registers.
>>
>> 5) Take a look at the linux-pm list. ;) The power domain framework has
>> just gained support for multiple power domains per device. I think that
>>  is the right solution for this, as like you mentioned the PHY isn't
>> really a separate block on i.MX6, but part of the PCIe controller
>> device.

Yep, it sounds like the PCIe controller device is partitioned across
multiple PM domains.

>
> Yes, I noticed that earlier but not that it was merged recently. It is
> a better solution.
>
> Unfortunately the multiple power-domain code seems to require devices
> to explicitly fetch references to the power domains and manipulate
> them.

Actually, it's the other way around.

You need only one device to attach the PM domains. However, in genpd,
one device will be created per PM domain and its that device you get
back to operate upon.

Typically the returned device(s) should be linked with the "master"
device, device_link_add().

> As far as I can tell this means that every device using multiple
> power domains has to be modified to do so. In this particular case it
> would be useful to just have all power domains turned on before probe,
> just like when a single power-domain is specified:

I you need them to be powered on, just use the corresponding device
links flags when you create the link during probe.

Something along the lines of this:

device_link_add(dev, genpd_dev0, DL_FLAG_STATELESS |
DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);

>
>     power-domains = <&pd_pci>, <&pd_disp>;
>
> But this issue is not strictly related to imx7d pci hanging on
> suspend/resume, it can be dealt with later.

Maybe not, I don't have the complete picture.

However, you do get the opportunity to use the genpd infrastructure,
which calls the ->power_on|off() callbacks of the PM domain during
suspend/resume. And by using the dev_link_add(), you can make sure
that the PM domain gets powered on/off in the order as the
corresponding supplier device.

Kind regards
Uffe

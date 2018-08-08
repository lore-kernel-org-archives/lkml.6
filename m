Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA6D21776
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH466pnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA6D21776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeHHUmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbeHHUmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:42:32 -0400
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2174C21A5A;
        Wed,  8 Aug 2018 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533752498;
        bh=aei8Nka1ay1OaYRa7UAYJh0kf8jpSRahxiHUCihTkHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gH466pnbbmz610Y1eNRQlWldhHm2sEVDii7iZbYR9BfDuysh4iMP82SvPn8sCggeD
         NVOYDvlUuBrGm7XxmEoaPVHduS71CjvGXj3ohgg0CoZebwMxs932bZvF4g2JTY46sk
         lPUPwixrLXLYABjtw5g2ee62ZZloTXbt/UUfEugI=
Received: by mail-qt0-f180.google.com with SMTP id h4-v6so3544395qtj.7;
        Wed, 08 Aug 2018 11:21:38 -0700 (PDT)
X-Gm-Message-State: AOUpUlF9VnJ+WbI4cEGBGb0tbCe+0Ew3C/FzC4LutkJea+BjvBqlb8Dc
        F1X/LkwfAnKrKXSZEA43H4qnAOGKguusjYvfUw==
X-Google-Smtp-Source: AA+uWPxn1KxgBtkl8r3YS2Rratn0mAldPuHFlTHRJC09JDukbtnRQMjiXCQfseD3QDQe5zJI2aA4d3xumWdfOPnlYAk=
X-Received: by 2002:ac8:96b:: with SMTP id z40-v6mr3857966qth.362.1533752497212;
 Wed, 08 Aug 2018 11:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de> <20180730151131.GA28633@mani>
 <20180807184710.GA26423@rob-hp-laptop> <20180808172946.GA4188@Mani-XPS-13-9360>
In-Reply-To: <20180808172946.GA4188@Mani-XPS-13-9360>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Aug 2018 12:21:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7rFt8OKQoyD4JuZ+i9Fqc6RLsTxN4cJmur28ptwyNWQ@mail.gmail.com>
Message-ID: <CAL_JsqL7rFt8OKQoyD4JuZ+i9Fqc6RLsTxN4cJmur28ptwyNWQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl SoCs
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>,
        Parthiban Nallathambi <pn@denx.de>, edgar.righi@lsitec.org.br,
        Saravanan Sekar <sravanhome@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:30 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi Rob,
>
> On Tue, Aug 07, 2018 at 12:47:10PM -0600, Rob Herring wrote:
> > On Mon, Jul 30, 2018 at 08:41:31PM +0530, Manivannan Sadhasivam wrote:
> > > Hi Andreas,
> > >
> > > On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas F=C3=A4rber wrote:
> > > > Hi Mani,
> > > >
> > > > Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > > > > This patchset adds Reset Controller (RMU) support for Actions Sem=
i
> > > > > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrate=
d into
> > > > > the clock subsystem in hardware. Hence, in software we integrate =
RMU
> > > > > support into common clock driver inorder to maintain compatibilit=
y.
> > > >
> > > > Can this not be placed into drivers/reset/ by using mfd-simple with=
 a
> > > > sub-node in DT?
> >
> > That is exactly what I tell folks not to do. Design the DT based on h/w
> > blocks, not current desired driver split for some OS.
> >
> > > Actually I was not sure where to place this reset controller driver. =
When I
> > > looked into other similar ones such as sunxi, they just integrated in=
to the
> > > clk subsystem. So I just chose that path. But yeah, this is hacky!
> > >
> > > But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (=
Reset)
> > > are two separate IPs inside SoC, we shouldn't describe it as a MFD dr=
iver. Since
> > > RMU has only 2 registers, the HW designers decided to use up the CMU =
memory
> > > map. So, maybe syscon would be best option I think. What is your opin=
ion?
> >
> > If there's nothing shared then it is not a syscon. If you can create
> > separate address ranges, then 2 nodes is probably okay. If the register=
s
> > are all mixed up, then 1 node.
> >
>
> I don't quite understand the reason for not being syscon. The definition
> of syscon says that, "System controller node represents a register region
> containing a set of miscellaneous registers. The registers are not cohesi=
ve
> enough to represent as any specific type of device." which exactly fits
> this case. Only the registers of CMU & RMU are shared and not the HW bloc=
k!
>
> Can you please clarify?

IIRC, the original intent of 'syscon' was really for things that had
no subsystem. Random bits all just dumped together. A block with clock
and reset doesn't sounds pretty well defined functions. Plus that
criteria doesn't work well because what does and doesn't have a
subsystem (and DT binding) evolves. IMO, we should probably get rid of
'syscon'.

Let me turn it around. Why do you want it do be a syscon? Simply to
create a regmap I suppose because that is all that 'syscon' compatible
is. A flag to create a regmap. Why do you need a regmap then? Do you
need to protect concurrent accesses (a single register has both clock
and reset bits). If so, you can't really call CMU and RMU 2 blocks. If
not, you don't really need regmap.

Rob

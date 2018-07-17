Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CBEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C84720877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C84720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeGQQDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:03:41 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5816 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbeGQQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:03:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4e0b630000>; Tue, 17 Jul 2018 08:29:39 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Jul 2018 08:30:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Jul 2018 08:30:29 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Jul
 2018 15:30:26 +0000
Date:   Tue, 17 Jul 2018 18:30:20 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Mikko Perttunen" <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] dt-bindings: Add Tegra PMC pad configuration
 bindings
Message-ID: <20180717183020.5ab9bfa6@dhcp-10-21-25-168>
In-Reply-To: <CAL_JsqL1F0RF_6=ho0pa7Uh4AUsyvFRDGM50gN4=6_+MwBfGYQ@mail.gmail.com>
References: <1531396813-6581-1-git-send-email-avienamo@nvidia.com>
        <1531396813-6581-6-git-send-email-avienamo@nvidia.com>
        <20180716154309.GA16477@rob-hp-laptop>
        <20180717152318.3608e3f9@dhcp-10-21-25-168>
        <CAL_JsqL1F0RF_6=ho0pa7Uh4AUsyvFRDGM50gN4=6_+MwBfGYQ@mail.gmail.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 08:22:07 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, Jul 17, 2018 at 6:23 AM Aapo Vienamo <avienamo@nvidia.com> wrote:
> >
> > On Mon, 16 Jul 2018 09:43:09 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  
> > > On Thu, Jul 12, 2018 at 03:00:11PM +0300, Aapo Vienamo wrote:  
> > > > Document the pinctrl bindings used by the PMC driver for performing pad
> > > > configuration. Both nvidia,tegra186-pmc.txt and nvidia,tegra20-pmc.txt
> > > > are modified as they both cover SoC generations for which these bindings
> > > > apply.
> > > >
> > > > Add a header defining Tegra PMC pad voltage configurations.
> > > >
> > > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > > > ---
> > > >  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     | 84 +++++++++++++++++++
> > > >  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 95 ++++++++++++++++++++++
> > > >  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h | 18 ++++
> > > >  3 files changed, 197 insertions(+)
> > > >  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > > > index 5a3bf7c..9528f41 100644
> > > > --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
> > > > @@ -34,3 +34,87 @@ Board DTS:
> > > >     pmc@c360000 {
> > > >             nvidia,invert-interrupt;
> > > >     };
> > > > +
> > > > +== Pad Control Nodes ==
> > > > +
> > > > +The PMC can be used to set pad power state and voltage configuration.
> > > > +The pad configuration is done via the pinctrl framework. The driver
> > > > +implements power-source, low-power-enable, and low-power-disable pinconf
> > > > +pin configuration node properties. Each pinctrl pin corresponds to a
> > > > +single Tegra PMC pad. Thus, in the following sections of this document
> > > > +pin refers to the pinctrl frameworks notion of a Tegra PMC pad.  
> > >
> > > "pinctrl framework" is Linux specific and doesn't belong in the binding.
> > > Neither does what a driver supports. Describe what the h/w supports.
> > >  
> > > > +
> > > > +The pad configuration state nodes are placed under the pmc node and they
> > > > +are referred to by the pinctrl client device properties. For more  
> > >
> > > Another driver detail not relevant.
> > >  
> > > > +information see the examples presented later and  
> > >
> > > examples don't document bindings. The documentation should be complete
> > > without examples.
> > >  
> > > > +Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> > > > +
> > > > +The values accepted by power-source property are
> > > > +TEGRA_IO_PAD_VOLTAGE_1V8 and TEGRA_IO_PAD_VOLTAGE_3V3, which are defined
> > > > +in dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.  
> > >
> > > You need to list out what properties the child nodes can have.
> > >
> > > power-source needs a vendor prefix.  
> >
> > Isn't it a generic pinctrl property?  
> 
> I don't know offhand. Doesn't look like it if you have custom values.

It's listed under "Supported generic properties" in
pinctrl-bindings.txt. The convention seems to be not to add a vendor
prefix even though such custom macro values are used. The property is
currently used by qcom,pmic-gpio, qcom,pmic-mpp, and renesas,pfc-pinctrl.
I could not find a bindings document describing it with a vendor prefix.

 -Aapo

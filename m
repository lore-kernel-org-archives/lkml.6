Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C289C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9DD20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9DD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeLCMl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:41:26 -0500
Received: from foss.arm.com ([217.140.101.70]:36488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeLCMl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:41:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4231688;
        Mon,  3 Dec 2018 04:40:32 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 655A03F614;
        Mon,  3 Dec 2018 04:40:32 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 538511AE1062; Mon,  3 Dec 2018 12:40:52 +0000 (GMT)
Date:   Mon, 3 Dec 2018 12:40:52 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Tom Rini <trini@konsulko.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        Grant Likely <glikely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to
 json-schema
Message-ID: <20181203124039.GA25097@arm.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
 <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:00:05PM -0600, Rob Herring wrote:
> On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >
> > Hi Rob,
> >
> > On 05. 10. 18 18:58, Rob Herring wrote:
> > > Convert ARM CPU binding to DT schema format using json-schema.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> > >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> > >  2 files changed, 503 insertions(+), 490 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
> 
> [...]
> 
> > I have take a look at xilinx part of this and try to build it for arm64
> > platforms and I see errors coming from this cpu description.
> > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> > unexpected)
> 
> Thanks for actually giving this a spin!
> 
> > Based on grep this is used in a lot of places
> > compatible = "arm,cortex-a53", "arm,armv8";
> >
> > Should this be moved to just simple?
> > compatible = "arm,cortex-a53";
> 
> I'd normally go with the majority which would be to keep it. However,
> 'arm,armv8' is of questionable value, isn't actually documented, and
> doesn't exist for any other version of the architecture. So we should
> kill it IMO.

I'd prefer to keep it around, since that's what's used to describe the CPUs
on the fastmodel iirc.

Will

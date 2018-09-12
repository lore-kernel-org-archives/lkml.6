Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3799AC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDD2206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDD2206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeILM3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:29:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55806 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeILM3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:29:38 -0400
Received: from ip5f5a866f.dynamic.kabel-deutschland.de ([95.90.134.111] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fzzXR-0004QC-Dw; Wed, 12 Sep 2018 09:26:13 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>, robh+dt@kernel.org,
        vicencb@gmail.com, shawn.lin@rock-chips.com,
        enric.balletbo@collabora.com, pbrobinson@gmail.com, tom@vamrs.com,
        dev@vamrs.com, stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: Split out common nodes for Rock960 based boards
Date:   Wed, 12 Sep 2018 09:26:12 +0200
Message-ID: <11137562.zz0kzkSHxt@diego>
In-Reply-To: <20180912031248.GA4880@Mani-XPS-13-9360>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org> <9e1868684ed851dfa19300ac2e648cfea7bf3eb9.camel@collabora.com> <20180912031248.GA4880@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 12. September 2018, 05:12:48 CEST schrieb Manivannan Sadhasivam:
> Hi Ezequiel,
> 
> On Tue, Sep 11, 2018 at 04:40:29PM -0300, Ezequiel Garcia wrote:
> > On Tue, 2018-09-11 at 08:00 +0530, Manivannan Sadhasivam wrote:
> > > Since the same family members of Rock960 boards (Rock960 and Ficus)
> > > share the same configuration, split out the common nodes into a common
> > > dtsi file for reducing code duplication. The board specific nodes for
> > > Ficus boards are then placed in corresponding board DTS file.
> > 
> > I think it should be possible to move the common USB nodes to the dtsi
> > file, and keep the board-specific (phy-supply property) in the dts files:
> > 
> > &u2phy0_host {
> > 
> >         phy-supply = <&vcc5v0_host>;
> > 
> > };
> > 
> > &u2phy1_host {
> > 
> >         phy-supply = <&vcc5v0_host>;
> > 
> > };
> 
> We can do that but my intention was to entirely partition the nodes
> which are not common. So that it would be less confusing when someone
> looks at it (please correct me if I'm wrong).

The supply is actually named the same on both boards, so you could move
all the usb-nodes to the main dtsi, including the reference to vcc5v0_host
which would then get defined itself in the two board dts.

Then again, seeing that the vcc5v0_host also only differs in the actually
used gpio another option would be to move the whole regulator node
to the dtsi and just define the gpio properties in the board dts files.


Heiko



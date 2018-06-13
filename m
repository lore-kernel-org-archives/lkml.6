Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 88AE7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B7D204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B7D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935708AbeFMM45 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:56:57 -0400
Received: from gloria.sntech.de ([95.129.55.99]:41764 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935570AbeFMM4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:56:54 -0400
Received: from ip9234b215.dynamic.kabel-deutschland.de ([146.52.178.21] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fT5KO-00078J-J0; Wed, 13 Jun 2018 14:56:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     klaus.goger@theobroma-systems.com
Cc:     Randy Li <ayaka@soulik.info>, linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] ARM64: dts: rockchip: add some pins to rk3399
Date:   Wed, 13 Jun 2018 14:56:43 +0200
Message-ID: <6575089.GrJ2ErpgXD@diego>
In-Reply-To: <B649911B-28E0-4466-B3F0-15875FFB9D43@theobroma-systems.com>
References: <20180612152544.3812-1-ayaka@soulik.info> <B649911B-28E0-4466-B3F0-15875FFB9D43@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. Juni 2018, 20:21:06 CEST schrieb klaus.goger@theobroma-
systems.com:
> Hi Randy,
> 
> > On 12.06.2018, at 17:25, Randy Li <ayaka@soulik.info> wrote:
> > 
> > Those pins would be used by many boards.
> > 
> > Signed-off-by: Randy Li <ayaka@soulik.info>

agree to everything Klaus said ;-) .

[...]

> > +			pcie_clkreqn: pci-clkreqn {
> > +				rockchip,pins =
> > +					<2 26 RK_FUNC_2 &pcfg_pull_none>;
> > +			};
> > +
> > +			pcie_clkreqnb: pci-clkreqnb {
> > +				rockchip,pins =
> > +					<4 24 RK_FUNC_1 &pcfg_pull_none>;
> > +			};
> > +
> 
> I’m not sure if pci-clkreqn is functional at all. If not I’m not sure if we
> should add it to the dtsi. Shawn may know more about it.

Yep, wasn't there a big change away from clkreqn, due it
not being functional?


> > 			pcie_clkreqnb_cpm: pci-clkreqnb-cpm {
> > 			
> > 				rockchip,pins =
> > 
> > -					<4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
> > +					<4 24 RK_FUNC_GPIO &pcfg_pull_none>;
> > 
> > 			};
> > 		
> > 		};
> 
> Could we actually use RK_Pxx for all new pin definitions? Would increase
> readability a lot.

Especially as the above change really only seems to change RK_PD0 back
to 24, so this block (and some others) will go away entirely.


Heiko




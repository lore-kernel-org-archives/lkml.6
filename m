Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD234C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E03A216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E03A216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeHHM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:56:20 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42108 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeHHM4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:56:19 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F04EABD974;
        Wed,  8 Aug 2018 10:37:10 +0000 (UTC)
Message-ID: <dc8a28bcfbe082158bac5b097badb3ddf0f51ce8.camel@aosc.io>
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi
 M2 Berry DTS to rebase on M2 Ultra
From:   Icenowy Zheng <icenowy@aosc.io>
To:     maxime.ripard@bootlin.com
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Date:   Wed, 08 Aug 2018 18:36:56 +0800
In-Reply-To: <20180726124119.dwne2sncws2p3sdi@flea>
References: <20180724163655.61365-1-icenowy@aosc.io>
         <20180726124119.dwne2sncws2p3sdi@flea>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-07-26四的 14:41 +0200，Maxime Ripard写道：
> On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> > Banana Pi designs the BPi M2 Berry board to be software compatible
> > with
> > BPi M2 Ultra,
> 
> Do you have a reference for this?
> 
> > so it's based on M2 Ultra with some function cuts, including:
> > 
> > - 2048MiB DRAM -> 1024MiB (this should be proceed by the
> > bootloader);
> > - dropped a LED;
> > - dropped eMMC;
> > - dropped USB2 and connect USB1 to a 4-port HUB.
> 
> Is it the exhaustive list?

I have asked Mikey from Sinovoip, and he has agreed this.

Here's a list provided by him, which covers some things I forgot:
- 2GiB -> 1GiB
- no eMMC
- no onboard microphone
- no IR
- no charging (and power jack to USB)
- USB change
- one less LED

Should I add this to the device tree's comment?

> 
> I'm a bit reluctant to merge that kind of patches usually, since that
> would also imply that each time someone will commit something to the
> M2-Ultra, it would automatically apply to the M2-Berry, without any
> easy way to tell and / or test.
> 
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


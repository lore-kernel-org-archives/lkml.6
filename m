Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595ABC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1588D2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1588D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeJLCCS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:02:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60714 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbeJLCCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:02:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1FD4F207EB; Thu, 11 Oct 2018 20:33:51 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id E235B207C4;
        Thu, 11 Oct 2018 20:33:40 +0200 (CEST)
Date:   Thu, 11 Oct 2018 18:40:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc:     aleksandr.aleksandrov@emlid.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: new board - Emlid Neutis N5
Message-ID: <20181011164053.zxoucudslmz3w2yn@flea>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <20181010144957.exrlupoph7ovsmdw@flea>
 <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
 <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:20:11PM +0200, Andreas Färber wrote:
> >> Also, I have a general comments, and it really depends on what your
> >> intention about the board ecosystem is. Do you expect the SOM to be
> >> swappable in multiple boards, or do you expect to send it as something
> >> that is just fixed into a daughter board?
> >>
> >> In the former case, you probably want to use overlays instead. In the
> >> latter, you're fine.
> >>
> > Right, we expect the SoM to be swappable. I agree, to use overlays is
> > more convenient, but
> > the devboard DT file will be a reference for the overlays and the future
> > boards based on Neutis.
> 
> What about just keeping the common nodes enabled in a SoM .dts, so that
> the average board doesn't need an Overlay for booting?

I guess the fundamental difference would be if the SoM can be run
free-standing or not. If it is, then overlays would be best. If not,
then I'm fine with using the include like Aleksandr has used.

> @Maxime/Rob, is it possible to merge .dtso files these days? If not,
> could that be considered in the big dts Makefile refactoring? :)

I don't really know what is that big dts Makefile refactoring you're
mentionning, but I don't think we can merge dtso before having the DT
connectors in place.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

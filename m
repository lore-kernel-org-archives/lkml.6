Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2883AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D446320843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t21wrzqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D446320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeIZQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:50:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47710 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIZQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:50:17 -0400
Received: from avalon.localnet (nat-242.udc.es [193.144.61.242])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43254506;
        Wed, 26 Sep 2018 12:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537958275;
        bh=j99ZjXI8qlnrC2UnJA8C+hbsBg4EC9YycNZjepTzxY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t21wrzqbEyXPsXlIK5L7rMFkLSxs1fvCNqNmU1M+d6J5yypVeOYHGgHCe9EJ25/N1
         GppdgUTC37Z2XV0ifll7wjibjaBsS2RD6xH7NMp4tsssQwILReRtIgEI/CoHX9+UHE
         81o4ur08HmBDPePzO0ysXOZatzorGn/tf4I44gzI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     maxime.ripard@bootlin.com
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "\"David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v11 1/2] dt-bindings: media: Add Allwinner V3s Camera Sensor Interface (CSI)
Date:   Wed, 26 Sep 2018 13:38:08 +0300
Message-ID: <1568838.d8CnAYTeDB@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180926103547.5ubb6xjkl7xngmfg@flea>
References: <1537951204-24672-1-git-send-email-yong.deng@magewell.com> <7197338.mhOH8fQaEM@avalon> <20180926103547.5ubb6xjkl7xngmfg@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wednesday, 26 September 2018 13:35:47 EEST maxime.ripard@bootlin.com wrote:
> On Wed, Sep 26, 2018 at 01:19:34PM +0300, Laurent Pinchart wrote:
> > > +Endpoint node properties for CSI1
> > > +---------------------------------
> > 
> > Should you list the CSI0 properties as well ? As the driver in patch 2/2
> > doesn't support the CSI-2 interface I assume you have left out CSI0 for
> > now, but it should still be listed in the bindings. I'm fine with fixing
> > this as a follow-up patch to avoid missing the v4.20 merge window, but if
> > you end up resubmitting the series, could you please address the problem
> > ?
> 
> That driver is not available, and the documentation isn't either, so
> there's no easy way to tell which properties are going to be needed
> before doing the actual work of reverse engineering it and writing a
> driver for it. Unfortunately...

While DT bindings should be independent from driver implementations, I agree 
it's difficult to develop good bindings without hardware documentation and 
without at least one working driver implementation.

How about just explicitly stating that these bindings don't support CSI0 yet ?

-- 
Regards,

Laurent Pinchart




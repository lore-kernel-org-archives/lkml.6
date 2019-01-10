Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE25820660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfAJP1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:27:10 -0500
Received: from muru.com ([72.249.23.125]:33012 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbfAJP1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:27:09 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8B4BC80E7;
        Thu, 10 Jan 2019 15:27:14 +0000 (UTC)
Date:   Thu, 10 Jan 2019 07:27:05 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_omap: Drop check for of_node
Message-ID: <20190110152705.GX5544@atomide.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
 <20190109091206.25759-2-vigneshr@ti.com>
 <20190109214403.GW5544@atomide.com>
 <20190110120758.bz63neey5ztepw4m@earth.universe>
 <dbc00a69-2144-6e30-e9b1-4f8ee272ab8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc00a69-2144-6e30-e9b1-4f8ee272ab8a@ti.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [190110 13:24]:
> 
> On 10-Jan-19 5:37 PM, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Wed, Jan 09, 2019 at 01:44:03PM -0800, Tony Lindgren wrote:
> >> * Vignesh R <vigneshr@ti.com> [190109 09:11]:
> >>> 8250_omap is DT only driver so dev->of_node always exists. Drop check
> >>> for existence of valid dev->of_node to simplify omap8250_probe().
> >>
> >> That part seems safe to me now.
> >>
> >>> --- a/drivers/tty/serial/8250/8250_omap.c
> >>> +++ b/drivers/tty/serial/8250/8250_omap.c
> >> ...
> >>> -		const struct of_device_id *id;
> >>> -
> >>> -		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> >>> -
> >>> -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> >>> -				     &up.port.uartclk);
> >>> -		priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
> >>> -
> >>> -		id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
> >>> -		if (id && id->data)
> >>> -			priv->habit |= *(u8 *)id->data;
> >>
> >> But this part it seems we still need to keep around
> >> as we still have lots of clock-frequency references
> >> in the *.dtsi files. Or am I missing something?
> > 
> > It's re-added a couple of lines later. Only the indent was removed.
> > 
> 
> That's right. You beat me to it. Thanks :)

Oh right, sorry I missed that :)

Regards,

Tony

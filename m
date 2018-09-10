Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B8A20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wbo21Eri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B8A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeIJOjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:39:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51274 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:39:08 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 39BF557;
        Mon, 10 Sep 2018 11:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536572750;
        bh=k84zJZiYcGw1dHZ3HCnA63TQAebrdAR5Z9WB5mvPXxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbo21EriiycGYUQAOOC8TOzdSxKG+Rsb1STeVpEEJ7lvcGhHKoLnnbB2ewNbct5M0
         jBFcx6yfg08s9rPbXlVm/jOXZB4t5eYd1QRCoC0SaS2duD0CLXA98BBYb9htt40VJ8
         SY973VdPUAF4V5Ts+J9VBTHIVXpWrodQnWR/guno=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        jacopo <jacopo@jmondi.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Date:   Mon, 10 Sep 2018 12:46:00 +0300
Message-ID: <8834220.fknQf5gIhd@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CACRpkdad=U5YACQ6k86A4BJo9-U4bC61A0kJ8kONSHu+u3BPyA@mail.gmail.com>
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com> <TY1PR01MB17697A2D3BCA85B3BFC1FE21F5020@TY1PR01MB1769.jpnprd01.prod.outlook.com> <CACRpkdad=U5YACQ6k86A4BJo9-U4bC61A0kJ8kONSHu+u3BPyA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Monday, 10 September 2018 10:48:58 EEST Linus Walleij wrote:
> On Wed, Sep 5, 2018 at 11:59 AM Phil Edworthy wrote:
> > On 05 September 2018 10:37, Geert Uytterhoeven wrote:
> > > Have the VxWorks DT bindings been submitted for review to the devicetree
> > > mailing list?
> > 
> > I'm not involved with the VxWorks port, but I am pretty sure that they
> > have not been submitted for review.
> 
> We have had other cases where deployments on other OSes have been
> establishing bindings (even not very pretty ones).

I hardly see that as a good reason to accept the bindings blindly. If they 
haven't been submitted for review, it's their problem, not ours. Even worse in 
my opinion is the fact that those bindings are used by the "out-of-tree Linux 
port". We've hammered the "upstream first" message for years if not decades, 
if the industry still can't get it, I don't see why we should be the ones 
suffering.

No ack from me for these new bindings, sorry.

> Examples include typically the Power MacIntosh and the original SPARC
> bindings.

-- 
Regards,

Laurent Pinchart




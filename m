Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC95C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5713620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfAaJFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:05:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58761 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfAaJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:05:42 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gp8I0-0007Qz-GK; Thu, 31 Jan 2019 10:05:40 +0100
Message-ID: <1548925539.6869.36.camel@pengutronix.de>
Subject: Re: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Thu, 31 Jan 2019 10:05:39 +0100
In-Reply-To: <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
         <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 31.01.2019, 08:03 +0000 schrieb Aisheng Dong:
> One irqsteer channel can support up to 8 output interrupts.
> 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ChangeLog:
> v2->v3:
>  * fix a typo
> v1->v2:
>  * remove one unnecessary note.
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> index 6d0a41b..582991c 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> @@ -6,8 +6,9 @@ Required properties:
> >  	- "fsl,imx8m-irqsteer"
> >  	- "fsl,imx-irqsteer"
>  - reg: Physical base address and size of registers.
> -- interrupts: Should contain the parent interrupt line used to multiplex the
> -  input interrupts.
> +- interrupts: Should contain the up to 8 parent interrupt lines used to
> +  multiplex the input interrupts. They should be specified sequentially
> +  from output 0 to 7.
>  - clocks: Should contain one clock for entry in clock-names
>    see Documentation/devicetree/bindings/clock/clock-bindings.txt
>  - clock-names:

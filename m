Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE58D214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="E7Laryj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeLSLiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:38:07 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51920 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeLSLiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:38:07 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDC37549;
        Wed, 19 Dec 2018 12:38:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545219484;
        bh=pMk32tWyfmJp9PmcfOUi0mquzU6wlJkMVW+t2StVdLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7Laryj3ruKmjq0oly6qXu3tMwwPSPyWMDvJzjw8DfWi/v1EJeOkeGgCWYpIYPVeP
         JSrtzbNvU9QcpnEhv/gyUVXy7Cf0giaYizYzkRhGQ+b+2hXBCEMmAMi4yginYrEWk9
         4j16X7RgNTBoJk38cPkbb2IvaElrzd0URyf3oJEs=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: display: bridge: lvds-transmitter: add pwdn-gpios
Date:   Wed, 19 Dec 2018 13:38:57 +0200
Message-ID: <2541072.bfOLpEHFeN@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <7c2f1268-43a3-1dc2-bb2d-6da9d74a5a43@axentia.se>
References: <20181218231850.3572-1-peda@axentia.se> <f0686eeb-14af-6525-6c55-9cc8bdc5730e@samsung.com> <7c2f1268-43a3-1dc2-bb2d-6da9d74a5a43@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wednesday, 19 December 2018 11:57:32 EET Peter Rosin wrote:
> On 2018-12-19 10:12, Andrzej Hajda wrote:
> > On 19.12.2018 00:19, Peter Rosin wrote:
> >> Add optional property to specify a power-down GPIO.
> >> The pwdn-gpios name is already in use by the thine,thc63lvdm83d
> >> binding, so go with that.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >> 
> >>  Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt |
> >>  3 +++ 
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> >> b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> >> index f9e7dd666f58..47941d39f92f 100644
> >> ---
> >> a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> >> +++
> >> b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> >> @@ -31,6 +31,9 @@ Required properties:
> >>    device-specific version corresponding to the device first
> >>    followed by the generic version.
> >> 
> >> +Optional properties:
> >> +- pwdn-gpios: Power-down control GPIO
> >> +
> > 
> > Since naming is not enforced by any datasheet I would propose something
> > more popular with less twisted logic. Maybe:
> > 
> > - enable-gpios: ... (active high).
> 
> That was my original thought too, but the driver implementing the
> lvds-encoder bindings also handles the mentioned thine,thc63lvdm83d
> lvds encoder, and that binding has the "pwdn" naming. So, for driver
> implementation simplicity I went with what was already there, thus
> allowing adding support for both bindings with one implementation
> (in patch 3/3).
> 
> Adding code just to handle multiple names for the same thing does
> not sounds too appealing.

I'm afraid I think we shouldn't add pwdn-gpios support to the lvds encoder DT 
bindings. The reason is that control GPIOs (and regulators) come with device-
specific semantics. If we add pwdn-gpios now, we'll then add reset-gpios, and 
power supplies, and all of a sudden we'll end up having to encode sequencing 
of GPIOs and power supplies in DT. That path has been tried in the past, with 
no good results.

I would instead create device-specific bindings, like done for 
thine,thc63lvdm83d. It's fine to then add support for the pwdn-gpios property 
in the lvds-encoder driver, as long as the meaning of the property comes from 
specific DT bindings, not from the generic ones.

-- 
Regards,

Laurent Pinchart




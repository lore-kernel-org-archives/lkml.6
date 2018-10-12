Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE33C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81F820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="MlRtEkfq";
	dkim=pass (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="dfpggKXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81F820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeJLVLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:11:54 -0400
Received: from forward106o.mail.yandex.net ([37.140.190.187]:56795 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728447AbeJLVLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:11:53 -0400
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id AE04278704D;
        Fri, 12 Oct 2018 16:39:19 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id PyIlBU19dD-dHZCItIX;
        Fri, 12 Oct 2018 16:39:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539351559;
        bh=UDgDfRZhaZ79J4/IZ8CNyBmcITAgLulkoSlZ3oLYy3w=;
        h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To;
        b=MlRtEkfq0TYcJUR3MqZw7JgNliAmm7PVhi91c78qzYVPEzfx+kD2D/KNv7SZYJt/v
         fVEk/gOZhf76HQx4gOtn4/om5XyWfZuawIWIX81vz/EBjqpnqMPwl9TTEBH1R1bo5T
         OznyaWyr9+A9dRVMIzabcx0Z0l/ksWq8EC9wXoyY=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id DyUvoURzV7-dF1WFtvN;
        Fri, 12 Oct 2018 16:39:15 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539351556;
        bh=UDgDfRZhaZ79J4/IZ8CNyBmcITAgLulkoSlZ3oLYy3w=;
        h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To;
        b=dfpggKXaLdfCJntB6/zBmfxtXY0gg+ZfwxzWjw6DeGskZm/+x1Olkc8y7EOm/HEHS
         4l39n5qcd2Ra1lN9rfap2hmAGo2yw/Ex+st5Hm8jP9LKM30ZIpI3Okr9CSzEyl22ST
         PR6Hh7P0BWpILLW523c9O8FAaww4sjdYSMJth2qU=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@emlid.com
Date:   Fri, 12 Oct 2018 16:39:14 +0300
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] arm64: dts: allwinner: new board - Emlid Neutis N5
Message-ID: <20181012133914.GA32670@imagebutcher>
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <b47c5458-683e-3e96-0bbe-f9db84579c77@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47c5458-683e-3e96-0bbe-f9db84579c77@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Thanks for your feedback!

> > + *
> > + * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h5-emlid-neutis-n5.dtsi"
> > +
> > +/ {
> > +	model = "Emlid Neutis N5 Developer board";
> > +	compatible = "emlid,neutis-n5-devboard",
> > +		     "emlid,neutis-n5",
> 
> You are lacking bindings definitions for these new identifiers. The
> vendor prefix should be patch 1/3, the SoM/board compatibles 2/3 and
> this .dts[i] patch 3/3, so that only vendor prefixes and compatibles
> that are defined and don't result in checkpatch.pl warnings get used.

Patch 2/3:

commit 46dcb8632b36644cb20e6b35ede12ff0088a60eb
Author: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Date:   Fri Oct 12 16:22:28 2018 +0300

    dt-bindings: arm: sunxi: emlid,neutis-n5(-devboard)
    
    sunxi: add new compatibles for Emlid Neutis Dev board and SoM module
    
    Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..a907e52 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -19,3 +19,5 @@ using one of the following compatible strings:
   allwinner,sun9i-a80
   allwinner,sun50i-a64
   nextthing,gr8
+  emlid,neutis-n5
+  emlid,neutis-n5-devboard

Is this right place for the neutis compatibles?

Aleksandr


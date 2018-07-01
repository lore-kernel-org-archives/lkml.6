Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6429C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588AB25224
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="psjhxCNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588AB25224
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeGAIVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeGAIVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:21:33 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B16024519;
        Sun,  1 Jul 2018 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530433292;
        bh=pD6vGKCaXqfpBRTtC+UxNYBhpONfF16NOiuHj7uhO8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psjhxCNZawNaJr+CqH1XBLe1eH7kF0qJH+7aJIy6hjezdu8OaZYGMA/eAOMbIUZIW
         4kUOFueWskEpdDhQxzNxwse3qwLkAfOX5Ke6Wwo4l48vYSJjuUVdTO6dd/n45L5vQA
         QPBg3emNoGcRsG3exDW1ukNLMu5x9x3StNF1vw+4=
Date:   Sun, 1 Jul 2018 16:21:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, nikita.yoush@yandex.ru,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
Message-ID: <20180701082119.GH4348@dragon>
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
 <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
 <CAOMZO5B5PS7a6SFfzX915AkRoDpeFVV7P0hrG9A51yWRFy5X_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5B5PS7a6SFfzX915AkRoDpeFVV7P0hrG9A51yWRFy5X_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 02:00:11PM -0300, Fabio Estevam wrote:
> On Wed, Jun 27, 2018 at 1:46 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
> 
> > We are now starting to give Andrey Gusakov conflicting
> > recommendations. For the sake of moving forward, can we agree that
> > this and similar comments are relatively minor and defer to the
> > maintainers to make a call which way to go?
> > This way Andrey has a clear way on how to move forward with this set.
> 
> The approach in this patched looked fine to me as well.
> 
> Maybe we can have some feedback from Shawn?

I'm overall fine with the approach as well.  But I agree with Nikita's
comment that having pinctrl definition and usage spread in different
files makes reader's life harder.  So I would suggest that we have the
following properties in imx51-zii-rdu1.dts as well.

	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_swi2c>;

Shawn

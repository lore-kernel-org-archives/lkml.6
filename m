Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610C120863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLrrx8d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610C120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeK2JDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:03:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2JDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:03:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E9120832;
        Wed, 28 Nov 2018 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442406;
        bh=72kqhyeQVO8JTefh63w4wPrqJnB+6Kqgor1kttGM0E8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=oLrrx8d+r8KJtapDivhObs5epDeg3Y9KqwioqT/Ca4g9SEuJUXoTWJQRZlTBjrh42
         J3tyCBU8KFDmS+m0dLesvzw0tn6GQVnr/SgPmpQbl+gfNx2i3l9MBukCRzZ7CtLKTM
         br4ea5yHohfY/qYPijhdiECuYZxADZj+61y1dPU8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87efbbq2i7.fsf@bootlin.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-5-gregory.clement@bootlin.com>
 <153980091588.5275.2414842812770832337@swboyd.mtv.corp.google.com>
 <87efbbq2i7.fsf@bootlin.com>
Message-ID: <154344240618.88331.16995563056122948942@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 4/6] clk: mvebu: ap806: Fix clock name for the cluster
Date:   Wed, 28 Nov 2018 14:00:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-11-23 06:42:24)
> Hi Stephen,
>  =

>  On mer., oct. 17 2018, Stephen Boyd <sboyd@kernel.org> wrote:
> =

> > Quoting Gregory CLEMENT (2018-09-22 11:17:07)
> >> Actually, the clocks exposed for the cluster are not the CPU clocks, b=
ut
> >> the PLL clock used as entry clock for the CPU clocks. The CPU clock wi=
ll
> >> be managed by a driver submitting in the following patches.
> >> =

> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >
> > Does this need a fixes tag?
> =

> It doesn't fix a regression so I don't thing it needs a fixes tag.
> =


Would it help anyone who is backporting the stack of patches to support
this? I would liberally add a Fixes tag here in case it helps anyone
learn that this was incorrect all along.


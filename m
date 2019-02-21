Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CD7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BFF2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550786028;
	bh=HqmzWx1WnbLsrPdHjBxf+JDc5SDbk2yFRHQ+34ezSEo=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=qR9mcbkSbw2RrRgk7kpaAAQzhE/5PQIuBmtNUBKTDtGIHT44eEIvIaN4m9dCzAudX
	 ka1Swgv7EZ7nrVC6zDqZw0uAGSOHY2a8wcRmdLO1DYY25vNcREzwL9NlrZpXqbuv37
	 PRIC0lmD79eonoeJpgDApyP3QHp3SRXiIeJt5EOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfBUVxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfBUVxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:53:46 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915E52083E;
        Thu, 21 Feb 2019 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550786025;
        bh=HqmzWx1WnbLsrPdHjBxf+JDc5SDbk2yFRHQ+34ezSEo=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=X2ZckhBkLTSFOc4sRSX46kC68N/9tCozM71ZYDjQft23toKHMW1ESlRp2Nm5/lvtz
         VxZwSJq+Xpe1Yre9GS3e9vjfCxtsSmDVLW+H82NGXNAYvMawWOb+qVq3Gzl+ik7K5V
         mtb8PJMWyHGLaax+0SKQT6Km2NwERjIbRdwCRWcE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] clk: mmp2: separate LCDC peripheral clk form the display clock
Message-ID: <155078602492.77512.6283122570028118811@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190121063129.552580-1-lkundrak@v3.sk> <20190121063129.552580-3-lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190121063129.552580-3-lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Date:   Thu, 21 Feb 2019 13:53:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-20 22:31:29)
> These are in fact two clocks, they shouldn't be exposed as one. One is
> required for accessing LCD controller registers (peripheral clock), while
> other (AXI clock) can be optionally used as a pixel clock source for the
> panel.
>=20
> LCDC can alternatively use different clocks than the Display 1 AXI clock
> for generating the pixel clock: the second AXI clock (fixed in this
> commit too), the HDMI PLL, or the AXI bus clock.
>=20
> They should really be controlled independently.
>=20
> Link: https://lists.freedesktop.org/archives/dri-devel/2019-January/20397=
5.html
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next


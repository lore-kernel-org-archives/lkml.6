Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2454BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E02208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdiOdLL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E02208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeFQHG0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932075AbeFQHGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:06:24 -0400
Received: from dragon (unknown [45.56.152.75])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762F120864;
        Sun, 17 Jun 2018 07:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529219184;
        bh=jNuqkMMATqUUs4rluPRjdodz+jB1pYNnJzt/JADU5Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdiOdLL+chPHEdi5lKxmN88SDA7gRJKsDWA7n4BI2EKjc+qngFm9anOWXlqDzcA96
         6pHJpAQBr6E7/9yuddT1YGaG9/jZ4LkTSHgbbtfgaR7aXD4Gnee0PV4OvkRM5YWHzX
         c7WVQF40SopUO+Npk6AOg0drXR+5H/ubkhHHrLTo=
Date:   Sun, 17 Jun 2018 15:05:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
Message-ID: <20180617070527.GL16091@dragon>
References: <20180517055014.6607-1-o.rempel@pengutronix.de>
 <20180517055014.6607-4-o.rempel@pengutronix.de>
 <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
 <2307533.g32PyNi9fl@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2307533.g32PyNi9fl@aspire.rjw.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:33:05PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 12, 2018 2:42:12 PM CEST Oleksij Rempel wrote:
> >  This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
> > --Sj2PRcQlY7eZybdA0sq9wWzJEO8fKS924
> > Content-Type: multipart/mixed; boundary="d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg";
> >  protected-headers="v1"
> > From: Oleksij Rempel <o.rempel@pengutronix.de>
> > To: Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
> >  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
> >  linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
> >  linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
> >  Liam Girdwood <lgirdwood@gmail.com>,
> >  Leonard Crestez <leonard.crestez@nxp.com>, Rob Herring <robh+dt@kernel.org>,
> >  Mark Rutland <mark.rutland@arm.com>,
> >  Michael Turquette <mturquette@baylibre.com>,
> >  Stephen Boyd <sboyd@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>,
> >  Russell King <linux@armlinux.org.uk>
> > Message-ID: <daba73df-037c-2583-3a08-f3f27c4129d1@pengutronix.de>
> > Subject: Re: [PATCH v7 3/6] kernel/reboot.c: export pm_power_off_prepare
> > References: <20180517055014.6607-1-o.rempel@pengutronix.de>
> >  <20180517055014.6607-4-o.rempel@pengutronix.de>
> > In-Reply-To: <20180517055014.6607-4-o.rempel@pengutronix.de>
> > 
> > --d6BZYFRi4L3iCmOh3nm6wjii3dWC9QFDg
> > Content-Type: text/plain; charset=utf-8
> > Content-Language: en-US
> > Content-Transfer-Encoding: quoted-printable
> > 
> > Hi Rafael,
> > 
> > Last version of this patch was send at 17.05.2018. No other comment was
> > provided and this patch is a blocker for other patches in this serie.
> > Can you please give some feedback on it.
> 
> I would have done that had I not missed the patch.
> 
> Which probably wouldn't have happened had you CCed it to linux-pm.
> 
> Anyway, I have no particular problems with exporting pm_power_off_prepare via
> EXPORT_SYMBOL_GPL().

Rafael,

Can we have your explicit Acked-by tag on this patch?  Thanks.

Shawn

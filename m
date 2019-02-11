Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33EFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEEA21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549903814;
	bh=LcvZhtBH8sT/FfIXhbJnm+yYbtq9PPZD3obTaiJC9UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z8f7unmmvDL4mBgvFjxw7/2CZUg7OqDOSKtFaD87WURa+N5IybMfPgeAyASh99sb1
	 hiEaoHwzOLGzC9Y7hSkYNY9gcQNIaNF3wmuv6qeNQtf3VyQK7I46h8fCHNBWP1rE51
	 k7B4azcu8Rw1lrdM3kDs3xsjS6B9YJlPqllR8Rd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfBKQuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfBKQuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:50:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31A821B68;
        Mon, 11 Feb 2019 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549903811;
        bh=LcvZhtBH8sT/FfIXhbJnm+yYbtq9PPZD3obTaiJC9UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+Dm8k5V2lflbQ77CQrh53gYI+8LWscBTubitlEKW1e9AlX/Z0hMsWrm7mgVn6ICQ
         S8uOgbo+q+Eh4YDuo4hpM/FdHBSikiL+cq3BzGD6PkpGvpJte1pmaDaJ4WTPFwKAtB
         5RMakC61Qm/k7/I2q8qQ6MotDGOsXjKcI2HbEMII=
Date:   Mon, 11 Feb 2019 17:50:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 066/352] ASoC: sunxi: sun50i-codec-analog: Add
 support for cpvdd regulator supply
Message-ID: <20190211165008.GB21634@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141850.315232314@linuxfoundation.org>
 <20190211143924.GD22391@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211143924.GD22391@sirena.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:39:24PM +0000, Mark Brown wrote:
> On Mon, Feb 11, 2019 at 03:14:53PM +0100, Greg Kroah-Hartman wrote:
> 
> > On the Allwinner A64 SoCs, the audio codec has a built-in headphone
> > amplifier. This amplifier has a power supply separate from the rest of
> > the analog audio circuitry, labeled cpvdd.
> 
> > This patch adds a DAPM widget for this supply, and ties it to the
> > headphone amp widget.
> 
> This is more a new feature than a bug fix, it doesn't look like obvious
> stable material.

Normally we take "new quirks and device ids", and given that this is a
tiny 2 line patch, that seems to fit that requirement.

If not, I'll be glad to drop it, it's your call.

thanks,

greg k-h

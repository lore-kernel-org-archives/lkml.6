Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9251DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586482082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549905160;
	bh=d7jehLNI2M4di3zYyTcMMPliksQMK8UaWvW9U3OHz0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FgRuvDNAwuWkliJYZhH8cBZlkhKirYRR00Fuz/AScwYi9Iw1QVc7W+eu3D7RERo0g
	 lHSqrO6fAmTpRXI1p0iy9wJxzJqHgouBImp6v7yfKMpH2QkagT97mJpiYNewNU4UUz
	 3LHmA0Oc8q98Eta4mO4Dh1uFTHbs7DAPIykUQQa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfBKRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:12:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbfBKRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:12:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01B12082F;
        Mon, 11 Feb 2019 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549905157;
        bh=d7jehLNI2M4di3zYyTcMMPliksQMK8UaWvW9U3OHz0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PL5UtC15FyxPMmYkKEqJzS8tKRZa9ZEzZHhWvR31XTSfBNzZ5L3wUIkWDpFI0BBcn
         wvfHWi86ppUMzm5r9qUC9soLTWzEVx0/elX5Y5OQ/i2wAYWMAmw/N//+ZUsN1KQZjc
         PyiVoubY60LfOhS+hu3hIunmWzqDtsjUd1uvhWeA=
Date:   Mon, 11 Feb 2019 18:12:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 066/352] ASoC: sunxi: sun50i-codec-analog: Add
 support for cpvdd regulator supply
Message-ID: <20190211171234.GB13294@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141850.315232314@linuxfoundation.org>
 <20190211143924.GD22391@sirena.org.uk>
 <20190211165008.GB21634@kroah.com>
 <20190211165839.GF22391@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211165839.GF22391@sirena.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:58:39PM +0000, Mark Brown wrote:
> On Mon, Feb 11, 2019 at 05:50:08PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 11, 2019 at 02:39:24PM +0000, Mark Brown wrote:
> 
> > > This is more a new feature than a bug fix, it doesn't look like obvious
> > > stable material.
> 
> > Normally we take "new quirks and device ids", and given that this is a
> > tiny 2 line patch, that seems to fit that requirement.
> 
> It's definitely not a quirk, it's changing from completely ignoring a
> supply to actively managing it at runtime which if it has any effect on
> existing systems is more likely to break something than fix it.  It's
> not like the fixes for build problems which can't be triggered in old
> kernels, it'll start us things we never used to do.

Ok, that's fair enough, now dropped.

greg k-h

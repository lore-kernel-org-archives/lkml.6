Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C2CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A88F2170A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBTkt25H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A88F2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeGCGey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754240AbeGCGex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:34:53 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA46244F5;
        Tue,  3 Jul 2018 06:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530599692;
        bh=gw4eJxtcYp1CwhgiDO4/lE6ZcJeY79iPy8VvClFyRuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBTkt25HUU6CrDyXWzk0iG4o+t6gFl+oxa5filR4PPQIN4PPPkUyoq5m1g56ddlgt
         /fYfNsQEernI5SPukNgkwhJvxXPcrKfNfbecU7GLe4UY8R61iyscEWBfauErX1z3X1
         nGMGNYm79NXMtO7BoaJRiHOrXB4W34+svwpaLHB4=
Date:   Tue, 3 Jul 2018 14:34:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull: add operating points
Message-ID: <20180703063436.GI4348@dragon>
References: <20180629145221.10393-1-sebastien.szymanski@armadeus.com>
 <20180702045205.fdh4dwwhwyfftptl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702045205.fdh4dwwhwyfftptl@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 10:22:05AM +0530, Viresh Kumar wrote:
> On 29-06-18, 16:52, Sébastien Szymanski wrote:
> > i.MX6ULL has different operating ranges than i.MX6UL so add the
> > operating points for the i.MX6ULL and removed them form board device
> 
> s/removed/remove/
> s/form/from/

I fixed them up and applied the patch.

Shawn

> 
> > trees. A 25mV offset is added to the minimum allowed values like for the
> > i.MX6UL.
> > The valid frequencies are now selected by the cpufreq driver according
> > to ratings stored in fuses since commit 0aa9abd4c212 ("cpufreq: imx6q:
> > check speed grades for i.MX6ULL")
> > 
> > Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

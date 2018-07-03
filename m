Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FF6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9329E246F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhifG8fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9329E246F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeGCMfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753490AbeGCMfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:35:04 -0400
Received: from dragon (unknown [104.237.91.44])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C0F245D6;
        Tue,  3 Jul 2018 12:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530621304;
        bh=mC9aVvxHQXUtuZ7hmsxvJ++Y6J66blI1jRtazPDy6Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhifG8fpCv+9ej5vu+3EjzhhpLzBVSLh1fSK+M6kJr2z/9wvxEIrzMnke9gFNNAoC
         tv921kuT4xvctPSo7+geXA76AwXQpIPXVNorDe4CvZp9MPh+6Q1Lb6yzhJHUJDzVkd
         WVnoIs5Cp3mE30islxe4vbEaGSVFa8IJwlFP8zDo=
Date:   Tue, 3 Jul 2018 20:34:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] arm: dts: imx: Add missing OPP properties for CPUs
Message-ID: <20180703123447.GQ4348@dragon>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <264124e14b966a1bbc07c364fbd89fc55aa765e6.1527244201.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:02:01PM +0530, Viresh Kumar wrote:
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
> 
> Add such missing properties.
> 
> Fix other missing properties (like clocks, supply, clock latency) as
> well to make it all work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks.

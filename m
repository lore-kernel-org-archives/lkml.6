Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB2CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6511A208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=awxrd.com header.i=@awxrd.com header.b="CegZYASB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6qGZAOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6511A208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=awxrd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbeGPQYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:24:07 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36501 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728947AbeGPQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:24:07 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 12:24:07 EDT
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E7F4E2D0;
        Mon, 16 Jul 2018 11:48:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 16 Jul 2018 11:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awxrd.com; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=jxG6NWUbfPe0XeTlRQi6oW25zB8a4
        ByrPrpqLwyulkA=; b=CegZYASB9Tia6bRbWnNrgDSDXg6+LQlxRPUCMIx+08Ryi
        oRiEdZkb25PI/UlFa5oxHbE5M1RgmuvptzKr5UbN98S8ucGwGEfoI82Is0nR+jme
        h8kj2xm0+wjEvYxESbfIAx137Omazo8joz3jPjENPIbxp1Qi8XKAPLLXq2XmPYOp
        TBbgWIrokt6NqfLfA2QQmsGY7elgnJnX/e3boATQUR1rpjDzBEEut8zXy2rwBYTb
        Glk1R7XW5yNVssEJNPKAxs1iGDfQLDUm9mhk6qSdZwhytPIEP+AAnKM36JRTOyNt
        Oc67h2z4UJiJEFAfugQ85UzPrXaECX9qZ/AhJdGwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jxG6NW
        UbfPe0XeTlRQi6oW25zB8a4ByrPrpqLwyulkA=; b=q6qGZAOyBmiZ0wRwRLhICj
        gK5FntuUN/flmTvnZWBAI1dwiLj6jRRllsTP7KCgqQN2+7sP98gtl66PuwV9Nyls
        uPohAs7pquF1TCFYyD50DG5oKz+VGhLizB9zunjRvooc086M+ZpD2Jpgc4TX1lu+
        BVkCB8ODSdL4E8pwAB548YNt2YWiLCieMYj5G7RYpyAX+a+La4CGJ6OwbjGnY3qN
        IcDVtD24VFjzya+MEezpdoKfEvGUQ6S77TJ54PrJW5ZaCZgqgcY/lCLLzr6Adq1r
        meb6Tv7XQ+9PZ6HAxFvafjEXvlcqgVlS4N9tzjsnBIc5LfdCPMvMHmNrlPrzF9vw
        ==
X-ME-Proxy: <xmx:ML5MW9G1nIN4xUOgcyiULy9aLfY1_CMV6pPKR5ZW8X9SaWq1vdsguA>
    <xmx:ML5MW04Qc-IMiog-MOPgQZ4RQSXwCJsBwc-acPnDadFrPvtWMzQkKw>
    <xmx:ML5MWyzaqf6J5R6D1m4LoxnO9ZXYjkZ3vRNY7oDVHPT8B_eKLi_XQQ>
    <xmx:ML5MWzMicl51voURmCa5YIkUo0BU8M9XrSOHUiMH3BoMGqAUPd9-Hg>
    <xmx:ML5MW4mR1gNv5fyYdYdJDHNrYwQdif2GEhoZV2QjluqefzKuy_SfCQ>
    <xmx:ML5MW76eKCa1I241Nxsu1gb22_Xv1i3kKM8rsdW9yvTlT-Ki3SlkPA>
X-ME-Sender: <xms:L75MW_o2ya66lGkbS1A3Sxiv4l5t0K889xJa6WymkyiEwJPKUWoZMA>
Received: from allworx.com (unknown [24.213.148.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C16D1026C;
        Mon, 16 Jul 2018 11:47:59 -0400 (EDT)
Date:   Mon, 16 Jul 2018 11:47:58 -0400
From:   David Rivshin <drivshin@awxrd.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm-omap: handle timers not ready in probe
Message-ID: <20180716114758.60a6a6cb.drivshin@awxrd.com>
In-Reply-To: <20180716083720.GA3047@amd>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
        <20180709220211.GA7760@amd>
        <20180710101147.lyu65ro4czvrs2da@earth.universe>
        <20180710133040.GA4391@amd>
        <20180710161123.azym6sbboriuj4yc@earth.universe>
        <20180711080218.GA21225@amd>
        <20180711132739.GL99251@atomide.com>
        <20180711142526.dto6iost57zx5t5l@earth.universe>
        <20180716071323.GB23110@amd>
        <20180716075740.GT99251@atomide.com>
        <20180716083720.GA3047@amd>
Organization: Allworx
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018 10:37:20 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Mon 2018-07-16 00:57:40, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180716 07:16]:  
> > > 
> > > When all the drivers are built-in, timers are not ready and probing
> > > fails. Fix that with -EPROBE_DEFFER.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> > > index 665da3c..debeb70 100644
> > > --- a/drivers/pwm/pwm-omap-dmtimer.c
> > > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> > > @@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> > >  	timer_pdata = dev_get_platdata(&timer_pdev->dev);
> > >  	if (!timer_pdata) {
> > >  		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
> > > -		ret = -EINVAL;
> > > +		ret = -EPROBE_DEFER;
> > >  		goto put;
> > >  	}  
> > 
> > There seems to be an earlier similar patch, care to take a look
> > at "[PATCH] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no
> > dmtimer platform data"?  
> 
> Yes, that one is equivalent.
> 
> You can add
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> on it.
> 
> Thanks,
> 									Pavel

Thanks Pavel. I hadn't been watching the Droid 4 threads, so I didn't 
see you were hitting the same problem. I'm assuming the patch will go
through the PWM tree, so copying in Thierry.

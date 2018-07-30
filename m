Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A31FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B2F20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fj++ZVJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B2F20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeG3RpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:45:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41939 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeG3Ro7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:44:59 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so5759889ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=05e1J8Dbor5qR8v2eujXPipcvlb8HuTK3TitcT8sh90=;
        b=fj++ZVJ3YV0a1IGkc88y/JMiYtfhnEAPTGa1bsUzgpJKErCr8ipItZaqQbxQ74rEWW
         i768t4/02ZPNP/oVcGlm5/wZm4p76AhLaOGNYw9Ksl+3Ji/hSPFJnToqne1H6/ugfxk0
         XxridjMwPfjIbl40RPHOSCafh2+zUWvs+Nmfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=05e1J8Dbor5qR8v2eujXPipcvlb8HuTK3TitcT8sh90=;
        b=iiiwyYuRCA0d75PtNoK6mXjI3vbB7naq4HMG0N+un1SIvb/RvP2MuHrPERRPko4Emn
         tGVOrMC1AUJqT5aSr0WRNoaX9lKwAZD9cEMh/jtyEIESme1nShmoxortgmObBxlgTtTX
         QQMSXCHt8F9of8VPHqcy7fpObHeJNtJgoqRgvP5wP9U6dTsaWQ/mswQL0xk4czAbNzoU
         u/4hgsEKzVfT2NGhycVuxSzBoGHvrVIO5fybWGNi/pOcct8BVLwQ6rbGBuC8PCExnuP0
         kqHTWlt1GfGVZzcfnMRCabP7lVLrITwa/Vladbx1+ANUy//inztpuBvBRUWWlWBa6OAp
         jM8w==
X-Gm-Message-State: AOUpUlH8uEvft2I8y53apvbn8oOk0GqFn5NMTkqDr8WFo6m31kz5wOtz
        t/q9d/aX3bkQhL8RlGN7TdRr
X-Google-Smtp-Source: AAOMgpeXgb+S0PuOOiMv5WCZzq6YvTj4VVw2D+em1XklYjCDcaYvMJHGoH41onEPy+uLIqsa6gATYA==
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr17050492ply.93.1532966959757;
        Mon, 30 Jul 2018 09:09:19 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7249:4c1:2087:1b6f:e7df:5e1a])
        by smtp.gmail.com with ESMTPSA id u2-v6sm18222485pfn.59.2018.07.30.09.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 09:09:19 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:39:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com
Subject: Re: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl
 SoCs
Message-ID: <20180730160904.GA2511@Mani-XPS-13-9360>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
 <20180730151131.GA28633@mani>
 <1532965111.3471.14.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532965111.3471.14.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, Jul 30, 2018 at 05:38:31PM +0200, Philipp Zabel wrote:
> On Mon, 2018-07-30 at 20:41 +0530, Manivannan Sadhasivam wrote:
> > Hi Andreas,
> > 
> > On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas Färber wrote:
> > > Hi Mani,
> > > 
> > > Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > > > This patchset adds Reset Controller (RMU) support for Actions Semi
> > > > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > > > the clock subsystem in hardware. Hence, in software we integrate RMU
> > > > support into common clock driver inorder to maintain compatibility.
> > > 
> > > Can this not be placed into drivers/reset/ by using mfd-simple with a
> > > sub-node in DT?
> > > 
> > 
> > Actually I was not sure where to place this reset controller driver. When I
> > looked into other similar ones such as sunxi, they just integrated into the
> > clk subsystem. So I just chose that path. But yeah, this is hacky!
> > 
> > But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
> > are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
> > RMU has only 2 registers, the HW designers decided to use up the CMU memory
> > map. So, maybe syscon would be best option I think. What is your opinion?
> 
> Using syscon seems cleaner than stuffing the regmap into owl_clk_desc.
> 

Okay.

> > Even if we go for syscon, we should place the reset driver within clk
> > framework as I can see other SoCs like Mediatek are doing the same. But again
> > I'm not sure!
> 
> Me neither. If the CMU and RMU are really separate and only share the
> memory map, a syscon driver could live in drivers/reset without
> problems.
> It's only when there are interactions between clocks and resets that you
> really want to have the reset driver integrated with clk.
> 

Okay. Then I will add it as a syscon driver under drivers/reset.

I hope that Andreas would also be happy with this.

Thanks a lot for your response!

Regards,
Mani

> regards
> Philipp

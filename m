Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0773C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500AD262E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="UJe/E50A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500AD262E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755792AbeFYX5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:57:23 -0400
Received: from vern.gendns.com ([206.190.152.46]:36804 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbeFYX5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gfj8Uze7y62u/mprEEP2irGAi6ze3qYhTmccQ2GLFXs=; b=UJe/E50Aw0P1finS3j9/r/UdEe
        Wr3/K0d3hvqBLAruesp8VnkMJq2kQst7wmcqcTeWUIETcqSjOpGcHIQgSYahV8/JVpnT6RHdS8RCT
        FDS3Fg50kuxLhkoQVEdP4u5MiPdIQUKlIIX9nN+OJCAaxx87LsDZt9Zfi+SJc9dZz+OXL2JO7YEhf
        D+jxDIVZ5Xne8WK8kvWU6ocyNd9r2uv18/lrQBTngL8HHdrOJgCkE7dkEa75uBsoUKDyGfQK2l0QB
        o7r5H0Cx0qz4sKnmkzN/0sUeYPNzTA2qFEevVpdsbb8Rv9mBS7j4vAxlvHB1t/2RIcibDT3g5cy9u
        776WCxpg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:33748 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXbMG-002TqO-6v; Mon, 25 Jun 2018 19:57:20 -0400
Subject: Re: [PATCH] clk: davinci: cfgchip: testing the wrong variable
To:     Stephen Boyd <sboyd@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180602075256.hrvidsfsmr33mv2f@kili.mountain>
 <3a6d0388-7915-8ea3-6ad6-38dc7ee06377@lechnology.com>
 <152996958098.143105.4718477050150092384@swboyd.mtv.corp.google.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <72942901-07a8-936f-351e-14ac6e71a22c@lechnology.com>
Date:   Mon, 25 Jun 2018 18:57:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152996958098.143105.4718477050150092384@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 06:33 PM, Stephen Boyd wrote:
> Quoting David Lechner (2018-06-25 16:17:55)
>> On 06/02/2018 02:52 AM, Dan Carpenter wrote:
>>> There is a copy and paste bug here.  We should be testing "usb1" instead
>>> of "usb0".
>>>
>>> Fixes: 58e1e2d2cd89 ("clk: davinci: cfgchip: Add TI DA8XX USB PHY clocks")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
>>> index c971111d2601..20a120aa147e 100644
>>> --- a/drivers/clk/davinci/da8xx-cfgchip.c
>>> +++ b/drivers/clk/davinci/da8xx-cfgchip.c
>>> @@ -672,7 +672,7 @@ static int of_da8xx_usb_phy_clk_init(struct device *dev, struct regmap *regmap)
>>>    
>>>        usb1 = da8xx_cfgchip_register_usb1_clk48(dev, regmap);
>>>        if (IS_ERR(usb1)) {
>>> -             if (PTR_ERR(usb0) == -EPROBE_DEFER)
>>> +             if (PTR_ERR(usb1) == -EPROBE_DEFER)
>>>                        return -EPROBE_DEFER;
>>>    
>>>                dev_warn(dev, "Failed to register usb1_clk48 (%ld)\n",
>>>
>>
>> Applied to https://github.com/dlech/linux/tree/clk-davinci-fixes
>>
> 
> Ok. I expect this will be coming in a PR soon? Usually I can pick up
> fixes just fine from the list and merge them on up to Linus, unless you
> feel the need to pick it into your development tree to base future
> development on.
> 

Yes, in a few minutes actually. I have never done a PR via email before,
so I figured this would be a good way to learn with a few small patches.

I know everyone is always busy, so of course, if I'm making more work for
you, I'll be glad to do it differently.

And I'll keep this in mind for future fixes.

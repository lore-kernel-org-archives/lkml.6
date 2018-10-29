Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB8F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCvw+VwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB8F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeJ3DgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJ3DgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:36:19 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F22B20657;
        Mon, 29 Oct 2018 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540838784;
        bh=mrHMnLwX0DVtjbXQ+jvcykd02wNA85+ktJMKPlCOsX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCvw+VwL0mm9FXuFYDD7DW93R9dxUBVzzppX7Au0vMu/Hyrmk+Y95HqBVgnnhzYwL
         6ygZOYjb13k0PPR9IpolVmT2OC3cUM8qY+MhCkHUoEF2fViJKKApb4FWbZOrl5MT4E
         PzyAB60pXGPZjYBNGBTwsCFqmqzUsvIqISVAJDuM=
Date:   Mon, 29 Oct 2018 14:46:22 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars Persson <lars.persson@axis.com>,
        "chris.ruehl@gtsys.com.hk" <chris.ruehl@gtsys.com.hk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH AUTOSEL 4.9 33/98] ARM: dts: imx6ul-14x14-evk: Add
 ksz8081 phy properties
Message-ID: <20181029184622.GO2015@sasha-vm>
References: <20181025141423.213774-1-sashal@kernel.org>
 <20181025141423.213774-33-sashal@kernel.org>
 <AM0PR04MB42906FF43CCBE63339E25462EEF30@AM0PR04MB4290.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AM0PR04MB42906FF43CCBE63339E25462EEF30@AM0PR04MB4290.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 02:07:52PM +0000, Leonard Crestez wrote:
>On 10/25/2018 5:15 PM, Sasha Levin wrote:
>> From: Leonard Crestez <leonard.crestez@nxp.com>
>>
>> [ Upstream commit e6f4292ae0a1e73fae26ced57de13a48f71ad1fa ]
>>
>> Right now mach-imx6ul registers a fixup for the ksz8081 phy. The same
>> register values can be set through the micrel phy driver by using dts
>> properties.
>>
>> This seems preferable and allows cleanly fixing suspend/resume.
>>
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This patch only fixes suspend on 6ul evk in combination with
>79e498a9c7da ("net: phy: micrel: Restore led_mode and clk_sel on
>resume"). It is otherwise not very useful to backport just the DT patch.
>
>That patch was earlier backported but then reverted from 4.9 because it
>unexpectedly caused issues when combined with other phy patches applied
>out-of-order. It seems a correct fix was eventually made (by backporting
>bfe72442578b) and 79e498a9c7da could now be restored:
>
>     https://lkml.org/lkml/2018/7/11/972
>
>I'm not sure fixing nfsroot suspend/resume on dev boards meets the
>criteria for linux-stable, especially since it already caused trouble
>once. In general I'd class "fixing things that never worked before" as
>not particularly suitable for backporting.

Thank you for looking into this, I'll drop the patch.

--
Thanks,
Sasha

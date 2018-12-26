Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C610C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22418214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeLZUeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:34:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34650 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeLZUet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:34:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0CB9314B48A06;
        Wed, 26 Dec 2018 12:34:49 -0800 (PST)
Date:   Wed, 26 Dec 2018 12:34:46 -0800 (PST)
Message-Id: <20181226.123446.1336493304514420420.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     kjlu@umn.edu, pakki001@umn.edu, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: bcm_sf2: Propagate error value from
 mdio_write
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4f6199de-51c4-4446-3ad3-6b036a09a63c@gmail.com>
References: <20181226182132.76798-1-kjlu@umn.edu>
        <4f6199de-51c4-4446-3ad3-6b036a09a63c@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Dec 2018 12:34:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 26 Dec 2018 20:13:15 +0100

> On 26.12.2018 19:21, Kangjie Lu wrote:
>> Both bcm_sf2_sw_indir_rw and mdiobus_write_nested could fail, so let's
>> return their error codes upstream.
>> 
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>  drivers/net/dsa/bcm_sf2.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
>> index 2eb68769562c..236815700fba 100644
>> --- a/drivers/net/dsa/bcm_sf2.c
>> +++ b/drivers/net/dsa/bcm_sf2.c
>> @@ -303,11 +303,10 @@ static int bcm_sf2_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
>>  	 * send them to our master MDIO bus controller
>>  	 */
>>  	if (addr == BRCM_PSEUDO_PHY_ADDR && priv->indir_phy_mask & BIT(addr))
>> -		bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
>> +		return bcm_sf2_sw_indir_rw(priv, 0, addr, regnum, val);
> This is wrong. Please get familiar with what the function does.
> And test changes before submitting them!

This is getting rediculous.

You are making completely untested changes, resubmitting very quickly
without any care or consideration whatsoever, and wasting a lot of
developer time with your carelessness.

Please stop doing this.

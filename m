Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5636257E2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bZSNm9RK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5636257E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeGBOAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:00:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54656 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeGBOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:00:40 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w62E0Txt089205;
        Mon, 2 Jul 2018 09:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530540029;
        bh=14nXrWjotd8zpuk6/BzeBmeMnYv1oneg7Zqshapc1JA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=bZSNm9RKPJx7KdGRODbDbgwKxE+w1l3ZhUnvStEHK/f1vYf21oR4hjNy4cYrjLq4C
         0q97gknDWzM0BCEtZqYpkc0Iafnl8ZR1hdjHQ914X7d0KXdmklngTsEqojDCK4XNtH
         u3/YvuMICZcb2SlIpv1FNNa5IXOjPkQn3+b7G/+k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62E0Tm7016969;
        Mon, 2 Jul 2018 09:00:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 09:00:29 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 09:00:29 -0500
Received: from [172.22.170.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62E0TRr019635;
        Mon, 2 Jul 2018 09:00:29 -0500
Subject: Re: [PATCH net-next v2 1/2] net: phy: DP83TC811: Add INT_STAT3
From:   Dan Murphy <dmurphy@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180629153546.24107-1-dmurphy@ti.com>
 <20180629154502.GG11285@lunn.ch>
 <ee9220f3-4e93-0054-d94b-97c3756fb38d@ti.com>
Message-ID: <2e414357-2b7f-3706-2edb-2953dd6ee7c8@ti.com>
Date:   Mon, 2 Jul 2018 09:00:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ee9220f3-4e93-0054-d94b-97c3756fb38d@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

On 06/29/2018 11:17 AM, Dan Murphy wrote:
> Andrew
> 
> On 06/29/2018 10:45 AM, Andrew Lunn wrote:
>> On Fri, Jun 29, 2018 at 10:35:45AM -0500, Dan Murphy wrote:
>>> Add INT_STAT3 interrupt setting and clearing
>>> support.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v2 - Removed bug fix removal of writing INT_STAT1 twice when disabling interrupts
>>>
>>>  drivers/net/phy/dp83tc811.c | 26 ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
>>> index 49ac678eb2dc..f8653f5d8789 100644
>>> --- a/drivers/net/phy/dp83tc811.c
>>> +++ b/drivers/net/phy/dp83tc811.c
>>> @@ -21,6 +21,7 @@
>>>  #define MII_DP83811_SGMII_CTRL	0x09
>>>  #define MII_DP83811_INT_STAT1	0x12
>>>  #define MII_DP83811_INT_STAT2	0x13
>>> +#define MII_DP83811_INT_STAT3	0x18
>>>  #define MII_DP83811_RESET_CTRL	0x1f
>>>  
>>>  #define DP83811_HW_RESET	BIT(15)
>>> @@ -44,6 +45,11 @@
>>>  #define DP83811_OVERVOLTAGE_INT_EN	BIT(6)
>>>  #define DP83811_UNDERVOLTAGE_INT_EN	BIT(7)
>>>  
>>> +/* INT_STAT3 bits */
>>> +#define DP83811_LPS_INT_EN	BIT(0)
>>> +#define DP83811_NO_FRAME_INT_EN	BIT(3)
>>> +#define DP83811_POR_DONE_INT_EN	BIT(4)
>>> +
>>>  #define MII_DP83811_RXSOP1	0x04a5
>>>  #define MII_DP83811_RXSOP2	0x04a6
>>>  #define MII_DP83811_RXSOP3	0x04a7
>>> @@ -81,6 +87,10 @@ static int dp83811_ack_interrupt(struct phy_device *phydev)
>>>  	if (err < 0)
>>>  		return err;
>>>  
>>> +	err = phy_read(phydev, MII_DP83811_INT_STAT3);
>>> +	if (err < 0)
>>> +		return err;
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -216,6 +226,18 @@ static int dp83811_config_intr(struct phy_device *phydev)
>>>  				DP83811_UNDERVOLTAGE_INT_EN);
>>>  
>>>  		err = phy_write(phydev, MII_DP83811_INT_STAT2, misr_status);
>>
>> Hi Dan
>>
>> Isn't this going to fail to apply because net-next says STAT1 here?
>>
> 
> Yes but this should not be a pre-requisite for a code review.
> 
> Maybe I should have put the RFC in the subject.
> 
>> That is why i said you need to wait for David to merge net into
>> net-next. Then you can submit these patches, and not have conflicts.
>>

David has applied the pre-requisite patch so this series can be review and tested.

Dan

>> 	  Andrew
>>
> 
> 


-- 
------------------
Dan Murphy

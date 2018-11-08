Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944EEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595B520840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IDjyDAKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595B520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeKIDuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:50:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43292 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeKIDuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:50:02 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8ICGU8025212;
        Thu, 8 Nov 2018 12:12:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541700736;
        bh=hEH45vvzoFGsfDOdSd5SThFixOtCoRG9m50n2/RGh0M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IDjyDAKbJWfTov70wqLrsyVjpzLOxsNNFu0UNa5pMq3qpZpdqD1kL8iYxrI/rCbL3
         PTU5G2wxs16SGqI98gcnySTy6NjuKrF1V28R9cjo4B57d3uOVg3ymZIFi26+Z6DStL
         ArgAftrBLFSiWI7DM50TfqsO0qH7VPmFyN+YGBCw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8ICGLr025901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 12:12:16 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 12:12:15 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 12:12:15 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8ICFEH001387;
        Thu, 8 Nov 2018 12:12:15 -0600
Subject: Re: [PATCH 2/5] phy: core: add PHY_MODE_ETHERNET
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>, <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20181108003617.10334-1-grygorii.strashko@ti.com>
 <20181108003617.10334-3-grygorii.strashko@ti.com>
 <20181108004200.GW30658@n2100.armlinux.org.uk>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fbb63ce7-4a5f-738a-c398-4c28abd3cb60@ti.com>
Date:   Thu, 8 Nov 2018 12:12:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108004200.GW30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Russell,

On 11/7/18 6:42 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 07, 2018 at 06:36:14PM -0600, Grygorii Strashko wrote:
>> Add new PHY's mode to be used by Ethernet PHY interface drivers or
>> multipurpose PHYs like serdes. It will be reused in further changes.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   include/linux/phy/phy.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index b17e770..02c9ef0 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -42,6 +42,7 @@ enum phy_mode {
>>   	PHY_MODE_UFS_HS_A,
>>   	PHY_MODE_UFS_HS_B,
>>   	PHY_MODE_PCIE,
>> +	PHY_MODE_ETHERNET,
> 
> Are you sure about this - we already have a bunch of "ethernet" modes
> that are more specific, like PHY_MODE_SGMII, PHY_MODE_2500SGMII and
> PHY_MODE_10GKR which require PHYs to be configured differently.  Having
> a very generic "ethernet" mode brings up questions about when it should
> be used vs the more specific modes.

yes. the idea of this series is to split PHY mode on - PHY mode (generic)
and PHY submode (subsystem specific), so multi-functional PHY like serdes will do
(for example):

  phy_set_mode_ext(port->comphy, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_SGMII);
  where PHY_INTERFACE_MODE_SGMII is defined by phy_interface_t enum.

instead of

  phy_set_mode(port->comphy, PHY_MODE_SGMII);

In patches 3-5 I've converted users of existing PHY "ethernet" modes to use
this approach and, finally, in patch 5 removed
    PHY_MODE_SGMII/2500SGMII/QSGMII/10GKR

> 
> (I've already mentioned that the SGMII modes are mis-named, since
> they also apply to 1000base-X and 2500base-X - the only difference
> is how one 16-bit word in the data stream is used which has no effect
> on the PHY.)
> 

-- 
regards,
-grygorii

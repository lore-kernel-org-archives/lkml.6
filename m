Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeC2UBV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:01:21 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:52744 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeC2UBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:01:20 -0400
Subject: Re: [net-next PATCH v2 08/10] net: netcp: ethss: use
 of_get_phy_mode() to support different RGMII modes
To: Andrew Lunn <andrew@lunn.ch>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-9-git-send-email-m-karicheri2@ti.com>
 <20180327173509.GQ5862@lunn.ch>
From: Murali Karicheri <m-karicheri2@ti.com>
Organization: Texas Instruments
Message-ID: <1b12754d-38b5-d03a-3ba8-90135ad3ead0@ti.com>
Date: Thu, 29 Mar 2018 16:03:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180327173509.GQ5862@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 01:35 PM, Andrew Lunn wrote:
>> +	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
>> +		has_phy = true;
>> +		phy_mode = of_get_phy_mode(slave->node);
>> +		/* if phy-mode is not present, default to
>> +		 * PHY_INTERFACE_MODE_RGMII
>> +		 */
>> +		if (phy_mode < 0)
>> +			phy_mode = PHY_INTERFACE_MODE_RGMII;
> 
> Can only do RGMII? Maybe add a call here to
> phy_interface_mode_is_rgmii() and return -EINVAL if DT contains
> something which is not RGMII?
> 
Ok. Make sense.

> 	  Andrew
> 


-- 
Murali Karicheri
Linux Kernel, Keystone

Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC321C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2F214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rInS1iwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E2F214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJJDre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:47:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39360 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJDre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:47:34 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w99KSU4H079739;
        Tue, 9 Oct 2018 15:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539116910;
        bh=upotiUt4CqogOYtKmu1y/fIExdJR9jytEfDuhVNCW6w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rInS1iwEtwvnTT9Q68liBCLFfdsttbznyYDx/c5bxY+Hd/dC7+86ccmSCYiCblOWu
         fRlzemaFKrGoaQ064Ktuc8glYPJulx/xBN4Zyw5fSN6571h/0XvcKT4qkj3Jl2G6Qi
         I8T7UaBwq6YXHbK9oj8b3RbrMMCKueu/frnYY6OY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99KSU1s002026;
        Tue, 9 Oct 2018 15:28:30 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 9 Oct
 2018 15:28:30 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 9 Oct 2018 15:28:30 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w99KSTG9016272;
        Tue, 9 Oct 2018 15:28:29 -0500
Subject: Re: [RFC PATCH 05/11] net: ethernet: ti: cpsw: add support for port
 interface mode selection phy
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-6-grygorii.strashko@ti.com>
 <20181009005048.GB23588@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fd5c9503-8eed-0f7f-e9db-1bc870a23a93@ti.com>
Date:   Tue, 9 Oct 2018 15:28:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009005048.GB23588@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 10/08/2018 07:50 PM, Andrew Lunn wrote:
>>   	/* Configure GMII_SEL register */
>> -	cpsw_phy_sel(cpsw->dev, slave->phy->interface, slave->slave_num);
>> +	if (!IS_ERR(slave->data->ifphy))
>> +		phy_set_netif_mode(slave->data->ifphy, slave->data->phy_if);
> 
> Is slave->data->phy_if also passed to phy_connect()? So you are going
> to end up with both the MAC and the PHY inserting RGMII delays, and it
> not working.

No. This logic not changed comparing to how it was.

  * "rgmii" (RX and TX delays are added by the MAC when required)

rgmii_id = 0 --> CPSW: 0 : Internal Delay, PHY - no delay

  * "rgmii-id" (RGMII with internal RX and TX delays provided by the PHY, the
     MAC should not add the RX or TX delays in this case)
  * "rgmii-rxid" (RGMII with internal RX delay provided by the PHY, the MAC
     should not add an RX delay in this case)
  * "rgmii-txid" (RGMII with internal TX delay provided by the PHY, the MAC
     should not add an TX delay in this case)

rgmii_id = 1 --> CPSW: 1 : No Internal Delay, PHY/board -  delay

> 
> You need to somehow decide if the MAC is going to do the delay, or the
> PHY. But not both.

Again, this series does not change logic - only interfaces and DT.

Thank you for review.

-- 
regards,
-grygorii

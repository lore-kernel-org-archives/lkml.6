Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C69ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1734E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SgS+yRsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1734E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeIRSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:23:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48788 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeIRSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:23:16 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8ICoYcm081153;
        Tue, 18 Sep 2018 07:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537275034;
        bh=O7EKDdwIQBHnLDyLN/Zy+KvOEWj2cz/mJNxJGwkRLv8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SgS+yRsBLaaO2QHNoBBMPcWSBocFHL1aGemdiO0jzCjEW556oMTZbzzFa7EU+PTa6
         CQyXQlwcCogmbTLCFMu73/ji9XryRnRCdLOGoultS6j5VGT4CefZdtUMvb5r+AeM7s
         q3d/0flbausYYK8BZukUSLEG5V6/1R49viu0pFCQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8ICoYOp016126;
        Tue, 18 Sep 2018 07:50:34 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 18
 Sep 2018 07:50:34 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 18 Sep 2018 07:50:34 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8ICoYZd028471;
        Tue, 18 Sep 2018 07:50:34 -0500
Subject: Re: [PATCH 2/3] ARM: dts: am335x: add support for Moxa UC-2101 open
 platform
To:     =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <SZ.Lin@moxa.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        =?UTF-8?B?V2VzIEh1YW5nICjpu4Pmt7XmsrMp?= <Wes.Huang@moxa.com>,
        =?UTF-8?B?RmVybyBKRCBaaG91ICjlkajkv4rpgZQp?= <FeroJD.Zhou@moxa.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
 <20180830040929.23357-3-sz.lin@moxa.com>
 <47ebc8e6-b1cb-e040-8533-06eec05b4edd@ti.com>
 <TY2PR0101MB252666FF7718C84A4261682FE21E0@TY2PR0101MB2526.apcprd01.prod.exchangelabs.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <2c14acd7-6443-f9c9-d2e4-c86544e39ff3@ti.com>
Date:   Tue, 18 Sep 2018 07:50:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <TY2PR0101MB252666FF7718C84A4261682FE21E0@TY2PR0101MB2526.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/17/2018 01:53 AM, SZ Lin (林上智) wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Grygorii Strashko [mailto:grygorii.strashko@ti.com]
> 
> <snip>
> 
>>
>> Pls, use phy-handle instead of phy_id here and in the next patch.
> 
> Thanks for the reminder, I will use phy-handle in next version.
> 
> Furthermore, the property of "phy-handle" doesn't work properly in 4.4.y-stable kernel.
> I've fixed it and sent the backport patches to 4.4.y-stable [1][2][3][4].
> 
> [1] https://www.spinics.net/lists/stable/msg256121.html
> [2] https://www.spinics.net/lists/stable/msg256124.html
> [3] https://www.spinics.net/lists/stable/msg256131.html
> [4] https://www.spinics.net/lists/stable/msg256749.html
> 

Thank you.

-- 
regards,
-grygorii

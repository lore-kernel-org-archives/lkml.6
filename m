Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDD6C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E1C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MEpq1COk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfBFMkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:40:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38132 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfBFMkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:40:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16Ce7m5105936;
        Wed, 6 Feb 2019 06:40:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549456807;
        bh=l2NWpFN2mMrmT4GZAfp1gAlH6Y6+Au5EiBCvRU2qaNg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MEpq1COkXzEId8lizaZCHfdaD/h+9EA3/Jhe7FD0sK1eQNRR/6aw5Ncs8ttW4OWS+
         ZtOZgEP6qxB1Lc8g10R9OvPriiVbHWvP+xWVQKe1kUOrv6nTv8UodNswc0d/EgOaow
         xMyYn+AdJPpQV8pfCtci0XQxMSoMEMmloJpyPCHk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16Ce7YO064525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 06:40:07 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 06:40:07 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 06:40:07 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16Ce3EM011216;
        Wed, 6 Feb 2019 06:40:04 -0600
Subject: Re: [PATCH v3 4/5] phy: qcom-qmp: Add QMP UFS PHY support for msm8998
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <8315045c-471a-1ce3-7558-efaaf2cd5406@free.fr>
 <c6046efa-1a74-21d1-e110-0d1aa282d386@codeaurora.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1d876cdc-c6b5-e490-3e6a-b04c8f9ccc0c@ti.com>
Date:   Wed, 6 Feb 2019 18:09:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c6046efa-1a74-21d1-e110-0d1aa282d386@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/02/19 11:40 PM, Jeffrey Hugo wrote:
> On 2/4/2019 10:39 AM, Marc Gonzalez wrote:
>> Use same init sequence as sdm845.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
> 
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

I don't seem to have the dt-binding patch in my inbox. Can you resend them please?

Thanks
Kishon

> 
>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> index b4006818e1b6..39b9c31b67d0 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
>> @@ -1735,6 +1735,9 @@ static const struct of_device_id
>> qcom_qmp_phy_of_match_table[] = {
>>       }, {
>>           .compatible = "qcom,msm8996-qmp-usb3-phy",
>>           .data = &msm8996_usb3phy_cfg,
>> +    }, {
>> +        .compatible = "qcom,msm8998-qmp-ufs-phy",
>> +        .data = &sdm845_ufsphy_cfg,
>>       }, {
>>           .compatible = "qcom,ipq8074-qmp-pcie-phy",
>>           .data = &ipq8074_pciephy_cfg,
>>
> 
> 

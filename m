Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEAFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273D920859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ibVcyo/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391463AbfAPI6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:58:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48878 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389533AbfAPI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:58:18 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G8wBql013562;
        Wed, 16 Jan 2019 02:58:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547629091;
        bh=uodxHO5sh4LiIItRYqEG+2BUEjlHfSHuPSpyLZ43uPg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ibVcyo/w9quCt08fI4may+VmX/J8xH61hgzH1+dXZrxLsbMOWsI4kPg8utpiYoEwA
         iSz9phfximNrhdgvdLSJbWiChsoNo8Ry+TJ2ZEjRE/VTVE4kCYovbGodj88rH76kWP
         RGaefO3PXL92gSWYtP00WLy85FpuY++IZj0c2mm8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G8wBZZ092961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 02:58:11 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 02:58:10 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 02:58:10 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G8w62Q001016;
        Wed, 16 Jan 2019 02:58:07 -0600
Subject: Re: [PATCH v2 1/6] dt-bindings: phy-qcom: Add support for msm8998 usb
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <andy.gross@linaro.org>, <david.brown@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>
References: <1547483771-5334-1-git-send-email-jhugo@codeaurora.org>
 <20190115180839.GC28907@builder>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <899dbd3d-2ce2-9a31-aca3-0ca936bdd2dd@ti.com>
Date:   Wed, 16 Jan 2019 14:27:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115180839.GC28907@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/01/19 11:38 PM, Bjorn Andersson wrote:
> On Mon 14 Jan 08:36 PST 2019, Jeffrey Hugo wrote:
> 
>> USB on msm8998 utilizes the QUSB2 and QMP phys, similar to sdm845.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   | 5 +++++
>>  Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt | 1 +
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> index 41a1074..6061b6f 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> @@ -9,6 +9,7 @@ Required properties:
>>  	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>>  	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>>  	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>> +	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
>>  	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>>  	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
>>  	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
>> @@ -42,6 +43,8 @@ Required properties:
>>  			"aux", "cfg_ahb", "ref".
>>  		For "qcom,msm8996-qmp-usb3-phy" must contain:
>>  			"aux", "cfg_ahb", "ref".
>> +		For "qcom,msm8998-qmp-usb3-phy" must contain:
>> +			"aux", "cfg_ahb", "ref".
>>  		For "qcom,sdm845-qmp-usb3-phy" must contain:
>>  			"aux", "cfg_ahb", "ref", "com_aux".
>>  		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
>> @@ -60,6 +63,8 @@ Required properties:
>>  		For "qcom,msm8996-qmp-pcie-phy" must contain:
>>  			"phy", "common", "cfg".
>>  		For "qcom,msm8996-qmp-usb3-phy" must contain
>> +		 "phy", "common".
> 
> Odd indentation.
> 
> 
> Apart from this, you have my
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Fixed the indentation and merged it.

Thanks
Kishon

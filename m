Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D87CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4536D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mPL6w5ww";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CKKGj4l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeLSHE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:04:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSHE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:04:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB9D16191D; Wed, 19 Dec 2018 07:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545203096;
        bh=T9SA5xKfCnaNx3N7fqlrUcn9wlqGD4Sq/2iku0384Co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mPL6w5wwidx0Bg4YFXZbBtooRoL85pTe9P1A9uPNfQG7C4Cp/u2u3Xb+id5k+xufZ
         t0wqzCU54MvfPpGf9Hm2RKHE4110UoHlH/JUnl2HdSuwJ1LNKK4Bpor4uRXmt+yAM7
         JKxbCWOCqGVr/UuxgoSB0zVfYnJEpkChXalow0f0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8DF636191D;
        Wed, 19 Dec 2018 07:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545203095;
        bh=T9SA5xKfCnaNx3N7fqlrUcn9wlqGD4Sq/2iku0384Co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CKKGj4l0ty1krxuIi38A37yLXCTNXWwvTOLMwH0o0+l+MFglQPUh11YvNuOOTofpc
         gWQB5QLkK8+EHCKN80Pj0I+kIwOfxKVwC9MNweqwz1RpDnpOt4DNx9IA4B2WSeY8Xp
         yeCQPw1+L6bvK2Gx0eE/CD8bxZbmO08rGY0GXN5k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Dec 2018 12:34:55 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: remoteproc: qcom: Add clock bindings
 for Q6V5
In-Reply-To: <20181218172709.GA19660@bogus>
References: <20181217100724.4593-1-sibis@codeaurora.org>
 <20181217100724.4593-2-sibis@codeaurora.org> <20181218172709.GA19660@bogus>
Message-ID: <365dfd8e7160c0c3e5a113dbaa88be68@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thanks for the review!

On 2018-12-18 22:57, Rob Herring wrote:
> On Mon, Dec 17, 2018 at 03:37:19PM +0530, Sibi Sankar wrote:
>> Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt       | 10 
>> +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 9ff5b0309417..780adc043b37 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -39,13 +39,17 @@ on the Qualcomm Hexagon core.
>>  - clocks:
>>  	Usage: required
>>  	Value type: <phandle>
>> -	Definition: reference to the iface, bus and mem clocks to be held on
>> -		    behalf of the booting of the Hexagon core
>> +	Definition: reference to the list of 4 clocks for the modem 
>> sub-system
>> +		    reference to the list of 8 clocks for the modem sub-system
>> +		    on SDM845 SoCs
>> 
>>  - clock-names:
>>  	Usage: required
>>  	Value type: <stringlist>
>> -	Definition: must be "iface", "bus", "mem"
>> +	Definition: must be "iface", "bus", "mem", "xo" for the modem 
>> sub-system
>> +		    must be "iface", "bus", "mem", "gpll0_mss", "snoc_axi",
>> +		    "mnoc_axi", "prng", "xo" for the modem sub-system on SDM845
>> +		    SoCs
> 
> This seems to me a list of all clocks you need enabled, not what clocks
> actually go to the modem. Specifically, shouldn't the *noc_axi clocks 
> be
> managed by the interconnect driver?

clocks = ...,
        <&gcc GCC_MSS_SNOC_AXI_CLK>,
        <&gcc GCC_MSS_MFAB_AXIS_CLK>,
          ...;
clock-names = ..., "snoc_axi", "mnoc_axi",...;

snoc_axi and mnoc_axi maps to above GCC clks and
both of them fall under the MSS functional group

> 
> Rob

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

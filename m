Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06182C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3EB24561
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xoq4U0zv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IpatoUMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3EB24561
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbeF0OY2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:24:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933879AbeF0OYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:24:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24EEE60B19; Wed, 27 Jun 2018 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530109465;
        bh=rHgitbQxo0395bOci3NbXswVEoLbTwItbAHH6JOkVpk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xoq4U0zv4mZ5kliRxW11MH9vUgiQNqbpAf4mxH3DFnijVm03if89Z43EzR42JFk8g
         ZqZIVQvdqHGOWDXcclCT8tbmLtvBfsvxsWJ51cZKrDqUblSRCV3OMyJhIpOTanwCqT
         JULkKjO3vam0FollVsjarm05RAsAD5TXmRevJ0mw=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 436326034E;
        Wed, 27 Jun 2018 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530109464;
        bh=rHgitbQxo0395bOci3NbXswVEoLbTwItbAHH6JOkVpk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IpatoUMBgg+YTg7CYKMToaolo9m1W+R+iY5cEw6t0eJj00VwTnmZ5cTjohQNNp5BL
         3m+bIVNEeRqvC9VLciuU8qhHGygTxi4wBka389n73/RINeifdwzE1NReC2XguSFGO+
         4X6vQVZnca/W/WKuLBShpJsNinBFYQn3zov6uVFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 436326034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v5 1/8] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
References: <20180521172714.8551-1-sibis@codeaurora.org>
 <20180521172714.8551-2-sibis@codeaurora.org>
 <20180623004433.GQ3402@tuxbook-pro>
From:   Sibi S <sibis@codeaurora.org>
Message-ID: <aa84c861-5e37-5576-cd6f-94a302750d19@codeaurora.org>
Date:   Wed, 27 Jun 2018 19:54:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180623004433.GQ3402@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review will address the comments in the next respin.

On 06/23/2018 06:14 AM, Bjorn Andersson wrote:
> On Mon 21 May 10:27 PDT 2018, Sibi Sankar wrote:
> 
>> Add SDM845 AOSS (always on subsystem) reset controller binding
>>
> 
> I think it would be better if you made the binding represent the entire
> clock controller, rather than only the reset-related portion of it.
> 
> As I can't find anything in the downstream kernel that references the
> clock part of the hardware block I think the driver can be kept as is
> (with updated compatible and adjust the offsets of the registers)
> 
> 
> This makes the DT better represents the hardware and it makes it
> possible to control the clocks in the future, without breaking backwards
> compatibility with existing DTBs.
> 

yup makes sense.

>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   .../bindings/reset/qcom,aoss-reset.txt        | 52 +++++++++++++++++++
>>   include/dt-bindings/reset/qcom,sdm845-aoss.h  | 17 ++++++
>>   2 files changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>>   create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>> new file mode 100644
>> index 000000000000..cd5dcafb4ed7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>> @@ -0,0 +1,52 @@
>> +Qualcomm AOSS Reset Controller
>> +======================================
>> +
>> +This binding describes a reset-controller found on AOSS (always on subsystem)
>> +for Qualcomm SDM845 SoCs.
>> +
>> +Required properties:
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be:
>> +		    "qcom,sdm845-aoss-reset"
> 
> qcom,sdm845-aoss-cc
> 
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the register
>> +	            space.
>> +
>> +- #reset-cells:
>> +	Usage: required
>> +	Value type: <uint>
>> +	Definition: must be 1; cell entry represents the reset index.
>> +
>> +Example:
>> +
>> +aoss_reset: reset-controller@c2b0000 {
>> +	compatible = "qcom,sdm845-aoss-reset";
>> +	reg = <0xc2b0000 0x21000>;
> 
> reg = <0xc2a0000 0x31000>;
> 
>> +	#reset-cells = <1>;
>> +};
>> +
> 
> Apart from this the binding looks good!
> 
> Regards,
> Bjorn
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

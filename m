Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65414C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5CF208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ftxvTb9r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUYWbgMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5CF208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH1J6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:58:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeH1J6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:58:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 726796055B; Tue, 28 Aug 2018 06:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535436507;
        bh=CwCr5IWIB7Op2Pz2bM3u7X4KdxC7Hkazhj93ZnN9Ne4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ftxvTb9r0fdiQanUqYumsxBNFfhX9GMk18YER8rBfqlaI4opju3Z6DNIlQftuKP3P
         tyZUKc0vmKoXA+Cnwr4F4DUTuuZX9mS8lq4SQrzCh3I9DaT+9qSjPFAFNFCFxI9bIl
         v4nmHyJYZhP5UlTkH47BJatlWnoUn/PaBgUUpFqY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7B288601DA;
        Tue, 28 Aug 2018 06:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535436506;
        bh=CwCr5IWIB7Op2Pz2bM3u7X4KdxC7Hkazhj93ZnN9Ne4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hUYWbgMtCRCf5ZWBKFAYW8EFk2ioOAqXEMXBR5w8NkurWJ5AEqEIBkcYtg8vDuOzK
         5JSu3GiuSRN9sKGXxRVf1usHnHqjV0oW1j9CKTIbDIw4FAvdHs5Ij8oQ8TQFqjldmy
         IyanX8FFElxfO56CsYhpCsM8i2C/4WwG61D6C0j0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Aug 2018 11:38:26 +0530
From:   sibis@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reset: Add PDC Global binding for
 SDM845 SoCs
In-Reply-To: <20180828003823.GY160295@google.com>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-2-sibis@codeaurora.org>
 <20180828003823.GY160295@google.com>
Message-ID: <c675b609fcd0d243e4db2e6637c70902@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,
Thanks for the review

On 2018-08-28 06:08, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> On Fri, Aug 24, 2018 at 06:48:55PM +0530, Sibi Sankar wrote:
>> Add PDC Global(Power Domain Controller) binding for SDM845 SoCs.
> 
> nit: missing blank before the opening parenthesis.
> 

Will fix it

>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  .../bindings/reset/qcom,pdc-global.txt        | 52 
>> +++++++++++++++++++
>>  include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
>>  2 files changed, 72 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
>>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt 
>> b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
>> new file mode 100644
>> index 000000000000..69f9edca9503
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
>> @@ -0,0 +1,52 @@
>> +PDC Global
>> +======================================
>> +
>> +This binding describes a reset-controller found on PDC-Global(Power 
>> Domain
>> +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.
> 
> Are there other PDC reset controllers that aren't 'global'? Otherwise
> I'd suggest to use 'pdc-reset' instead of 'pdc-global', which is more
> specific and in line with the name of the driver added by this series.
> Or something like 'pdc-reset-global/main' if there are other
> controllers?
> 

These are the only reset lines found in the pdc-global register space. 
But as
explained by Bjorn, wouldn't it be better to leave it as such since 
pdc-global
best describes the hardware without being limited by the current 
functionality
it is being used for?

>> +Required properties:
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be:
>> +		    "qcom,sdm845-pdc-global"
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
>> +pdc_reset: reset-controller@b2e0000 {
>> +	compatible = "qcom,sdm845-pdc-global";
>> +	reg = <0xb2e0000 0x20000>;
>> +	#reset-cells = <1>;
>> +};
>> +
>> +PDC reset clients
>> +======================================
>> +
>> +Device nodes that need access to reset lines should
>> +specify them as a reset phandle in their corresponding node as
>> +specified in reset.txt.
>> +
>> +For list of all valid reset indicies see
> 
> s/indicies/indices/ (or s/indicies/lines/ ?)
> 
> Cheers
> 
> Matthias

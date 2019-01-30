Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D0C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E3B20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Oa8A15CO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QvfKM2sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfA3XH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:07:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfA3XH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:07:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 41255606DB; Wed, 30 Jan 2019 22:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548887393;
        bh=blT2AUeEPrxhvhcqHPQ9xJMAZikWb5D61u8qctJXg/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oa8A15COeoYu9KSbWicmR//PaQgfNAlr4yECHi0HfR9MiBPbcj7VqQ8J1sU/fIRT8
         9bPMGlGbS5SdlkCcj66MhFuIDiVszrivOb3vY13rnzuw+ihj/h/pAdPUmbovzQSjHn
         u4cH0T1DAQbDbnCMER284tBXDz0z9hmyZuYgqsKs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C0C4B604FD;
        Wed, 30 Jan 2019 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548887392;
        bh=blT2AUeEPrxhvhcqHPQ9xJMAZikWb5D61u8qctJXg/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QvfKM2sjMp284O/em731AdX5ufIogxxzLt4KkbJgCqAajnaNrcsrhYNxhThxNUmRZ
         MqH6e8VkjOrZrMEce5rwJzskEMgoIoGAXzmywCvNGhDC5H59TJ2z1QMe2EQZ6tSe8x
         JPYb5rs4C8okowmXso+qM5GCC5f+WVBrFw95Nnz4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jan 2019 14:29:52 -0800
From:   alokc@codeaurora.org
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
In-Reply-To: <c4260d66-5ca4-b194-0cbc-2a682a99db4b@linaro.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
 <c4260d66-5ca4-b194-0cbc-2a682a99db4b@linaro.org>
Message-ID: <77a4841746b00a67a14daa42886be57b@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 10:35, Georgi Djakov wrote:
> Hi Alok,
> 
> Thanks for the patches!
> 
> On 1/22/19 08:33, Alok Chauhan wrote:
>> Add documentation for the interconnect and interconnect-names bindings
> 
> s/interconnect /interconnects /
> 
>> for the GENI QUP as detailed by 
>> bindings/interconnect/interconnect.txt.
>> 
>> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 
>> ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt 
>> b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> index dab7ca9..44d7e02 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>> @@ -17,6 +17,12 @@ Required properties if child node exists:
>>  - #address-cells: 	Must be <1> for Serial Engine Address
>>  - #size-cells: 		Must be <1> for Serial Engine Address Size
>>  - ranges: 		Must be present
>> +- interconnects:	phandle to a interconnect provider. Please refer
> 
> s/a interconnect/an interconnect/
sure, will do.
> 
>> +			../interconnect/interconnect.txt for details.
>> +			Must be 2 paths corresponding to 2 AXI ports.
>> +- interconnect-names:	Port names to differentiate between the
>> +			2 interconnect paths defined with interconnect
>> +			specifier.
>> 
>>  Properties for children:
>> 
>> @@ -67,6 +73,10 @@ Example:
>>  		#size-cells = <1>;
>>  		ranges;
>> 
>> +		interconnects = <&qnoc 11 &qnoc 512>,
>> +				<&qnoc 0 &qnoc 543>;
> 
> Please take a snippet from your patch 6/6 and put it here instead of 
> the
> hard-coded integers above.
sure
> 
>> +		interconnect-names = "qup-memory", "qup-config";
>> +
>>  		i2c0: i2c@a94000 {
>>  			compatible = "qcom,geni-i2c";
>>  			reg = <0xa94000 0x4000>;
>> 
> 
> When you post a new version, please change the subject of the patch
> series to PATCH v2, PATCH v3 etc, in order to be able to distinguish
> between different versions.
sure, will do this.
> 
> Thanks,
> Georgi

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project

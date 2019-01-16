Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D5FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805EC20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N/+R2Swh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbfAPJpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:45:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38012 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbfAPJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:45:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so6130899wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vfJh0k8ffZLjmT/dXdzJx6lZgQPY/KRK1cZNRU4Qdyg=;
        b=N/+R2SwhaHTlm6qinqi71DxgFa7GODR5XTtaDgrTPqObxiGVUgknrkuJ9WlG3jCWL8
         ctErdDNdLVeVUqRbaUAcpjKKFdsvSgcp/0imDtmwUYvG8ni0VKq17cQdLrF5wTvTvmuj
         j8oxNnnIdi+C/0YhbUsB4ZwoCsQGtk8LJoS4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vfJh0k8ffZLjmT/dXdzJx6lZgQPY/KRK1cZNRU4Qdyg=;
        b=G6qBos9F8xGBLAZb3Bma9yygnFfwl8/dU6A6OLzF0uKa/ZR7sRpGmoa/OlVpwikhjc
         OxCWcb34kU3VaSE4IUg1tZh3uDygW6BjZfaIx2zM6ZV3mPd7sIo02dx8bAdWtRfeKXYY
         vADXzU9fOiSd7HrtNVnxkY2o3dMruMCwU1jx18xO+o6AAR6Qtajxygbkb0r0fOgxIyFr
         qkhNB/pMG15YsSlqLcbLUw9hbHovlsKGJLcdgMv/KGu556UwOB48k7bIw9gygKtKVJM/
         +RV00qkpAtD377sFiqo8YEjT6gMU18dyQDGX0dl4CFEd9VwhI2WLLJrOUBFwxDo/lX0D
         9w4w==
X-Gm-Message-State: AJcUukcc+vKU+CCi0dbv6rD686nFB1mdWpHbJ7Lhxu3Qt6r/UKxiwnvh
        6RA8Z5Je+/zkV/caN407tTSilg==
X-Google-Smtp-Source: ALg8bN5RYk7fviGLHs7cEd+XNIb1VPWDFUR8/LD5VAHJGOMUJ0Yq47bABFgC4kI2Bu7d+57+i7/CeQ==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr7073742wra.186.1547631899610;
        Wed, 16 Jan 2019 01:44:59 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j33sm120197162wre.91.2019.01.16.01.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 01:44:58 -0800 (PST)
Subject: Re: [PATCH v3 1/5] misc: dt-bindings: Add Qualcomm Fastrpc bindings
To:     Rob Herring <robh@kernel.org>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, bkumar@qti.qualcomm.com,
        linux-arm-msm@vger.kernel.org, thierry.escande@linaro.org
References: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
 <20190114194112.32567-2-srinivas.kandagatla@linaro.org>
 <20190115202206.GA4849@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <113dc31e-c17d-4df0-b275-9f2d09591037@linaro.org>
Date:   Wed, 16 Jan 2019 09:44:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115202206.GA4849@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

On 15/01/2019 20:22, Rob Herring wrote:
> On Mon, Jan 14, 2019 at 07:41:08PM +0000, Srinivas Kandagatla wrote:
>> The FastRPC driver implements an IPC (Inter-Processor Communication)
>> mechanism that allows for clients to transparently make remote method
>> invocations across DSP and APPS boundaries. This enables developers
>> to offload tasks to the DSP and free up the application processor for
>> other tasks.
>>
>> Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/misc/qcom,fastrpc.txt | 84 +++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>> new file mode 100644
>> index 000000000000..004e636b4133
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>> @@ -0,0 +1,84 @@
>> +Qualcomm Technologies, Inc. FastRPC Driver
>> +
>> +The FastRPC driver implements an IPC (Inter-Processor Communication)
> 
> driver or this is a h/w block?

This is a software/firmware block in Hexagon DSP.

> 
>> +mechanism that allows for clients to transparently make remote method
>> +invocations across DSP and APPS boundaries. This enables developers
>> +to offload tasks to the DSP and free up the application processor for
>> +other tasks.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,fastrpc"
>> +
>> +- label
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: should specify the dsp domain name this fastrpc
>> +	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
>> +
>> +- #address-cells
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Must be 1
>> +
>> +- #size-cells
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Must be 0
>> +
>> += COMPUTE BANKS
>> +Each subnode of the Fastrpc node represents compute context banks available
>> +on the dsp. The name of the nodes are not important. The properties of these
> 
> Please specify what the node names are.

Sure, these are compute context banks, will reword this accordingly.

> 
>> +nodes are defined by the individual bindings for the specific service
>> +- All Compute context banks MUST contain the following property:
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,fastrpc-compute-cb"
>> +
>> +- reg
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Context Bank ID.
>> +
>> +- secured:
>> +	Usage: Optional
>> +	Value type: <boolean>
>> +	Defination: Indicating context bank is secured
> 
> What does 'secured' mean here?
> 
secured in TZ sense, this context requires secure buffers to work with.


>> +
>> +- nsessions:
>> +	Usage: Optional
>> +	Value type: <u32>
>> +	Defination: A value indicating how many sessions can share this
>> +		    context bank. Defaults to 1 when this property
>> +		    is not specified.
> 
> Needs a vendor prefix.
> 
Sure, will do that in next version!

>> +
>> +Example:
>> +
>> +adsp-pil {
>> +	compatible = "qcom,msm8996-adsp-pil";
>> +	...
>> +	smd-edge {
>> +		label = "lpass";
>> +		fastrpc {
>> +			compatible = "qcom,fastrpc";
>> +			qcom,smd-channels = "fastrpcsmd-apps-dsp";
>> +			lable = "adsp";
> 
> typo.

Thanks for spotting this.. will fix this!

--srini

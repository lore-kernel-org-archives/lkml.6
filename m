Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A636D2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKrnW199"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A636D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeLJLRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:17:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46609 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLJLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:17:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so9099823edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 03:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PWOXAW5zptjQ5xZdQFHKSbapnt9sD5n2CT3naJkIGp8=;
        b=YKrnW199TGt46fn8zrz/NUS2gOU4WpzlPjZhH2px5Fj4ZNdEfUt3HVns+WFkZ1m39M
         nuoJioHF+y5DENGuKloTNnsErA7jIqyKw0v3Pe2su8Qbt1d9kAqg+cmih36n8Zyek2f9
         /41mHqcOZEtOrVddZO3QUYt2aauEK1LsP1cV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PWOXAW5zptjQ5xZdQFHKSbapnt9sD5n2CT3naJkIGp8=;
        b=R47MSgx8BWoxR69dBaMH4HkpRL3OtO3v3J780PVgvMyDvxnFzeLHrDxJ4PTWpvY31C
         /9C2H4PU3DrENB6S1aFKLcaAd7A7Sa08TXG7KJUbvLcl1ZQ7iDIfFIYXr+wdVN9WdER8
         rxNiUHTV4pXqSQOAsWy1XVmT7RX5gSMFZLbCe6eDrFDkTzuXc/FVbkDvF7ttcOo/5KdO
         Fkpwid2vJXDT7qXrfVKuZ5smLGpyDr/4O5UGCQYDuBSZt4BsyLVJMRL12YVTigNnJG3A
         dJHpFx+5fzCb3Ser712Lp9hZ/EtyNZ4LsTwv0gF9UvU80R5ktlqU1d/NwclM0o9ov6iB
         i3Hg==
X-Gm-Message-State: AA+aEWbRn8Hocl//zmt3FMN6lFjXBbbwqt7j/zlnLcfR9jJEiJSQOzBm
        ngLDbt8yANo29HFdE0G0Icx4rA==
X-Google-Smtp-Source: AFSGD/UKld3CWsoikAOsriELRNJH7QgVr5wCBRztdmqz/A3CroE/CJ7qxQLmzhVx4D5bvnhszjeaGg==
X-Received: by 2002:a17:906:3ed4:: with SMTP id d20-v6mr9439476ejj.151.1544440664046;
        Mon, 10 Dec 2018 03:17:44 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e35sm3291777eda.13.2018.12.10.03.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 03:17:43 -0800 (PST)
Subject: Re: [PATCH v2 1/6] misc: dt-bindings: Add Qualcomm Fastrpc bindings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-2-srinivas.kandagatla@linaro.org>
 <20181207182327.64mtkfx6v4wlwccz@lakrids.cambridge.arm.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <afdeecc4-4ee9-e933-9917-9930ece85b00@linaro.org>
Date:   Mon, 10 Dec 2018 11:17:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181207182327.64mtkfx6v4wlwccz@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 07/12/18 18:23, Mark Rutland wrote:
> On Fri, Dec 07, 2018 at 04:35:08PM +0000, Srinivas Kandagatla wrote:
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
>>   .../devicetree/bindings/misc/qcom,fastrpc.txt | 73 +++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>> new file mode 100644
>> index 000000000000..06e8c25839d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>> @@ -0,0 +1,73 @@
>> +Qualcomm Technologies, Inc. FastRPC Driver
>> +
>> +The FastRPC driver implements an IPC (Inter-Processor Communication)
>> +mechanism that allows for clients to transparently make remote method
>> +invocations across DSP and APPS boundaries. This enables developers
>> +to offload tasks to the DSP and free up the application processor for
>> +other tasks.
> 
> Which hardware does this node represent?
> 
This is hexagon dsp, remoteproc node represents this.

> If this is functionality provided by another block of hardware (i.e. the
> DSPs themselves), it would be better to have nodes for them.
Currently the dsp nodes are remoteproc nodes itself, all the services 
that dsp provides are child nodes of this.

Ex: Audio DSP nodes looks like this:

adsp-pil { /* remoteproc device */
	compatible = "qcom,msm8996-adsp-pil";
	...
	smd-edge { /* rpmsg device */
		...
		fastrpc { /* platform device */
			compatible = "qcom,fastrpc";
		};
	};
};


> 
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,fastrpc"
>> +
>> +- reg
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: DSP Processor ID.
>> +	Possible values are :
>> +			0 - ADSP
>> +			1 - MDSP
>> +			2 - SDSP
>> +			3 - CDSP
> 
> Why is this in a reg?

This is to identify which type of dsp(Audio/Modem/Sensor/Compute) it is, 
This information is used to create device nodes for user-space access.

> 
> To be, a phandle to the relevant DSP would seem better.
> 
>> +
>> += COMPUTE BANKS
>> +Each subnode of the Fastrpc node represents compute context banks available
>> +on the dsp. The name of the nodes are not important. The properties of these
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
> In what sense?
> 
> Does this mean Secure / Non-secure in the TrustZone sense?

Yes, its secured in TZ sense, this context requires secure buffers to 
work with.

> 
>> +
>> +- nsessions:
>> +	Usage: Optional
>> +	Value type: <u32>
>> +	Defination: A value indicating how many sessions can share this
>> +		    context bank. Defaults to 'One' when this property
>> +		    is not specified.
> 
> Presumably the default is 1, rather than 'One'.
Yes!
> 
> What is a session? How do there share a context bank?

A Session is a running instance on a compute context bank.

The value here indicates how many sessions can run simultaneously on 
that compute context bank.

> 
>> +
>> +Example:
>> +
>> +fastrpc {
>> +	compatible = "qcom,fastrpc";
>> +	qcom,smd-channels = "fastrpcsmd-apps-dsp";
>> +	reg = <0>; /* DOMAIN_ADSP */
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	cb@1 {
>> +		compatible = "qcom,fastrpc-compute-cb";
>> +		reg = <1>;
>> +		iommus = <&lpass_q6_smmu 1>;
> 
> These iommus should be associated with the device (i.e. the DSP itself).

Currently the device model is via remoteproc bus followed by rpmsg bus 
(communication channel) and then each compute context banks instance is 
a platform device as children of the rpmsg channel device.


There are few practical issues though,

1> None of the parent buses (remoteproc/rpmsg) have ability to do a dma 
allocations or associate there child devices with iommus.

2> Each compute bank has its own iommu stream id associated with it. How 
can the parent bus associate this with each compute context bank 
instance? Given that we have more than one compute context banks in each 
dsp.
Are there any examples which already do this?

3> Are there already dt bindings which describe this parent bus handling 
all the iommu stream ids of child devices?



Thanks,
srini


> 
> Thanks,
> Mark.
> 
>> +	};
>> +
>> +	cb@2 {
>> +		compatible = "qcom,fastrpc-compute-cb";
>> +		reg = <2>;
>> +		iommus = <&lpass_q6_smmu 2>;
>> +	};
>> +	...
>> +};
>> -- 
>> 2.19.2
>>

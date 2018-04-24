Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524585852; cv=none;
        d=google.com; s=arc-20160816;
        b=dZcmwfVLBuhUrKcUsmTkZo6mCRx0rJExdFWJIEiDjpH6ml1/ZMrNCjY1bOTOplILdV
         efyJPcFJQ6nX3Kzi3r6rIkXwDnbjQq4K7nLiqPjqcdVRMo/B+aIUtLRUZdTjqRxWtWYp
         FvOTOttc+AxwFujCcvCgqNQUxfjHRQHK+N9cCrr5RcPu4Zeypb2pENBUa32soPnwj5I0
         otHtTi0iGaRGq/xckigfK8xoYp9aeSniJdIvcak7XwerLK3iOf3WuLScdByFeVQqDDgv
         Ul0+AxRai2FG4C5ZddcVdCMBbvATIVM/5/E8WRzwjm04AMo55ygw//IiBlbiX5CFgZ3i
         n+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=PUITQb7vx/KHMSS2mOb8mty4aKLCq62/wr/JX1TGwe4=;
        b=n/xfLp7Ox5allltKewdHukwjTWVJdsW2PZESq04QitSPc6DnFGv6hvoFPG+IFlzs3j
         fSIUcqQybW85QAZU0yeWOZBPzV0GYNeGe9oqfBQOEWT2qhLUjY3yMRRnFJXEVGOxA7+B
         P5U6w9IvPAej0APIHU6DGcQ9sSf5AgHO7DDQkz3zflEPCCTJIhPNFE0ycX+TZV+4YlXM
         oW94alq6JJyVEuDOGJw2i4MHdDpq/wecXTvHzaghhiKw6NI8IpGY+RCv5MXWugjX16xs
         ZPwfUy7AfNR7k24uoFPQdia63qgh5oQhXCqMua3LU51JPBcfB5ujt3uEyu6MDbzmRtBZ
         0PkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DZo+6V4x;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DZo+6V4x;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpRRfrzpgYA2ck62j9qT7C2oi6I/hq0T6y7s00UpMg5qfUBhmQeiZkos+bofwMTO7zIwJW0rg==
Subject: Re: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR bus bindings
To: Rob Herring <robh@kernel.org>
Cc: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
 plai@codeaurora.org, bgoswami@codeaurora.org, tiwai@suse.com,
 perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <de5fac3b-1a56-61d0-facd-a592715d7606@linaro.org>
Date: Tue, 24 Apr 2018 17:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098775422985978?=
X-GMAIL-MSGID: =?utf-8?q?1598644134883484941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the review comments,

On 24/04/18 16:52, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
>> bus driver. This bus is used for communicating with DSP which provides
>> audio and various other services to cpu.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 85 ++++++++++++++++++++++
> 
> This should probably go under bindings/sound/ as it is at least mostly
> sound related.
There are other non audio dsp/modem services that will be using apr.

> 
>>   include/dt-bindings/soc/qcom,apr.h                 | 27 +++++++
>>   2 files changed, 112 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>>   create mode 100644 include/dt-bindings/soc/qcom,apr.h
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>> new file mode 100644
>> index 000000000000..85cc0433fb00
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>> @@ -0,0 +1,85 @@
>> +Qualcomm APR (Asynchronous Packet Router) binding
>> +
>> +This binding describes the Qualcomm APR. APR is a IPC protocol for
>> +communication between Application processor and QDSP. APR is mainly
>> +used for audio/voice services on the QDSP.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
>> +
>> +- qcom,dest-domain-id
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
> 
> If this is an array, what do the indexes of the array correspond to?
> 
This should be
  Value type: <u32>

these indexes point to the remote processor ID.

>> +	Definition: Destination processor ID.
>> +	Possible values are :
>> +			1 - APR simulator
>> +			2 - PC
>> +			3 - MODEM
>> +			4 - ADSP
>> +			5 - APPS
>> +			6 - MODEM2
>> +			7 - APPS2
>> +
>> += APR SERVICES
>> +Each subnode of the APR node represents service tied to this apr. The name
>> +of the nodes are not important. The properties of these nodes are defined
>> +by the individual bindings for the specific service
>> +- All APR services MUST contain the following property:
>> +
>> +- reg
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
> 
> Not really an array, right?
No, again this is  Value type: <u32>

> 
>> +	Definition: APR Service ID
>> +	Possible values are :
>> +			3 - DSP Core Service
>> +			4 - Audio Front End Service.
>> +			5 - Voice Stream Manager Service.
>> +			6 - Voice processing manager.
>> +			7 - Audio Stream Manager Service.
>> +			8 - Audio Device Manager Service.
>> +			9 - Multimode voice manager.
>> +			10 - Core voice stream.
>> +			11 - Core voice processor.
>> +			12 - Ultrasound stream manager.
>> +			13 - Listen stream manager.
>> +
>> += EXAMPLE
>> +The following example represents a QDSP based sound card on a MSM8996 device
>> +which uses apr as communication between Apps and QDSP.
>> +
>> +	apr {
>> +		compatible = "qcom,apr-v2";
>> +		qcom,smd-channels = "apr_audio_svc";
> 
> Drop this?
Sure


--srini

Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527095845; cv=none;
        d=google.com; s=arc-20160816;
        b=DEtNJniVm840Nn+yP0v4ffEejiwbKM6bK6EvimiugmwoiYxZrsrXorvZZjEOMewiCv
         uFI/P64vkAjG12LPfbqlJY+Er4tN/m+FUefwIwLPH2Y4MkLUXwN9bj/ofA/RFZgV//r9
         TH7WWWQ3gntVgyCyipPA6KlWRRf0Ea9wbNTY3uRQ8T4lur/+rWmQD9Z7f9JPjikOLeXh
         QAjBapquNgEyf2GX7EtJIZ2U0HZmlb66R0FaDwxECmxqRACwx7rbqKyp11vakZsBg9CD
         TgNaNymuyOvO0uLzaz2d8Hp1Dk1EW+XsnYuXg6fjkG4ZOJlwwG2esGSsKlMkfTAvFw9R
         +yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=oorM8A5kHnrjtRdvUuQpn7ZcEXEGHm2Dmp5aLTdzLis=;
        b=dj3IBi7oTAqQSxWIJmCo9XzgTlevkfKE+EMaqxcEhtRCJ0W+8Innjiq1gzVpyu8kA1
         zZx7W1/WLUYAqHwqZuabiA+O8jFTNnB1j0sJVLvNdBKmUbAI7s4bKVVGYi2ZCeBYTdMk
         2Yt8vwpv1xgMN2CnTvKp10u/FZyrYxcQsNd/cNIiMqG/YpZ2u7l4uQJEo2C/9W3MlFsC
         dYDWZWmXqYDM/6dxJq0DWI4xjINtaI9NDwrM9dvP5w5KeROtQBpbff2tTs8pFyib+7ut
         T6thftpzMpf8ipRqO/YjHSH/TlCymkImbOcjJJL1VN0T2A78mPrL5dXInGKvKI1yZREc
         XD4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=MaDriYv2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=MaDriYv2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr8vdfpg3DlS97cwuAZhB5y4CN3nh0njMLmHcWr+KigLMcBvCyQ0tAXvczx+S0BKktzzOgmqg==
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, kramasub@codeaurora.org, sdharia@quicinc.com,
 girishm@quicinc.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 bgoswami@codeaurora.org, devicetree@vger.kernel.org, broonie@kernel.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
 <20180523164023.GA24671@rob-hp-laptop>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <94271b39-37f4-16c5-db35-782bbbc9d851@linaro.org>
Date: Wed, 23 May 2018 18:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180523164023.GA24671@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1601276052774940038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Rob for review,

On 23/05/18 17:40, Rob Herring wrote:
> On Wed, May 16, 2018 at 05:51:17PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm SLIMBus NGD controller found in
>> all new SoCs starting from B family.
>> SLIMBus NGD controller is a light-weight driver responsible for
>> communicating with SLIMBus slaves directly over the bus using messaging
>> interface and communicating with master component residing on ADSP for
>> bandwidth and data-channel management
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 70 ++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
>> new file mode 100644
>> index 000000000000..c948fb098819
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
>> @@ -0,0 +1,70 @@
>> +Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
>> +
>> +SLIMBus NGD controller is a light-weight driver responsible for communicating
>> +with SLIMBus slaves directly over the bus using messaging interface and
>> +communicating with master component residing on ADSP for bandwidth and
>> +data-channel management
>> +
>> +Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,slim-ngd"
> 
> SoC specific compatible needed.

Yes, I will add that in v2.
> 
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the controller
>> +		    register blocks.
> 
> blocks? Is there more than one? If so, how many?
Its just one. I will fix the text to reflect this.

> 
>> +
>> +- reg-names:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "ctrl"
> 
> reg-names is pointless when there is only 1.
> 
>> +
>> +- qcom,ngd-id
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: ngd instance id in the controller
> 
> Why do you need this?
I have removed this totally in my next version, which I will be posting 
soon.

Thanks,
srini

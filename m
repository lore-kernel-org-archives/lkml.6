Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524586808; cv=none;
        d=google.com; s=arc-20160816;
        b=ZcBW3HKxJLmSydGaJ6eXzOFORYIkZ2B4F+1e63VvKuPwPI4YN6aN3JKmIPcHIF6fM5
         GMcFvUtusiYpbBjzYths8jrzt+m1D9q3je7nOhdNJ6IWptyQn5/tLQKDflWz/kOpER+Q
         mHFrnSrlDE745i6bkU+Pfn4pl9vBNxFsIqsHw8+1uPnJccE/uQ7evHzdpy9xJ9zcrgAl
         l65hmZD8O9gGkmCYZexqJRXffLnspmqSlkwoa4DkxIuzNOQUsUoH85qNQ+/ZllqG3Arq
         Vp70WIaExX7ogBpt2SSGfG037PqLFzNUC+In28zKOuOY0nKoPavj49jHQlCrTC7l+2AD
         qAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=jgDBGlP2yHdTe5Li9FbTNgVxGkHwtKP7MaQu5GpzA5k=;
        b=XYYN2b82/zJ3Rg0mgyAVcFbM2dutwhkBT9N4yaBZ2C1AhKafnYq6IQ6MOTqTmG/c37
         4La+0PqlQYrsJFSKAgGkupk66v1alQofNelQxr99Weuff8/VwgXNBLkHm1FR8jyWBM5o
         rVoPKdlAGWR1a08TVRpL7dtvsu9kpSMiRB1KcL8j9Q9vxGQBPJBVX59srWqsWaeblRTm
         7r5HQ7whM1AbRJ9UQteg1O3LREhRT4zXFmh8q1zPFBI1vKBRLpxe0fFXFCMvPVwUsIto
         DT4w+d5MONJPDs1p/EmzJxCkIay1YhtGECF9+GqjHyZTjm37+/aF27OAxMRfeiJhKykp
         F0Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kDPhZyq+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kDPhZyq+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+bIviJD2fqbdZr0jMguebzztLbVT1bQbW8Kr8BRyeu4KG3cPpJC+TNu1/GN2M6kNrxAs0w2A==
Subject: Re: [PATCH v5 06/23] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
To: Rob Herring <robh@kernel.org>
Cc: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
 plai@codeaurora.org, bgoswami@codeaurora.org, tiwai@suse.com,
 perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-7-srinivas.kandagatla@linaro.org>
 <20180424161730.4r3vixqa4sdjv7a2@rob-hp-laptop>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0cc7f804-4c3c-1955-3d61-0dcbb70ae017@linaro.org>
Date: Tue, 24 Apr 2018 17:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180424161730.4r3vixqa4sdjv7a2@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098782482052461?=
X-GMAIL-MSGID: =?utf-8?q?1598645138173802030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the review comments,

On 24/04/18 17:17, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:40PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch add DT bindings for ASM (Audio Stream Manager) DSP module.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
>>   include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
>>   2 files changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>>   create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>> new file mode 100644
>> index 000000000000..d034a50a202a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>> @@ -0,0 +1,33 @@
>> +Qualcomm Audio Stream Manager (Q6ASM) binding
>> +
>> +Q6ASM is one of the APR audio service on Q6DSP.
>> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
>> +used by the apr service device.
> 
> Need to be clear this is a child of APR.
Yep, I will add a line to state this explicitly.

> 
>> +
>> +- but must contain the following property:
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
>> +		    Or "qcom,asm" where the version number can be queried
>> +		    from DSP.
>> +		    example "qcom,asm-v2.0"
>> +
>> += ASM DAIs (Digial Audio Interface)
>> +"dais" subnode of the ASM node represents dai specific configuration
>> +
>> +- #sound-dai-cells
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: Must be 1
>> +
>> += EXAMPLE
>> +
>> +q6asm {
> 
> Unit address needed.
Agree, Will fix all such instances.
> 
>> +	compatible = "qcom,q6asm";
> 
> Doesn't match the doc.
Opps!! will fix all such instances with afe and asm too.
> 

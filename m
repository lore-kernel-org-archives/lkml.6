Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524841084; cv=none;
        d=google.com; s=arc-20160816;
        b=WjmT53JhRkBcX+G0TiBPXxcIpedrFA5vCzkiVN1FzKfP80UHvsYO9m2ahxqnFcPCSZ
         iEJ+DO7HPHcHgFqcuT1RDIT7RpVrEPiY6f8MgVwr4RjEh2xWGPudWC6r0085Fj0/5/XJ
         PXTq0fQS3Daxb2Y1fE0C5fs5KC/wQBmmLJu21pQusMmib9X+7uZ6WZApBCFudT1UTJC/
         ZqQgPY65YkC3r3DpQxRzC9e4/8widuZBN1ejOX8gByhmdDNTkm/voZQS0OfS64agdUr1
         LQcRufu7vXTOmTopg9u87Co6aXaBl310qa6xyrD86t1QXPqzrRHtCkB2xjdDnECRm8FS
         dfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=iZWe2H6nlqfFU1B5zdrCcMZn4O9fIuOLKEki/dX9CYw=;
        b=ZxsTUXxXrjrgJUn2yhpuq6Scr/ONuQhpmJq7XEmvxzVdHkP2W2lq1YYh6J8HA/RiWE
         xYQxAvDdETT0FjGRTu8Rb+lHwb/RJTbPJo5dHWHOAnoTTKScf6Khq16KG6Oj5QlsOGo6
         e6kCxCN6y6nmR8lcCxYLklrc8LfdhVrrIrF6/XLycjiqSYZOONzswkpfW4JkElC3Prtr
         so4wIOiXT9/xLyPY++z6FJ2yA/Ex700SfzsCy/J6zeQJyEwiUoyzjyONxFWt9CCOAY0w
         Kle7qb5zfU5mYWncWcQTZEYN08tadPucZvfKEz+F4wR5HQIovbg/kEJ5Z4lB5c1DD2VJ
         3YIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LSwm50P2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=LSwm50P2;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr0C4OOeGxIfpqHB6FnFVcTFg/tBiiigLdBnKdskEd4EWZrI52z4sDOudH3G3fW5ar70SH5Bw==
Subject: Re: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
To: Rob Herring <robh@kernel.org>
Cc: andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
 <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dd30b0ed-d958-9bf8-13cf-55d100b645ab@linaro.org>
Date: Fri, 27 Apr 2018 15:58:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801759184316258?=
X-GMAIL-MSGID: =?utf-8?q?1598911765213363791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the review.

On 27/04/18 15:13, Rob Herring wrote:
> On Thu, Apr 26, 2018 at 10:45:46AM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch add DT bindings for AFE (Audio Frontend) DSP module.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,q6afe.txt       | 88 ++++++++++++++++++++++
>>   include/dt-bindings/sound/qcom,q6afe.h             | 31 ++++++++
>>   2 files changed, 119 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>>   create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>> new file mode 100644
>> index 000000000000..05208a63dd3c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>> @@ -0,0 +1,88 @@
>> +Qualcomm Audio Front End (Q6AFE) binding
>> +
>> +AFE is one of the APR audio service on Q6DSP
>> +Please refer to qcom,apr.txt for details of the common apr service bindings
>> +used by all apr services.
>> +
>> +- but must contain the following property:
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
>> +		  Or "qcom,q6afe" where the version number can be queried
>> +		  from DSP.
>> +		  example "qcom,q6afe"
> 
> reg too.

I did not want to repeat what is already mandated for apr children in 
qcom,apr.txt
So skipped repeating reg property in here.

> 
>> +
>> += AFE DAIs (Digial Audio Interface)
>> +"dais" subnode of the AFE node represents dai specific configuration
>> +
>> +- #sound-dai-cells
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Must be 1
>> +
>> +- reg
> 
> It's not clear here these are in a grandchild node.
> 
Every afe port/dai has some board specifics, to allow that we need dai 
specific child nodes.

>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Must be dai id
>> +
>> +- qcom,sd-lines
>> +	Usage: required for mi2s interface
>> +	Value type: <prop-encoded-array>
>> +	Definition: Must be list of serial data lines used by this dai.
>> +	should be one or more of the 1-4 sd lines.


--srini

Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525845913; cv=none;
        d=google.com; s=arc-20160816;
        b=YSCzv0lmua1nEAaXO3Cee2WNohWPC7yEbW62kgEnDlMCLXYa47QGoYp8yAksvKGpxS
         zNQmVnjjH8mwu2W5+TCfjAptOALS849I1Xkkysz1Lt4RyAauxq+AKQJs1YpJKsVQexwE
         6sEhjoS0Di9rMzuf6rVPqwF39iDJZ05b6/vloi7nGeLyOg1Mo3NQxGnsEK3MVm6OID/r
         h4oYSCpeS6CMB1wZJtWayQvdaY0LfRb5ikOuNNol2l3aS/S96Or3pVbHBMLU3fZAEl2L
         hbm57MsH0HSmydqFcOvU61cNsqiXHAqnUz+zcFNkku3YIEOBfqkly1vgylN4366/QcCd
         2AeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=TeuPKYQYzWySnkBJdWdpU4HuaOMRB0bMQIIslvv7Ws0=;
        b=x63ykqrDBJyANQsekbtdyWwrz3eKxkxq7mw2NSxNDIU0aCrEvQNnII7/YpHMIWve2e
         KTL5LchGpq8QBXaYoyv3CiyomS7beWSe6AHQTZkWCjsCgMLR6WCMGoJnKC3m4upCMpVk
         W53+Im2Lzmv5DaUwm/Q8Q3dCps/sgENf/BixOOvNPw9TLL0js008CT1RMdyV3TU4uvad
         UOxSdtge8ChjC2o/Sq3R3fU6YJ6HJQ/ltjF0kZo2dvGb45cWUqCeQVpWZrpLaiTNqTBE
         rgDL6lfUSxRkT8AH1Z7sH5COuIy+OrjvAK0nkjZC722QggMPBbxQsa32KWp6w904q3Ps
         KL9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OiRSU2tS;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=OiRSU2tS;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrkpZVMJWEUMa96x+JRpo1fTl+5QEt5sn3W3FAc8cWsbBABIIrimkAHPy8oWgjXSfGr7AdYTg==
Subject: Re: [PATCH v7 11/24] ASoC: qdsp6: q6afe: Add support to MI2S ports
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-12-srinivas.kandagatla@linaro.org>
 <2d1e7dfd-b65a-4297-f98b-15c2dd54c61a@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3e8b4622-81b9-2091-dfd9-22ea035a8b52@linaro.org>
Date: Wed, 9 May 2018 07:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2d1e7dfd-b65a-4297-f98b-15c2dd54c61a@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263620627617198?=
X-GMAIL-MSGID: =?utf-8?q?1599965404370023116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Banajit for review!

On 09/05/18 04:21, Banajit Goswami wrote:
> 
> On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
>> This patch adds support to 4 MI2S ports on LPASS.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6afe.c | 224 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   sound/soc/qcom/qdsp6/q6afe.h |  13 +++
>>   2 files changed, 237 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
>> index be55b3ab045f..ceb18aaa5af4 100644
>> --- a/sound/soc/qcom/qdsp6/q6afe.c
>> +++ b/sound/soc/qcom/qdsp6/q6afe.c
>> @@ -14,6 +14,10 @@
>>   #include <linux/spinlock.h>
>>   #include <linux/delay.h>
>>   #include <linux/soc/qcom/apr.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dai.h>
>> +#include <sound/pcm.h>
> <snip>
> 
>>   union afe_port_config {
>>       struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
>>       struct afe_param_id_slimbus_cfg           slim_cfg;
>> +    struct afe_param_id_i2s_cfg    i2s_cfg;
>>   } __packed;
>>   struct q6afe_port {
>> @@ -210,6 +264,22 @@ static struct afe_port_map 
>> port_maps[AFE_PORT_MAX] = {
>>                   SLIMBUS_4_RX, 1, 1},
>>       [SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
>>                   SLIMBUS_5_RX, 1, 1},
>> +    [QUATERNARY_MI2S_RX] = { AFE_PORT_ID_QUATERNARY_MI2S_RX,
>> +                QUATERNARY_MI2S_RX, 1, 1},
>> +    [QUATERNARY_MI2S_TX] = { AFE_PORT_ID_QUATERNARY_MI2S_TX,
>> +                QUATERNARY_MI2S_TX, 0, 1},
>> +    [SECONDARY_MI2S_RX] = { AFE_PORT_ID_SECONDARY_MI2S_RX,
>> +                SECONDARY_MI2S_RX, 1, 1},
>> +    [SECONDARY_MI2S_TX] = { AFE_PORT_ID_SECONDARY_MI2S_TX,
>> +                SECONDARY_MI2S_TX, 0, 1},
>> +    [TERTIARY_MI2S_RX] = { AFE_PORT_ID_TERTIARY_MI2S_RX,
>> +                TERTIARY_MI2S_RX, 1, 1},
>> +    [TERTIARY_MI2S_TX] = { AFE_PORT_ID_TERTIARY_MI2S_TX,
>> +                TERTIARY_MI2S_TX, 0, 1},
>> +    [PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
>> +                PRIMARY_MI2S_RX, 1, 1},
>> +    [PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
>> +                PRIMARY_MI2S_RX, 0, 1},
> Can these be added after SLIMBUS_6_RX?
> Also, for better arrangement, please add the port_maps from 
> PRIMARY_MI2S_RX to QUATERNARY_MI2S_TX in the same sequence of definition 
> of AFE ports.
> Otherwise LGTM.
Yep, I have reordered this now!

> Once fixed the above comment add-
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> 

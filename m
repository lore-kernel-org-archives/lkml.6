Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520949091; cv=none;
        d=google.com; s=arc-20160816;
        b=JIu3yCuRaxj3MHM8m0+Ni7+4gvVAKNELN5q+q+AspDZuIwQtLflTwouORGMjxerT6k
         HKx4NSxOIudkVNurSDsWPq2rV3w8Y64lH/lOYD980SlxfBvzQ8vneCvMFFlC+GiJvEKi
         R9+Y4Ab/LTCPtAt6VqVgV0Rw3BmFx6sHc/b/J1aPnV4BNvmqNsbFwO5Ok5EgxKgpZ6m9
         YCEoG26MwN2zO1/X7Q68I8qe5FnjAkS4OWt+8Iy7/T2eH0d55Mahsh6hTIBx//QfKI18
         x9AH/3jN6sbP2DYc2DxOJrLxgJ9scsNFGBXG3YzaKc0N9JO/Nm2trEf/quUgqCDk5Ngs
         3cAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Gm90PCwlOvIqSyKwg9TpRvcVCxNjEIAjCHxqmzYW6oU=;
        b=P3emd2coZrT7XTHQplO8GrgNPRRlZkZEPqwLVSVQ77iiC/L+kdRP4c0LLoHH5dhxDC
         9KB0R2Wei2pomv9LTun085Y5hpMdq/vCUT6TXLObEmUuYPL5sOax7FhrfUJWe6zjxKbI
         37+ciNNCBfyZVnmYzRyFB9maXyIxkRrkTHGMthtXASGb6NpCoJRzPvwwqlBQqJaInxzJ
         eZkhO5APnC/ta39lc3b4u2Fcj1A0JMmnw3CsT5t6DojKLg/KbqxkWPsbdgMWvtZyTGN0
         GASWiw0Vx8nYQYkWtR/Wl3kNFuB+MOjcBZXCHbW4v9HuMMDa3SR6DNTopaS2FQT/8C4A
         cBoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QB7T8NCz;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QB7T8NCz;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsBvbK58EZMGyyJZkkMpBnM8fufOvo29imv9ZIVQoS9isOMa8qtpv7oBciANmN30t1Jki9xpg==
Subject: Re: [alsa-devel] [PATCH v4 07/24] ASoC: qdsp6: q6afe: Add q6afe
 driver
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
 gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com,
 tiwai@suse.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com,
 linux-kernel@vger.kernel.org
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-8-srinivas.kandagatla@linaro.org>
 <3d750b29-d341-af4d-41b3-30260f8296b7@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e2c668dd-aad5-db06-cc92-e27c57cf598e@linaro.org>
Date: Tue, 13 Mar 2018 13:51:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3d750b29-d341-af4d-41b3-30260f8296b7@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515911539130697?=
X-GMAIL-MSGID: =?utf-8?q?1594830714096160308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Rohit for the review,

On 13/03/18 11:29, Rohit Kumar wrote:
> 
> 
> On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
>>
> [..]
>> +        if (res->status) {
>> +            dev_err(afe->dev, "cmd = 0x%x returned error = 0x%x\n",
>> +                res->opcode, res->status);
>> +        }
>> +        switch (res->opcode) {
>> +        case AFE_PORT_CMD_SET_PARAM_V2:
>> +        case AFE_PORT_CMD_DEVICE_STOP:
>> +        case AFE_PORT_CMD_DEVICE_START:
> 
> case AFE_SVC_CMD_SET_PARAM: needs to be added
thanks for spotting this, Will add this back

>> +            port = afe_find_port(afe, data->token);
>> +            if (port) {
>> +                port->result = *res;
>> +                wake_up(&port->wait);
>> +            }
> [..]
>> +
>> +static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
>> +                   int param_id, int psize)
>> +{

...
>> +    ret = afe_apr_send_pkt(afe, data, port);
>> +    if (ret)
>> +        dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
> 
> we should add %s to distinguish different functions with similar error 
> logs. Also, q6afe_port_set_param_v2() can be called for different 
> purpose.  AFE enable for port 0x%x failed is suitable only for port 
> start failure. Error message needs to be updated here.
> 
q6afe_callback already has a extra level of error message which shows 
the opcode and error code in failure cases.

thanks,
srini

>> +               port_id, ret);
>> +
>> +
>> +    return ret;
>> +}
>> +

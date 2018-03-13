Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520949342; cv=none;
        d=google.com; s=arc-20160816;
        b=qf8gGaAxWeOiTjqBYdqzI7wTkgRj/uDfYM2EgvEzux+FbDKZnK5putGEYCkpJQWolW
         iOtcY89zWwBU1NSiYJToze7hL7Da5obhNp1xBVPgE3wdB+hL+W9koHMwYCNPisgp9u/x
         JvwyHmcb+bN0ON9c6mVl0pXy+pvW9Ms81uFGWsa8XWvyJwJ/dd7YXhtwbG++XHDYeAuq
         WpQEtXzn5upPJ7aYZZjuCT/jt6naeL7DNZwu3XT/Z3KydZthfEVy21fBKTXB+lEhxf9F
         UTIh1NCyJQ8u0DQ/To7CD2qBy4xzSxrlQNpXnpyYyK9+pTJlOJ4D8BmUVRTS+7Bhuj/g
         z1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=LFHgJClzCatseGGfs7W+kgk8b/BHSVzdZiuAZzD0Yzk=;
        b=d1EUAROCe75la23Cx75GXZTHoDiSlWjIaGV/TLelTM5yWxhkMzkDNAyUbKZEocG+Vg
         3lxjQ4cMTUtha2H+qAGVtGR5F1vJf9eAVegL5ae4ZwYF2jNPJJEg+6lVZrp1f30m1tEK
         9J7uMTJRoeWKFZXCwqM7pZB07OoLs6dYezlsdFVB/EcCNxQQvKLkTn2RSkQsIGZGCnE4
         SND/lYI6Lh68IUp51hSXJpgyqqLoUAd2BglmNasvv81P6YNQTR/4Gya6PPYeFvUJdnoh
         rJb34o8+774jh4rKBEYccgc5nbcY2WrHSWRZk6XMJr85FADDgUJyc7nLLlaN+2z+z42C
         g3hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f/Ajl07p;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f/Ajl07p;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtUu58CgxnCsP8ZOny4ixQmLwwVpgVn7aDMnQHyU8Ia59BFNugbpzR9M5Tp3UjLUMSHiMlfLw==
Subject: Re: [alsa-devel] [PATCH v4 15/24] ASoC: qdsp6: q6core: Add q6core
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
 <20180310022456.26739-16-srinivas.kandagatla@linaro.org>
 <21207441-4e81-284e-343c-bdeb01c9d06f@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e1d119f8-146a-b549-3dd9-da6d8b0f3e9f@linaro.org>
Date: Tue, 13 Mar 2018 13:55:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <21207441-4e81-284e-343c-bdeb01c9d06f@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515922191950788?=
X-GMAIL-MSGID: =?utf-8?q?1594830978228353011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Rohit for review comments,

On 13/03/18 11:46, Rohit Kumar wrote:
> 
> 
> On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> [..]
>> +static int q6core_get_svc_versions(struct q6core *core)
>> +{
>> +    struct apr_device *adev = core->adev;
>> +    struct apr_hdr hdr = {0};
>> +    int rc;
>> +
>> +    core->get_version_supported = true;
> 
> core->get_version_supported should be set to true only after we get 
> proper response from adsp in callback(). In case,we get wrong response 
> from adsp, memory for g_core->svc_version
>   will not get allocated and there will be NULL pointer dereference in  
> q6core_get_svc_api_info() in below statement

I totally agree with you , this line seems to be a leftover from 
previous patches, It should be removed.

thanks,
srini
> +    } else if (g_core->get_version_supported) {
> +        for (i = 0; i < g_core->svc_version->num_services; i++) {
> 
> 
>> +    hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
>> +                      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
>> +    hdr.pkt_size = APR_HDR_SIZE;
>> +    hdr.opcode = AVCS_GET_VERSIONS;
>> +
>> +    rc = apr_send_pkt(adev, &hdr);
>> +    if (rc < 0)
>> +        return rc;
>> +

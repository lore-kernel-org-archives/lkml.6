Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525845966; cv=none;
        d=google.com; s=arc-20160816;
        b=N2sza0HE/KhFjZisMvuiTUF3L5EideGtDScb4mDgmnye5F+FemfuxcnqJtP3JB1FLv
         hFaX7jrBjOL2ftiAWEklZTU39Y+qF+7w18wW164NfNQlqqIKHTA4pU6DG2tfpdMfe54y
         au6SJfSwkAclvSj6IBFg5IEgux6A9PJp94uKeK83lSql58dh0xh98RiatYVTujy86HkI
         boHEHFkpni5vN0WQviB8fY5k7vpz5HisiC5LnCquRFiXACEyEoFGc+4E19qxwe61Bsi0
         SKqs4pWXcM2ySqX9F0s+HufFvKtbKaRdYIjRxyL8IH6TbGf4IDhSLDTlDBk8J1h3kmft
         18Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=amRFn+xf8OhHynEcDo3FzaSsiXMpGnRuZKs9NmcT600=;
        b=KrgOSXXsznm9GdF3TFkoCtPW1MskusoXDAVrCLroM8Q6dw8GVhQdRaopIyZCU4n4fQ
         Rr54Dgx+jqRNA7U72eZXhJ4X/bN5bqN/W+LE8RZ8Qh0bF113F+KEfwmPPJfmozgysiHO
         V5qTIinPuHNCsbwXiBHiuuqi4C2TTKxkIorLveSwjklNyd+7IzjLGomDvPYH9F8wmurz
         n5RIont2HakTgaB6QYq0TmJ5/FKbRRz/eIMB29aFVs7/corIe74MlyqDMAl7MQJTkLIE
         VkBUUGAweZ15Eygl001OucaVWYAjvQ2zDQN/Y8H0cZCIkGk1rGuDuY468B+FmrnOw8Ul
         OtzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=VnmE/cyC;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=VnmE/cyC;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZppXRIjknqSqMv4SL87KtjMBH9gV8tB9ZOVvuJfZCGIc6bjs8ZCzojOGFnIPT5WRaTz0WYNgA==
Subject: Re: [PATCH v7 08/24] ASoC: qdsp6: q6core: Add q6core driver
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-9-srinivas.kandagatla@linaro.org>
 <46511158-ed1d-7f07-0a8f-b325c088e386@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9ea47387-d849-19e8-1075-74a5e7e11a22@linaro.org>
Date: Wed, 9 May 2018 07:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <46511158-ed1d-7f07-0a8f-b325c088e386@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263616340654821?=
X-GMAIL-MSGID: =?utf-8?q?1599965460521463972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Banajit for the review!

On 04/05/18 20:04, Banajit Goswami wrote:
>> +
>> +static int q6core_callback(struct apr_device *adev, struct 
>> apr_resp_pkt *data)
>> +{
>> +    struct q6core *core = dev_get_drvdata(&adev->dev);
>> +    struct aprv2_ibasic_rsp_result_t *result;
>> +    struct apr_hdr *hdr = &data->hdr;
>> +
>> +    result = data->payload;
>> +    switch (hdr->opcode) {
>> +    case APR_BASIC_RSP_RESULT:{
>> +        result = data->payload;
>> +        switch (result->opcode) {
>> +        case AVCS_GET_VERSIONS:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->get_version_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        case AVCS_CMD_GET_FWK_VERSION:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->fwk_version_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        case AVCS_CMD_ADSP_EVENT_GET_STATE:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->get_state_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        }
>> +        break;
>> +    }
>> +    case AVCS_CMDRSP_GET_FWK_VERSION: {
>> +        struct avcs_cmdrsp_get_fwk_version *fwk;
>> +        int bytes;
>> +
>> +        fwk = data->payload;
>> +        core->fwk_version_supported = true;
>> +        bytes = sizeof(*fwk) + fwk->num_services *
>> +                sizeof(fwk->svc_api_info[0]);
>> +
>> +        core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
>> +        if (!core->fwk_version)
>> +            return -ENOMEM;
> When the above allocation fails,  core->fwk_version_supported will be 
> still true, and q6core_get_fwk_versions() will return 0 (timeout as 
> core->resp_received will not be set to true). This can cause a NULL 
> pointer dereference inside the if() loop pointed below (added comment).
> Please move the line to set core->fwk_version_supported flag to after 
> memset() to copy fwk version info.

Yes, makes sense, I fixed this and other comments in v8.

thanks,
srini
>> +
>> +        memcpy(core->fwk_version, data->payload, bytes);
>> +
>> +        core->resp_received = true;
>> +
>> +        break;
>> +    }
>> +    case AVCS_GET_VERSIONS_RSP: {
>> +        struct avcs_cmdrsp_get_version *v;
>> +        int len;
>> +
>> +        v = data->payload;
>> +        core->get_version_supported = true;
>> + 

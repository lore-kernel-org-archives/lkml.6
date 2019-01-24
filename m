Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4982721872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqs2Jyle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfAXIyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:54:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40203 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAXIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:54:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so2070806wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bh2FUmVddwAQCYJRRsFVs3EK3FSO1m8h2gNcK+jT5aM=;
        b=aqs2Jyle2ijvFGD9nSubBWBENvcvBcHLaxMr6hgaLXp7o1Py/wS2JcXYHEjMkaygaN
         uPTtN72qfSXWMuDgKa4waKU9eiWjDezFJWdIMmEWnXK5B2fKeItYC3nyml6knALRMcYs
         NquhGfENY8BtmLp0Guahh40R4SK84yKOm27zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bh2FUmVddwAQCYJRRsFVs3EK3FSO1m8h2gNcK+jT5aM=;
        b=LtOJjUTGG2wcBsLE2FkhsxuprSH29pc/ssvelh+5VTw5QuFsp2+JfBC5BeRVdzk5c3
         cMlbEF3FtUMgolT9UqmP7RfMOydt9e9nC53YhLMvSfMqAHvRKMpi4fT7VsyLKUkGajr+
         KWNOAZJTtv3nQzmHh1hq+IEus98TGzi/BkZONdjnM9R6accA3FXk/FyKC8AKS9kE+/Qd
         cblcTzTENrR26p1rMG8AnjNrBWzg+caus7Wgnx8ik2JXaBsFejTGGB4BENyqX8zWK5mw
         itn4hEVITR7xXi9kjueC6pv7AKP++Fyzz27p/pqHWg3tOjV5+EEGVXSRpmYcNf/sXtt9
         2J1w==
X-Gm-Message-State: AJcUukftgfthLA0W6AkgVDX5W5mKC//eTRylUtk7GNwAm0flOQ2GcC5J
        QuYhwzArwN6x4BKOVMApRnQGoA==
X-Google-Smtp-Source: ALg8bN7jczByGSm14iW70yoU7yAdgJyGOeKUdtKwURQR8mc+7muZcdwXJemfiroSveEnsZuTduW0BA==
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr1641587wmf.85.1548320074225;
        Thu, 24 Jan 2019 00:54:34 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id c8sm84476090wrx.42.2019.01.24.00.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:54:33 -0800 (PST)
Subject: Re: [PATCH 07/10] venus: helpers: add three more helper functions
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-8-stanimir.varbanov@linaro.org>
 <CAPBb6MVPhpZkCLFhAfPhE83TSpnCjH4Zy4-Mage5s=LkU9_RzA@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <47e2feac-3dbe-280d-0523-2226225a6733@linaro.org>
Date:   Thu, 24 Jan 2019 10:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MVPhpZkCLFhAfPhE83TSpnCjH4Zy4-Mage5s=LkU9_RzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for the review!

On 1/24/19 10:43 AM, Alexandre Courbot wrote:
> On Fri, Jan 18, 2019 at 1:21 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> This adds three more helper functions:
>>  * for internal buffers reallocation, applicable when we are doing
>> dynamic resolution change
>>  * for initial buffer processing of capture and output queue buffer
>> types
>>
>> All of them will be needed for stateful Codec API support.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/helpers.c | 82 +++++++++++++++++++++
>>  drivers/media/platform/qcom/venus/helpers.h |  2 +
>>  2 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
>> index f33bbfea3576..637ce7b82d94 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -322,6 +322,52 @@ int venus_helper_intbufs_free(struct venus_inst *inst)
>>  }
>>  EXPORT_SYMBOL_GPL(venus_helper_intbufs_free);
>>
>> +int venus_helper_intbufs_realloc(struct venus_inst *inst)
> 
> Does this function actually reallocate buffers? It seems to just free
> what we had previously.

The function free all internal buffers except PERSIST. After that the
buffers are allocated in intbufs_set_buffer function (I know that the
function name is misleading).

> 
> 
>> +{
>> +       enum hfi_version ver = inst->core->res->hfi_version;
>> +       struct hfi_buffer_desc bd;
>> +       struct intbuf *buf, *n;
>> +       int ret;
>> +
>> +       list_for_each_entry_safe(buf, n, &inst->internalbufs, list) {
>> +               if (buf->type == HFI_BUFFER_INTERNAL_PERSIST ||
>> +                   buf->type == HFI_BUFFER_INTERNAL_PERSIST_1)
>> +                       continue;
>> +
>> +               memset(&bd, 0, sizeof(bd));
>> +               bd.buffer_size = buf->size;
>> +               bd.buffer_type = buf->type;
>> +               bd.num_buffers = 1;
>> +               bd.device_addr = buf->da;
>> +               bd.response_required = true;
>> +
>> +               ret = hfi_session_unset_buffers(inst, &bd);
>> +
>> +               dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
>> +                              buf->attrs);
>> +
>> +               list_del_init(&buf->list);
>> +               kfree(buf);
>> +       }
>> +
>> +       ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH(ver));
>> +       if (ret)
>> +               goto err;
>> +
>> +       ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH_1(ver));
>> +       if (ret)
>> +               goto err;
>> +
>> +       ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH_2(ver));
>> +       if (ret)
>> +               goto err;
>> +
>> +       return 0;
>> +err:
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(venus_helper_intbufs_realloc);
>> +


-- 
regards,
Stan

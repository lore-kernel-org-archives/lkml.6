Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB8C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAB724001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaZxl9hN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAB724001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeGFMTY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:19:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39191 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:19:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so14221527wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWqXr67z/8MSAZ9RwH1wvU+dHSfz5c0+biK0d/tTB/o=;
        b=LaZxl9hNMZT+RL6Y/WyX7k2Y6LbQJeNDkVbxBt3aiRRPL/Jys+uV1KzrT17SDJkmaa
         Z9a6RtnSVYcTWqFrAQami3z9UcaG8/8nibFVJ65XROEpLaLR6aJN/B7u6Xj6RaW2ax52
         0Q3cNWk9aI6nPU1Of4kvuMQaCTu9u4cYVuvuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWqXr67z/8MSAZ9RwH1wvU+dHSfz5c0+biK0d/tTB/o=;
        b=VGuaA9AzBkHqzBKTipk6ln6DZvGa49PIJ2dVRSmygLLPQoLF6N5YKTYuznefaZ5jR0
         zp6fPymO+3dSfe78VjGrk5nKAv8x1h5eCqb0FpBztDBmRh34ftl7JR0oMxomxCm9a77k
         m27JNY6MlPABTxw+nieo9IIYX7zC1qYxjtdMSkflMzId5kh/caP1TABBzAdT8vOOLVU7
         J9Yk3HN3ih5woFj4vUkc675tzght8hlIS5YElTJ4Q5b6oeFsklxRF9UkrSAPSoDY9ial
         jecU0Ct5U3Lj6pm4Xc9I3dofJQ+1WD3ivIDO7lwmcYKWP0J1s4LOsoJoZto2TzcjZFj5
         Uztw==
X-Gm-Message-State: APt69E0n+aA4+9zSY3ycjRI9UjRGZ4DDOxqC/uA2F9VSVp4wjOnOwuUO
        vwl4HOn/kzJ2MJyzGz3ixMC+jQ==
X-Google-Smtp-Source: AAOMgpe+gFDInU1pqripQ+CyeMD6Bp3r4L42gjiRBaRbOdcB/iniyd0YXawUX/IruNYATn4KWirTbQ==
X-Received: by 2002:a1c:a406:: with SMTP id n6-v6mr6385145wme.29.1530879561105;
        Fri, 06 Jul 2018 05:19:21 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id h102-v6sm13048116wrh.60.2018.07.06.05.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 05:19:20 -0700 (PDT)
Subject: Re: [PATCH v5 12/27] venus: hfi_parser: add common capability parser
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
 <20180705130401.24315-13-stanimir.varbanov@linaro.org>
 <7866a592-1764-a7e6-1149-52d4f070dfd4@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <e2e2b138-9dc9-58d1-4723-83fc90dd9567@linaro.org>
Date:   Fri, 6 Jul 2018 15:19:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7866a592-1764-a7e6-1149-52d4f070dfd4@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 07/06/2018 02:21 PM, Hans Verkuil wrote:
> Hi Stanimir,
> 
> While preparing a pull request I ran smatch and I found some issues with
> hfi_parser.h:
> 
> On 05/07/18 15:03, Stanimir Varbanov wrote:
>> This adds common capability parser for all supported Venus
>> versions. Having it will help to enumerate better the supported
>> raw formats and codecs and also the capabilities for every
>> codec like max/min width/height, framerate, bitrate and so on.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>  drivers/media/platform/qcom/venus/Makefile     |   3 +-
>>  drivers/media/platform/qcom/venus/core.c       |  85 ++++++
>>  drivers/media/platform/qcom/venus/core.h       |  74 ++---
>>  drivers/media/platform/qcom/venus/hfi.c        |   5 +-
>>  drivers/media/platform/qcom/venus/hfi_helper.h |  28 +-
>>  drivers/media/platform/qcom/venus/hfi_msgs.c   | 356 ++-----------------------
>>  drivers/media/platform/qcom/venus/hfi_parser.c | 283 ++++++++++++++++++++
>>  drivers/media/platform/qcom/venus/hfi_parser.h |  45 ++++
>>  drivers/media/platform/qcom/venus/vdec.c       |  38 +--
>>  drivers/media/platform/qcom/venus/venc.c       |  52 ++--
>>  10 files changed, 525 insertions(+), 444 deletions(-)
>>  create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.c
>>  create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.h
>>
> 
> <snip>
> 
>> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.h b/drivers/media/platform/qcom/venus/hfi_parser.h
>> new file mode 100644
>> index 000000000000..2fa4a345a3eb
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/venus/hfi_parser.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2018 Linaro Ltd. */
>> +#ifndef __VENUS_HFI_PARSER_H__
>> +#define __VENUS_HFI_PARSER_H__
>> +
>> +#include "core.h"
>> +
>> +u32 hfi_parser(struct venus_core *core, struct venus_inst *inst,
>> +	       void *buf, u32 size);
>> +
>> +static inline struct hfi_capability *get_cap(struct venus_inst *inst, u32 type)
>> +{
>> +	struct venus_core *core = inst->core;
>> +	struct venus_caps *caps;
>> +	unsigned int i;
>> +
>> +	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
>> +	if (!caps)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	for (i = 0; i < caps->num_caps; i++) {
>> +		if (caps->caps[i].capability_type == type)
>> +			return &caps->caps[i];
>> +	}
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>> +#define CAP_MIN(inst, type)	((get_cap(inst, type))->min)
>> +#define CAP_MAX(inst, type)	((get_cap(inst, type))->max)
>> +#define CAP_STEP(inst, type)	((get_cap(inst, type))->step_size)
>> +
>> +#define FRAME_WIDTH_MIN(inst)	CAP_MIN(inst, HFI_CAPABILITY_FRAME_WIDTH)
>> +#define FRAME_WIDTH_MAX(inst)	CAP_MAX(inst, HFI_CAPABILITY_FRAME_WIDTH)
>> +#define FRAME_WIDTH_STEP(inst)	CAP_STEP(inst, HFI_CAPABILITY_FRAME_WIDTH)
>> +
>> +#define FRAME_HEIGHT_MIN(inst)	CAP_MIN(inst, HFI_CAPABILITY_FRAME_HEIGHT)
>> +#define FRAME_HEIGHT_MAX(inst)	CAP_MAX(inst, HFI_CAPABILITY_FRAME_HEIGHT)
>> +#define FRAME_HEIGHT_STEP(inst)	CAP_STEP(inst, HFI_CAPABILITY_FRAME_HEIGHT)
>> +
>> +#define FRATE_MIN(inst)		CAP_MIN(inst, HFI_CAPABILITY_FRAMERATE)
>> +#define FRATE_MAX(inst)		CAP_MAX(inst, HFI_CAPABILITY_FRAMERATE)
>> +#define FRATE_STEP(inst)	CAP_STEP(inst, HFI_CAPABILITY_FRAMERATE)
>> +
>> +#endif
> 
> When compiling vdec.c and venc.c with smatch I get a whole bunch of:
> 
> drivers/media/platform/qcom/venus/hfi_parser.h:17:14: error: not an lvalue
> drivers/media/platform/qcom/venus/hfi_parser.h:21:16: error: not an lvalue
> drivers/media/platform/qcom/venus/hfi_parser.h:17:14: error: not an lvalue
> drivers/media/platform/qcom/venus/hfi_parser.h:21:16: error: not an lvalue
> 
> To be honest I don't quite understand what is happening here.
> 
> What I DO see is that get_cap can return ERR_PTR, but the CAP_MIN/MAX/STEP macros
> do not test for that. It doesn't feel right, I think it might be better if you
> move get_cap into the source and provide little cap_min/max/step inlines that
> properly test the return code of get_cap and return 0 or something on error.
> 
> This is the command line I use to test with smatch:
> 
> make W=1 C=1 CHECK="smatch -p=kernel" drivers/media/platform/qcom/venus/

thanks for catching!

Do you want a new revisited version of this patch only? Or one patch on
top of the series?

-- 
regards,
Stan

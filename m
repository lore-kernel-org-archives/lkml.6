Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB0BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9D724058
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9D724058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeGFLVM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:21:12 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:42578 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932174AbeGFLVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:21:10 -0400
Received: from [IPv6:2001:983:e9a7:1:c0df:c193:2d8f:16db] ([IPv6:2001:983:e9a7:1:c0df:c193:2d8f:16db])
        by smtp-cloud9.xs4all.net with ESMTPA
        id bOnTfsjzoEJtcbOnUfEkqs; Fri, 06 Jul 2018 13:21:08 +0200
Subject: Re: [PATCH v5 12/27] venus: hfi_parser: add common capability parser
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
 <20180705130401.24315-13-stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7866a592-1764-a7e6-1149-52d4f070dfd4@xs4all.nl>
Date:   Fri, 6 Jul 2018 13:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705130401.24315-13-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfATWKM2E/5MEo+AhT1pxU/Iyxd5VTAzghxx2bKje3OGbSBOBgS3Mc1e4DVP6TiBNtbMmQangjEJ48qYBa8ObJUegO0aQe9dHjUKP0UPyXnKQroNbBpkq
 uARfMxzCA34b4xz3Z3LElr+3Eo2aL/T2X+iZWYYxhja5RzOEr+CDE/xm/gcglA2NrovR43+3NySWD6237+VE9cegnF2tbTleMxPevTLZRoWT6IqGLNTfVLvz
 VXThDce4YkRAyOtBymOkodk7O+8G2MaGoUHGiztakl3nceumbUACnzlFkRMxQn1Ll05S/YzyCGq0nXJ81vR96kmSJu/NHNrTjE8db39po4+oT62KRDLnxW6H
 oabD7uxPFrFtJ6yjlTd+k8x55G8msh415xl1M3J+xsecHmRRYk/hz0tPwTjODtfPbyaaAGdp/YKWJfbnEiz1EMNg5YOdx2pIVYZeJ0L+16LgSX81Qow4IA1Q
 V1cvnhnQLVtt4ofrfA5EwP8JvsuJ0oVSHq0mYfpQVvhktmXSVjV7MCfIp9jj6e43v6zDhx65Jatj8qC5NJ4FKTR6vUBnoc2QBbWwaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

While preparing a pull request I ran smatch and I found some issues with
hfi_parser.h:

On 05/07/18 15:03, Stanimir Varbanov wrote:
> This adds common capability parser for all supported Venus
> versions. Having it will help to enumerate better the supported
> raw formats and codecs and also the capabilities for every
> codec like max/min width/height, framerate, bitrate and so on.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/Makefile     |   3 +-
>  drivers/media/platform/qcom/venus/core.c       |  85 ++++++
>  drivers/media/platform/qcom/venus/core.h       |  74 ++---
>  drivers/media/platform/qcom/venus/hfi.c        |   5 +-
>  drivers/media/platform/qcom/venus/hfi_helper.h |  28 +-
>  drivers/media/platform/qcom/venus/hfi_msgs.c   | 356 ++-----------------------
>  drivers/media/platform/qcom/venus/hfi_parser.c | 283 ++++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_parser.h |  45 ++++
>  drivers/media/platform/qcom/venus/vdec.c       |  38 +--
>  drivers/media/platform/qcom/venus/venc.c       |  52 ++--
>  10 files changed, 525 insertions(+), 444 deletions(-)
>  create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.c
>  create mode 100644 drivers/media/platform/qcom/venus/hfi_parser.h
> 

<snip>

> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.h b/drivers/media/platform/qcom/venus/hfi_parser.h
> new file mode 100644
> index 000000000000..2fa4a345a3eb
> --- /dev/null
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018 Linaro Ltd. */
> +#ifndef __VENUS_HFI_PARSER_H__
> +#define __VENUS_HFI_PARSER_H__
> +
> +#include "core.h"
> +
> +u32 hfi_parser(struct venus_core *core, struct venus_inst *inst,
> +	       void *buf, u32 size);
> +
> +static inline struct hfi_capability *get_cap(struct venus_inst *inst, u32 type)
> +{
> +	struct venus_core *core = inst->core;
> +	struct venus_caps *caps;
> +	unsigned int i;
> +
> +	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
> +	if (!caps)
> +		return ERR_PTR(-EINVAL);
> +
> +	for (i = 0; i < caps->num_caps; i++) {
> +		if (caps->caps[i].capability_type == type)
> +			return &caps->caps[i];
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +#define CAP_MIN(inst, type)	((get_cap(inst, type))->min)
> +#define CAP_MAX(inst, type)	((get_cap(inst, type))->max)
> +#define CAP_STEP(inst, type)	((get_cap(inst, type))->step_size)
> +
> +#define FRAME_WIDTH_MIN(inst)	CAP_MIN(inst, HFI_CAPABILITY_FRAME_WIDTH)
> +#define FRAME_WIDTH_MAX(inst)	CAP_MAX(inst, HFI_CAPABILITY_FRAME_WIDTH)
> +#define FRAME_WIDTH_STEP(inst)	CAP_STEP(inst, HFI_CAPABILITY_FRAME_WIDTH)
> +
> +#define FRAME_HEIGHT_MIN(inst)	CAP_MIN(inst, HFI_CAPABILITY_FRAME_HEIGHT)
> +#define FRAME_HEIGHT_MAX(inst)	CAP_MAX(inst, HFI_CAPABILITY_FRAME_HEIGHT)
> +#define FRAME_HEIGHT_STEP(inst)	CAP_STEP(inst, HFI_CAPABILITY_FRAME_HEIGHT)
> +
> +#define FRATE_MIN(inst)		CAP_MIN(inst, HFI_CAPABILITY_FRAMERATE)
> +#define FRATE_MAX(inst)		CAP_MAX(inst, HFI_CAPABILITY_FRAMERATE)
> +#define FRATE_STEP(inst)	CAP_STEP(inst, HFI_CAPABILITY_FRAMERATE)
> +
> +#endif

When compiling vdec.c and venc.c with smatch I get a whole bunch of:

drivers/media/platform/qcom/venus/hfi_parser.h:17:14: error: not an lvalue
drivers/media/platform/qcom/venus/hfi_parser.h:21:16: error: not an lvalue
drivers/media/platform/qcom/venus/hfi_parser.h:17:14: error: not an lvalue
drivers/media/platform/qcom/venus/hfi_parser.h:21:16: error: not an lvalue

To be honest I don't quite understand what is happening here.

What I DO see is that get_cap can return ERR_PTR, but the CAP_MIN/MAX/STEP macros
do not test for that. It doesn't feel right, I think it might be better if you
move get_cap into the source and provide little cap_min/max/step inlines that
properly test the return code of get_cap and return 0 or something on error.

This is the command line I use to test with smatch:

make W=1 C=1 CHECK="smatch -p=kernel" drivers/media/platform/qcom/venus/

I use smatch from here:

https://git.linuxtv.org/mchehab/smatch.git/

Otherwise everything looked good for this series, but I think this needs to
be fixed.

Regards,

	Hans

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeEaJUV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:20:21 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41974 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeEaJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:20:19 -0400
X-Google-Smtp-Source: ADUXVKJRnf4rGYFRP2xHEP0LIrYFtU4mpW5QncyOhDoT+icsH66rr736GRNzrw/Vw/lAOrPS4R2S/Q==
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org> <20180515075859.17217-24-stanimir.varbanov@linaro.org>
In-Reply-To: <20180515075859.17217-24-stanimir.varbanov@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 May 2018 18:20:04 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CGiB-7kQ8tWBw69cceu6+9mdhrW9ohHCfcVcWbJLbGfg@mail.gmail.com>
Message-ID: <CAAFQd5CGiB-7kQ8tWBw69cceu6+9mdhrW9ohHCfcVcWbJLbGfg@mail.gmail.com>
Subject: Re: [PATCH v2 23/29] venus: helpers: add a helper to return opb
 buffer sizes
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 5:02 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Add a helper function to return current output picture buffer size.
> OPB sizes can vary depending on the selected decoder output(s).
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.h    | 10 ++++++++++
>  drivers/media/platform/qcom/venus/helpers.c | 15 +++++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>  3 files changed, 26 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 255292899204..4d6c05f156c4 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -234,6 +234,11 @@ struct venus_buffer {
>   * @num_output_bufs:   holds number of output buffers
>   * @input_buf_size     holds input buffer size
>   * @output_buf_size:   holds output buffer size
> + * @output2_buf_size:  holds secondary decoder output buffer size
> + * @dpb_buftype:       decoded picture buffer type
> + * @dpb_fmt:           decodec picture buffre raw format

typo: s/decodec/decoded/ and s/buffre/buffer/

> + * @opb_buftype:       output picture buffer type
> + * @opb_fmt:           output picture buffer raw format
>   * @reconfig:  a flag raised by decoder when the stream resolution changed
>   * @reconfig_width:    holds the new width
>   * @reconfig_height:   holds the new height
> @@ -282,6 +287,11 @@ struct venus_inst {
>         unsigned int num_output_bufs;
>         unsigned int input_buf_size;
>         unsigned int output_buf_size;
> +       unsigned int output2_buf_size;
> +       u32 dpb_buftype;
> +       u32 dpb_fmt;

These 2 don't seem to be used.

Best regards,
Tomasz

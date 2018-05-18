Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeERI5Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:57:24 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36135 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeERI5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:57:20 -0400
X-Google-Smtp-Source: AB8JxZpYoM7e+PCY7QANmUMDQ/88ogyNrSFA0OWuJEz0oHbg7WBbsON4XMT3m+nqVud/krwJw8tZ9Q==
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org> <20180515075859.17217-2-stanimir.varbanov@linaro.org>
In-Reply-To: <20180515075859.17217-2-stanimir.varbanov@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 18 May 2018 17:57:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C+S0admv8qVc-e+xBGwxku8+jF7WXKmt2qzD1NEtq8yA@mail.gmail.com>
Message-ID: <CAAFQd5C+S0admv8qVc-e+xBGwxku8+jF7WXKmt2qzD1NEtq8yA@mail.gmail.com>
Subject: Re: [PATCH v2 01/29] venus: hfi_msgs: correct pointer increment
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

On Tue, May 15, 2018 at 5:13 PM Stanimir Varbanov <
stanimir.varbanov@linaro.org> wrote:

> Data pointer should be incremented by size of the structure not
> the size of a pointer, correct the mistake.

> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_msgs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c
b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index 90c93d9603dc..589e1a6b36a9 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -60,14 +60,14 @@ static void event_seq_changed(struct venus_core
*core, struct venus_inst *inst,
>                          frame_sz = (struct hfi_framesize *)data_ptr;
>                          event.width = frame_sz->width;
>                          event.height = frame_sz->height;
> -                       data_ptr += sizeof(frame_sz);
> +                       data_ptr += sizeof(*frame_sz);
>                          break;
>                  case HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT:
>                          data_ptr += sizeof(u32);
>                          profile_level = (struct hfi_profile_level
*)data_ptr;
>                          event.profile = profile_level->profile;
>                          event.level = profile_level->level;
> -                       data_ptr += sizeof(profile_level);
> +                       data_ptr += sizeof(*profile_level);
>                          break;
>                  default:
>                          break;
> --
> 2.14.1


(Posted to v1 originally, since I missed v2.)

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gX1ADMKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45D256070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeFFTKc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:10:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36415 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeFFTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:10:31 -0400
X-Google-Smtp-Source: ADUXVKLgVbcZd3YRnR/IL8RrzfMyWvCmqJBIWxQqHFXjHzX3UG2e8nCzJTOC0rRYonAwKdHlgTlpsxizlculhyB/Stw=
MIME-Version: 1.0
In-Reply-To: <1527851302-5843-1-git-send-email-suzuki.poulose@arm.com>
References: <1527851302-5843-1-git-send-email-suzuki.poulose@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 6 Jun 2018 13:10:29 -0600
Message-ID: <CANLsYkyhJFrNtc7PDY0XNQoiHW8sHW+kJiaUPoWqPwCZM-R_Tw@mail.gmail.com>
Subject: Re: [PATCH] coresight: Fix check in coresight_tmc_etr_buf_insert_barrier_packet
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 June 2018 at 05:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> We request for "CORESIGHT_BARRIER_PKT_SIZE" length and we should
> be happy when we get that size.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>
> Mathieu,
>
> Please could you pull this patch, if you are happy with it ?
> This fixes a problem in the ETR buf series, which I just
> noticed while testing the part2 of the series.

I will pick up the change - you will see it being queued when the
first rc comes out.

>
> Suzuki
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index e2bcef3..c736250 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -862,7 +862,7 @@ tmc_etr_buf_insert_barrier_packet(struct etr_buf *etr_buf, u64 offset)
>
>         len = tmc_etr_buf_get_data(etr_buf, offset,
>                                    CORESIGHT_BARRIER_PKT_SIZE, &bufp);
> -       if (WARN_ON(len <= CORESIGHT_BARRIER_PKT_SIZE))
> +       if (WARN_ON(len < CORESIGHT_BARRIER_PKT_SIZE))
>                 return -EINVAL;
>         coresight_insert_barrier_packet(bufp);
>         return offset + CORESIGHT_BARRIER_PKT_SIZE;
> --
> 2.7.4
>

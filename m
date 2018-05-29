Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeE2ETL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:19:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36376 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeE2ETI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:19:08 -0400
X-Google-Smtp-Source: AB8JxZqYd8kPrfea4ygPkJx4Nqsqolk0waDq/zrL4WWyNw5ZkiVe7jHeaLM6B/PLqNNYwI3KUN/vzA==
Date: Mon, 28 May 2018 21:20:47 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ramon Fried <ramon.fried@gmail.com>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5: don't auto boot remote processor
Message-ID: <20180529042047.GE2259@tuxbook-pro>
References: <20180524192141.20323-1-ramon.fried@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524192141.20323-1-ramon.fried@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 May 12:21 PDT 2018, Ramon Fried wrote:

> Sometimes that rmtfs userspace module is not brought
> up fast enough and the modem crashes.
> disabling automated boot in the driver and triggering
> the boot from user-space sovles the problem.
> 
> Signed-off-by: Ramon Fried <ramon.fried@gmail.com>

Thanks for your patch Ramon. While this nudges the behavior to make
things work slightly better I think we need to describe the explicit
dependency between the mss firmware and the existence of rmtfs.

As our remoteprocs are essentially always-on I would prefer that they
start "automatically" and not through use of the sysfs interface.

But we're at the point where this is a real problem on 410, 820 and 845,
so we have to come up with some way to tie these pieces together. If
your patch suits that solution I will happily take it.

Regards,
Bjorn

> ---
>  drivers/remoteproc/qcom_q6v5_pil.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index cbbafdcaaecb..719ee96445b3 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -1133,6 +1133,8 @@ static int q6v5_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	rproc->auto_boot = false;
> +
>  	qproc = (struct q6v5 *)rproc->priv;
>  	qproc->dev = &pdev->dev;
>  	qproc->rproc = rproc;
> -- 
> 2.17.0
> 

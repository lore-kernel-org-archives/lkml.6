Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDYErW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:47:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43315 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeDYErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:47:18 -0400
X-Google-Smtp-Source: AIpwx4/S0ViO8pW6lEBFgb/16UzzVi4JBbTP7LU6CfCxX6xu0P0KwmnKzJnQr9w4AUM+I8RLUe2NFQ==
Date: Tue, 24 Apr 2018 21:48:26 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: andy.gross@linaro.org, clew@codeaurora.org, aneela@codeaurora.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] soc: qcom: smem: fix off-by-one error in
 qcom_smem_alloc_private()
Message-ID: <20180425044826.GH2052@tuxbook-pro>
References: <20180410222542.29474-1-elder@linaro.org>
 <20180410222542.29474-5-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410222542.29474-5-elder@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Apr 15:25 PDT 2018, Alex Elder wrote:

> It's OK if the space for a newly-allocated uncached entry actually
> touches the free cached space boundary.  It's only a problem if it
> would cross it.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/smem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 82f0908b90e1..0ed263055988 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -375,7 +375,7 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  
>  	/* Check that we don't grow into the cached region */
>  	alloc_size = sizeof(*hdr) + ALIGN(size, 8);
> -	if ((void *)hdr + alloc_size >= cached) {
> +	if ((void *)hdr + alloc_size > cached) {
>  		dev_err(smem->dev, "Out of memory\n");
>  		return -ENOSPC;
>  	}
> -- 
> 2.14.1
> 

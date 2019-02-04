Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A7AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57B9207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549279160;
	bh=R88YbzfpfiULuSjvVuN7QKbxSeUsow8kQePBOQ6p9JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZsIglF0bFO9NoPL+YorsicVXmbHiZGtHXDyy8fTNkGJOepMz1fEi9kEVgi1j/C8Mv
	 YZ6SqWWJWZEgStiK/Rgm6MZoYcWiipYe557d8CsD7zm1anWqVuhIfVKAc0Jxa77fdB
	 l4e/G67HufcBU284r+85FIYvL4+HFlO/XCa/8rYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfBDLTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbfBDLTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:19:18 -0500
Received: from localhost (unknown [171.76.74.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8DEB207E0;
        Mon,  4 Feb 2019 11:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549279157;
        bh=R88YbzfpfiULuSjvVuN7QKbxSeUsow8kQePBOQ6p9JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXefLXja6+nLPiVzAcyrjeP79vRAXBI16Hog801UyegKEDPSybVs/E9elBd/LtkNC
         J3zFB+p8ezWign8qBvY0bJLcFZa7u8kBJni/SSHGgTNQ1hOXQPCsF8MYZEFT/5hEao
         gz5z2I6Oscjz0kSm5dYw8trmTfmUs5t49aotDgXg=
Date:   Mon, 4 Feb 2019 16:49:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: qcs404: Correct SDC tile
Message-ID: <20190204111908.GO4296@vkoul-mobl>
References: <20190131172953.27339-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131172953.27339-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-19, 09:29, Bjorn Andersson wrote:
> The SDC controls live in the south tile, not the north one. Correct this
> so that we program the right registers.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Cc: stable@vger.kernel.org
> Fixes: 22eb8301dbc1 ("pinctrl: qcom: Add qcs404 pinctrl driver")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qcs404.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> index 7aae52a09ff0..4ffd56ff809e 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> @@ -79,7 +79,7 @@ enum {
>  		.intr_cfg_reg = 0,			\
>  		.intr_status_reg = 0,			\
>  		.intr_target_reg = 0,			\
> -		.tile = NORTH,				\
> +		.tile = SOUTH,				\
>  		.mux_bit = -1,				\
>  		.pull_bit = pull,			\
>  		.drv_bit = drv,				\
> -- 
> 2.18.0

-- 
~Vinod

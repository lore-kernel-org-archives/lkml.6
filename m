Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEE9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FF420C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gc6RA7WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FF420C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeGJVQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:16:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42512 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732329AbeGJVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:16:52 -0400
Received: by mail-pl0-f67.google.com with SMTP id f4-v6so3962229plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mh3Z72VNqPUMJiv5SXqd+5LjqvcneonWKzqiCoMrX2c=;
        b=Gc6RA7WZtDyKigySLiFckKgvtuIMNDEsoEftDLsq2WjWIt18A3m5D3iwmwJQaSImIL
         XrW6NImIVu00w26Ici752dLGyhO/AMgdwc7I2Bb4fD442YIv9bZxMv5Y/ojJ1uVCG78S
         X2tODIYbg2eRHsT31jK3TTsdexMB7LFcaNPRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mh3Z72VNqPUMJiv5SXqd+5LjqvcneonWKzqiCoMrX2c=;
        b=dKIACi4zH/Pj1glrZ1fPlBY6yiSb1tNWfros6JRu5GOz8gvaYbK/uWtyFe64Te8xL9
         rCjgEn2WQsDgsGkCJWU8VVks1Hz5LecW0BOVAEo/EV4fB5nmv6EtXJ773605UYB6A2Bh
         MUcQtmE5cgATpP5duf9d315iN8zKST5wdIQ4Sia/wwoHrbuFP83xwBs5eMeAD5YuoWkj
         d6gZUtios6fsCJaLxwy3GECOQhxHenihO6XCTN81xUFciUvTdl2KlC2BADWsa0oFhSOs
         KFkZSKZen6xWNqU42sMvCeYGea8HuC3MA+8szfrmwWza/hHUN/Gk7ur7SQyEzY4LmQ17
         PpRg==
X-Gm-Message-State: APt69E2zJkFtOMakGvj2MacgBen1I2hSv10/cx/DdrfTNkRpUlXQEldO
        rAG7DgtJDXQ9KDeqWUdVlv6msg==
X-Google-Smtp-Source: AAOMgpePLgMyC59tanwFkFtSENrIeVnoTAqSgRpg7MYX6u+B84g1w4CY8P7srBVUjj5Lq2hz6YR64Q==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9-v6mr25459847plo.1.1531256960142;
        Tue, 10 Jul 2018 14:09:20 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y15-v6sm28696739pfm.136.2018.07.10.14.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 14:09:19 -0700 (PDT)
Date:   Tue, 10 Jul 2018 14:09:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-pil: fix modem hang on SDM845
 after axis2 clk unvote
Message-ID: <20180710210931.GA5090@builder>
References: <20180709151220.12641-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709151220.12641-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 08:12 PDT 2018, Sibi Sankar wrote:

> GCC_MSS_AXIS2 clock is used for disabling boot IMEM (a part of
> AP boot up). With Boot IMEM disable now a part TZ/ATF, AXIS2
> clock is no longer required post AP boot up and expected to
> remain untouched. However if the clock is turned ON after Q6
> is brought out of reset and later turned off, it results in
> modem hang. When Q6 attempts a power collapse the internal
> handshaking to check if AXIS2 is idle never goes through since
> it is turned off preventing the RSC from getting triggered,
> leaving modem in a funky state. Hence removing AXIS2 clk
> enable/disable from the driver.
> 
> [bjorn: identified unvoting axis2 clk caused modem hang]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Thanks Sibi

Regards,
Bjorn

> ---
>  drivers/remoteproc/qcom_q6v5_pil.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index e04319573c91..d7a4b9eca5d2 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -1243,7 +1243,6 @@ static const struct rproc_hexagon_res sdm845_mss = {
>  	.hexagon_mba_image = "mba.mbn",
>  	.proxy_clk_names = (char*[]){
>  			"xo",
> -			"axis2",
>  			"prng",
>  			NULL
>  	},
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

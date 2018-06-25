Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955FAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47684261AC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIOvECoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47684261AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeFYV6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:58:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39562 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeFYV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:58:12 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so14578340itp.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l1QdscZ3gQJu2ZqZs5mDMlFdAJ3LQr6mMES2DQK2lTI=;
        b=iIOvECoVLLBac+gJLvQlWZMWlzP3Bdl3XFWRDjnfjGugKcaU1xFhrGxbABZKhE6UEf
         J0Ux5Nccavdb2nP9I+jg4zdHzQlZyPAJC2/xcmvAx3FzyPJ6B9cxU/n9TQMdhN3Km3gD
         659XgckU5NXVQF8R1XMbSS3UgqhZZTxpze3aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l1QdscZ3gQJu2ZqZs5mDMlFdAJ3LQr6mMES2DQK2lTI=;
        b=FpSPtRSvFzus87+fCv3Pk3RiyxfnrHqb1WJRYH1MEq7KW2hNDDF/K3kiDrkJ2LuiwD
         uF2pSSjZnsL2b9rfhqBe550IEdyFsdt+2A0wd165AOcm5nZfNlAW4PtXdct2f8wDa6Jr
         khCXucl4BBUITbjesnifIpEvY+93LEdJ5TcCD/UgVS0oNIyzDrv9wOHEmpxVISZZJR0T
         SSwpjAaSZ6js7dzhafmc3gQy0zoJvfpvFfqgvnEG48aCkLQilrJ8m8reh7iC3BFpaFdw
         BYKXQhxrnJ5SiNtoy22wBgPLD/SkD3mp/14IdOElK6JF55xeCr4ilt407D8AvDt9Damb
         Zgpg==
X-Gm-Message-State: APt69E3BDMRkDU3C2pKRTIaEYUIIMerQrvddBn2gdTzyq9SvxFB3CWCx
        OXSavyd7QhkEGUoMP9LB/Es/OvIZPbo=
X-Google-Smtp-Source: ADUXVKI7oOCQPZhQXhMnPO3g6gW0yUwTxVghE+J+7ufDsJ0OA4Xb/JzUtMWQOyjmnd465JWNghuNzw==
X-Received: by 2002:a02:1245:: with SMTP id i66-v6mr3625928jad.37.1529963891583;
        Mon, 25 Jun 2018 14:58:11 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id n4-v6sm6713023ioc.76.2018.06.25.14.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 14:58:10 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: smem: Correct check for global partition
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180625200613.20245-1-bjorn.andersson@linaro.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <983a7c61-fecc-91dc-a75b-8b1b409a8393@linaro.org>
Date:   Mon, 25 Jun 2018 16:58:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625200613.20245-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 03:06 PM, Bjorn Andersson wrote:
> The moved check for the global partition ended up in the wrong place and I
> failed to spot this in my review. This moves it to the correct place.

Whoops.  That's strange.  The description explains what it was supposed
to do.  And what got committed is actually what I sent...  Hmmm.  I bet
quilt did a fuzzy refresh and I neglected to verify the result was correct.
Or more likely, I just did something stupid.

In any case, this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Fixes: 11d2e7edac6a ("soc: qcom: smem: check sooner in qcom_smem_set_global_partition()")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/soc/qcom/smem.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 70b2ee80d6bd..bf4bd71ab53f 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -364,11 +364,6 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
>  	end = phdr_to_last_uncached_entry(phdr);
>  	cached = phdr_to_last_cached_entry(phdr);
>  
> -	if (smem->global_partition) {
> -		dev_err(smem->dev, "Already found the global partition\n");
> -		return -EINVAL;
> -	}
> -
>  	while (hdr < end) {
>  		if (hdr->canary != SMEM_PRIVATE_CANARY)
>  			goto bad_canary;
> @@ -736,6 +731,11 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
>  	bool found = false;
>  	int i;
>  
> +	if (smem->global_partition) {
> +		dev_err(smem->dev, "Already found the global partition\n");
> +		return -EINVAL;
> +	}
> +
>  	ptable = qcom_smem_get_ptable(smem);
>  	if (IS_ERR(ptable))
>  		return PTR_ERR(ptable);
> 


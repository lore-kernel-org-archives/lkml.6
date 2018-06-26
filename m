Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59919C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121C7267E9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOYWQ6j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121C7267E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934157AbeFZJgO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:36:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39561 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933481AbeFZJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:36:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id q6-v6so1962792lfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KPTmWE0TZni5SmHj1/CdFBVEFFCe1mDBs0oOrKeaOUw=;
        b=EOYWQ6j6KOYSzKMSt6E2oCJz6cg5vHcs6rkoZAjJg15/boLWditLMSsVVC8rp0dOrd
         6aosrdDc+i+bsw8cnNu9O9kwwoMAG6W80BDxWkJBq/+hj/bekiJoZFfPavaqr9Ow6HWb
         gmXB+08XjzuvjIXJ/OUr2AcTFx9m0xN2WJtb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPTmWE0TZni5SmHj1/CdFBVEFFCe1mDBs0oOrKeaOUw=;
        b=N8C0CkJOiGD/rVs4wy/g7cdkMYbHut9IOwgJ1gUmqT+y3RJVPkVNrb9GEwnQqW1Q5u
         rbh1fw4pMqtEDOrfwV9Swz+Bf9n6p+yASlLCm4CNT60liJiljHmFLzfu3D4SXOsGNlGt
         +TkFdmRUWr7TKuYT5sC5QsIaQAkLOTDto3bkvFQCTlShr6gR9Z58jCC5Q5Iav/uuYUjc
         gXP+bP2S93gotRYccykRHaP9vlkbZgxtpozMftE08zHfBmfKKT037MarG3a83zMU1+I2
         pgmXvq4xeIzVBKfveimjR73/gd9xYaGRcfT71D8qYmi06MBx8BvaBIH7kSi6SaCdvJaB
         umbA==
X-Gm-Message-State: APt69E3i1ZKrr7DMCjWRK0U6C5O/KmyxC02Qg/D6pbGxA2k/IaS5arN0
        ORSuFg1mOR2VW3ZgfxMd2x/2mg==
X-Google-Smtp-Source: AAOMgpfTBRrUzBQGHutw8qoS+eVl1EeIEx63/QiT05nZPbUIDbvv2vCKlnSBcqHmvfLhzLGT4QbK3w==
X-Received: by 2002:a19:1586:: with SMTP id 6-v6mr721774lfv.51.1530005771083;
        Tue, 26 Jun 2018 02:36:11 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id p16-v6sm175802lji.20.2018.06.26.02.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:36:10 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:36:08 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/12] ASoC: qdsp6: q6routing: add proper error check
Message-ID: <20180626093608.GG25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-12-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-12-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:15AM +0100, Srinivas Kandagatla wrote:
> q6adm_open can return error pointer or a null in error cases.
> Fix the return handling.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6routing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
> index ab696bf8d1d3..c80fdbc2442e 100644
> --- a/sound/soc/qcom/qdsp6/q6routing.c
> +++ b/sound/soc/qcom/qdsp6/q6routing.c
> @@ -310,7 +310,7 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
>  			      session->channels, topology, perf_mode,
>  			      session->bits_per_sample, 0, 0);
>  
> -	if (!copp) {
> +	if (IS_ERR_OR_NULL(copp)) {
>  		mutex_unlock(&routing_data->lock);
>  		return -EINVAL;
>  	}
> -- 
> 2.16.2
> 

Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45009C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04E6267EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5ihI1jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04E6267EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934248AbeFZJgr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:36:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39258 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbeFZJgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:36:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id t7-v6so6736794ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oJ5x+I5MhVhVtKmcHchxMIGyRLfRU1JfgSA/H4hpY8M=;
        b=Q5ihI1jSr86q3bzsGxlGBN7bX8u/k7Np7Shm7tFDqFtr1Dp87RK5pKDsQN9oqk6esb
         /9Ija4UlPxjQZ4ftB3cUkbsCHmKvlvD+k7i6VM9a6X2WqQdsGZwQ+jTcbkhzJw+cm4k2
         AOViCS8r80ySZWNIiW4qTFrrni0+Iyf89HiIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJ5x+I5MhVhVtKmcHchxMIGyRLfRU1JfgSA/H4hpY8M=;
        b=hBzfCvwp4Ma5quKQD3J0zmSRs0D06jAWUTtuP3zpA5E6qbussEkMSVY23TOF2XO4IS
         Edz583X8ztQuVZOm2NybNkWN6DWab5hPNmd0B5SiXrAoxH1Iq4Tuf8RnvWw8TyeDwzCj
         CG+LAMJqjrKPkx5nrfRApmd8p2BqegbUlJRoUG4i0DaWLzuBih7Zas+TlwWvyCCu0yAd
         Oh5Z4rC2gp6FKrranvQawglYOB8zXwsWKs0E3f5mOxETw1w5eyll3gNUHEfEH/bp8U6N
         PJT0b3MmTFK+pMbXbgdRR1rIEjFAaNXFHeva48+0AoJUkQ4jE2uk0te71glog3RtClws
         ncoQ==
X-Gm-Message-State: APt69E2Uv4JREvvxjTNAlgq+6qb3J6kAWaK/96srH/PgP8FgmBS9g97m
        zpWNimpCLIsmBgm1W5OR7WTv/w==
X-Google-Smtp-Source: AAOMgpf7Af5F/1hCLdTBBAuKC2je3qEmQS1TGEjZ3RlxkimmSjjzXzzAlgJpG3XIfR2Fu6Oq7A/0hQ==
X-Received: by 2002:a2e:712:: with SMTP id 18-v6mr588616ljh.37.1530005803961;
        Tue, 26 Jun 2018 02:36:43 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id l10-v6sm175705ljh.34.2018.06.26.02.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:36:43 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:36:41 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/12] ASoC: qdsp6: q6asm: remove unused struct q6asm
 member
Message-ID: <20180626093641.GH25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:16AM +0100, Srinivas Kandagatla wrote:
> pcmdev in struct q6asm seems be left over and unused, so just remove it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index c4fd28f168d5..2b2c7233bb5f 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -174,7 +174,6 @@ struct q6asm {
>  	struct device *dev;
>  	struct q6core_svc_api_info ainfo;
>  	wait_queue_head_t mem_wait;
> -	struct platform_device *pcmdev;
>  	spinlock_t slock;
>  	struct audio_client *session[MAX_SESSIONS + 1];
>  };
> -- 
> 2.16.2
> 

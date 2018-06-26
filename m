Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D71C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DBB267DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Std+uG2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DBB267DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934113AbeFZJcw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:32:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933263AbeFZJct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:32:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id t7-v6so6728601ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a16OwTHvyVE63SZhRwW3KLf44hU9K5v7yM0ssTMTY9c=;
        b=Std+uG2TYq+nSsq82sJTh0lLvfalmSAlDn+TNQWl7kqGpUACdIAm8l4IkqbANyGTGb
         Yrl2nPPVgFVA7ozjNIf2NC+SCxJfUTVjdl7fKXCVkKYix53WbZHVfwCS2y8Kn0CqWLn7
         Tv6AznehTQw6TKxJdV5oIA2ibG4LAAFQdL2R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a16OwTHvyVE63SZhRwW3KLf44hU9K5v7yM0ssTMTY9c=;
        b=LiXhxMf+JAv3OwhXwZgxFQ2sw2nb+oZNPuooDBj0uyw0BrsACBaSncpR09vCK1W6J+
         L2HaNTcB0Qa+Y4jXA8KUMiC7nnLomeo9vk3o0PsIlPApr5rLh+YR6N4a0rjEVarqVooh
         steNrWT6d8bLZbeEHIAGyWgExhCNteahK2It4Q7kcAo4a4upxdsMFZhv0+6re6fTLYz9
         eRTC7FCi+71MK/ORV6RloNeMLwSvQH4so1WTu8IhQ7thlvjVTb8q62Tfi53g+nr0noJR
         kTkEUmIZjoh8GYX+kQY/QhTy1lZusvFt+TF/d/S7/CoU4FQxzv6uYjwrIUbSKnItL/9r
         gNQg==
X-Gm-Message-State: APt69E1nKkTKOYx4Lta8T0kAXrlnKQISAEO6LV1El0CdLDx9g/MXLpd7
        dq27LyY+fH99x6POhdACSwyCxw==
X-Google-Smtp-Source: AAOMgpd5ZmoEACYBDwpVKcaCbLA5bWXfby7ijmWAgXzcRMWqttu3V0HtlBuvzFwbn9dYaVqrubzdPw==
X-Received: by 2002:a2e:870d:: with SMTP id m13-v6mr556856lji.139.1530005568034;
        Tue, 26 Jun 2018 02:32:48 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 26-v6sm174487lje.26.2018.06.26.02.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:32:47 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:32:45 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/12] ASoC: qdsp6: q6asm: use
 of_platform_populate/depopulate()
Message-ID: <20180626093245.GC25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-6-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:09AM +0100, Srinivas Kandagatla wrote:
> Now that the child nodes have there own compatible strings,
> Use of_platform_populate/depopulate() instead of less common
> of_platform_device_create()/destroy().
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 530852385cad..c4fd28f168d5 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -177,7 +177,6 @@ struct q6asm {
>  	struct platform_device *pcmdev;
>  	spinlock_t slock;
>  	struct audio_client *session[MAX_SESSIONS + 1];
> -	struct platform_device *pdev_dais;
>  };
>  
>  struct audio_client {
> @@ -1344,7 +1343,6 @@ EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
>  static int q6asm_probe(struct apr_device *adev)
>  {
>  	struct device *dev = &adev->dev;
> -	struct device_node *dais_np;
>  	struct q6asm *q6asm;
>  
>  	q6asm = devm_kzalloc(dev, sizeof(*q6asm), GFP_KERNEL);
> @@ -1359,22 +1357,12 @@ static int q6asm_probe(struct apr_device *adev)
>  	spin_lock_init(&q6asm->slock);
>  	dev_set_drvdata(dev, q6asm);
>  
> -	dais_np = of_get_child_by_name(dev->of_node, "dais");
> -	if (dais_np) {
> -		q6asm->pdev_dais = of_platform_device_create(dais_np,
> -							   "q6asm-dai", dev);
> -		of_node_put(dais_np);
> -	}
> -
> -	return 0;
> +	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
>  static int q6asm_remove(struct apr_device *adev)
>  {
> -	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
> -
> -	if (q6asm->pdev_dais)
> -		of_platform_device_destroy(&q6asm->pdev_dais->dev, NULL);
> +	of_platform_depopulate(&adev->dev);
>  
>  	return 0;
>  }
> -- 
> 2.16.2
> 

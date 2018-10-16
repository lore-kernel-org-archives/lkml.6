Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28739C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D784A208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H8Qkl3d9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D784A208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeJPNan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:30:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34159 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeJPNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:30:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id z25-v6so24472874wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aN5T+E2mtLJusevk4aCR20XhJ6KSSmAGvn90Y5s64Ms=;
        b=H8Qkl3d9QpjfH9y28wqeuXccK27jDAmBDtasEQlIpgAR+8/EmAj+6drKUyn22kIDVY
         at4vD+4w+7yHtRtu3Q6Nrd7GoYIz1CEZH8g5v8JF5+Wz9oKld4VJpOjOk8WrIzBeRP1F
         GakNz7hFN5K8ToKaTJMZ7P6C1zN6dqSHVX1t3wWjoMG+nypJM+ftOF7zea2tcF/Pfb4N
         jxvpwqsMJJJpqGpt43cMgf3x6eiVyX10HpwvnnZmtaLE9RNM5u8PRG22dAALDC6zcpi7
         aEHydPhX/uch7JYaENMrN5icP4r6jFJoDQiWApAdzJnknE5kaPZ3ZL7ry1AfayPh2Hfc
         hDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aN5T+E2mtLJusevk4aCR20XhJ6KSSmAGvn90Y5s64Ms=;
        b=C2YYqZaIsXuE1G/Wa5b5MorvHNOSHechsCp8mwIJQcnSr99GwOIQ7bhZcp0w7Rk/LM
         d7W6Drdg/8j/oPsJN+1a3FgB+dDvD46vX/R3Sf6le2YNlJYFmTop4bvY03l7CTKsaoFk
         q1iij9rrU2grEbtD3I4w0L4e0cInEW2GS2UgrJD/WEfGY4Gk2Xbo15R6+aiy5FKbFFTG
         U6qvXnfS+aB9rl8fZLnUDuZoEEkqY/TDuZrjQnffGQmsA7HPrF4eGeXlameKWyMnrkSl
         LA+ybtHVHeWeoAzdquJ/TN8LNQMzxaUPBBPXaJ7tQ5y9z0/AGgfBtsV9hx/1tbzpPW/K
         9MnQ==
X-Gm-Message-State: ABuFfog46tm3DKAkp0kl/MYG3qnj7JrX5tzlCPFQhIrX8kVJ6K35w1PC
        Ivl6F8yY3mv3zQu3lSGMABlH6w==
X-Google-Smtp-Source: ACcGV63Jnj7paOtmclPeys4PJfV8o82k5s/XkdvkzXq9RKFIPBnBoq/Qqnq+Qgqt6r8tWa1WSXGotA==
X-Received: by 2002:a1c:9a4a:: with SMTP id c71-v6mr15135854wme.71.1539668518077;
        Mon, 15 Oct 2018 22:41:58 -0700 (PDT)
Received: from ziepe.ca ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e133-v6sm13061953wma.42.2018.10.15.22.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 22:41:56 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gCI79-0004rz-KA; Mon, 15 Oct 2018 23:41:55 -0600
Date:   Mon, 15 Oct 2018 23:41:55 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Message-ID: <20181016054155.GA18664@ziepe.ca>
References: <20181015111434.7777-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015111434.7777-1-tomas.winkler@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:14:34PM +0300, Tomas Winkler wrote:
> Ignore the return value of go_to_idle() in tpm_try_transmit().
> Once it may shadow the return value of actual tpm operation,
> second the consequent command will fail as well and the error
> will be caought anyway.
> Last fix wrong goto, that jumped back instead of forward.
> 
> Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from runtime_pm")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>  drivers/char/tpm/tpm-interface.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 129f640424b7..f69c711bf74a 100644
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>  		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
>  
>  out:
> -	rc = tpm_go_idle(chip, flags);
> -	if (rc)
> -		goto out;
> +	(void)tpm_go_idle(chip, flags);

We don't really use this style in the kernel, AFAIK.

Jason

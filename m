Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F832C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C680F248AA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fZZgsvpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C680F248AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeFVUmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:42:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44408 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbeFVUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:42:06 -0400
Received: by mail-pg0-f68.google.com with SMTP id g26-v6so3441202pgn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BcDlNzgSlgWM2DhXa1MNT2YX5MIO73dhfA7J6YrjR1M=;
        b=fZZgsvpl/W9teAbn/M5ShBdSYF2Y389hfV/eceNmU92rGM6Fpuib/WveLZXND7WoP/
         FQ0YY7y817Ve2klPbFuQj66o+sufwmvSw+whv4/lbHxHOn0VW7dFp13nU+woTprdMHjL
         pdMBNqyCn/ODJonD8jgumXocVrVw9r/n+uFQy6fmaTw2Zr2WY4dMd77sArvSZw2v0t6J
         14gKeze28zqjwZ7cz7gAwly5ynauUZbS7WVMdKEx+kJxfYSL1RxRVacC9KvM+qSwoL/v
         CYcXGcBVhA1R6M/+SsEH0/DYMLaahJRn+IU00ZQ7mQXNx3GBRF+NkNUUlPxSD2pFBVXv
         Rf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BcDlNzgSlgWM2DhXa1MNT2YX5MIO73dhfA7J6YrjR1M=;
        b=Q7PaVk4bmAervtQXx5nTw5GaZroeAi4j2lHMYBZDn85XALOz+j/XApa47TexqSbM5d
         wZO3EZzZt9rTrE1nDGhDvV6R85QNG8V/i3y8pCNrInKuZjrWPWSrIgeBhiEXQadK4YHF
         TzvTbdm7ealq+7d1A1U9TMBsggVY73m6Cw+6xis3e7/VKt1XvY8GKwmYzojnyy/Zujsd
         pGy1CwbiTTZrwyWIi4h/GW2Ky7VFzmuw/KEkaV0LEGSQldNXXXTjFH31ghzXTq6CXEva
         9VkamqkjhVibw+7ZV0Iw+ua4SwQ82xFWqTv9KvbWrl2ElYVRlDTqRnT9AqJNe3g9p1ci
         /T8Q==
X-Gm-Message-State: APt69E29ndLJ4tPp7cKd6Bbi5bdBDx1PiS2bNZ83HaCgWqpgTZOfBPai
        rlfvBCHSkjPcBk6PNKIv2CiVwQ==
X-Google-Smtp-Source: ADUXVKJDsupm2DZrwVLvJYN6DM2uU1KzZhU20vZbtL4Hecl5JnPnqR5BJybTJIoECpVQYYpT2ZC3MQ==
X-Received: by 2002:a62:81c5:: with SMTP id t188-v6mr3246308pfd.146.1529700126264;
        Fri, 22 Jun 2018 13:42:06 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id n25-v6sm12589345pff.119.2018.06.22.13.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 13:42:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fWSse-0000rU-MF; Fri, 22 Jun 2018 14:42:04 -0600
Date:   Fri, 22 Jun 2018 14:42:04 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] tpm: rename tpm_chip_find_get() to tpm_get_ops()
Message-ID: <20180622204204.GD19151@ziepe.ca>
References: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
 <20180622164613.1609313-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622164613.1609313-2-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:46:10PM -0400, Stefan Berger wrote:
> Rename tpm_chip_find_get() to tpm_get_ops(). This now matches
> the name of its counter part tpm_put_ops() better.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c      |  4 ++--
>  drivers/char/tpm/tpm-interface.c | 14 +++++++-------
>  drivers/char/tpm/tpm.h           |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..4e83695af068 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -81,7 +81,7 @@ void tpm_put_ops(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
>  /**
> - * tpm_chip_find_get() - find and reserve a TPM chip
> + * tpm_get_ops() - find and reserve a TPM chip
>   * @chip:	a &struct tpm_chip instance, %NULL for the default chip
>   *
>   * Finds a TPM chip and reserves its class device and operations. The chip must
> @@ -92,7 +92,7 @@ EXPORT_SYMBOL_GPL(tpm_put_ops);
>   * %NULL if a chip is not found.
>   * %NULL if the chip is not available.
>   */
> -struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
> +struct tpm_chip *tpm_get_ops(struct tpm_chip *chip)
>  {

It is sort of weird that this returns a tpm_chip, but I think if you
revise the comment it would be OK.

 This function is for internal use only, it supports existing TPM
 callers by accepting NULL, but those callers should be converted to
 pass in a chip directly.

Jason

Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB776C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C70920693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kSUJCaEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C70920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeFTSi5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:38:57 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33854 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeFTSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:38:56 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so218602pgr.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5wXsL0Ig4SUB9xNYiDKgAZlvbBW3n+P3QstZzSccxqA=;
        b=kSUJCaEfmijzEjn1PRDhGvqSR27v5i3ClOedITuLpxyzcDJuuuXD5AOwNAcYHS4qZA
         +RRpZ0NURjceZSTjAELKQCpJiL2RV+CHW2lsONV0FlMGx8VsMQymKzwfdmcTW9Gp7RTa
         uSUt1aILToQKEuIr1Us52q2a0OGpu/uB3nbUvhvnqOOGt9lJLNNugfkvrlYhgRXc8Nsa
         jG6B6ckWRGk7ILC6P6MokTsuhC2qVTMb+p46bleAqcGMkvisiBB1so7sIVNwZ7DdzETE
         TyRQOS6g9IsbuZtLi3yJjNLQiIR5GXhoWZYoDFr1XfRME3MefQ13VbHd+Dest3KYwr7A
         8ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wXsL0Ig4SUB9xNYiDKgAZlvbBW3n+P3QstZzSccxqA=;
        b=B7tzsiBdo70euhttTvJJFwsRbK6cn5El1uP+zlxXjqaJVKDJ2XoUzcxy897JkJBxsM
         TwR8od8ih/fe9B8mNGw5fMUF7Fs0fqrpUIerTKwB2V9+pwD0zuBObTed5iLq5q6srGrQ
         iEH0/9r6fOO0ToVgsJkswB7Y5elDkZG4+NA0eSj084i5ZHeiiv0sN+f/TFYM4TncP78X
         qWvlW165gi5N8Irk7NbqVgeIqvL9l3+sjwBuNfAav1n3I3fsyjP/onG0dvX6StCHmZD+
         3TQNMu+enPJ+nV39nPsuxG/DCmvlmvFj1sZN5vzKUOpOFJWVoOajgKTrs+76Q8MMoXJX
         Uitg==
X-Gm-Message-State: APt69E0jFum3/8T35/8Jy/661GGX1CaEchYzdSmSMjR+rZxBNKbMJHVx
        NqHKjyyD5fmCyjA4WY1F3giacA==
X-Google-Smtp-Source: ADUXVKIE8faCLg7XWhrcZjmHj/yB8Z/87/2vrILUgdOca2nQSVMSLXH9iKjQXJV7CXB7jMkQKks56Q==
X-Received: by 2002:a62:1bc2:: with SMTP id b185-v6mr24099327pfb.225.1529519935793;
        Wed, 20 Jun 2018 11:38:55 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a23-v6sm4351499pfn.113.2018.06.20.11.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 11:38:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fVi0M-0000zA-Dd; Wed, 20 Jun 2018 12:38:54 -0600
Date:   Wed, 20 Jun 2018 12:38:54 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] tpm: Introduce a kref for the tpm_chip
Message-ID: <20180620183854.GC27445@ziepe.ca>
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
 <20180620161948.1464255-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620161948.1464255-2-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:19:43PM -0400, Stefan Berger wrote:
> Introduce a kref for the tpm_chip that we initialize when the tpm_chip has
> been allocated and release before the tpm_chip is to be freed.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c | 24 +++++++++++++++++++-----
>  drivers/char/tpm/tpm.h      |  1 +
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..a933676194a4 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -119,8 +119,24 @@ struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
>  	return res;
>  }
>  
> +static void tpm_chip_free(struct kref *kref)
> +{
> +	struct tpm_chip *chip = container_of(kref, struct tpm_chip, kref);
> +
> +	kfree(chip->log.bios_event_log);
> +	kfree(chip->work_space.context_buf);
> +	kfree(chip->work_space.session_buf);
> +	kfree(chip);
> +}
> +
> +static void tpm_chip_put(struct tpm_chip *chip)
> +{
> +	if (chip)
> +		kref_put(&chip->kref, tpm_chip_free);
> +}
> +
>  /**
> - * tpm_dev_release() - free chip memory and the device number
> + * tpm_dev_release() - free the device number and release reference to chip
>   * @dev: the character device for the TPM chip
>   *
>   * This is used as the release function for the character device.
> @@ -133,10 +149,7 @@ static void tpm_dev_release(struct device *dev)
>  	idr_remove(&dev_nums_idr, chip->dev_num);
>  	mutex_unlock(&idr_lock);
>  
> -	kfree(chip->log.bios_event_log);
> -	kfree(chip->work_space.context_buf);
> -	kfree(chip->work_space.session_buf);
> -	kfree(chip);
> +	tpm_chip_put(chip);
>  }
>  static void tpm_devs_release(struct device *dev)
> @@ -195,6 +208,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  
>  	mutex_init(&chip->tpm_mutex);
>  	init_rwsem(&chip->ops_sem);
> +	kref_init(&chip->kref);
>  
>  	chip->ops = ops;
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 7f2d0f489e9c..098d7dcc04a4 100644
> +++ b/drivers/char/tpm/tpm.h
> @@ -211,6 +211,7 @@ struct tpm_chip {
>  	struct cdev cdev;
>  	struct cdev cdevs;
>  
> +	struct kref kref;

NAK, there is already a kref in struct device, that one must be used.

Jason

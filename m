Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1D844C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DD0208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMYjElAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DD0208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeFMRzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:55:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42125 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeFMRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:55:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id w7-v6so1805648pfn.9;
        Wed, 13 Jun 2018 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=s8oIl8Njyr5FUlaShgpVHuhgTh3S77iE9ZkDjAS+gr4=;
        b=QMYjElAjZTaCZ58YCL/z8JFPxj19xqIgqnS832kKTkIQ5ogbATVClvesDl2/iv6BLQ
         3Jga53qH42aMW4ZpzCxJbda/hJDLsIXW7+QdT/hKscG4S8UyS0GkT9AxZpMQm/jPchFp
         V29ic7c+fOV80wpC4YzNLk+7OcbVWA6RJTt6CS4M1P9W7ns+6X1sngKeMy3LW44MXtyS
         4zn/aF8gKhyZm+ckB13eBjwo+hMUfSSvX671UhHoefJZ2B70OBbscWx5dFfa4saVF1ih
         jZ98gXSLBXTXT+yxolQiJd8GKkRXuJBS6R3klWimU/0RxAuv5zPs741vZI9A6K6j7nFY
         6ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s8oIl8Njyr5FUlaShgpVHuhgTh3S77iE9ZkDjAS+gr4=;
        b=L7HYifnn8payCfEdGgPuh2OIh1iBkfppv2BjkwEmGmWKRnovXvJaeFz70tB6qrznIq
         I5Po36OVFYNDlFY4dq/IM/WVZLJ+1NORxYKqHHA/OaKbG49aJGvfEn711gre8ITKdcxJ
         V3FJeCpGx3RQtfNdHGCdN/0J0P9nzPhLBTk8s6h9Uz/O1qmxjcq08DH/zXqz0E/4uLG1
         4f27hzDLd76Zfnk4uYYH4C+sJUOrx33+qsCSdCW/WUZK5kW5pp3IHsHqFg4x5twhnJjU
         DLu+l9oMTelsFgVzuEb1Yd/eScNAuoxsB3aqqtUQgbFPd5LLuaeeTfcjRKbh887na5bf
         qPYQ==
X-Gm-Message-State: APt69E2Vu6SA0YVFOxCkBiiq+drw6fCbd4RaesHc2t1I/dJOddSKgh1A
        TcH53q7TYVfLKMGtm+aoDkn0Fzuq
X-Google-Smtp-Source: ADUXVKLHUzHuD88h4I35zTykqe+tafKTIvLfUYR9jZ0txWKJJytRttm5xr0T+y+TI15D9DylvsCd2w==
X-Received: by 2002:a62:830e:: with SMTP id h14-v6mr6008557pfe.64.1528912536393;
        Wed, 13 Jun 2018 10:55:36 -0700 (PDT)
Received: from JF-EN-C02V905BHTDF.tld ([12.111.169.54])
        by smtp.gmail.com with ESMTPSA id q11-v6sm4411719pgs.2.2018.06.13.10.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 10:55:35 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] tpm: add support for nonblocking operation
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
 <152882631679.30206.9516257862583104447.stgit@tstruk-mobl1.jf.intel.com>
From:   J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <f2ed324e-8512-5ac1-7e5b-29943bbace53@gmail.com>
Date:   Wed, 13 Jun 2018 10:55:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152882631679.30206.9516257862583104447.stgit@tstruk-mobl1.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/18 10:58 AM, Tadeusz Struk wrote:
> Currently the TPM driver only supports blocking calls, which doesn't allow
> asynchronous IO operations to the TPM hardware.
> This patch changes it and adds support for nonblocking write and a new poll
> function to enable applications, which want to take advantage of this.
>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
snip
.
.
.

> @@ -84,10 +124,9 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   			 size_t size, loff_t *off)
>   {
>   	struct file_priv *priv = file->private_data;
> -	size_t in_size = size;
> -	ssize_t out_size;
> +	int ret = 0;
>   
> -	if (in_size > TPM_BUFSIZE)
> +	if (size > TPM_BUFSIZE)
>   		return -E2BIG;
>   
>   	mutex_lock(&priv->buffer_mutex);
> @@ -97,20 +136,19 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   	 * buffered writes from blocking here.
>   	 */
>   	if (priv->data_pending != 0) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;
>   	}
>   
> -	if (copy_from_user
> -	    (priv->data_buffer, (void __user *) buf, in_size)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EFAULT;
> +	if (copy_from_user(priv->data_buffer, buf, size)) {
> +		ret = -EFAULT;
> +		goto out;
>   	}
>   
> -	if (in_size < 6 ||
> -	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EINVAL;
> +	if (size < 6 ||
> +	    size < be32_to_cpu(*((__be32 *)(priv->data_buffer + 2)))) {
> +		ret = -EINVAL;
> +		goto out;
>   	}
>   
>   	/* atomic tpm command send and result receive. We only hold the ops
> @@ -118,25 +156,48 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   	 * the char dev is held open.
>   	 */
>   	if (tpm_try_get_ops(priv->chip)) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return -EPIPE;
> +		ret = -EPIPE;
> +		goto out;
>   	}
> -	out_size = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> -				sizeof(priv->data_buffer), 0);
>   
> -	tpm_put_ops(priv->chip);
> -	if (out_size < 0) {
> -		mutex_unlock(&priv->buffer_mutex);
> -		return out_size;
> +	/*
> +	 * If in nonblocking mode schedule an async job to send
> +	 * the command return the size.
> +	 * In case of error the err code will be returned in
> +	 * the subsequent read call.
> +	 */
> +	if (file->f_flags & O_NONBLOCK) {
> +		queue_work(tpm_dev_wq, &priv->async_work);
> +		return size;

Apologies for the question, but should there be a mutex_unlock() here?  
It's about the only return statement I am seeing where I cannot tell if 
a mutex_unlock() will be called before return or is needed before 
return.  The rest of the code is pretty obvious the return statements 
are being re-factored to an out: block where the mutex_unlock() will 
always be called before returning.

Thanks,
Jay




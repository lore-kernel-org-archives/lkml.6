Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94476C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443242793C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4WnSZr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443242793C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966586AbeF1Vsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:48:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40973 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966462AbeF1Vsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:48:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so3200272pff.8;
        Thu, 28 Jun 2018 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hj/QP+U3N/9xY/Kq8C67i8jIGODozKLOmzonW1RWRDU=;
        b=F4WnSZr1mMCsYzekxQT6u/g52vZnrCntfr6dGv+YF4de2j4qe/dta+VDT91oOuCYy7
         3O9wtVqSyAHK1398J1euTbOxjSaJ54RYWEoATCKqVpLBxx6p7Zqq1rGrkWvsiqk5IDcj
         NRLwqwjdk2Dln9HuTKlTeMwnmIXYjanID1fAme2uP+4CqW5ntuzTZo2+J6ckoSfPkRyq
         Excy5lg/MQiCVy1tVbAHu1wH6BIm+OmXwEl99AekmAqqNL/sI8Eje6+zQZk/NpXfq00H
         /PQx3pakw03S+l5tAkcFeN/+nZiWLjpR4yMiI3uAJSREmqp/OSmysHQD3jlVm+esOwol
         jPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hj/QP+U3N/9xY/Kq8C67i8jIGODozKLOmzonW1RWRDU=;
        b=f6sjMByx7OeTUktf+muVE4tLN/s7SUm/wCM+KyPE73tyXpDLF+HpJHptS8omxUZhaV
         PZdSDDphKlSY0/IdgPYz2+O1js9kk4vcVi7HqdTNbt9vHN6gXfmHRyrJlD9DXLwzOePy
         EG7vgtzOexDQgjYpwE1Kn6vSHM/aVZA7e5/IcWBnPZgBEB0jjK3wkogabh1nHDBPdOlv
         XQS2upQKyWGJyxjy5FBkiWS+f7i9bCwkVT9cDpg47PRFa7Hc7UkZ9kuVSZ2cEvKmsm2g
         CyzwhgSDfwiDeeJ3mFVonmeJ9/x7fdfdoW3nmLqhR5m8fa2m5WdIFRv+QDvMKmqzIELn
         BufA==
X-Gm-Message-State: APt69E3t9PgBjD6mi73d9WdxIPU0gc5YdAmUJE0ADqp1NZ7rD03eza0Y
        HS2WJKM9GloA3JT6WUCkt/k=
X-Google-Smtp-Source: ADUXVKK7jAMxAqFVDUHHoirT8uFhvKh91AYhz+qNLkk7ejxueBSORglAUSmEiKHSMhUqtwXkfHDAPA==
X-Received: by 2002:a63:7f4e:: with SMTP id p14-v6mr10133363pgn.27.1530222510187;
        Thu, 28 Jun 2018 14:48:30 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id e186-v6sm597898pfc.13.2018.06.28.14.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 14:48:29 -0700 (PDT)
Date:   Fri, 29 Jun 2018 03:18:18 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, lukas@wunner.de,
        Ismail.Kose@maximintegrated.com, vilhelm.gray@gmail.com,
        sean.nyekjaer@prevas.dk, pombredanne@nexb.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: dac: Add AD5758 support
Message-ID: <20180628214818.GA3577@himanshu-Vostro-3559>
References: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:13:32PM +0300, Stefan Popa wrote:
> The AD5758 is a single channel DAC with 16-bit precision which uses the
> SPI interface that operates at clock rates up to 50MHz.
> 
> The output can be configured as voltage or current and is available on a
> single terminal.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
[..]
> +static const int ad5758_dc_dc_ilim[6] = {
> +	150000, 200000, 250000, 300000, 350000, 400000
> +};
[..]
> +int cmpfunc(const void *a, const void *b)
> +{
> +	return (*(int *)a - *(int *)b);
> +}

Since Kbuild hit a Sparse error in this function, I would also like to
add that the above implementation of cmpfunc() is not safe.

For eg: https://wandbox.org/permlink/MqGnA3nVg7eAN4I7

The following will be safer:

static int cmpfunc(const void *a, const void *b)
{
	int arg1 = *(const int*)a;
	int arg2 = *(const int*)b;
	return (arg1 > arg2) - (arg1 < arg2);
}

[..]
> +		index = (int *) bsearch(&tmp, ad5758_dc_dc_ilim,
> +					ARRAY_SIZE(ad5758_dc_dc_ilim),
> +					sizeof(int), cmpfunc);

Thanks.
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology

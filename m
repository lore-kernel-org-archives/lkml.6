Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C6C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE2F21908
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="FYlvjRW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391657AbeLVSaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:30:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42815 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390029AbeLVSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:30:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so7492826lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wRV6ysD8ImKDgeAJ4ToSAl5f/ZtrhzJ0q4tF02birXc=;
        b=FYlvjRW72xHELK+nbLnK+idADzYemL4xb/3MGVX5kAfY3M0FnatKkXa5l6uztO9Gzx
         FQ1ZcXhbeE1piqptc0+nD+SU7Z+OaSya331+8+H4Fe5MfqNV0PPWXzlnKiony4gGILhp
         rCN9Rsv1obGQXd/3lrgWCzh0xYt0tyuNimHGd+ylsdghxn6hwDR95FZexbCx9aYwcV43
         +ouZoLbn/KdqcTc2Xeuly1rO2TjxDxGx0QX7Gn5gti2vnejgivyE1S5e1YnlBdMtIrGV
         JmOXk5Ncp7+glT3mVzLoe71vnvMhTrIKXLHI3iBYjkaBw7KSXZNb6KyIpagKSXlQ6AeN
         jDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wRV6ysD8ImKDgeAJ4ToSAl5f/ZtrhzJ0q4tF02birXc=;
        b=a4dHCBHVaYU4BbMZ18drqMvVCY+Qb4TrzR00JRZ2hItuAt78GAn6nASz5zChIqLf5p
         doTeNIBpyQaz5vXZOtlR5Yw/DEhWqUs28s2gED2PZwLjP6JMdtA8jzlN01RzF3uSkWTC
         1tEWcliFBIU03nCSuBFZtv9iIOpC9gB2Krf6Z0EHIDk3mllJvz9UUqrUA8J4JHkoRSvj
         ZNZPmpaZBmAZkxYeeLjpqPiWOTzozoLYgO5O8rtflaiz9DKHoN1qznbyNfZFM3ZwMSYI
         oqvn+L1CXKxKKVGbaF8Q20cbF/x6J/Q7IXB5X7pFYuxFYQu6jCvkss3qIIOsuT8CRqpA
         V4FQ==
X-Gm-Message-State: AJcUuke0NeaD2jGn7Ts3fzkOqXVcKhGAE3L25AoMIdH1zT5ItonQIyyB
        pAzz0prTcHoNku26JzgrYzu64Z0aQQ0=
X-Google-Smtp-Source: AFSGD/WllA3JRwjo+76y4HiSNsfCK4e46Oh7nps8egu+CCmuSt3OWpk3cdKYyfyIBveEWaePK2lhpQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr4299085lji.93.1545503417057;
        Sat, 22 Dec 2018 10:30:17 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id v5-v6sm5427157lje.78.2018.12.22.10.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 10:30:16 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: fix use-after-free bug
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Igor Konopko <igor.j.konopko@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181222073952.GA11561@embeddedor>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1992ea52-cc13-c704-4653-7fbe667b1c5a@lightnvm.io>
Date:   Sat, 22 Dec 2018 19:30:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181222073952.GA11561@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/18 8:39 AM, Gustavo A. R. Silva wrote:
> Remove one of the calls to function bio_put(), so *bio* is only
> freed once.
> 
> Notice that bio is being dereferenced in bio_put(), hence leading to
> a use-after-free bug once *bio* has already been freed.
> 
> Addresses-Coverity-ID: 1475952 ("Use after free")
> Fixes: 55d8ec35398e ("lightnvm: pblk: support packed metadata")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/lightnvm/pblk-recovery.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 3fcf062d752c..5ee20da7bdb3 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -418,7 +418,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	if (ret) {
>   		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>   		bio_put(bio);
> -		bio_put(bio);
>   		return ret;
>   	}
>   
> 

Thanks Gustavo. I missed that one.

Jens, if possible could you please pick this up?

Happy holidays!



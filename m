Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DAFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC4D26099
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC1zIa4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC4D26099
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965173AbeFYT5J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:57:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43483 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964980AbeFYT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:57:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so6931636pfm.10;
        Mon, 25 Jun 2018 12:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aAwad66trf1BTS6JKDeJUcDCrtiGBzSw8oF+8Pqhnnk=;
        b=kC1zIa4uDYqptnyyK6Lo5lci+gNcz3WvQbEmtVHf4/zbHw53hzxVMrkHKykOIwSsNu
         1i7geZnWsEeT2dI4JNE/gGwu5RfvxiuVFuil0jDmwIaMuQG0y0URZ8UxSCtq/Xv8MkON
         eIhPaxXm6N1Je6EqzcqHltv4BQrJ4mHHEedON66YMn7IXCXO3e+9OQU7qZJ/nxu08Fgw
         idQTMm8su9ZFAH0vuQZRYCzHAH+9QL1u5nw76UQTO9b9Y2U7tGOVdrhfe9eqyQF4koHH
         Q1p4xG9XO1ehugCY8/Ucg5/8sKsLprOHeaTg1iM/PFIIp81GC7V2ZgFvEYoABbC3zAMC
         stcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAwad66trf1BTS6JKDeJUcDCrtiGBzSw8oF+8Pqhnnk=;
        b=gVE8cU7B7Mrkhoda3BObot/77CemFnQ1x94/kp4NDpq3F7+ark5ARJbmnS0n9lWrMa
         bh4S/ylJlqoNQiPUTEth81jEYQwa7Ujb6spsCPrHsuTIENwNtsO61+XbFa9QcnRby/DK
         o6122isFB30jFRZNPSoDRoWYRK5RUJ45VF6ruyc0ArLMV1+qNLtSAM3vzT7qc0u0c8rO
         IkN4gBqOhObHzaJnr7oBKLRUMi3+9XAt3B2yLJgRMh9SB0TNKbYD4/xYrfimbz7TPZ16
         +wb1Fs9qoFYonXFW8q7uvpAla4D0UlGvD1nt0LsiI4gQuijj/J38K2pLYNahFaGYPjO5
         Nh/g==
X-Gm-Message-State: APt69E0N0pAd5KEZGPjdrlzSZc+DZ/ZAxBK6TtFhmCRzwcvRjf7cwAa3
        3BKsQdz9bLl9HmjojEEt0TQ8I41u
X-Google-Smtp-Source: ADUXVKK8C/i3UgLZ7YglAznpoJ0iMAdYzRAv7dAc7hrvPZDUJOxohYlsTkMe/NRSA1gxKiAt4+vB2w==
X-Received: by 2002:a62:5582:: with SMTP id j124-v6mr2087495pfb.20.1529956626820;
        Mon, 25 Jun 2018 12:57:06 -0700 (PDT)
Received: from [10.69.62.13] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n68-v6sm27161628pfk.145.2018.06.25.12.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:57:05 -0700 (PDT)
Subject: Re: [PATCH] scsi_transport_fc: use 64-bit timestamps consistently
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     y2038@lists.linaro.org, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Steffen Maier <maier@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180618153004.1808419-1-arnd@arndb.de>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <cb2a2d5b-3293-8cd8-2d81-5bbc5e7d072c@gmail.com>
Date:   Mon, 25 Jun 2018 12:56:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618153004.1808419-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/2018 8:29 AM, Arnd Bergmann wrote:
> The get_seconds() helper returns an 'unsigned long' value, which can
> overflow on 32-bit architectures. Since the interface we pass it into
> already uses a 64-bit type, we can just use ktime_get_real_seconds()
> instead.
> 
> While we generally prefer local timestamps in CLOCK_MONOTONIC format
> (ktime_get_seconds), this keeps using the CLOCK_REALTIME version
> in order to maintain compatibility with existing code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/scsi_transport_fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index 1da3d71e9f61..bb6de88aa724 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -567,7 +567,7 @@ fc_host_post_event(struct Scsi_Host *shost, u32 event_number,
>   
>   	INIT_SCSI_NL_HDR(&event->snlh, SCSI_NL_TRANSPORT_FC,
>   				FC_NL_ASYNC_EVENT, len);
> -	event->seconds = get_seconds();
> +	event->seconds = ktime_get_real_seconds();
>   	event->vendor_id = 0;
>   	event->host_no = shost->host_no;
>   	event->event_datalen = sizeof(u32);	/* bytes */
> @@ -635,7 +635,7 @@ fc_host_post_vendor_event(struct Scsi_Host *shost, u32 event_number,
>   
>   	INIT_SCSI_NL_HDR(&event->snlh, SCSI_NL_TRANSPORT_FC,
>   				FC_NL_ASYNC_EVENT, len);
> -	event->seconds = get_seconds();
> +	event->seconds = ktime_get_real_seconds();
>   	event->vendor_id = vendor_id;
>   	event->host_no = shost->host_no;
>   	event->event_datalen = data_len;	/* bytes */
> 

looks good

Reviewed-by:  James Smart  <james.smart@broadcom.com>


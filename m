Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE03ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B2F20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="CbtgNfD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B2F20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJYBgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:36:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34938 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYBgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:36:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7-v6so4583816lfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=246Y0pPxHtDV7HciFhstUINfCHjlkJE2NCGTT9I4PpY=;
        b=CbtgNfD9/dylXhhH+IlNWjWCrinU7oiojuYpISKkDMRDlsSMFjqhXIGF3XiW2/EGj8
         Mvblv0ZupCFoJoMbyAxRndtf4tpeh2p4fRxylQcmHkciImbrdumiOyuuMHO0DnWYrdtR
         pAIg9Bp14e1AzsZmI2GII2anHsAWVPVfPQn8Tkyopy11tu9N8TXXdQ8UT7bMHXgf288j
         16VMplvxtVUXcGhwuXQBnxpXJhLCgIXwzXvFzS1CdDmAJLCSoKZrfblof7K/B5JMt4rX
         1ogVc8KK9JBQQRylnoDmlB39DAtTtN8TgorYRZSfDTJLZ+xh8r526+eB5ge8tHxrBAFW
         1u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=246Y0pPxHtDV7HciFhstUINfCHjlkJE2NCGTT9I4PpY=;
        b=GlXay+XJFsPP5lmn6jKnHVHkJWo0XVNRALdqkHCFnXjMd3LN6WuXwQl5ECxfg1wqGO
         8KzpXIv7w+AFPhXhd0q/jeK5HEtUIsGdkNKg6HMdNFv8edjmM2cOLSNJCi4yQ2ntxImh
         7IuBp75EOQmx9LDPtQjFiD8EjRVqWG/tjk/ASn79dgfUSd8ZLBnv501mzv/saCjn+1JQ
         53cWVXgDSvqyNkdei+50Ptr+1TWiTadVS+lOmFqWQoER3fwasBm58VlK4dg+2QWZHaQY
         ONdi5YnKD3E90FQQhIZfrKcpt2LT1YF0pkkGgQhoN+ouSY3yvqpQhy00R/StB+wKm0IH
         qh2g==
X-Gm-Message-State: ABuFfoiG9YkhjQ2LyD9GigxpfeGKOWKFpxY/CeHDd3wiezaf50l54K0P
        scD/m7mjXSWaIcOPWddC9JwT9jbSIag=
X-Google-Smtp-Source: ACcGV62KcHRMdqktwogj00R21Xowx5+74y0+pxt2tRu3mwtJ5LAPbDqa0e5ccBk4raHMVgASb6rRPw==
X-Received: by 2002:a19:e4dc:: with SMTP id x89mr15215215lfi.111.1540400832282;
        Wed, 24 Oct 2018 10:07:12 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.216])
        by smtp.gmail.com with ESMTPSA id v18-v6sm735395lja.26.2018.10.24.10.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 10:07:11 -0700 (PDT)
Subject: Re: [RFC PATCH 4/5] usb: typec: Find the ports by also matching
 against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
 <20181024150525.11552-5-heikki.krogerus@linux.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <4a091620-94fa-5831-6c8c-1690efa0be66@cogentembedded.com>
Date:   Wed, 24 Oct 2018 20:07:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181024150525.11552-5-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/24/2018 06:05 PM, Heikki Krogerus wrote:

> When the connections are defined in firmware, struct
> device_connection will have the fwnode member pointing to
> the device node (struct fwnode_handle) of the requested
> device, and the endpoint will not be used at all in that
> case.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/class.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 5db0593ca0bd..fe6f3a932a88 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -204,15 +204,28 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  	put_device(&adev->dev);
>  }
>  
> -static int __typec_port_match(struct device *dev, const void *name)
> +static int typec_port_fwnode_match(struct device *dev, const void *fwnode)
> +{
> +	return dev_name(fwnode) == fwnode;

   dev_name(dev), maybe?

[...]

MBR, Sergei

Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872CEC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2490820652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt6LGkW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2490820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeIHAnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:43:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41820 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIHAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:43:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so7036547plr.8;
        Fri, 07 Sep 2018 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UPoI3K8ddGaCAcnFy/hakP/pRAFd3rbpgiPWQRu+5Uo=;
        b=Zt6LGkW5tyuoy6itytaa4CNx5sFPm1SoNmkQLQmd3TrsXvUvlNLm7TiQHL5WcoIasz
         GisubVYT8xkzetEKthsPT2nwk+O6moHxPa0kyeFwHYWO2TTHkYw05qqVFy1PMDowQcSV
         k/0LK2Ml8YjI9JejtK6Iwdmt3/axWcumzP0UBK5MxDqzwvU6vXO88z5PbxpLcHBq08DB
         gICY56rFjm6Erz5PUwX6IZmgp+dav6ewnz6iZeIu4h3+1oAu4yk9/4OHjJMaHZ2jSwCl
         k6NvvcAjzoRoZB+26jgQ9bGYgbIuOva3i3KlAe4nfmD5BSnqjZIzCF5usf3bqMi3DRwR
         Z+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPoI3K8ddGaCAcnFy/hakP/pRAFd3rbpgiPWQRu+5Uo=;
        b=FL0Gg1CqAhaPADBp1Xx9ar8P1ZtP+GUlj8HkzZ9VbB1a97O0TRRFTFdGnXO/D/I6k8
         QROWk3o7OHd7I8RWtPzKFFtffBRiAS/lFyOYkObwOd7ibbaagUh7tmqi4FLT844Z07iS
         PfdbatU9ui6RdK/sNiy3UTu/abyYSj78GZRQcitXq1axXP6NUiNu5gh6JZKAzCSEVsA7
         9QqLKT3KfLdHXySMoqdFajgUKk4D215JYxnKH9/ItAgKd6y7DpwtBsCHIQY/sGQymyN5
         91uka5Z+VtvUHlUFFpe6QJ5WGW3rQWzxYsFiswuS3ZEEK5DlAzwjp1fvWa41AocwbkaL
         Awog==
X-Gm-Message-State: APzg51B7shNbxWxsYtQmhvHFPn98kbvkZakrwRmkFttVam2ocrOdW2uU
        sT+jF88bSLcuhAAra0r3RCw=
X-Google-Smtp-Source: ANB0VdawJcSm1bd6AUnyIPk1+ys3pT1lBKN6GXUX4tQcrhsElybCjD/O6exOOYLUadz2H/NbPorNOg==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5-v6mr9768433plt.140.1536350444569;
        Fri, 07 Sep 2018 13:00:44 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h132-v6sm12514269pfc.100.2018.09.07.13.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 13:00:44 -0700 (PDT)
Subject: Re: [PATCH v2] of: __of_update_property_sysfs only call
 __of_sysfs_remove_bin_file if of_node_is_attached
To:     Andre Kalb <Andre.Kalb@sma.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c0bcc2c1-3058-db4d-ca4d-4e56c502891b@gmail.com>
Date:   Fri, 7 Sep 2018 13:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB52394FDB1266388BCE1374E3FC030@AM6PR04MB5239.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andred,

On 09/04/18 08:51, Andre Kalb wrote:
> To prevent warning "kernfs: can not remove '(null)', no directory" if an overlay isn't applied to the active devicetree.
> 
> Using of_remove_property and then of_add_property doesn't show the warning.
> 
> Signed-off-by: Andre Kalb <Andre.Kalb@sma.de>
> ---
> Changes in v2:
>   - Fix typo
> 
>  drivers/of/kobj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c index 7a0a18980b98..962b660e8ad1 100644
> --- a/drivers/of/kobj.c
> +++ b/drivers/of/kobj.c
> @@ -104,7 +104,7 @@ void __of_update_property_sysfs(struct device_node *np, struct property *newprop
>                 struct property *oldprop)
>  {
>         /* At early boot, bail out and defer setup to of_init() */
> -       if (!of_kset)
> +       if (!of_kset || !of_node_is_attached(np))
>                 return;
> 
>         if (oldprop)
> --
> 2.17.1
> 
> 
> ___________________________________________________
> 
> SMA Solar Technology AG
> Aufsichtsrat: Dr. Erik Ehrentraut (Vorsitzender)
> Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert, Pierre-Pascal Urbon
> Handelsregister: Amtsgericht Kassel HRB 3972
> Sitz der Gesellschaft: 34266 Niestetal
> USt-ID-Nr. DE 113 08 59 54
> WEEE-Reg.-Nr. DE 95881150
> ___________________________________________________
> 

What is the calling path that results in the warning?

-Frank

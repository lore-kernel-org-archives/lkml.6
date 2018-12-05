Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E2C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4696220834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgOFkQ1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4696220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeLECsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:48:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46047 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLECsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:48:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so9283462plm.12;
        Tue, 04 Dec 2018 18:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FdhlA/v//Y6Tf84tpCD0uUa6QuVqVr2RpNMvDUyZxtA=;
        b=ZgOFkQ1n8/46F/I0ythX6FqirNzaExf72CrVsEjWLWz8XrbOgdHa3VyxJudcg8Y7O2
         XwMrC/WLsDf0a5g/Eyyi4ZqVQDlblianq08oMP+YdcGfib+gxVuEWRUNF5NyVmmRfNGg
         VJzjysALCawv+kq3e7NAi4TqEfg1qnCZzp0dbRRQJy7FvE0QQVP1WS0x+p08rzKYZolp
         RkbaFYAM+5xqGvJnxqPE9E1qzD4+kkk9c9hjxFZgtrnCu0fdLJzYdoyoAjsAzrHoomry
         Zf6H0yIvblbxmo3+9Z2UsM0WZVpRiXD0rIMuVPKnXea3Q/0bjwqvsnljOUzNZKY2kGTL
         p9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdhlA/v//Y6Tf84tpCD0uUa6QuVqVr2RpNMvDUyZxtA=;
        b=nKDqfNmVG5xjLXXCc7RWyb+UWSukMd7PxL8z9F5w3PGPNITeK3LscPYlk5SgPDEeML
         qmZO4d93msSJkwl/c8+mj5zldNIe4CV8IUpmRK9znnW05lruZEKyrOD2IpXfZE7GcI2h
         k2twnk7bVYmMRROkwjxpRXX1wYIvjVhbo2ZEaNeMMGgkdehp6eap/m3JZhi8zFSx/cuO
         nr7hxq72GJ1vmB2JwJkP9hB4Rs8XCm5UHCv1qA9S57I+9pn3QOY7vy/DBeQ6XZKv8nH7
         67E77Al2SyQUayAqAAajK/FpAKcGH/OZNF0mxDmzkyl/HJE3FxxC6KruM0s6OFwmS8mB
         FU5g==
X-Gm-Message-State: AA+aEWZ1mdMnrDZU1n2EWSPySvFNjtBO4rAQFZ6dxhkTrBcNSVQmgqL+
        DxXVXJYk8UFvsOEtp3PDaPKjpzDP
X-Google-Smtp-Source: AFSGD/URJ6xprat8damhRSAgHDA/+ULEi4+o3l1hGmDCzA5+yE+aIgCXVcvbbqDhE7WB3yjYXu9umg==
X-Received: by 2002:a17:902:227:: with SMTP id 36mr22657065plc.140.1543978080462;
        Tue, 04 Dec 2018 18:48:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e123sm21786116pgc.58.2018.12.04.18.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:47:59 -0800 (PST)
Subject: Re: [PATCH 1/1] watchdog/hpwdt: Do not claim unsupported hardware
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543976538-75532-1-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bdd17fda-00ca-3c7a-81d7-fc08c8c21164@roeck-us.net>
Date:   Tue, 4 Dec 2018 18:47:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543976538-75532-1-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 6:22 PM, Jerry Hoemann wrote:
> Do not claim when SSID 0x0289 as the watchdog features
> are not enabled/validated by the firmware.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9356230..b99ef0a4 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -281,6 +281,17 @@ static int hpwdt_init_one(struct pci_dev *dev,
>   	    dev->subsystem_device == 0x1979)
>   		return -ENODEV;
>   
> +	/*
> +	 * Ignore unsupported hardware
> +	 */
> +	if (dev->vendor == PCI_VENDOR_ID_HP &&
> +	    dev->device == 0x3306 &&
> +	    dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR &&
> +	    dev->subsystem_device == 0x0289) {
> +		dev_info(&dev->dev, "Not supported on this platform\n");
> +		return -ENODEV;
> +	}
> +

Please use a pci_device_id table with PCI_DEVICE_SUB() to create
a blacklist, and pci_match_id() to match against it.

Thanks,
Guenter

>   	if (pci_enable_device(dev)) {
>   		dev_warn(&dev->dev,
>   			"Not possible to enable PCI Device: 0x%x:0x%x.\n",
> 


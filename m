Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B1EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC4021A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqg8LS0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC4021A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbeHFR53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:57:29 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37944 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFR53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:57:29 -0400
Received: by mail-oi0-f66.google.com with SMTP id v8-v6so23029579oie.5;
        Mon, 06 Aug 2018 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NUxULdrAsENRyAZz9hmMd/lFkVRAbPU7a/kClLZEie0=;
        b=fqg8LS0XKJjBceyYkHdw7qpsqd6x7p7SSQ4kTl0UATuG3LOBo1EyprGyCLcChu1N0L
         SwYye7GRtxncc9HgwAMwoxCAvDBXU9JcF3JCKPcgD6KXfmJ/SyvoJg+iBydbq4U0IW6y
         Kk2D/Mu28kSU09yLr5qzbvGQjoZFOurmNRdFMA4dViTHhxLzrfcn7JB05BD5T2ZNe0EU
         i5JgbmU98mL+e/IGQRMkhOh+8dYiVdBzOpW0b7iMClSLkbJqPUI3hKvO3XOmkBVvfQBE
         y+zjph5+tgGkuq3CZHmZfoGgGqaKMtrZRVw/QMGgx6S/XLAR/GOxDqTZDB06VZgYhKlf
         q3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUxULdrAsENRyAZz9hmMd/lFkVRAbPU7a/kClLZEie0=;
        b=Ux34pTmYaRkL7BoBafDKVKaYQJjMRGWvlZ1NDPzBd/hQb0vMCt7603R3MVRhdUl7cm
         gxuUtK4CVMtIZR5jb9MySbd2A4tWKFJ+P1OC7NjLtVMqIHFMmq14EbegXNxhNHGPO+gc
         QTuOwA7p74eBjoq+8KMd5B4VnWy6EUyXIqK1UD8RK0nomEB3CSouvd555M51TrTm+QaK
         ASUhw5ygR3P0hTX9g4m4aOWk6YSrDVHoOhsCu2H1bk1wTaHsnZcoVDqzllUSMFxleS0l
         tbJL7VqYmoSJG7ovrCgYYtxwGO2qFS5mXrrU4Jcc4wL+iju6LYvKM5eJdJ0eBzdimlIV
         Z4Xg==
X-Gm-Message-State: AOUpUlE2Y+KhsM7GHmb6hVWvESKt2GBAa59LCw4e7mMM48IL9SFnQobb
        4YvIRqIrB6YCDZoZ0R3dG5s44hr1
X-Google-Smtp-Source: AAOMgpdhO41O++DSlvfQh7rH8ZXw0lGRXaXp+qPPwHbBUNq5G8OTZxbqToDKbmZo1lNtdPb3v5aYSA==
X-Received: by 2002:aca:847:: with SMTP id 68-v6mr16276184oii.312.1533570466713;
        Mon, 06 Aug 2018 08:47:46 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p7-v6sm10445656oif.35.2018.08.06.08.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 08:47:45 -0700 (PDT)
Subject: Re: [PATCH][usb-next] USB: typec: fsusb302: remove unused variables
 snk_pdo and toggling_mode_name
To:     Colin King <colin.king@canonical.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180806111414.9436-1-colin.king@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <554613b4-daec-7db6-d770-7e222ab8d23b@roeck-us.net>
Date:   Mon, 6 Aug 2018 08:47:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806111414.9436-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 04:14 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables snk_pdo and toggling_mode_name are defined but are not used and
> hence can be removed.
> 
> Cleans up clang warnings:
> warning: 'snk_pdo' defined but not used [-Wunused-const-variable=]
> warning: 'toggling_mode_name' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/fusb302/fusb302.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
> index 82bed9810be6..ad7cfed1cea7 100644
> --- a/drivers/usb/typec/fusb302/fusb302.c
> +++ b/drivers/usb/typec/fusb302/fusb302.c
> @@ -48,13 +48,6 @@ enum toggling_mode {
>   	TOGGLING_MODE_SRC,
>   };
>   
> -static const char * const toggling_mode_name[] = {
> -	[TOGGLINE_MODE_OFF]	= "toggling_OFF",
> -	[TOGGLING_MODE_DRP]	= "toggling_DRP",
> -	[TOGGLING_MODE_SNK]	= "toggling_SNK",
> -	[TOGGLING_MODE_SRC]	= "toggling_SRC",
> -};
> -
>   enum src_current_status {
>   	SRC_CURRENT_DEFAULT,
>   	SRC_CURRENT_MEDIUM,
> @@ -1178,10 +1171,6 @@ static const u32 src_pdo[] = {
>   	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
>   };
>   
> -static const u32 snk_pdo[] = {
> -	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
> -};
> -
>   static const struct tcpc_config fusb302_tcpc_config = {
>   	.src_pdo = src_pdo,
>   	.nr_src_pdo = ARRAY_SIZE(src_pdo),
> 


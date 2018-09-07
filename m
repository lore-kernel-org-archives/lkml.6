Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C26C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03439206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="caLBK6MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03439206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeIGOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:19:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43282 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeIGOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:19:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so11518593lfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ANyHVdrhNp1oj4ND7UmGANeykDRjzuIoxvHYRgv5ElY=;
        b=caLBK6MULWmSgAZTBYM0yDl32wKYKlBB/Pb/ISd4UrTqWllqGEggfHOItKSLYypX/A
         zxJM+/Wz1IsMW+2wkm0S8yd+/Dj3QAg5LQ5PKPRokFFQS2RPk1MFHg07/+nbAXeQWqu+
         yhxIwdlYAnIg0ku7Ye4xthuU9P5+U7MKLzovwUJZ3tm8NV5LQOZ2SSnytoIjDvv995RV
         dTqvxXdC/PI3431+UvNzMUse6iI7HAHtqyPVZYV8A6fv57/KLfRzh2lNor4yRR6BJKKz
         TBhlwFf550ur5JNTjpgjSAVMEA0BvL5M9HY9ZxBaBY1y9MBi0eMsBW0tZqU/1PAqc6V5
         b4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ANyHVdrhNp1oj4ND7UmGANeykDRjzuIoxvHYRgv5ElY=;
        b=YtJvesnfQLx/WtsUhJKH2UQ1CBEjQ3e4utsxFZry6GfJIriqo6M++/7r5Aw0teuYVp
         PDqln/VAjnnqo9WsT7/0+z44xOLeXXzEHFzBe5WvWNUDvTglTpU5KLvbK9GnkgdjdwT2
         fY32rYx368+Ha080diaKtahDVGvzKnYViKDfZ1xsF+J8e7xyZugzbB3eCghQxoW+xTz9
         hWFGE17xB5GDgY0YPIwXzWWQw6nbddYaMrMxTP/4zM6E1LpP52C4mcotJF4iiwiuE1B1
         14iMbKR5vXhfMYtkM0Bdn3QAb+4thhKbZPmPtb1IPjY1/zi0BHcVD2mRCIlJl5l3mbSU
         ps7A==
X-Gm-Message-State: APzg51DXoL/dWhH6CJ31UxYsitrA/uaY+qooGq+3tuRwgwOue61qkwbP
        ZOwr/zxVb1IgXjFAISjTUZ087q6UNsk=
X-Google-Smtp-Source: ANB0VdZKv2ExlehBwGrn7LU6g/Jm35PG7MBOt9PBPlySDu+VQ+JQ8M8FOt+F2iqDr6b/IF8FTsAqIQ==
X-Received: by 2002:a19:3fcd:: with SMTP id m196-v6mr4426047lfa.11.1536313160924;
        Fri, 07 Sep 2018 02:39:20 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.85.38])
        by smtp.gmail.com with ESMTPSA id g133-v6sm1203070lfg.81.2018.09.07.02.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 02:39:19 -0700 (PDT)
Subject: Re: [PATCH] usb: typec: don't disable sink or source on
 initialization
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180906192644.24587-1-angus@akkea.ca>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <45750b5b-5124-ddb8-c78e-368b2d9ece83@cogentembedded.com>
Date:   Fri, 7 Sep 2018 12:39:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906192644.24587-1-angus@akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/6/2018 10:26 PM, Angus Ainslie (Purism) wrote:

> If the board is being powered by USB disabling the source and sink
> can remove power from the board. Default to source and sink enabled.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>   drivers/usb/typec/tcpm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index ca7bedb46f7f..a1b819cf31da 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -2462,9 +2462,11 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>   {
>   	int ret;
>   
> -	ret = port->tcpc->set_vbus(port->tcpc, false, false);
> -	port->vbus_source = false;
> -	port->vbus_charge = false;
> +	/* default to source and sink enabled in case USB is our only power
> +	 * source */

    The multi-line comments should look like this:

/*
  * bla
  * bla
  */

[...]

MBR, Sergei

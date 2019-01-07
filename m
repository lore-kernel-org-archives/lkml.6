Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F90C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361C22173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U83lrlEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfAGN6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:58:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38974 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGN6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:58:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so178632pgl.6;
        Mon, 07 Jan 2019 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4zs6Zz/1DJZgW8YjZW8JHJMs9OMo+LSQ66u5CYsQHdY=;
        b=U83lrlErW2ykOCdOygq1yQiiSxbDpREHs8CUUS6DmpryKb8ScnDarMfsrtFrOv+tfp
         qPWa3rmlK20lWMdTI0RDnYrvWPLMGveFYFcf5ZgsB3Bo0cwQFHITNBZJoE1WUbWr4sLa
         TyHFEXOzKXsUNa9JQA6nyb0rWRnM8a55uttx3kkrxz0yIJb/XDGMfrB4PbtVfBii16p9
         RXYjl3YSCMaNHTvQu6sJsjQrkx2Ywcs7ZegY2TvKwuKCE6zdl64RmyU37fHrY5+3Gcap
         b65+kf+7cA9h1dlxPmeekmQHikfEdjJ6e7UdBQ+UNPpq/s69/eevymHvO0YA9+7FgwKd
         asnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4zs6Zz/1DJZgW8YjZW8JHJMs9OMo+LSQ66u5CYsQHdY=;
        b=cq35GioRW+w2FDVC83N+A71jaSw8HiROq3bEDJjXl6P6GkvtmAbJ5VkDm1fDjnhTRg
         sshEDAAZ/HGC9HZffZNZ6foLh7vD2AZ1IRDEvyJg8DElVIt2gOz/LeCfPUcGcHdUEWaf
         zibzkY9BRaGdPQ/l+hKTGNt8utPgZYqBj4XjF+xJ2voxJNQwolgRqxc12PKmu/Ij34it
         WB8H5zGfayxS+8p5Kxt7yHBUfbeayZ0V+9UZYPqi2oJQNHaBCKG0SNZqp3X6S4U3riUX
         MME01cpMsnGpZK0NQJTuvWufkek7cJnAs2aJZSGG4WyMN4U7bcbwnoqtNaiPkOCgIJHd
         F/6w==
X-Gm-Message-State: AJcUukdSTvxVT7ebw0uW5jR7FoYCjrovzA/TLY/HXygZRUuYpG3mHA7X
        veuNc2MyZIn3J2c7pg4u5BQ=
X-Google-Smtp-Source: ALg8bN6K8fA1w3egzAOY/yFHKyx2O+61Fqi8ej6M0tMaRAMzCYVEoAJhWphYYlMUdmba47qIsXvuYw==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr56771951pgk.213.1546869490165;
        Mon, 07 Jan 2019 05:58:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m65sm115241212pfg.180.2019.01.07.05.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 05:58:09 -0800 (PST)
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon: add dps650ab documentation
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>, jdelvare@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com, openbmc@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shunyong.yang@hxt-semitech.com,
        dongsheng.wang@hxt-semitech.com
References: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <0087d2d9c7cd7f38761f76c80d1c37cb2cea6ef2.1546851856.git.xiaoting.liu@hxt-semitech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <568735a3-1de2-3880-5fe1-7be38a55f33f@roeck-us.net>
Date:   Mon, 7 Jan 2019 05:58:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0087d2d9c7cd7f38761f76c80d1c37cb2cea6ef2.1546851856.git.xiaoting.liu@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 3:00 AM, Xiaoting Liu wrote:
> Bindings for DPS650AB power, voltage, temperature, and fan monitering.
> 
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
> v2:
>    Change the patch subject.
> ---
>   Documentation/devicetree/bindings/hwmon/dps650ab.txt | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/dps650ab.txt b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> new file mode 100644
> index 000000000000..6bbbff89f6d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
> @@ -0,0 +1,11 @@
> +Bindings for DPS650AB power, voltage, temperature, and fan monitering
> +

Assuming this is the Delta Electronics DPS-650-AB power supply, I think
you should mention that here.

> +Required properties:
> +- compatible : "dps650ab"

Again, assuming this is the Delta Electronics power supply, this should
probably be something like "delta,dps650ab".

Thanks,
Guenter

> +- reg       : I2C address, one of 0x58, 0x59.
> +
> +Example:
> +       dps650ab@58 {
> +                   compatible = "dps650ab";
> +                   reg = <0x58>;
> +       };
> --
> 1.8.3.1
> 
> 
> 
> 
> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
> 
> 
> 


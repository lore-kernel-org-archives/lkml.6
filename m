Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A8BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CBB2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozeWsTDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CBB2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeHXQmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:42:54 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43929 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:42:53 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so15166526oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+azNStaMXY6fEJfq0jVnztHFd6AN/uuKn1ohIe3fqsU=;
        b=ozeWsTDMmjlRyWR6Ry3eUGw9UeS0FbV96LxsFhxHeZL/drQUusJiBOMezH9unTxFM0
         jmDGfZ+6bJlKoa1BRVSTWQ+0DlfXjghMrz03W5ez6ksa31YmHHVFlX38AiNV8sPMTkjW
         LproYtFTlgnM7RRYMPDHBCCA40MAH8nGs6JY5vX/lfxPotv9Q6K2Z5OIn14DaP2bb5Q1
         qUeXmD/p17ucgivYEpcr6t7KOK2xKr9BAxtZEI16IJ9tl2EN8zzoBTv2A9l8ujH63Bgj
         XYpG9NIfgTopv3D9H1RNFA3j5pG7rwpF68I9QEPKS3IP9zWfIbdRgkpS7loMinVewI4H
         vMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=+azNStaMXY6fEJfq0jVnztHFd6AN/uuKn1ohIe3fqsU=;
        b=Z7SsIpeHQJCjmxIWK8H9ZVn+Ggzm7khQBXPg2Gz5XxHrdOofPZ2bwE81xQD5Af5iuD
         UwyXQZbnnIy3NDTrrpoOlokbzGcbLygEwKuLQe7rfgemtRtiD50NLsMiJwiTncFteD3e
         aoCSLK1zGE1HjL/Oi+joy3vBdlaIJuzzLeq+rqqQdoRlWbFy/x2t2idYOl01CP0GQaSD
         jCyLYMPkJFVxeCVJhJum1gvxEuFYh2P0JXwgSplUpT1uZAsYA2pDp8NXmpMP6nyJGcom
         I3QBJs2+DFa/L9zgy+x1vRnaj3fstBVBHDs4LCgtFkWNhMCxftFKGFTc5pGwYLa654yF
         TEbA==
X-Gm-Message-State: APzg51CtecbjF0krzna/0QTe3tVbszzq/jy6LeNcwEnNjN/XqEIXsg3Z
        JdMk6SH5Ydia5si4jgxnEw==
X-Google-Smtp-Source: ANB0VdZr/8YjH0m+nCktttQo3DECzDAdTjCZuJNU5EkveBMLBtx4kq3Gqc+PWWNISuXJ3e7dLo7cnw==
X-Received: by 2002:aca:df55:: with SMTP id w82-v6mr1425937oig.355.1535116097563;
        Fri, 24 Aug 2018 06:08:17 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id k85-v6sm12849932oiy.2.2018.08.24.06.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 06:08:16 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:55dc:837e:d5b5:84dc] (unknown [IPv6:2001:470:b8f6:1b:55dc:837e:d5b5:84dc])
        by serve.minyard.net (Postfix) with ESMTPSA id 95A233A8;
        Fri, 24 Aug 2018 08:07:45 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH 1/2] ipmi_ssif: Unregister i2c device only if created by
 ssif
To:     George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <c25ed354-5971-389a-0439-369171b5aabc@acm.org>
Date:   Fri, 24 Aug 2018 08:07:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 06:10 AM, George Cherian wrote:
> In ssif_probe error path the i2c client is left hanging, so that
> ssif_platform_remove will remove the client. But it is quite
> possible that ssif would never call an i2c_new_device.
> This condition would lead to kernel crash as below.
> To fix this leave only the client ssif registered hanging in error
> path. All other non-registered clients are set to NULL.

I'm having a hard time seeing how this could happen.

The i2c_new_device() call is only done in the case of dmi_ipmi_probe 
(called from
ssif_platform_probe) or a hard-coded entry.  How does 
ssif_platform_remove get
called on a device that was not registered with ssif_platform_probe?

Small style comment inline...

>   CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference firmware version 7.0 08/04/2018
>   pstate: 60400009 (nZCv daif +PAN -UAO)
>   pc : kernfs_find_ns+0x28/0x120
>   lr : kernfs_find_and_get_ns+0x40/0x60
>   sp : ffff00002310fb50
>   x29: ffff00002310fb50 x28: ffff800a8240f800
>   x27: 0000000000000000 x26: 0000000000000000
>   x25: 0000000056000000 x24: ffff000009073000
>   x23: ffff000008998b38 x22: 0000000000000000
>   x21: ffff800ed86de820 x20: 0000000000000000
>   x19: ffff00000913a1d8 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000
>   x15: 0000000000000000 x14: 5300737265766972
>   x13: 643d4d4554535953 x12: 0000000000000030
>   x11: 0000000000000030 x10: 0101010101010101
>   x9 : ffff800ea06cc3f9 x8 : 0000000000000000
>   x7 : 0000000000000141 x6 : ffff000009073000
>   x5 : ffff800adb706b00 x4 : 0000000000000000
>   x3 : 00000000ffffffff x2 : 0000000000000000
>   x1 : ffff000008998b38 x0 : ffff000008356760
>   Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
>   Call trace:
>    kernfs_find_ns+0x28/0x120
>    kernfs_find_and_get_ns+0x40/0x60
>    sysfs_unmerge_group+0x2c/0x6c
>    dpm_sysfs_remove+0x34/0x70
>    device_del+0x58/0x30c
>    device_unregister+0x30/0x7c
>    i2c_unregister_device+0x84/0x90 [i2c_core]
>    ssif_platform_remove+0x38/0x98 [ipmi_ssif]
>    platform_drv_remove+0x2c/0x6c
>    device_release_driver_internal+0x168/0x1f8
>    driver_detach+0x50/0xbc
>    bus_remove_driver+0x74/0xe8
>    driver_unregister+0x34/0x5c
>    platform_driver_unregister+0x20/0x2c
>    cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
>    __arm64_sys_delete_module+0x1b4/0x220
>    el0_svc_handler+0x104/0x160
>    el0_svc+0x8/0xc
>   Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
>   ---[ end trace 09f0e34cce8e2d8c ]---
>   Kernel panic - not syncing: Fatal exception
>   SMP: stopping secondary CPUs
>   Kernel Offset: disabled
>   CPU features: 0x23800c38
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 18e4650..ccdf6b1 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -181,6 +181,7 @@ struct ssif_addr_info {
>   	struct device *dev;
>   	struct i2c_client *client;
>   
> +	bool client_registered;
>   	struct mutex clients_mutex;
>   	struct list_head clients;
>   
> @@ -1658,6 +1659,8 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   		 * the client like it should.
>   		 */
>   		dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
> +		if (!addr_info->client_registered)
> +			addr_info->client = NULL;
>   		kfree(ssif_info);
>   	}
>   	kfree(resp);
> @@ -1672,11 +1675,14 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   static int ssif_adapter_handler(struct device *adev, void *opaque)
>   {
>   	struct ssif_addr_info *addr_info = opaque;
> +	struct i2c_client *client;
>   
>   	if (adev->type != &i2c_adapter_type)
>   		return 0;
>   
> -	i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
> +	client = i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
> +	if (client)
> +		addr_info->client_registered = true;
>   

How about..
    if (i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo))
        addr_info->client_registered = true;

No need for the client variable.

-corey

>   	if (!addr_info->adapter_name)
>   		return 1; /* Only try the first I2C adapter by default. */



Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31892C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20C720672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20C720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502012AbeKWQre convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:47:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39460 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389704AbeKWQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:47:34 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gQ4a8-0000so-Km
        for linux-kernel@vger.kernel.org; Fri, 23 Nov 2018 06:04:48 +0000
Received: by mail-pl1-f197.google.com with SMTP id az10so15148661plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 22:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I1+fu75weQUtIphLyUnPL8GnzMDMi/xdl573VKhsdf0=;
        b=QCGSKUCqIiCM6s63vP9H6ac7Pis12wTwjoAaYBQcV3OXyEqSSLBiyhHoVkJUkJW1V7
         NSF0UuylSGYGmFvFHvzz/HHL/ALyu64ZsOH4IvsyRc8waeIem05QTrBcSBsEf3BNZhkM
         XwBCmBWOyZ1ULabiaeqUH+jIwY54C3CEtkmzqDK7bt+nmDrOzaEkGnHvdC9rQ7N1pGYW
         wxMgf5ANUy4sBaVdoNQRVnn6knskObWYnYFE87fA9IRzAk+hPHbaIDI5RR60WWkHF+8U
         241u3oXJeEDiiALjpT+zvmE17qRk5nRNXSHAIeX0iZCBYW/Ez/AFz/WEGVLxnbEdPv1s
         RIAw==
X-Gm-Message-State: AA+aEWanePgCuy7jsOiWz1cy7PsZYtCoaYq/ONMx5HPQs5iZZwCC414S
        k3mEN2SvVALtSOYqfl222JuhNkhuNYJSlzx2avhKcuJVj91ypYU0p4i4leNQ9XktNBd0jrJOgCG
        0aJuaFUF9p5xjFeq8e9dDP0QTJasPOn8otPtnGHnKfg==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr434721plo.210.1542953087287;
        Thu, 22 Nov 2018 22:04:47 -0800 (PST)
X-Google-Smtp-Source: AFSGD/W1FKKGTe9q2/GsTLfu/KR2spDar/anDAv+IsQgSkMkFMMN/resQzGG0OEEIRDoQYZYvoAv0A==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr434703plo.210.1542953087068;
        Thu, 22 Nov 2018 22:04:47 -0800 (PST)
Received: from [10.101.46.245] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id n65-v6sm61636106pfi.185.2018.11.22.22.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:04:46 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] USB: Disable USB2 LPM at shutdown
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181106173401.32001-1-kai.heng.feng@canonical.com>
Date:   Fri, 23 Nov 2018 14:04:45 +0800
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EDF7D3E0-D82D-436E-9F31-45D440A103FE@canonical.com>
References: <20181106173401.32001-1-kai.heng.feng@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Nov 7, 2018, at 1:34 AM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> The QCA Rome USB Bluetooth controller has several issues once LPM gets
> enabled:
> - Fails to get enumerated in coldboot. [1]
> - Drains more power (~ 0.2W) when the system is in S5. [2]
> - Disappears after a warmboot. [2]
> 
> The issue happens because the device lingers at LPM L1 in S5, so device
> can't get enumerated even after a reboot.
> 
> Disalbe LPM at shutdown can solve the issue.
> 
> [1] https://bugs.launchpad.net/bugs/1757218
> [2] https://patchwork.kernel.org/patch/10607097/
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Would it be possible to merge this patch?

Kai-Heng

> ---
> drivers/usb/core/port.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 1a06a4b5fbb1..15f6924a4d84 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -285,6 +285,15 @@ static int usb_port_runtime_suspend(struct device *dev)
> }
> #endif
> 
> +static void usb_port_shutdown(struct device *dev)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	if (port_dev->child)
> +		usb_set_usb2_hardware_lpm(port_dev->child, 0);
> +
> +}
> +
> static const struct dev_pm_ops usb_port_pm_ops = {
> #ifdef CONFIG_PM
> 	.runtime_suspend =	usb_port_runtime_suspend,
> @@ -301,6 +310,7 @@ struct device_type usb_port_device_type = {
> static struct device_driver usb_port_driver = {
> 	.name = "usb",
> 	.owner = THIS_MODULE,
> +	.shutdown = usb_port_shutdown,
> };
> 
> static int link_peers(struct usb_port *left, struct usb_port *right)
> -- 
> 2.19.1
> 


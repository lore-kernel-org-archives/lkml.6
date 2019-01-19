Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C806C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF342084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="poXDz1Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfASQ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:58:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35137 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfASQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:58:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so12691955lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 08:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rl9QzDiWS3ECOTqZ66FCWnB2/Tdh96XIbmNhfLuyKrY=;
        b=poXDz1AbIWzZSK3/z4QCbA/GkknEm33isbRJDl6VwXIboH8exDE3aLYd7AKVFmpMxr
         Xh1AvgUg/Ge/9HKlY7cTaMiNv+RtjBIODSVrGy8QGKZ6LYmHhrznm+TQZk0ejeInlSPW
         kNEZAb5GxhfFyzLR3mLX/WWUEFBT52lwr+CBaaJBe59Gq/jCNofE4nJQpmZhVlAncH71
         GR/FxtaSVLk01kjpmsvmjfv8CecFlz192m09xFk2+EnjNqB87LsyCc03ekysX3Irg6b1
         eIzkuKtMTPpbDvqMxObdRMWIiWTdZ7aT9mTjjtQGyy6RbpUV3DIGSCdGXP708+ClRIHk
         E4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rl9QzDiWS3ECOTqZ66FCWnB2/Tdh96XIbmNhfLuyKrY=;
        b=UUPvNT6azE4W0qsjMa7qNSuy9jZKOmmtbIQaLqJJInDYzVKr4W1b6VZdsdXL23QaEt
         6oyP24r0tVLjPSMv5v0AuDp5qgZQ8gF7PEDEmfyoLFA/SsX1fFiBhw5scWgeWSCTJArS
         fuexbonvoHE9J6xkj3AeTQha72Lb0ZT0zrBK8QPuFf1aKpn9WpxujGSGbUxPAHh2cXEy
         tf6LV4N7PlyNOhBP++bCSluU2qGjuH2sLLjiZlDc5LE/wOaCKKPfgj4Do98M0ZLq6syX
         y09Wc5MA6tom1HZH1YhoNdyGb+dPO26zT+F0Mw9E1b6yHQkdu15AlXSwqj4IHmd3hXYS
         duaw==
X-Gm-Message-State: AJcUukf7KQVdReLaao2X6r6D1y9tmx06xRfOLXlhru+vBdg9Nak3xPw+
        oirLtT5j5nqQ+im9nlpwHmIxRC78YO0=
X-Google-Smtp-Source: ALg8bN4wFupTApSIHdkBqXd2mNmba7yZLDgQRZCejC0QOtGR5RB/+Z7++r9KUlQzsDUtBhaOl+Z6BA==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr16037926lfd.9.1547917129256;
        Sat, 19 Jan 2019 08:58:49 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.86.74])
        by smtp.gmail.com with ESMTPSA id m10-v6sm1274871ljj.34.2019.01.19.08.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 08:58:48 -0800 (PST)
Subject: Re: [PATCH] usbip: Fix vhci_urb_enqueue() URB null transfer buffer
 error path
To:     Shuah Khan <skhan@linuxfoundation.org>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
 <20190118212931.18482-2-skhan@linuxfoundation.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bf3e3361-2cab-3229-21a0-b4b12241afaa@cogentembedded.com>
Date:   Sat, 19 Jan 2019 19:58:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190118212931.18482-2-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/19/2019 12:29 AM, Shuah Khan wrote:

> From: Shuah Khan <shuah@kernel.org>
> 
> Fix vhci_urb_enqueue() to print error and return error instead of
> failing with WARN_ON.

   It's BUG_ON().

> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 1e592ec94ba4..849ebfde87b5 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -702,8 +702,10 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>  	}
>  	vdev = &vhci_hcd->vdev[portnum-1];
>  
> -	/* patch to usb_sg_init() is in 2.5.60 */
> -	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
> +	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
> +		dev_err(dev, "Null URB transfer buffer\n");
> +		return -EINVAL;
> +	}
>  
>  	spin_lock_irqsave(&vhci->lock, flags);
>  

MBR, Sergei


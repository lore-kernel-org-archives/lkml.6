Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3220A206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jpb0O5pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfBVSfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:35:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44980 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:35:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id c4so1446068pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Y6FUf1o3WhhkHli7j3JyYJgyuLdWO1HgU68e0xr5N0=;
        b=Jpb0O5pgTwr531IiOH6fogI4/CM9hKG4gp/7J2lDTuSROYEjHIGLOWYIrPYyQlX7J2
         1BqbmgVDJUHgrdy0o7qtO/vIDS4H3I/klMbMKmO83+UeWxSd7qPvjgguWFWI/X26hwjY
         KXnFBPDgjzzj42J23Fi05Wu9Q79IhCfKEfaXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Y6FUf1o3WhhkHli7j3JyYJgyuLdWO1HgU68e0xr5N0=;
        b=dFvzsMH/YwYLpq0axUK8n8NzhWCf/QwzqUhbkC63+J2hwsaZJs15IAYrDfF0HSW0Xr
         J/4kmWcp1xkJb9jgrd4JW+XlthIjGMrAeYCYPvBZ+T5HKQUmY3JKMb/BuGV5LLq42cM2
         /pnY8k/a9E/Zb1tHW7TIkUIPv1FLLGWsRlhZRLfAx7XjW7oeu1dYmkJam1vIs3PIfQ85
         Xjqe0fdbQMeASAlXhxvEy9cuuCDOJ36kc28GVegJWuhjnHm31GoKRfd1oUIv34dRTPTl
         MnF1ypCXG+Bxl8k5DuRn8y59zkHWpXc4/mo3xGQPSL5Q5Yei6z0k0PYXiGrlC2f3m3ZY
         9R8w==
X-Gm-Message-State: AHQUAuZ4ciHhPO2rJJXcGj952gO1xUekWZCexaFgrY9icvwrhY9hQi3y
        UZrsepRQ3KiWCaTFYJPJamdjQA==
X-Google-Smtp-Source: AHgI3Ia8Qzpm4FlotF/3CMXjOxvqR+YZb5bxuaotvFtsVEb0InQ+6yAH5kzcV8gUac8dUclHnyhCpw==
X-Received: by 2002:a17:902:7246:: with SMTP id c6mr5419830pll.68.1550860523584;
        Fri, 22 Feb 2019 10:35:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o76sm5639694pfa.156.2019.02.22.10.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:35:22 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:35:22 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] Bluetooth: btusb: request wake pin with NOAUTOEN
Message-ID: <20190222183522.GD223791@google.com>
References: <20190222003051.127006-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222003051.127006-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:30:51PM -0800, Brian Norris wrote:
> Badly-designed systems might have (for example) active-high wake pins
> that default to high (e.g., because of external pull ups) until they
> have an active firmware which starts driving it low. This can cause an
> interrupt storm in the time between request_irq() and disable_irq().
> 
> We don't support shared interrupts here, so let's just pre-configure the
> interrupt to avoid auto-enabling it.
> 
> Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/bluetooth/btusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4761499db9ee..470ee68555d9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2885,6 +2885,7 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
>  		return 0;
>  	}
>  
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);
>  	ret = devm_request_irq(&hdev->dev, irq, btusb_oob_wake_handler,
>  			       0, "OOB Wake-on-BT", data);
>  	if (ret) {
> @@ -2899,7 +2900,6 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
>  	}
>  
>  	data->oob_wake_irq = irq;
> -	disable_irq(irq);
>  	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
>  	return 0;
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

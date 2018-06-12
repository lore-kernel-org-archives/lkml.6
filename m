Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B837C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203882086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZtfa0yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203882086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934743AbeFLXcW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:32:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33965 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934131AbeFLXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:32:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id a63-v6so348929pfl.1;
        Tue, 12 Jun 2018 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmjpDVKVQkdqWOUdfiXrrJu1iA1Iqj55bZTG+JrUnrA=;
        b=JZtfa0ydcEPBzQdRQYIa32zkPCS1ildAP+LJsPDYe9cIjpRYKl7TvuSCpxLb4q0fuG
         GJfNEywOPjME4UM8Mur7pM7wUiQLpv1e6wpQp8F+T+vBPp+BEAlr0iiOT2PHhyw4QqBx
         m1t8P4UgjKFzepkRS6Pg7W+++bnTprx/eb8WPWF4NlZn4ocP+6Pwi2Nvx94UBq3yHKYP
         rOhdtxy6dAdadh1y1Sw6zM95yLjVuRSEmzRzww0lO1mqdwcJiYxYcoKU9OgCZYoiImMP
         zftpJ333iOB5gtwLB1ia+qMVkLC7Y4V4r/IMwxVlJ86o5LVrHTpnFqlwXWYUmQ0kP3w3
         IDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmjpDVKVQkdqWOUdfiXrrJu1iA1Iqj55bZTG+JrUnrA=;
        b=BnhMBt1J2R2j35eZbmz9b6QC7CUAV36HUH7HGPfhwwz+YOpMA/OUhYeP54vwboA769
         Hu8t5iFPXWYiCnLdZRENT0UouH9j8PKjcfkPihw/06IkmEVCbf6XLTbFnZTYLvjHk/0C
         +jV8+Xj/tN7IdFTDX5jo/V/fnhur/agFESKm27rQSGTmh41McecRdgUQjBZcr6vCUAJJ
         28MxkaWSNpwv99eYjr36Aqx7EnIOBhIJOLJ0h/N/X55k8K5xLwhfkDNA6nMWPHSKK60k
         2QsD3JrzqGvq0lpHS07AXytmI+YT55rzeTzNmJsFllFcMefzabhl3b+Ri4y1iVQrKgIy
         8ohA==
X-Gm-Message-State: APt69E0kJCwfcJ5kBLtELIT4JytJqV0M+4zCvmRLkjaTRV9CD0UkRMBi
        JeEmXT4YZCzlhuWak/wt1BY=
X-Google-Smtp-Source: ADUXVKJ1/ioWDgfyNlmtxQQdQ+VODSKS/BJWLGL0a4xSb3/3dvKx+ehE8J+LKbBizsfkE3jfIFSCQQ==
X-Received: by 2002:a63:7205:: with SMTP id n5-v6mr1984006pgc.337.1528846339864;
        Tue, 12 Jun 2018 16:32:19 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id s2-v6sm1659831pfb.127.2018.06.12.16.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:32:18 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:32:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     ravisadineni@google.com, dtor@google.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
Message-ID: <20180612233216.GG38773@dtor-ws>
References: <20180605224458.62692-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605224458.62692-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:44:57PM -0700, Ravi Chandra Sadineni wrote:
> Remove the unnecessary check before calling pm_wakeup_event. If the
> device is not wake enabled, this call is no-op anyway.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 30 ++++++++++-----------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 489ddd37bd4ee..c5e32544130dc 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -242,19 +242,17 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	u32 val;
>  	unsigned int ev_type;
>  
> +	/*
> +	 * If not wake enabled, discard key state changes during
> +	 * suspend. Switches will be re-checked in
> +	 * cros_ec_keyb_resume() to be sure nothing is lost.
> +	 */
> +	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
> +		return NOTIFY_OK;
> +
>  	switch (ckdev->ec->event_data.event_type) {
>  	case EC_MKBP_EVENT_KEY_MATRIX:
> -		if (device_may_wakeup(ckdev->dev)) {
> -			pm_wakeup_event(ckdev->dev, 0);
> -		} else {
> -			/*
> -			 * If keyboard is not wake enabled, discard key state
> -			 * changes during suspend. Switches will be re-checked
> -			 * in cros_ec_keyb_resume() to be sure nothing is lost.
> -			 */
> -			if (queued_during_suspend)
> -				return NOTIFY_OK;
> -		}
> +		pm_wakeup_event(ckdev->dev, 0);
>  
>  		if (ckdev->ec->event_size != ckdev->cols) {
>  			dev_err(ckdev->dev,
> @@ -268,10 +266,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  		break;
>  
>  	case EC_MKBP_EVENT_SYSRQ:
> -		if (device_may_wakeup(ckdev->dev))
> -			pm_wakeup_event(ckdev->dev, 0);
> -		else if (queued_during_suspend)
> -			return NOTIFY_OK;
> +		pm_wakeup_event(ckdev->dev, 0);
>  
>  		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
>  		dev_dbg(ckdev->dev, "sysrq code from EC: %#x\n", val);
> @@ -280,10 +275,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  
>  	case EC_MKBP_EVENT_BUTTON:
>  	case EC_MKBP_EVENT_SWITCH:
> -		if (device_may_wakeup(ckdev->dev))
> -			pm_wakeup_event(ckdev->dev, 0);
> -		else if (queued_during_suspend)
> -			return NOTIFY_OK;
> +		pm_wakeup_event(ckdev->dev, 0);
>  
>  		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
>  			val = get_unaligned_le32(
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 

-- 
Dmitry

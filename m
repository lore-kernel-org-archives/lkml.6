Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 10755C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40E22086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZZZhToU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40E22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934880AbeFLXdg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:33:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41562 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934156AbeFLXde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:33:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id a11-v6so338463pff.8;
        Tue, 12 Jun 2018 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hCuq2oO8cwoQt4Uo2TgYKFd5oKnwMy/8GxGKJg+F3w=;
        b=ZZZZhToUqEtM1EZqMBW00OhgkBSmpjDNhGSy77p1ikGVeckt2CXvGjCkTJkZ/zCWg/
         u0ta/vp01o7fT9/ILT0QcyAp963uXwXXc7+z7oON0nibi+9D7BXCAsXmL4sVRsl2yNOq
         Ff5EVQ2dipmW/mSD1DoucMCHZEp27c9mcXwAXc/GVxBdk8zO/4yX/JwFJ/CwhaYiP0U0
         dXcaO9aoc5loAyNuLPEa6LRID9Ujg3oyH+/FMaCGWZ+OCfPRkvqgy15vJ91zagW62kNw
         KAKvPHGa9V8aozbBJB6OHlmcM3uxATVUfUlSdUBytjTBQXTzMhgyIzoVYIPslnX8Lcgy
         k5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hCuq2oO8cwoQt4Uo2TgYKFd5oKnwMy/8GxGKJg+F3w=;
        b=HxvloTq0hE7BRiI+nmPgr3y8/wfxq1fMHFzPKpa1fTcjm/LNNfqeemziih/Dwabxgt
         Y/dL7GeY2MexhMqOzOVRq63hWgHIb56Ew7mL2vkCHMSlNUYOWD9Q8Zrx1loh0mUboJm7
         L8kDoTtrVkrMe4w5f+VYAmiLv6m939cDa3cQLOk1/S+jPwOofZR4cbqiwVVwTFOBIAjx
         Ja7YeWQo8++x7HTAaRbeIWIeIsXyra5OXKOea/b85tGGvZSqE2sMyMJ9nvIP9Ig87QGS
         4IPYb3JuTmzO2Ipp75efXcXkNNY2DgCIy54423l3EiXeDbQzm00vcrm3SmDCBJKrmMmo
         JYqg==
X-Gm-Message-State: APt69E1k7d3tsdIE/tyk1/+C1pcVJLr+xgCyN0G2001pRcMQdor+Mu/e
        i4C/p68TMNwcRG5VUhWS2AM=
X-Google-Smtp-Source: ADUXVKJzRY7Ju/njq6Y7gGTnkUN7nvd5oWpa/6g+8xXGMCF0zOF4dx/aIJb+79OoOtpK0X3qRNPVrw==
X-Received: by 2002:a62:9945:: with SMTP id d66-v6mr2440121pfe.192.1528846413689;
        Tue, 12 Jun 2018 16:33:33 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id p16-v6sm1652102pfd.47.2018.06.12.16.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:33:32 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:33:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     rafael@kernel.org, chenhong3@huawei.com, ravisadineni@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        rajatja@google.com, bleung@google.com, furquan@chromium.org
Subject: Re: [PATCH V3] i8042: Increment wakeup_count for the respective port.
Message-ID: <20180612233330.GH38773@dtor-ws>
References: <CAJZ5v0iu23LqdKUJA5OQGF3Yqq3=k+nfNUVn-LFpYgkDrgokCg@mail.gmail.com>
 <20180605190124.191827-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605190124.191827-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:01:24PM -0700, Ravi Chandra Sadineni wrote:
> Call pm_wakeup_event on every irq. This should help us in identifying if
> keyboard was a potential wake reason for the last resume.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>

Applied, thank you.

> ---
> V3: Remove the unnecessary device_may_wakeup check.
> V2: Increment the wakeup count only when there is a irq and not when the
> method is called internally.
> 
>  drivers/input/serio/i8042.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 824f4c1c1f310..b8bc71569349d 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -573,6 +573,9 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
>  	port = &i8042_ports[port_no];
>  	serio = port->exists ? port->serio : NULL;
>  
> +	if (irq && serio)
> +		pm_wakeup_event(&serio->dev, 0);
> +
>  	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
>  		   port_no, irq,
>  		   dfl & SERIO_PARITY ? ", bad parity" : "",
> -- 
> 2.17.1.1185.g55be947832-goog
> 

-- 
Dmitry

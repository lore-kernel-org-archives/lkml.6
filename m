Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7DC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC820880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVrIAiWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FC820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeILVS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:18:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38394 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:18:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so1251881pfh.5;
        Wed, 12 Sep 2018 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wA9QZWxEHkE2y540Jw1+PXYb+zEFc4T0fB6sME9gQ8M=;
        b=tVrIAiWJUDjETXwLEjHlmnFDoHOVxY0S+6LH7Yy5rJ1AWHtMWFwhwMai2FFvZw84Ai
         bjvvQIPefOeCeP+Sz6RWFShxIaS6eV7TDkT64L9uyKS6gYexmNEZnO4kfRqUJSvAzzq5
         Xd4JqwzNfFzq5wtM+/J4il4C4wMQJAxP6jMjEyhIecGgRJlcfZ/j+mFvEWfzZmPcWXVB
         1EpDaw4pBVHHP17wg3fCJpf7kAGHKviq4GRCPMKsL7wJIgEz4XvW+znYMjZCT+JZfJTj
         hKC0CFj/MpqozTWTfp2rdpDfKe7MGUSImVbHQf1UldoH+Yd4CQQ3G4cX2TILKbq90xo0
         aWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wA9QZWxEHkE2y540Jw1+PXYb+zEFc4T0fB6sME9gQ8M=;
        b=JLAmk5i2GmIJ1jPy7U2FgcSml51A/e+6uhk0zdFdgUVQPyWQ8cWZzJHKbunqF9Umxe
         vlTfB8bHvKLI5Br/JAm0QO2ZiTIrGXlQ++Ills2IYj7g+nHEdGVZ5YtCHMuer30/rIvJ
         NYnjWsV2JCzKckN+Wh3Brm8YHbfcCrXh8Sq+OC7V2kerwJDCXTT/8xNj8guYRIhaYrUR
         KfG3X54pf3xatxo90SazIjJOEUKB+PwK3aMmg+pi9micJhyx2M5pjAFpdSbrj6q8TsTP
         GwkxcmbimUe9JXAniy0JM2MQvBni09+wrqrlYnbo2ZTzhA2THdIx7cpwnx6socyX8Q3v
         dvRA==
X-Gm-Message-State: APzg51A9Yk2aOlg5jSN5gxIcQSpuIzZC3GcKCoQfCcRujf87N9HDLwqO
        vgd1cLDLoHtwOe6W3MnxSJk=
X-Google-Smtp-Source: ANB0VdYNjCgxasg3d/GGnqVycIgrOlDjZRqserioliLeW01XuX4T7RxwuSFoIYOInLfEZ6asJwQ3XQ==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr3152296pgq.392.1536768824096;
        Wed, 12 Sep 2018 09:13:44 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l127-v6sm3220168pfc.55.2018.09.12.09.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:13:43 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:13:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jagdish Tirumala <t.jag587@gmail.com>
Cc:     wim@linux-watchdog.org, yamada.masahiro@socionext.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WATCHDOG: DIAG288_WDT: Fixed error POINTER_LOCATION
Message-ID: <20180912161342.GB3300@roeck-us.net>
References: <20180912155632.8060-1-t.jag587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912155632.8060-1-t.jag587@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 08:56:32AM -0700, Jagdish Tirumala wrote:
> Fixed ERROR:POINTER_LOCATION: "foo * bar" should be "foo *bar" in
> file drivers/watchdog/diag288_wdt.c
> 

Same as before.

Guenter

> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
> ---
>  drivers/watchdog/diag288_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index 806a04a676b7..046333d1beb2 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -199,7 +199,7 @@ static int wdt_ping(struct watchdog_device *dev)
>  	return ret;
>  }
>  
> -static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
> +static int wdt_set_timeout(struct watchdog_device *dev, unsigned int new_to)
>  {
>  	dev->timeout = new_to;
>  	return wdt_ping(dev);
> -- 
> 2.17.1
> 

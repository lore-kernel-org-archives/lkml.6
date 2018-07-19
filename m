Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03689ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3032084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quWp4fO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3032084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeGSLXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:23:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37623 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeGSLXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:23:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id j8-v6so5668447lfb.4;
        Thu, 19 Jul 2018 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0J9gENjbBXNcOHTJUrfQ8+2Qbnt88ypENQSSk5lKtdE=;
        b=quWp4fO/2zNcdEz3Ezto789m42hAcInVXYQfaLf+/fTdmcdwEXlzznjdDhzeVnk3WG
         wzSqMAqujAmd/nhlDmqeJEQB6xtfBnLAEVEh5g3uk2rYDCKzmPCJ0TkODu7Jb61iXKAm
         QMB7PNrrOtFiFtcfeyyJ8qo5AcKnfC2YT213TtaUIY1zUEFfEjzRSc0NsbltSsY2NA/D
         bp/rwQyhZRKWY8UTzqH8oZjXKlGeeGebbzgPDuByc6hE8fki3W6NaJQtEOfgCaR+BGHH
         NxMLXRwreisIHg5PHe0Y3a4zx/h24QMLImXOUXinwf+LnkemOofxNqCEcD56IC24eUvU
         O4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0J9gENjbBXNcOHTJUrfQ8+2Qbnt88ypENQSSk5lKtdE=;
        b=ORcevjJ7+/MTVCjKuH2jEAXLhc8xKigCHMyEzQ6fmP6fbRbXwUijKEwWXzBU0tCeAO
         n/685jUoATBUuH/2pbhJDNc5fzSlRuhSjve7u7HMiexQpZbM9yBTNWV4U6mvOb5NPVy7
         ag5BVkCopDWe9exf5CXzas+9GtCHEwcEQWmRh0wCQAA5gaQEtyw0DJu/1Dj8gHlEU8Ns
         bOYFEAd8B4FBAVFx/vPsGvLEFKRVRpqaMwYYlwVC45x+qjrzNZGcMK+W75QmycGwkxZk
         scFvZElKK5dVbEhqYSJID18cJTXsydeCOWMmezURKqBOtPDBorThowfl0n1hY9wFamvP
         PIJg==
X-Gm-Message-State: AOUpUlFa2j8HK9dJewIpdU+XTUqWqrT3Y7pXSliJjNyyWT/AN4JJScsE
        sKMB99YlCxiIuPOeyrDoYRv90sJv
X-Google-Smtp-Source: AAOMgpesOViD7slXTGDyNsic1bM2pB2ukYy4LcHD/IQOvNhIYpYpUdO/ezFsN6XPNcOZcGMSjc2CtA==
X-Received: by 2002:a19:d890:: with SMTP id r16-v6mr6130736lfi.7.1531996831025;
        Thu, 19 Jul 2018 03:40:31 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id m8-v6sm1056459ljj.10.2018.07.19.03.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:40:30 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fg6M6-000640-JK; Thu, 19 Jul 2018 12:40:18 +0200
Date:   Thu, 19 Jul 2018 12:40:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v4 4/4] rtc: interface: Add power_off_program to
 rtc_class_ops
Message-ID: <20180719104018.GT10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-5-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531372060-10532-5-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:37:40AM +0530, Keerthy wrote:
> Add an interface function to set up the rtc for a power_off
> mode.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/interface.c | 12 ++++++++++++
>  drivers/rtc/rtc-omap.c  |  1 +
>  include/linux/rtc.h     |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 6d4012d..c19668b9 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>  	trace_rtc_set_offset(offset, ret);
>  	return ret;
>  }
> +
> +/**
> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> + * line and can be used to power off the SoC.
> + *
> + * Kernel interface to program rtc to power off
> + */
> +int rtc_power_off_program(struct rtc_device *rtc)
> +{
> +	return rtc->ops->power_off_program(rtc->dev.parent);

Why pass in parent instead of the rtc?

> +}
> +EXPORT_SYMBOL_GPL(rtc_power_off_program);

Either way, this is likely not an acceptable interface for this as
Alexandre already mentioned.

As I already suggested, I think you submit this as part of the PM work
adding support for entering the TI RTC-only mode. That will hopefully
provide enough context to be able to determine the right interface.

Note that this also means that we shouldn't split the current rtc-omap
power-off handler before this has been settled (i.e. patches 2/4 and 4/4
should not be applied before then).

Thanks,
Johan

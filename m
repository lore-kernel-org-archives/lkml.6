Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A05ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5182145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrNFK2MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5182145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeJRJFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:05:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41773 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:05:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so13507943plr.8;
        Wed, 17 Oct 2018 18:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gvl4zoNyk8NSWqjElwjKwUam7V6+b5fwjkgRVFdAJbQ=;
        b=DrNFK2MS3RpmZSwr5DEhh1ETxEEu0G29z//O6ibaBayLRhgb9hHxAkeaZexw2/6pom
         1dnbaC1kAA5+qbpayAYrixQw85J/1gV4U5f4YOlXg28wSkgj4YMM4q2zsjoDJv3rDx5v
         zUQqxm2H4z/YweVGKUD5hLmS2zgYnCeVk2QBnYxx7xjXPQ+IZ3ylK7UqEgRcSo9BOOFZ
         DEQiqV+BiFGX1tTEGCTtPNl7ZM8jEBG8bFiwqU4wNrPVJsYIViKnaSEXO6nEkX2Ly6Nj
         KH8uWCSxzORmDSidG6GmvjUUVvkxbJitPsIp+5No7FTYe37VpUA9fKXJN6jVrqE5+Ypx
         sU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gvl4zoNyk8NSWqjElwjKwUam7V6+b5fwjkgRVFdAJbQ=;
        b=s21kIRdvHZu8ILcVpNpcAILBhb4JMEcsJyMu2Rlxr9tbwEuv1utt5MJPxC0GVROY3k
         QbuKHh6TV3gdS9mVh/4BlvNKCSW9g0iNj2rWQmxwQza7JreI4eXEQLi48FN08M2kpcrh
         L46UCk0eYkegChwe9fM/mCWH0iXkPJbXAvCQmbWBQ94dJMPJ0cWGy46XGXjOahYr+f5F
         n+2H9gckPvq4irjSan8eGISdgKHEydn9JJu5Uqi+/qfqxENi78ZjfybIqoveQ9FTxh+v
         w+ovEtbnhOJNnbFxz6MW+wQbJ1jUMm0xNHIhZNvz2Atfc7j9KDXWDKNEZ8wQkfiS87Rk
         +6TA==
X-Gm-Message-State: ABuFfogUlADY3RQl8LU0XmcxgzKT/r+6j3mA7VrjnEcuQQ1KElPvUOAl
        yXHfBXhemHrTgjzqzvMKpuI=
X-Google-Smtp-Source: ACcGV63kq6gGlDfjCF2IoJ28VRZcFqMB7gM3ORLOJK3apXqU89WKPIOkXrfo0EqGXSvVm6ihQTNoww==
X-Received: by 2002:a17:902:d01:: with SMTP id 1-v6mr28383014plu.88.1539824807142;
        Wed, 17 Oct 2018 18:06:47 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id g62-v6sm24185692pgc.22.2018.10.17.18.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 18:06:46 -0700 (PDT)
Date:   Wed, 17 Oct 2018 18:06:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Message-ID: <20181018010643.GB205061@dtor-ws>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <20181016173244.GB230131@dtor-ws>
 <20181017133612.GK24771@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017133612.GK24771@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Wed, Oct 17, 2018 at 04:36:12PM +0300, Heikki Krogerus wrote:
> @@ -189,7 +210,7 @@ static int cht_int33fe_probe(struct i2c_client *client)
>  	memset(&board_info, 0, sizeof(board_info));
>  	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>  	board_info.dev_name = "fusb302";
> -	board_info.properties = fusb302_props;
> +	board_info.fwnode = data->fusb302_node;
>  	board_info.irq = fusb302_irq;
>  
>  	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);

OK, this totally explains it. I forgot how we can supply the properties
in board info for I2C/SPI devices and they would get attached to a
device later, and this obviously does not work if one wants to attach a
sub-tree.

Thank you for providing this example.

-- 
Dmitry

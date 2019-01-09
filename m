Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96309C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C2920883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547030654;
	bh=bMiqCxj+idodRPeB11wLlE7q7SHY4H1yDBtz6z65uiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m/h/v/mHI7OgAgEDDOvysr2oWJLnDpMSY/x5RiyysTNztc+Hl8An5tlmjjLfrX93k
	 2fUmx8F4mR7GjBPIrSgLtY7+aIFGJm+vLHxg7exbo8oBiJIp5EdZAejsBToXBic+tS
	 qo80ckDhMlmV5hVgHqJNHhiyqko1aecbrCTv4xgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfAIKoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:44:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44016 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfAIKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:44:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so5247802lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCgCHkZmNPzpbR4hMIdvjS9XtBmeFhqn41FaprU78ZU=;
        b=W/46ToweQYp1FJLqvpA+pNEO2TgVMMefaZ7R/fxABkDnlvWUkTsvI0kQJWhw/rhqXQ
         4Qiqzz1WmefKZa95jE4Os2ucveOnGzkNTFmdca6MMKP7WtL1yPQD4EYQzOzfLJR46h3A
         0Ns0wJF9qDEJ9MJB7fF9MSv4WUMuiJ//EWMc6g3K7VjiXxZ3Ga+zNKHQbxpcE8rVHsbP
         z8nDA9L9J4Rv3v/I1Bmpm9yA/1oNgKPU8C2bYIbJBixrw9H28N98oGr07CYSoQdvhyaW
         sK0Dk6Ct6z/0ZTGlGCr3pSc8i+83Em+S+UYPwmdUjRwNcU4l96I2l7eEmQTJmfBM9eRQ
         qPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCgCHkZmNPzpbR4hMIdvjS9XtBmeFhqn41FaprU78ZU=;
        b=JydtUHqjiIDq1Tc+RU+ZfrRL+TqexR1co010rZmnyGjXtwJbtCZt9yk2JTVgpQHNZF
         V9J4GlWFQkLotuXtwowqaqy0PkWjk2ImPi9fiKZTwCmm0yzc0CteqTOoH0Dfy7kj6YaM
         /J6/2raJZg4hCH7ENHPZ0EXwWCG5wDYcPKam05bEBjIlgoqQk4LE7QMQmSYIrNr7O1Wb
         CugUT3AUxX7KA82sgIo8AjyIjeLfH/5/mmFxEjbU7tCvgA4/rcrFfyUChawI9EsEWnDj
         KRXADBl3q1NE+H/Ka4QQQlWL2b1YeG8726eoWZZTchAb2cmfu719ZhfLv6M2L+9cJQiC
         7kJA==
X-Gm-Message-State: AJcUukclF3871vKxk2Ap2qJIXdl9YwYbFuNPHQzTU/UGsYE5mXQRoIy+
        Xzp6H7rChvv7V8ciokcpKtk=
X-Google-Smtp-Source: ALg8bN6B0xU/bc8rXxQQzKpx/1Jpi0XGmWlSieNlbhV4FVMeWiNVS9ALI2WhFASA08Ybi0TdN5vHCg==
X-Received: by 2002:a19:a40f:: with SMTP id q15mr974101lfc.4.1547030650390;
        Wed, 09 Jan 2019 02:44:10 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r29-v6sm14495007ljd.44.2019.01.09.02.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 02:44:09 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghBLK-0007y1-0k; Wed, 09 Jan 2019 11:44:14 +0100
Date:   Wed, 9 Jan 2019 11:44:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] staging: greybus: gpio: switch GPIO portions to
 use GPIOLIB_IRQCHIP
Message-ID: <20190109104414.GI14782@localhost>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
 <4a2b9c3439a806870e2cbc1f772bd97ea9448dfb.1545488665.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2b9c3439a806870e2cbc1f772bd97ea9448dfb.1545488665.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 08:17:02PM +0530, Nishad Kamdar wrote:
> Convert the GPIO driver to use the GPIO irqchip library
> GPIOLIB_IRQCHIP instead of reimplementing the same.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v4:
>  - Remove changes related to conversion to gpiochip_get_data() to
>    include it as a new patch.
>  - Remove the 'struct irq_chip' field from 'struct gb_gpio_controller'
>    as struct gpio_chip will have an irqchip whenever
>    CONFIG_GPIOLIB_IRQCHIP is selected.

Ok, sorry for misleading you this. It seems we cannot use the gpio-chip
irqchip, since that will register the irqchip automatically and possibly
in an incompatible way. This new functionality is far from well
documented, and you basically have to review the gpiolib code to figure
it out.

Looks like you need to add back the struct irq_chip.

Johan

Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2642086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7JbFjhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2642086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeIJShy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:37:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45505 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbeIJShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:37:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so21982228wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5A2Zw8pyJUAtvQra+uvx0+sUGSCxHLTKU7nfQ8OYI8I=;
        b=g7JbFjhq87bHefKHv5FTwkt9B2c32dU5LHTTpWv1kZUksASku4RB1m5cdgTZLQ9ZeH
         4g/QlS+o76ooabfMrILzG26Q+hM40OA6adnYG5J4mpkzVLfix1H4mR7Ho/TMuMJPtscT
         ml5l7R2zvbinqrB3MjJNxCdasByr7boTnTk/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5A2Zw8pyJUAtvQra+uvx0+sUGSCxHLTKU7nfQ8OYI8I=;
        b=eUUEZ0gNL7bC5iMU2Yx59C5QXDGp5alfDVrZUOhZO6ibbhJqt2D5TgOWnH+4w38I9v
         bkFzxA6Q2xxO5BqQiYhxLuPwfgphrNKfTSbeGqWcishSr750W3eErFlOJgrJ9Drh5Onf
         IfgXXqhanWkqjWmS13KgNIVThOHWyen1vGExqUc4Ep+yGSYuV8E4HS8jchVrjQjMSU11
         +vGRn9DlKPxgrKUXko276XRHKcWY4fRnROvK7lSWkMTpnTQJJ+bzlZ6S24MjDWJsVWCX
         XvTH69pIIyV38ihvhq6hzik1kUn0Y3sghaLSQeDfjQViyI24JvYeGFxIY5yEg60Nqe/X
         2rtw==
X-Gm-Message-State: APzg51CViAjFO71BCSj11pNNR/DWvwXbgp8xZ/EhGwnbt4T/YyDXZxqW
        /gdBTMOIHHECHKPOBIosoWHSqg==
X-Google-Smtp-Source: ANB0VdbGnKsDXrg6NqlyfLH16gnOyRkGGlZ0tcJYROgHtmDck79lwjEP0inkN+PZrONEyxzdU6LW+g==
X-Received: by 2002:adf:ed04:: with SMTP id a4-v6mr15470652wro.262.1536587021877;
        Mon, 10 Sep 2018 06:43:41 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id j6-v6sm14120341wrq.25.2018.09.10.06.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 06:43:41 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:43:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Message-ID: <20180910134339.GM28860@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180910094817.GJ28860@dell>
 <2a8ccc95-bbf0-2211-0f88-c5a594600d34@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a8ccc95-bbf0-2211-0f88-c5a594600d34@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Nicolas Ferre wrote:

> Hi Lee,
> 
> On 10/09/2018 at 11:48, Lee Jones wrote:
> > On Tue, 04 Sep 2018, Radu Pirea wrote:
> > > Well, this is the 12th version of this patch series.
> > > In this version I fixed a warning from kbuild-robot and I have no idea
> > > how I forgot to add static in declaration of that functions. Also I
> > > fixed the example for the SPI driver in bindings.
> > 
> > Okay great.  So which patches still require Acks?
> 
> None I would say: everything's ready to be integrated into your MFD tree as
> you proposed some time ago.
> 
> We are looking forward seeing this series integrated in linux-next as soon
> as possible.

Very well.

I'm just catching up after an extended vacation - only 300 mails to go!

Please bear with me.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

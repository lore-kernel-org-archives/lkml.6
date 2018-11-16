Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F249AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2602087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ix8D+Ak5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2602087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeKQBY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:24:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36957 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKQBY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:24:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so21317737wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0OWoHitRNTeGzn98FbVAZGW1OZq5PdXmttk2TdRXjqk=;
        b=Ix8D+Ak5eKS7LXk9h43a4xJTyv4Q9r3Wd3ZBPel/31mqWBRaEH1W2S/DxBeSSPV3IE
         VQCFhbTx2QGvP756c+l+CvxfQoTPq5Rc6W0RQCioL40L1zvUUJQl9wDSTYNT72ALlV3R
         dVe3gJQybZas4YN4HQpAdL9PJrCzanKXCB3NXEkhkegdipTjg9urUsAPKOt7Odcrng4a
         GReVAGrwsMDs80ZWC2Erj3gfJSIkxHa2UJSKf6HvpYIS1dZY5RuWky+LJzJ/1io4Y+LH
         Y7z/gZH7SNib9GPBN/f6AmB/uq7P+Bntpa3oZRUAKsUEe0uR/HJD8VQbHzCVnX6eyepz
         uigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0OWoHitRNTeGzn98FbVAZGW1OZq5PdXmttk2TdRXjqk=;
        b=ugYeCkaxG6gG6T2xh3ww4ywtRp84qcCvHKggWhB/+qNVVTyvd4+N1zaSfcZuqkuh45
         FXo/ogmq6BKGZf+BeS0ObL9gWbWYtkouvJO8iZJ98PQfcT+QO3KwqTyXunTONchsG84T
         QDERbcVb1Lba46qWBiPhr9t/AQUsdVOBcRlXkndI+maNI8pIYcfOIkV/C7JkblKLQeuf
         GDgTOYuWLBzJFQzRy1CtdAeYC7pLdphCbLiVGtnFcBx+cAaCSLM1romxGlBiI/4ghWFG
         j9TcjL5tWUywNcfeu9/F7jp6Q6681T/iWDQ1fwx5Wjtxmix6BkVV60Eg0k5W0WpTLlrm
         aT9Q==
X-Gm-Message-State: AGRZ1gIqsg5YH+5+xThy/wT3YPIF7EoYGfvOkrsVMPRFu0ciFE+JlOzo
        WMN1gSPqHWD3mT/JNn3ctpthdg==
X-Google-Smtp-Source: AJdET5dNDSOKwLbO2s71nh75Uf3DMd/Jq+3IPLW5t2rFw3r/UxH6YgrGlXntlNVORYqNQHFR4nRUvQ==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr1429090wml.76.1542381130945;
        Fri, 16 Nov 2018 07:12:10 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id 4-v6sm15606860wmd.18.2018.11.16.07.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:12:10 -0800 (PST)
Message-ID: <4d7628466f0128a34778d5eff164578812272711.camel@baylibre.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: meson: add libretech aml-s805x-ac
 board
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Fri, 16 Nov 2018 16:12:08 +0100
In-Reply-To: <8736s1t94r.fsf@dell.be.48ers.dk>
References: <20181116093938.26373-1-jbrunet@baylibre.com>
         <20181116093938.26373-3-jbrunet@baylibre.com>
         <8736s1t94r.fsf@dell.be.48ers.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 15:00 +0100, Peter Korsgaard wrote:
> > > > > > "Jerome" == Jerome Brunet <jbrunet@baylibre.com> writes:
> 
>  > From: Neil Armstrong <narmstrong@baylibre.com>
>  > Add Libretech aml-s805x-ac board (aka 'La Frite') support
> 
>  > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>  > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
>  > +	vcck: regulator-vcck {
>  > +		compatible = "regulator-fixed";
>  > +		regulator-name = "VCCK";
>  > +		regulator-min-microvolt = <3300000>;
>  > +		regulator-max-microvolt = <3300000>;
>  > +		vin-supply = <&dc_5v>;
>  > +
>  > +		/*
>  > +		 * This is controlled by GPIOAO_9 we reserve this but
>  > +		 * claiming it as done bellow reset the board anyway
> 
> The 'bellow' typo is still here?
> 

Damn ! I messed up while formating the patch. Sorry for the noise, will resend


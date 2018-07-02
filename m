Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB30AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5923024F7E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b0P/Fn+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5923024F7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeGBH2v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:28:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43279 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeGBH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:28:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so360732oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I0yujopQwKdAk+ekJJBJefUrIFxzHamxpPz0MXgScEA=;
        b=b0P/Fn+DI0fFRcpudPzSQTWMX5pPSVrgSem5Qd9PmZRQ/ivunhEk1oHMPT3uynmx7P
         YkAjL4sDFdR9XWSSx8BSczeFlLnUrUP9KyaUMvLNyt0lXxKKzIEZMZWQ0AnqaP+r/oVr
         QseF2XrwUyAbXUS9G6y8U4LjFKCgVQU1GbDQBMGgy0aJ0PXuY0SHg+1SE38/LS9rD1Ew
         Qw/Znl9y6Jywu+K16Mz9ur7TQsEJFVm5jRol6uhrLOk/S6jUGrsmystgNUWwLCO5CzUN
         BnP2pA5yvIMoa+9tG5be7Vs4ygpHGITxPZowODpZuhoygbcsrQDU3ITXwo8+e+MYQF8j
         /tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I0yujopQwKdAk+ekJJBJefUrIFxzHamxpPz0MXgScEA=;
        b=PtrbUoBqd6tr7w+Uz1Zvbnr1wiqYRV7sBrJQSQ6gKX+eQH2bb8RstrZN/lYlQgQ6wd
         G9KkWaOIHnF+XBUHog5IxgQmpIO8YhCqgpoyb9rKZ8gUXH/4tPGhl7MrcTMvyXdrP0C0
         zhIZYO7k0bnxM+XcmF3k7TqjMu3EncnrhCYpTWNwFU2rIPr7MrlMyeyV3zfjmEsuEHFg
         KLu06V8FSyrJdgvpCJYabJ66l9tu9FJITimtrAUf4fuGOXKYmmtPiY4KniPAgy8m+2oX
         lv0+gkAU5uzoRp+4Vi7XJkzoiKEdaPrjINY1sDEhijuq6y5dXea5nRsxtIq9d4WJCRgD
         IEZg==
X-Gm-Message-State: APt69E20Axl2kfPql0wVi53tROEXUp0z2Ix56FgXuTrrZEZ98vCIc3gA
        aV1WgDtAITECJ9hrw9Oafbemz3/nF+cLHfiVMLp9wQ==
X-Google-Smtp-Source: AAOMgpfCvJRhnTT40wHhxpc7GaAcPBuFCyEQtSEOE8jJDTKCS7KDAYrUnSWXipcVsPkT7hIVCDU47DwNrhu9Sa7gSzk=
X-Received: by 2002:aca:7517:: with SMTP id q23-v6mr13408346oic.352.1530516528003;
 Mon, 02 Jul 2018 00:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c15:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 00:28:47 -0700 (PDT)
In-Reply-To: <46acbc64-6d22-d361-941c-f67aa3029242@lechnology.com>
References: <20180629094039.7543-1-brgl@bgdev.pl> <20180629094039.7543-10-brgl@bgdev.pl>
 <46acbc64-6d22-d361-941c-f67aa3029242@lechnology.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 2 Jul 2018 09:28:47 +0200
Message-ID: <CAMpxmJW2L+nYoPgR0G63uML_bqrhVRwpNRDFEv2e=3r4Yd9NBQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/18] ARM: davinci: da850-evm: remove dead MTD code
To:     David Lechner <david@lechnology.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-29 19:09 GMT+02:00 David Lechner <david@lechnology.com>:
> On 06/29/2018 04:40 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We no longer need to register the MTD notifier to read the MAC address
>> as it's now being done in the emac address.
>
>
> I think you mean "it's now being done in the emac _driver_"

Haha yes I do. :)

Thanks,
Bart

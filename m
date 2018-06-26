Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B06C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9A926F3B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyaJKjZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9A926F3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeFZTlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:41:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35133 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeFZTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:41:08 -0400
Received: by mail-wr0-f196.google.com with SMTP id c13-v6so8436149wrq.2;
        Tue, 26 Jun 2018 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g6CNNrYYUy1FNCufln/AxJM9lQ5M/knzFeJ83RDDU1c=;
        b=SyaJKjZeS9aAA89wosg+MvwQQRYSjjbqE5OSEDbWjDmM1nFSeVOV776xYBz9kzikDE
         J/aUhWDfTdhSGqeFC5aAy6kVqlqDwS6TbCP4bVpbz07ShiemYtG3AIL0FSx49ZUhl1im
         umVYvD4ezP/17PTAetiBVrj3bVWAnUTQO5VkktyF6CxSamgKtS1o94Cs370qzMjmS7lZ
         MO/m8FYkT+gYQZHU0gwHlpX09C4/fhrqTFn9E+cOZ+WizK1Rmw1O7h9ZAHsAt3ggMz2l
         SNCRBc31baVmYQS7HUX8OBQJNojA//v8hPaVavJvdRkkcuFxekN8hNF+KRSVzGwswNFH
         e7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g6CNNrYYUy1FNCufln/AxJM9lQ5M/knzFeJ83RDDU1c=;
        b=lw4J2BeTanEVYhSdfF5HB/ZQ3mubE2+awyHv17rIL2VZ4V1LD7a77p/XNFsXaLVVti
         FVOZl1CMEOx7Rj9LrUrbXfMvr4dDRSer4CLLD9Z/Yob9hPptZ/PHe7QNW3xXwWBeTQ59
         8rJuWNkG0FIR+a9PDSEUo0J/vumh80L+oCL7FndK/rVxr/DO/4+70szYTJeHOLgPZfWr
         njhKpaDz/eZXvNkTqno3JLTvs4vfvxo47paczOjdhvUSEfszTccPGNzEALY7BY8RbZKZ
         sX0wl1QJ/cxQPEilv3LcILQLQkEZyj0GXaKgFJ9yzoKflmUeYQGc2e8/485tKRAzTSnB
         cZkw==
X-Gm-Message-State: APt69E1EUTwKQRw7vKYs8nn5TpX912wWAsip7TYhqEGTKflAfuUHsTT5
        eYLE6kUgaywbggXoPklBBaGExG8A
X-Google-Smtp-Source: AAOMgpcX9554i2c1gG4ZV46Qz9kbG43vLotac44uH2sJDICszd2FU91KcddwEiiVx/9SoszDTjAmmQ==
X-Received: by 2002:adf:92e7:: with SMTP id 94-v6mr2629606wrn.70.1530042066781;
        Tue, 26 Jun 2018 12:41:06 -0700 (PDT)
Received: from [192.168.1.18] (dkk4.neoplus.adsl.tpnet.pl. [83.24.14.4])
        by smtp.gmail.com with ESMTPSA id 72-v6sm3111326wrb.22.2018.06.26.12.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 12:41:05 -0700 (PDT)
Subject: Re: [PATCH 4/9] devicectree: bindings: fix location of leds common
 file
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
 <51f7b37fd560a2cf8a79db5222bf02abef97510b.1530005114.git.mchehab+samsung@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a47c6716-ef88-464b-bc9c-236ff90b88b1@gmail.com>
Date:   Tue, 26 Jun 2018 21:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <51f7b37fd560a2cf8a79db5222bf02abef97510b.1530005114.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro.

Thank you for the patch.

On 06/26/2018 11:49 AM, Mauro Carvalho Chehab wrote:
> The leds.txt was moved and renamed. Fix references to
> it accordingly.
> 
> Fixes: f67605394f0b ("devicetree/bindings: Move gpio-leds binding into leds directory")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>   Documentation/devicetree/bindings/leds/common.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> index 1d4afe9644b6..aa1399814a2a 100644
> --- a/Documentation/devicetree/bindings/leds/common.txt
> +++ b/Documentation/devicetree/bindings/leds/common.txt
> @@ -31,7 +31,7 @@ Optional properties for child nodes:
>        "backlight" - LED will act as a back-light, controlled by the framebuffer
>   		   system
>        "default-on" - LED will turn on (but for leds-gpio see "default-state"
> -		    property in Documentation/devicetree/bindings/gpio/led.txt)
> +		    property in Documentation/devicetree/bindings/leds/leds-gpio.txt)
>        "heartbeat" - LED "double" flashes at a load average based rate
>        "disk-activity" - LED indicates disk activity
>        "ide-disk" - LED indicates IDE disk activity (deprecated),
> 

Applied.

-- 
Best regards,
Jacek Anaszewski

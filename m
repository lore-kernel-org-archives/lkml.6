Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9287FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F00222BB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVJEv1aT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfAEWyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:54:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfAEWyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:54:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so19975188pfk.10;
        Sat, 05 Jan 2019 14:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nFpbjDsPLS4jFHq0s+SxgHmBdArZMJRGWzNgZRlejnE=;
        b=QVJEv1aTPGi58WaG653tqlWLEGhatfqvtcB4y6OV0BcBRZkYh17/9JC7k9to+8mCrb
         3+v0gTwOafuvOYtv8HK0gR8yM40hG8dWMKaKhjzpCJpt1+R/hZlqlcez2Ej3+QSS2xpP
         2mlTa2Jpupdx+x/Bck7GjfyY/TUKZvGHEUBk35eAz03XLoZs+OdUofUq54bXFVtyTdy7
         khiF3k3ZrsBzhonl+xqIH675GPo2BZOoCIRSaVLoVyl9Tp5VojYnJURKF5I+anR1FDtp
         UmNCAQr3R8B7ta1IGP5ydLa+5STE5uUnfnFMxDDPa736hEofHtjIDeoIlQIrkiE1h/Kh
         MmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nFpbjDsPLS4jFHq0s+SxgHmBdArZMJRGWzNgZRlejnE=;
        b=hUj3QNvuP0xECvWMcZ8ejhJ4q88Od9Fy6BXR1FiSXExy2v1+gYJQszVUkfYbLy4JAe
         tTwaKtB5iw5L5/LY42mbdKA0jLFMseuzTgk1QwmLHwhGITlcS+o2usAcQqpdRV96MBLx
         Iaoekcz2WWZ8UHTXqcjWAtuKcAE8OyVysSuVKgNSmgNYORHeKOYYm7o9iHqFBgEiSdMn
         7RlFvi7o1jJ1PQDPAzjuLQFF6kqbrvRZE0ARU4/B96TMLiRcFr4nIa/2OSKY23Y2mEZu
         lpiRFqa1Yv8TO/qP9MTvpOVlq3wdpvxxiZWwKgOLd8+dLVianHlI2X5XUWWQl9d5DCCQ
         J2Pw==
X-Gm-Message-State: AJcUukfBpf9kM/SX5LDDearfaec7lnY6vN+UYAxvmlPS6DwUjS70wNTO
        bMQXsExzNfJ+h32WTzWGNzA=
X-Google-Smtp-Source: ALg8bN63PbEoOxWIfKLj12M74fgwLUseNF6q9mlYdV5M+EKmfLNzE34SGcuTYEOATnt0/Vx1AHcFYA==
X-Received: by 2002:a63:86c1:: with SMTP id x184mr2639140pgd.305.1546728876437;
        Sat, 05 Jan 2019 14:54:36 -0800 (PST)
Received: from localhost ([187.174.134.190])
        by smtp.gmail.com with ESMTPSA id u69sm109339794pfj.116.2019.01.05.14.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 14:54:35 -0800 (PST)
Date:   Sat, 5 Jan 2019 22:51:47 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     hadess@hadess.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Message-ID: <20190105225147.le5fgpnvq7sctxe5@penguin>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, Jan 04, 2019 at 05:00:48PM +0100, Alex Gonzalez wrote:
> The Goodix touch controller allows the use of two optional GPIOs (RESET
> and INT) to reset the touch controller, select the I2C address of the
> device and exit the device from sleep mode.
> 
> The current implementation requires both GPIOs to be provided, however,
> it is possible to provide only the INT line and not to have the RESET line
> available but pulled-up.
> 
> Designs that only provide the INT line are able to operate the touch on
> the default I2C address but will not be able to reset the touch via
> software or place the device in sleep mode.

I do not have a datasheet for the device, so I am not sure if reset line
is actually needed to put the device into sleep mode. As far as I can
see from the code we suspend it by pulsing INT line and then sending a
command to the controller, and resuming by pulsing the INT line again.
So it sounds to me INT only designs _could_ place device in sleep mode.

As far as the patch goes, if you do not need to execute reset or put
device into low power mode, you do not need to specify any of the GPIOs
as GPIO resources. Simply specify the INT GPIO as your interrupt source
(GpioInt() in ACPI world or "interrupts = <&gpio NNN
IRQF_TRIGGER_WHATEVER>" in DT world and be done with it.

Thanks.

-- 
Dmitry

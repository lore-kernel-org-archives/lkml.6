Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62EDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D2B20684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5l4MzfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D2B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeJAQVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:21:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51926 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbeJAQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:21:03 -0400
Received: by mail-it1-f193.google.com with SMTP id 74-v6so10398859itw.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5hlSnng3nEDrenUljXHXxiWGjY3SD+JKaRXxY8QqmA=;
        b=Z5l4MzfSEfAAEvrKwXNFKWcYfb4xK7GaiNHwZrHSaPPKwQDuqTvjPyurfIAhYpSyBu
         ab1Ij+4x5MaVXv2UgKGZKPNevaWSpgnB7c6SiVEgvS6ivrkanzfsGM95NmT5Q10ueeSo
         yIEZT56rXmxcWl+b+avsKpGUWBPkzGPmjdcdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5hlSnng3nEDrenUljXHXxiWGjY3SD+JKaRXxY8QqmA=;
        b=hWMZjUPdXK7v0tOp0hS2+Wt96wKw+8l1mz0hKs/OHBHg2Crxhv1fHZIRPH58sTBkcE
         GiIgzRD0stS3Ib5SD7zXra+IuUMr3onbLH7ax03uX68eyRauRAG6u94xB+7bNOYv5hhC
         KeFcmsZ3RP/veoWh1L3t13wTAOjl+hnPcsoAm9btB40c4C46IKn3hkvQRbB0nAXhSlh6
         ICn8i2o+uoyko1iJvvjqDCelebleqCmVm1Ga58imDqbZGvfNXGDitFeorVmrspe+t/1m
         9CHn0sOWwcj3J/EPPvSrz1vErVacHDT6lgPP5WsF/j/xLcg7DxQzggjUp+1RA2eejLyG
         NULQ==
X-Gm-Message-State: ABuFfohTvg51eOq4OaeO/1ahd0QFjcPVINeBbfJwBDAVqhnChbPDx879
        qTVJ4MrXe4y7kAskWQhCNGFc7An5KketYm8XMwQx0Q==
X-Google-Smtp-Source: ACcGV61vtXMdJSGc8IRz9eXH2BQJbKyW/YeZKhPmGuoqLWVJvkPWs21appvqVfiaYcqo3Eu3cfsF/3AxEFVs0Pk2Ifc=
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr10003767ite.16.1538387047601;
 Mon, 01 Oct 2018 02:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180930122703.7115-1-johan@kernel.org>
In-Reply-To: <20180930122703.7115-1-johan@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 11:43:55 +0200
Message-ID: <CACRpkdaG-S-6LfCKgxz4jdbD=kRO7q7k_8FAHqsSNBPdC07iDA@mail.gmail.com>
Subject: Re: [PATCH 0/2] USB: serial: gpio line-name fix and FT232R CBUS gpio support
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, pados@pados.hu,
        Loic Poulain <loic.poulain@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 2:29 PM Johan Hovold <johan@kernel.org> wrote:

> Turns out gpiolib still doesn't like having non-unique line names, so
> drop the line names from the recently added FTX cbus gpio
> implementation before adding support also for FT232R.

Oh.

> Linus, we finally got around to adding gpio support for FTDI devices;
> see commit
>
>         ba93cc7da896 ("USB: serial: ftdi_sio: implement GPIO support for FT-X devices")
>
> in my usb-next branch (and linux-next).

This is good news, I think it's a pretty neat way for people to get
a few inexpensive GPIOs from their serial adapters.

> The gpiolib warnings and inability to use the legacy sysfs interface
> prevents us from setting the line names however as someone is bound to
> plugin more than one of these devices at some point. I think we
> discussed this issue with the name space and hotpluggable devices a few
> years ago, but looks like this topic may need to be revisited.

Hm I guess the right long-term fix is to allow per-gpiochip unique
names rather than enforcing globally unique names.

The idea is to make it possible for userspace to look up a GPIO
on a chip by name, so if the gpiochip has a unique name,
and the line name is unique on that chip it should be good
enough.

Yours,
Linus Walleij

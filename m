Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D8C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8088820867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IT3naONL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8088820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeLAJh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:37:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39142 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeLAJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:37:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so6333151ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMOB10ie/ApF9p+FJJZhvby9IjUdiBRkT3RDtd9UZkY=;
        b=IT3naONLMiau8fjFxENHvVUgei3u1NWunAp63MW3nt3160RP2DX6Z/yfypLvdAZEUW
         VO5e4ucx7bI8hfRldzTtw2HYYY+3cZpg7XZX7UOruGtEIibYC3aTVTGAlFiIIIuofhI3
         Fc6QCcHZ/EHEi/t40sjt36i+Txgze0ztFDqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMOB10ie/ApF9p+FJJZhvby9IjUdiBRkT3RDtd9UZkY=;
        b=nCfPQA01vtfu8G3XW65UGp7YGkOVAOUEA/BA5YK1R0JvDDnxU4Z70bOGnIIpuaVlom
         PK2uDsO1BeZMpeTxKBnRfGr5c/teVJjB1+s+5f9X0UMNNoHRcPii09dH2U7QD6LcN1Tw
         BHHEufUUq4mg6TjVgm3drtH/RenBxvjAfciLdWB6604YnFlfpiDDtMTzOWHz945ymWag
         XWdjeRvmTncMXflIkqJWe+xsgiOff3cd6PpDhM70VqPGXn96pfzNqTVBSY2X63hHOV9I
         t0TuRXt2wTu5qhdv4TjnS0MklFW9a6+HbkPMabAcp9bK3IU56fSMxk48cv/IhQaUfDh1
         XM+A==
X-Gm-Message-State: AA+aEWbHkPgJYaWKTZx83NENZ22C3LTdt8mx/Mt6eREvphUqjD8AwRl8
        ibPMLLGYSkMlFZim44Tr5A/0mhqAd/QNzOOTloeZSg==
X-Google-Smtp-Source: AFSGD/VyUc2xq2emiQwtzER7TMHmq6/gqqL6cG8jRktUVj6RSGbVzR6P33LZ6+PL6wfXXdjVE4If1nbbjpDqb20aNyQ=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr4944780ljc.97.1543616797483;
 Fri, 30 Nov 2018 14:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20181120134032.31645-1-brgl@bgdev.pl> <20181120134032.31645-2-brgl@bgdev.pl>
 <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de> <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
In-Reply-To: <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Nov 2018 23:26:25 +0100
Message-ID: <CACRpkdY9-umyz=T8v0ZmfOx8tFapvDguS3B=BYAVkY73BrkxqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:14 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Thomas, Linus: after commit fa38869b0161 ("gpiolib: Don't support irq
> sharing for userspace") some libgpiod tests are failing because we can
> no longer depend on reading the value of a dummy GPIO after detecting
> an interrupt to know the edge of the interrupt. While these interrupts
> are triggered from debugfs and debugfs is not required to maintain
> compatibility, I thing having a working test suite for the GPIO
> subsystem and uAPI is worth applying these two patches and also the
> previous one[1].
>
> Can we have them applied for 4.20 or are there any objections?

I'm fine with applying them if I can just get an ACK from one of the IRQ
maintainers (Thomas, Marc).

Yours,
Linus Walleij

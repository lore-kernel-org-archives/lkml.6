Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1D2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpRcRIEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfAJUfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:35:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46519 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbfAJUfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:35:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12855181wrt.13;
        Thu, 10 Jan 2019 12:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5uXI/gYnx6tkF/mAv6kSNlRr8gdBVN63dgNFFM+Xu1M=;
        b=rpRcRIEszuMwYmKH+EgAkh3KG3bl1/tZ0klGiljMqkqGnrBpFt8b249VGRImTKgkwb
         ChcdzZzblR65egautzA5lNgVGtITiBGKD0G+dl2/p4HrLDecIrLsHjyw/avxuTdWnhT3
         5J3/BFTk1vii4tRus0rtPZltW12onf++RyNRfp69F8RQMh/uPV1cCwJ93RHfDoZsBzWr
         L/p5GZ9JRE4dUV1GcnqNEkw1hYQ4ZTtq8I85GsD69uAQ+cJJBUJRCCcTbdzBEIIi7BUQ
         SFtkw/d1E8Y6OCRImcz0OCcikup1rzyeFg4f5wQeVC6R64uL+QUjyYpYD2gnQYtyKNU0
         tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5uXI/gYnx6tkF/mAv6kSNlRr8gdBVN63dgNFFM+Xu1M=;
        b=a4ZRxsF6qKAsEXkd+ZZdt1kWmB1MOoRp78MPd18zggLAaTFbXUncxMiKZyF5mJHr+V
         cn+2Zefr4tGLhsirnAWRLkQR9XgXENqGyhREpH9lW0zgRCAS+Fb8UcZ3g/FTULoSSTvz
         MErKB7eDG9WkWyZ9Gan2LZZc6R1uswnJHOwPpjly69xewe3WxF0WVrHq1CnaSrb/jZFS
         vA6FtzNL950Nnh+R7QPnaWh6ZYOyMW5oMWIpy34tabvgelDQ8JBOW6EI2T6rMeNuc1fu
         53N9TyXpAijAwAxt49tpZH3vJiC4xHGhkMwvPWtIRuufXnCrxT9pea1gmBG+jy1MMDOZ
         1A0w==
X-Gm-Message-State: AJcUukeffMg9WqE76Z912kGDvhDO3E+EK2KYCRFLav9f+PHv40EUTcTJ
        zhBYZ0WBUlhJblWwCh1/eeKPZh7v
X-Google-Smtp-Source: ALg8bN5f6OmhOnxMMYBsvnmGsmzqKvsCFGCSD5hhar/gJPrE/dtvdJT6obzNg6MRLcAtJIZ6ZVb5PA==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr10635271wrx.306.1547152537525;
        Thu, 10 Jan 2019 12:35:37 -0800 (PST)
Received: from localhost.localdomain ([46.216.193.112])
        by smtp.gmail.com with ESMTPSA id c65sm17403216wma.24.2019.01.10.12.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 12:35:36 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.91)
        (envelope-from <jekhor@gmail.com>)
        id 1ghh38-0006u9-JH; Thu, 10 Jan 2019 23:35:34 +0300
Date:   Thu, 10 Jan 2019 23:35:34 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Message-ID: <20190110203534.GA25269@jeknote.loshitsa1.net>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20190109214756.GA18115@jeknote.loshitsa1.net>
 <20190110133236.GC3837@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110133236.GC3837@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:32:36PM +0000, Charles Keepax wrote:
> On Thu, Jan 10, 2019 at 12:47:56AM +0300, Yauhen Kharuzhy wrote:
> > On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > > i2c_device_remove does not clear this. When rebinding an I2C device,
> > > whos IRQ provider has also been rebound this means that an IRQ mapping
> > > will never be created, causing the I2C device to fail to acquire its
> > > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > > forcing i2c_device_probe to lookup the mapping again.
> > 
> > Hi.
> > 
> > I found  driver i2c/busses/i2c-cht-wc.c which instantiates I2C device
> > (battery charger) and passes IRQ to driver not using standard I2C IRQ mapping code.
> > So if we reprobe I2C device (by reloading I2C device driver module or by
> > manipulations with sysfs), we get invalid IRQ number for client:
> > 
> >  adap->client_irq = irq_create_mapping(adap->irq_domain, 0);
> >  ...
> >  irq_set_chip_data(adap->client_irq, adap);
> >  irq_set_chip_and_handler(adap->client_irq, &adap->irqchip, handle_simple_irq);
> >  ...
> >  board_info.irq = adap->client_irq;
> >  adap->client = i2c_new_device(&adap->adapter, &board_info);
> > 
> > 
> > adap->client->irq will be reset after device removing here.
> > 
> > 
> > Any advice to fix this? Maybe move initial i2c_client->irq value to new field
> > like client->init_irq and copy it to client->irq at probing, for example?
> > 
> 
> Could you be a little more specific here, are you saying if you
> reprobe the battery charger device or if you reprobe the I2C
> controller itself?

If I reprobe the battery charger.

> 
> Apologies but I am having a little difficulty working out the
> path through which the IRQ is not reinitialised. As I would have
> through the battery chargers probe would have reset up the IRQ
> then the core would pick it up again from there.

No, this I2C bus driver(i2c-cht-wc) pass the IRQ to charger not throuth
ACPI of OF but by initializing of board_info.irq field, so I2C subsystem
cannot reinitialize irq automatically.

I am not sure if this is right path for IRQ initialization and maybe
should be changed for this driver.

> 
> Thanks,
> Charles

-- 
Yauhen Kharuzhy

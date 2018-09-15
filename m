Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D30ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAEF20882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 02:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAqTLHZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAEF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIOHnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:43:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40549 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeIOHnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 03:43:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so5181216pga.7;
        Fri, 14 Sep 2018 19:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ER2mgwnaXmj/y1r9Xr+9FhLTjJ4Ui/i7KDp2PQG4T08=;
        b=JAqTLHZyzKcDxV1+RJLgl7tmzbXoNoqtTOGTL1fPtN01DGlUAP2mOQZiw0by7WDZpf
         V6Y4edp+sD48qk2IWttx16y4SEwY8aZusHzqIPx7LyM82tX+JfXPqEBniTYWjNap/u09
         Lv0Zq4gV2S5iiBpbdyoAdb4AMEmUwDYIkaBa8QWCn5VMKmOWsp7SgXjbrVgwqGpyJ0Za
         9u5BOJzBe9bACAnniOQ+u5Ds9Urxtr5tOarnzHXKeMC/QHQZ6jdWb8sOY8n1Jy+8RYjP
         hfJmt9jKyx2bKNsxR8Z4cqqnNThIuLY0vaE1DcGQ2SaOIyGCVJfPf/knBDYkFkiaJdDb
         f7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ER2mgwnaXmj/y1r9Xr+9FhLTjJ4Ui/i7KDp2PQG4T08=;
        b=YU4HFekE4FOSbm7WV6UPL1muMWsUPDevTYx2Zh9Np/qUR5UyVsrQ6HmHMXXnRcCFvw
         Vxklx+NzEI6ux+kNMnCTXOC3qtqWcrcy3a46vS4liAZ86go8uhCZ/A8SzAnK6Kl4b2VG
         u3UL1TD58onKD74cwy32ldP+8QW+CSxf01NejEPYO+1WaKnJ/Z6l5xHIDoxHyfOVBrpM
         nNry6vBlHckl6g59c0+kScJWS8BwLjXhu4QwTaspd+LDyZwG+5YGFP5GqHxLRxuclwh7
         Q/ajuAJ9nspWZ1j7nEQWXm38cpyShhyaQFxS0vyz8S3P1F+I//HudNuNnaEEKoZ62rQF
         67IA==
X-Gm-Message-State: APzg51BtcOOaGrw9ZofRVccrgovYKmqaPpf1sl3OMR6RminwNQsZmCJW
        oXMmL47KluwlRpZqOIhudNg=
X-Google-Smtp-Source: ANB0VdbblaEs+bPgjES107XIFuuL3Buy6LT6J6gvV3+BBQkamx8jivV1d2tl2L6/7AIICzgMOBCzVw==
X-Received: by 2002:a63:1618:: with SMTP id w24-v6mr14372310pgl.43.1536978366667;
        Fri, 14 Sep 2018 19:26:06 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id d10-v6sm8988928pgo.2.2018.09.14.19.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 19:26:06 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
Date:   Sat, 15 Sep 2018 10:25:57 +0800
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Song Qiang <songqiang1304521@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: Add driver support for ST's VL53L0X ToF
 ranging sensor.
Message-ID: <20180915022557.GA18453@Eros>
References: <20180913022229.21563-1-songqiang.1304521@gmail.com>
 <20180914184322.GA9481@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180914184322.GA9481@himanshu-Vostro-3559>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 12:13:22AM +0530, Himanshu Jha wrote:
> Hi Song,
> 
> On Thu, Sep 13, 2018 at 10:22:29AM +0800, Song Qiang wrote:
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into a iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > This version of driver supports only one-shot mode, and it can be
> > tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > 
> > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> 
> I'm sorry but you probably need another revision.
> 
> And don't feel embarrassed, I mean this is your first patch
> in the kernel and that's an IIO driver!!
> 
> I used to fix spelling mistakes, align parameters, ... an year ago
> and even those got rejected several times ;)
> 
> > ---
> 
> > +ST VL53L0X ToF RANGER(I2C) IIO DRIVER
> > +M:	Song Qiang <songqiang.1304521@gmail.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/iio/proximity/vl53l0x-i2c.c
> > +F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> 
> Obligations!
> 
> Just don't go "Keyser Söze" once you're done with your major
> at University. You would need to test/review patches in future.
> 
> Not a big deal though..
> 
> > +
> > +static const struct of_device_id st_vl53l0x_dt_match[] = {
> > +	{ .compatible = "st,vl53l0x-i2c", },
> > +	{ }
> > +};
> 
> MODULE_DEVICE_TABLE(of, st_vl53l0x_dt_match); ?
> 
> 
> Thanks
> -- 
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology

Hi Himanshu,

I think I'll do some double check on it to make sure it's good, compare
my patch with other drivers to see some more problems I miss.
Thanks for your kindness, and with or without this patch accepted, I've
been feeling glad to get connected with the community and learned a lot
from people like you. :)

yours,
Song Qiang

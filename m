Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3383EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E128E20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwDmVLbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E128E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeINX7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:59:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34063 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeINX7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:59:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so4804409pgv.1;
        Fri, 14 Sep 2018 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0zYx7tQE/lAU+PvvfjewRMWL9lA+OZfure6E93SwTOs=;
        b=lwDmVLbu5rtHfA3BkWxL1yzhzvlxNnQ2Q5Z3x/3i7eCIRLn4msPX/+AouxRLf2V98G
         Q5JfgHGR4DnLUw+CoOtcjcG8y2YMbe9ySJTbmAm9LgC3iyH/j07EKXDSh2o7qpxsZ+xp
         bq2T5SqeIa9k9me7d1yyAIpIBSu2k0qTs6O1t9S7LEIFKviwEf9FKkv+AQ5B44BIle7U
         Q+jXbf4DaSoiLjWI1d5Kk3KXJMfXyujTJS3kjsUdvov46IbDazfR3MWv1ZAoZAjQPu8Y
         qUb8laiNxB9LNJnU7vq/tdTkxxd/7hmPNBTOfsv8yxLbWtLw5kYNMXbJywSpEOl2ySJ+
         l8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0zYx7tQE/lAU+PvvfjewRMWL9lA+OZfure6E93SwTOs=;
        b=PoC9zmjhYfkQzDagyqS6v7mR1dth/ynB/nLarpYORY3w6kd3JATG3DFO6+87k74Dq8
         G3KmiGDzI/InaqXa66aZupXudn8lRVYNuMcH5YZtYksTnBDLaNHaUdEBgJpnQZcv49JK
         NypH4dVIlZAtbSwm+sjpnb+bqeW+eplFf7sqw+HwGYFKrsR5dH3Z1nXatIQfR6TblbQd
         iDGiSYaIonne7wKmvfmOMIFJwOS7S1HFN/Yduu1szNY81Ev6DMHkXfFb96xhPthure2Y
         CpgMTbnY0KfWs4VipNREg/7xNB/PNs3PWabw+HWuWpNu6TiObMqgJwO4Nx95NMM76M9I
         A02g==
X-Gm-Message-State: APzg51AVcE7u9Idy1d6zwpnf4uO7U+TXHAv/fqenSVNmOUjAiueirECG
        JVEdZZMTsBmLE7K9QQR5ZTE=
X-Google-Smtp-Source: ANB0VdbVDKRGGN8Siw++RhKcVkpYq4jRd1sTGuBX+hRS5GWs90R7cltUabzIm7/uZrj3K+djsryS/g==
X-Received: by 2002:a62:45d2:: with SMTP id n79-v6mr13874182pfi.137.1536950613215;
        Fri, 14 Sep 2018 11:43:33 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id 187-v6sm10659379pfu.184.2018.09.14.11.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 11:43:32 -0700 (PDT)
Date:   Sat, 15 Sep 2018 00:13:22 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: Re: [PATCH] iio: proximity: Add driver support for ST's VL53L0X ToF
 ranging sensor.
Message-ID: <20180914184322.GA9481@himanshu-Vostro-3559>
References: <20180913022229.21563-1-songqiang.1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913022229.21563-1-songqiang.1304521@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Thu, Sep 13, 2018 at 10:22:29AM +0800, Song Qiang wrote:
> This driver was originally written by ST in 2016 as a misc input device
> driver, and hasn't been maintained for a long time. I grabbed some code
> from it's API and reformed it into a iio proximity device driver.
> This version of driver uses i2c bus to talk to the sensor and
> polling for measuring completes, so no irq line is needed.
> This version of driver supports only one-shot mode, and it can be
> tested with reading from
> /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> 
> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>

I'm sorry but you probably need another revision.

And don't feel embarrassed, I mean this is your first patch
in the kernel and that's an IIO driver!!

I used to fix spelling mistakes, align parameters, ... an year ago
and even those got rejected several times ;)

> ---

> +ST VL53L0X ToF RANGER(I2C) IIO DRIVER
> +M:	Song Qiang <songqiang.1304521@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/proximity/vl53l0x-i2c.c
> +F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt

Obligations!

Just don't go "Keyser Söze" once you're done with your major
at University. You would need to test/review patches in future.

Not a big deal though..

> +
> +static const struct of_device_id st_vl53l0x_dt_match[] = {
> +	{ .compatible = "st,vl53l0x-i2c", },
> +	{ }
> +};

MODULE_DEVICE_TABLE(of, st_vl53l0x_dt_match); ?


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology

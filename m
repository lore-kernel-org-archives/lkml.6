Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D63C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB67205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="vrbI7anJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB67205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeKAXih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:38:37 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43188 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeKAXih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:38:37 -0400
Received: by mail-yw1-f65.google.com with SMTP id j75-v6so7972498ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fElzWe2NNg7U5IzTkze/2y/3Xx+Q4y3yBOMkhfvRtA4=;
        b=vrbI7anJ+W8dR+iY6HtRpTf9lC9nlFz5D9Zxs0Crfq/l9K8w0ZnGaJklc74wPQKm0O
         fgLCTbU7OSa95yY18aLDztEwfELQFzdQaJkdFJoF1idhp0BASn2P4NeqzivBY9dqvGgY
         +SeOPYPodGqP8GobhZNPuWjNUFeoHcToinGYjei5sonB6jtMh1eJ+BwnI8sW/aQ+xLov
         Yi9iO+/jBMOxQM70N4ENQ4qLAWl5VjuSXAvykGvawZ8sIEUp0vu0C9J1Wc2UWGwPinNl
         p85mzpEvUs5DJW+Nr4d97rDwATcsi7PXEcDwJ+BHDtH4MrRiR0XdlO5lqYQwTNzIU2mu
         96Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fElzWe2NNg7U5IzTkze/2y/3Xx+Q4y3yBOMkhfvRtA4=;
        b=e/QdraLaz2C4JFdmrAGtRmBmZvRpbQQkeYPEfZuAEcqAHEt7R6IY9++MA8XeYEbdmF
         0noQdENLVUG18AmCxAMt31lpTypuJl8T7D2UsG+gCNCug+dYZzK6wzuM+zMfgbSMLSGM
         d93mQe0cnMJ4CvNrxp814R1qA0UJQ3+TjEt+bzSZHl6e/w8ds69FCx0o2Wx2iWWxs4Cv
         1FaGcHiWbTAZg76dfWWFcFgFesGAuy0Udn/3Dx7ZDnZ/58NkiSB7hx7q+o4PILpTJL37
         LF75lSMk0xxbrCxIYeWZ4Q+SGWoceCxVpVaeZiGrvER8tMKpwm009ob5CeElLKVTbbct
         UmWw==
X-Gm-Message-State: AGRZ1gJNANpEoZVd5bWpmXJ71gqqAOcH+W8W7Mrp+m+ZnGnwNVrO5ZFv
        rxdm+ZP4RIMbhQFYUOnwOFWFPA==
X-Google-Smtp-Source: AJdET5ek7Sgb/eqiqQCfqYN3r1elE3kfiQbTRTjEBTuL5p4ZIHYB8pVWPx+cr/SHk67tDfuWFKz0eA==
X-Received: by 2002:a0d:ebd7:: with SMTP id u206-v6mr7843304ywe.40.1541082922540;
        Thu, 01 Nov 2018 07:35:22 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id x3-v6sm6603045ywc.56.2018.11.01.07.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 07:35:22 -0700 (PDT)
Date:   Thu, 1 Nov 2018 10:35:20 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ntb: idt: Add hwmon temperature sensor interface
Message-ID: <20181101143520.GA1939@kudzu.us>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
 <20180717092437.18918-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717092437.18918-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:24:33PM +0300, Serge Semin wrote:
> IDT PCIe-switches are equipped with an embedded temperature sensor. It
> works within the range [0; 127.5]C with a resolution of 0.5C. It can
> be used to monitor the chip core temperature so to have prevent it from
> possible overheating. It might be very topical for the chip, since it
> gets heated like in hell especially if ASPM isn't enabled.
> 
> Other than the current sampled temperatur, the sensor interface exposes
> history registors with lowest and highest measured temperature, thresholds
> and alarm IRQs enabled/disable bits, ADC/filter settings. The device manual
> states that the switch is able to generate a msi interrupt on PCIe upstreams
> if the temperature crosses one of three configurable thresholds. But in
> practice we discovered that the enable/disable threshold IRQs bits interface
> is very broken (see the third patch commit message), so it can't be used
> to create the hwmon alarm interface. As the result we had to remove the
> already available temperature sensor IRQ handler and disable the corresponding
> interrupt.
> 
> Current version of the driver provides following standard hwmon sysfs
> files: temperature input, lowest and highest measured temperature
> with possibility to reset the history, temperature offset. The rest of the
> nodes can't be safely implemented for the chip due to the described issues.
> 
> Changelog v2:
> - Add "select HWMON" to the NTB_IDT kconfig
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

 was waiting on you to address the kbuild errors, and it appears you
 did already.  Somehow I missed v2 of this series and just found it now.
 Sorry :(

Applied to the ntb-next branch

Thanks,
Jon

> 
> Serge Semin (4):
>   ntb: idt: Alter temperature read method
>   ntb: idt: Add basic hwmon sysfs interface
>   ntb: idt: Discard temperature sensor IRQ handler
>   ntb: idt: Alter the driver info comments
> 
>  drivers/ntb/hw/idt/Kconfig      |   4 +-
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 317 ++++++++++++++++++++++++++++++++++------
>  drivers/ntb/hw/idt/ntb_hw_idt.h |  87 ++++++++++-
>  3 files changed, 353 insertions(+), 55 deletions(-)
> 
> -- 
> 2.12.0
> 

Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81269C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449AD2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="c3AdRRpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449AD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeKAG1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:27:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45156 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeKAG1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:27:15 -0400
Received: by mail-yb1-f193.google.com with SMTP id 131-v6so7271844ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0G85Kx39zGxZ8q3L47ldXCNqZ5BBMx7UP+SlzKDVKpQ=;
        b=c3AdRRpeyp8+YJN6JpQrI71DHsfwkrXm1/NMqs+5a0mp5Jadcy3o91bY6NrvNZiFev
         8H0A6QyBnDRkDEiRsk6I24CKPHhsn1JMPgCXLZ/QleMXlS+NIDYHF58VcJ+7fzInSHtL
         f4sgRyoPMF/NypZeYO1vY8oRu8/VCtERzTzwlQo2MHSr+p3TekVCQrcwBESmQqYn9it4
         ZMXZPWQqosgsv8ALfb9h1XJG4MW/R6o6awjKR9gOxIQ5b7I5OQ8NnkSSEF24V3XKPB+3
         VtzHKHmR+crwgKkuMlgvgUAoZTgzPmEZ2S36rjkOjdApRum+ZdxMEfjnFKrIX7usIMVf
         FIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0G85Kx39zGxZ8q3L47ldXCNqZ5BBMx7UP+SlzKDVKpQ=;
        b=p/SzP9hxGQcH1rBVS5VUp0U2vRNRql91a3NZX/vSbbo1Tzj4mRu3+1nrTZItvYTxN2
         OHNZVw6HmweZ+hOsNdWk5mqr1udwdRUwKDqD76g+AK9pRrPMoQOz8cGp1LaSdvRygz4Q
         TaHRI8Yo1Guwi6g8ji9j6v4THvZqCABg+613C15SWHvQjxWIzMIZ8WR/HUjkNWYd54n4
         1fs0tc9U1KgTUf4d9NXnFAQ75CMlghD+Jz7ZzOPkKG0pbnJIkxeN4dh4IvBA3EthOF9b
         /KfSwxcVXhCCnQczmhSvwO8kvvvN28shNX/+OWMmnRQGA9c/UAwU2hUMs9b3CgDo2qny
         8CCg==
X-Gm-Message-State: AGRZ1gKTKbvHEFvYMUdV+n95PajkBMe1TRhPVhz6ka8044HoiNc+QrWa
        +9+qIjYsnzBMWvzEjYnkyrEHTQ==
X-Google-Smtp-Source: AJdET5d8Tw99h0QcD8Xuse2qTw59Eh4HE74yp9sfGzesiO0My/VvlD4Kh8konllMUapl4cOpFet28w==
X-Received: by 2002:a25:2c93:: with SMTP id s141-v6mr4831307ybs.193.1541021244888;
        Wed, 31 Oct 2018 14:27:24 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id d63-v6sm5694499ywf.100.2018.10.31.14.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 14:27:24 -0700 (PDT)
Date:   Wed, 31 Oct 2018 17:27:22 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ntb: idt: Add hwmon temperature sensor interface
Message-ID: <20181031212721.GA2565@kudzu.us>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 02:58:30PM +0300, Serge Semin wrote:
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
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

FYI, I'm waiting on you to correct the kbuild issues.  I have been
assuming you knew this, but given the lack of follow-up patches I am
beginning to this you might believe I'm ignoring them.  I'm not :)

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

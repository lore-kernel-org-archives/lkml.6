Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B090CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC192243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX/xGEuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC192243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbeKMRtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:49:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34917 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbeKMRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:49:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so12129738wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 23:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5HrnPGp3249O39o6J4gzjwU/PlV+7vnwIi7rLqkTdPg=;
        b=YX/xGEuVFURRkn8vk8UrfIuPumsjjkItsUpe6h0UquS7yl9nk9YGUL3hoOfndSbQhc
         Ym6alDz8e8v1h1sShrnGhv31w2oZbGM98rm4DX629xsKy0iNI8spSlE3FCtSIy7YZZWD
         lux0+H+SrE7Gf1zS8Qgs6a+dhqK7I7HgUdEKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5HrnPGp3249O39o6J4gzjwU/PlV+7vnwIi7rLqkTdPg=;
        b=UXU4C91ltgb6lJ8H02yMQnel63EeSEY4msnEOfCHdCt6Gv128zh0kebiAKzfkUBE5d
         ScxH92hyeopzN4x5D+J6PoMel5IX78Ky9ytkPuyrQRW5VXrUpS/1L2ucrfxlrwZkWF/E
         FsOpy019zTfxowJex1HdIfYpLp8u2W90esMprxBxPu1cQfYnhlBjsapSKYeHEOSZ0H5S
         /clVKeOX2QwN988i4fSODZoAtPfatSjVJWUHthBO4YhigYAcHxlHkBpThvHIcItkv/Ef
         dcCv+m08heCGBYJwNyC7LZpH7em2W/RskpQH/LsAP5oke7bSo5kVCuvBSpr5SkU2yP+7
         DxFA==
X-Gm-Message-State: AGRZ1gLm7tQvSuBG4w6mec4Dj2Fs10KxTSmIaw63qt9jMUnFPTLC57cZ
        /ULnQitPd30cwIax/7Mki7lUng==
X-Google-Smtp-Source: AJdET5dXgAbS38m1RkrIegEBwL/f81sJ/B1MeiQ+ooJEPrq3mlel1/yTH/QWZbKXnYFufKY/MjBy/Q==
X-Received: by 2002:adf:bbc5:: with SMTP id z5-v6mr3846072wrg.183.1542095578931;
        Mon, 12 Nov 2018 23:52:58 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id t4-v6sm17007359wrq.80.2018.11.12.23.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 23:52:58 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:52:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
Message-ID: <20181113075256.GE29388@dell>
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
 <4f636dde-674a-1793-7798-c475065615a1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f636dde-674a-1793-7798-c475065615a1@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2018, Jon Hunter wrote:

> Hi Lee,
> 
> On 19/10/2018 14:22, Jon Hunter wrote:
> > From: Jonathan Hunter <jonathanh@nvidia.com>
> > 
> > The tps6586x driver creates an irqchip that is used by its various child
> > devices for managing interrupts. The tps6586x-rtc device is one of its
> > children that uses the tps6586x irqchip. When using the tps6586x-rtc as
> > a wake-up device from suspend, the following is seen:
> > 
> >  PM: Syncing filesystems ... done.
> >  Freezing user space processes ... (elapsed 0.001 seconds) done.
> >  OOM killer disabled.
> >  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
> >  Disabling non-boot CPUs ...Hi 
> >  Entering suspend state LP1
> >  Enabling non-boot CPUs ...
> >  CPU1 is up
> >  tps6586x 3-0034: failed to read interrupt status
> >  tps6586x 3-0034: failed to read interrupt status
> > 
> > The reason why the tps6586x interrupt status cannot be read is because
> > the tps6586x interrupt is not masked during suspend and when the
> > tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
> > seen before the i2c controller has been resumed in order to read the
> > tps6586x interrupt status.
> > 
> > The tps6586x-rtc driver sets it's interrupt as a wake-up source during
> > suspend, which gets propagated to the parent tps6586x interrupt.
> > However, the tps6586x-rtc driver cannot disable it's interrupt during
> > suspend otherwise we would never be woken up and so the tps6586x must
> > disable it's interrupt instead.
> > 
> > Prevent the tps6586x interrupt handler from executing on exiting suspend
> > before the i2c controller has been resumed by disabling the tps6586x
> > interrupt on entering suspend and re-enabling it on resuming from
> > suspend.
> > 
> > Cc: stable@vger.kernel.org
> > 
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> 
> Thierry and Dmitry have acked/reviewed this, let me know if you have any
> comments.

Best thing you can do to regain attention on a potentially forgotten
submission is to collect any Acks you have accrued (if any) and submit
a [RESEND].

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

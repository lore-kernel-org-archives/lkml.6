Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659CDECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2238920658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP7CEH7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeJQW0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:26:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39784 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeJQW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:26:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id p1-v6so24549639ljg.6;
        Wed, 17 Oct 2018 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ieKC4jnguOktgK7S+Fbd/wjEU+7sItu4oRaVek0xahQ=;
        b=TP7CEH7gJ9l9IrvxfMPOXXhsrtzCE6SbLFfxjDhtxZWbz9846Te2Uw0jmsAwptztS9
         ZzHZ0HBaaIErqTNMJ+wj/qzE9NrOtu8C27gTuQndP80qZ5ZVMXfqW99orPUw1TzIYT3O
         e6KsMpA0O57spmK9vFE63+nQoQf1CWztXvWX7dP9/AjpHhASY+GJBCjhfIGFj5o4gSL2
         EBdsZqlWsHg6JZh/N3il5E5sNUJzvRe+aHYVyF71ezVataEqOjbKXVMQo1hiDhBnFcLm
         q10sWpircIenpBV9uiNtqvVCJ0C2HBza2ubOHHkGmIhuN/2pxEklu7S/C7BqTLwotbWS
         fKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ieKC4jnguOktgK7S+Fbd/wjEU+7sItu4oRaVek0xahQ=;
        b=fLTdKa2aIg4/8m9PRe7/uT0AnCLEsZZsR26xXJfUNhM+f2uSOFjyfrfR0oP+a3piTx
         jdgsRacmSj7hPKw9rqQf2T1Aq7MD2GVMTO/iw8+SK/sqIGchJSP83+dS1EoiXsaKMAEe
         rrPoxFQMNkrI3F36b+/Wd8ztnG21yYJwUesdwCXHd3Obf/6khBGwTfHEofgNwnNQW5TX
         dpP8x7ZqzB2MeFnQRZlEeSQsO2fK8FjfZlpnzy/p4lUIfM4S/HlLTrJzHpQyRArR1E5L
         dyevejkHyY/XSP/gd+jBvy2za2SmnumLT+YzGHgPjmdQmqa8iF0sNnofeNjufoPfGApU
         a+Sg==
X-Gm-Message-State: ABuFfoijimWebHmHaQkJTt1G5gJIvIkIPj3hvX63BXdVWnfIUu6OFjbf
        WTz1EgVKGjV11VLKc6oexgdJY9eX
X-Google-Smtp-Source: ACcGV61gxDId8jQTiyaBhxp9Z9edxF6tG+mActOlEiM9kF6HwN4QTdPK/wY2mJJYTOQW+9a/dRmqcA==
X-Received: by 2002:a2e:651d:: with SMTP id z29-v6mr18484327ljb.36.1539786616976;
        Wed, 17 Oct 2018 07:30:16 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id m19-v6sm418311lfj.39.2018.10.17.07.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:30:16 -0700 (PDT)
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
To:     Jon Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180513211347.7187-1-digetx@gmail.com>
 <c1b73435-48f0-b445-568f-3c8942878123@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <47eaced9-761d-b8d0-2f43-41bf3dd050cc@gmail.com>
Date:   Wed, 17 Oct 2018 17:30:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c1b73435-48f0-b445-568f-3c8942878123@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 4:59 PM, Jon Hunter wrote:
> 
> On 13/05/2018 22:13, Dmitry Osipenko wrote:
>> Nothing prevents I2C clients to access I2C while Tegra's driver is being
>> suspended, this results in -EBUSY error returned to the clients and that
>> may have unfortunate consequences. In particular this causes problems
>> for the TPS6586x MFD driver which emits hundreds of "failed to read
>> interrupt status" error messages on resume from suspend. This happens if
>> TPS6586X is used to wake system from suspend by the expired RTC alarm
>> timer because TPS6586X is an I2C device driver and its IRQ handler reads
>> the status register while Tegra's I2C driver is suspended, i.e. just after
>> kernel enabled IRQ's during of resume-from-suspend process.
> 
> I have been looking at the above issue with the tps6586x because I am
> seeing delays on resume caused by this driver on the stable branches. I
> understand that this patch was dropped for stable, but looking at the
> specific issue with the tps6586x I am curious why the tps6586x driver
> was not fixed because it appears to me that the issue largely resides
> with that driver and any other device that uses the tps6586x is
> susceptible to it. I was able to fix the tps6586x driver by doing the
> following and I am interested in your thoughts ...
> 
> Subject: [PATCH] mfd: tps6586x: Handle interrupts on suspend
> 
> The tps6586x device is registered as an irqchip and the tps6586x-rtc
> interrupt is one of it's interrupt sources. When using the tps6586x-rtc
> as a wake-up device from suspend, the following is seen:
> 
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>  Disabling non-boot CPUs ...
>  Entering suspend state LP1
>  Enabling non-boot CPUs ...
>  CPU1 is up
>  tps6586x 3-0034: failed to read interrupt status
>  tps6586x 3-0034: failed to read interrupt status
> 
> The reason why the tps6586x interrupt status cannot be read is because
> the tps6586x interrupt is not masked during suspend and when the
> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
> seen before the i2c controller has been resumed in order to read the
> tps6586x interrupt status.
> 
> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
> suspend, which gets propagated to the parent tps6586x interrupt.
> However, the tps6586x-rtc driver cannot disable it's interrupt during
> suspend otherwise we would never be woken up and so the tps6586x must
> disable it's interrupt instead.
> 
> Fix this by disabling the tps6586x interrupt on entering suspend and
> re-enabling it on resuming from suspend.

Looks like it should work, but I vaguely recalling that something didn't work after disabling of IRQ on suspend. Maybe wakeup was getting disabled, but seems it is working fine now. Patch is good to me if you're going to propose it for backporting, but you should test that it works properly with all of stable kernels.

I just found this [0], seems your patch need to address the same review comment.

[0] https://lkml.org/lkml/2011/3/29/18

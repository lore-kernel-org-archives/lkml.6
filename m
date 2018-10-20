Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11344C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98FF21712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkDnSQU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98FF21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJUF37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 01:29:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46621 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJUF36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 01:29:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5-v6so17334355plz.13;
        Sat, 20 Oct 2018 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u93W8U1BXZRuxW4ZzE1X204W+P+mtpLFO7CXD2O2WV0=;
        b=qkDnSQU4wERupeFFOzz3W3yaGRnh5TEkg/NT7l/X764YSw1ARjifrFqI2iS20zN31r
         U6lR0HLrO2P1SKpMIKU6dyH/tJsDglwAEN0g9aOyM6FcwQP/PtJc9oNLQpB15/LBU4mD
         uXrO7Cy82LIvaTlOaaQh2iuHeuRvyCUJ9mGUKjzHj9crd5eLbnDzC0d9OfGppiR4NRfY
         WAuMMcXiwDQEiZPd46GUetBoV3EVpSJLuss6R9J+4e0xGOyVQp6/fQc157DFezdXK7pA
         00Q60znbIgLsztg7l9lV0pxrmFSscFa/e6G8jmVVOaFGtGpSKQDQS5aaXhLMO7v0M9Ci
         BOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u93W8U1BXZRuxW4ZzE1X204W+P+mtpLFO7CXD2O2WV0=;
        b=KmY45vBp1iJ0HqNI8jP+Tp0ic3Dm5gXsReIF8GHk7J2ioPFPhFvkNOgYcKDFLGCdep
         O5F+lOyj8Ryn8O+tcpgFzC17gKE8WWAqxfN0PrvVblWAuQqPRQuOGf5uy1mC+Mi49jvY
         un/76ImcSXjtViDEz83bBdESdANJiZspSLzgCn6RREdRZgTPl6JfPLQc4ewiy7B1Nw47
         0fD+R8ojsNuIMe4/9k7yPkKUbn44dUotqR6j8mQHL174w/NrtSuZspepScR6VINjdUUX
         ak3zO1Ost06PY7itLew2XgRiiix1PZj5ugEPs1ridaN2aEivW8IVQQhRxSqlOFe1LWeq
         2ayA==
X-Gm-Message-State: ABuFfohwFDMV+X/6Nx7Y20N00BzvQr1dyg+tcoWRzEyv0aNYysKuYSoL
        Nvddw4KCmCFqPn5cAl8Uzp+jigKp
X-Google-Smtp-Source: ACcGV61NQxgiaTS/rfRLwP8jgGCtc/9lhBUa+vU9YGNaa/S+dshk7YTLmNGhw4R87k0DKz3RUidelA==
X-Received: by 2002:a17:902:7142:: with SMTP id u2-v6mr39332749plm.154.1540070291169;
        Sat, 20 Oct 2018 14:18:11 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id k86-v6sm41986156pfb.167.2018.10.20.14.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 14:18:10 -0700 (PDT)
Subject: Re: [PATCH] mfd: tps6586x: Handle interrupts on suspend
To:     Jon Hunter <jonathanh@nvidia.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        stable@vger.kernel.org
References: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <79285505-02de-5616-0c95-87586e4a8919@gmail.com>
Date:   Sun, 21 Oct 2018 00:18:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539955373-13735-1-git-send-email-jonathanh@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/18 4:22 PM, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
> 
> The tps6586x driver creates an irqchip that is used by its various child
> devices for managing interrupts. The tps6586x-rtc device is one of its
> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
> a wake-up device from suspend, the following is seen:
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
> Prevent the tps6586x interrupt handler from executing on exiting suspend
> before the i2c controller has been resumed by disabling the tps6586x
> interrupt on entering suspend and re-enabling it on resuming from
> suspend.
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Tested patch on linux-next and v4.14, works fine. Thank you!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>

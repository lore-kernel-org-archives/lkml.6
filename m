Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870E4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACEB2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0pkfjKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACEB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeIEQbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:31:32 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46084 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeIEQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:31:32 -0400
Received: by mail-io0-f194.google.com with SMTP id y12-v6so5665391ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSf0yDi8PqP62CTn8/sU3Pa+MixB02TZKtGE3NSoeq4=;
        b=Y0pkfjKgPW9516glVG0uPvBYd09qQbYE7Mi7cyDTiM5jNz+OqPpY0/twRiiLXwiM/B
         S4+w4m3PlxQwI3ZIDgXwA0SOnVsw5QCV+viPAYJi/aflEte63I+xNGpFZrC93PdufyDb
         O7K8ysxZvmbeL3WK5M2FzP5wT57CaDLyFypqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSf0yDi8PqP62CTn8/sU3Pa+MixB02TZKtGE3NSoeq4=;
        b=dk4C+3sNJkYEAaY5/R1mpNzbn6ONjVO5ZUOg43UOHMh6XlW/6T2qSD54AW9CH+E9bZ
         U/b3T+E++HADx26N0b71rkbLiJ9d8bIWrhZJUcLXg2D896oLCc7WUFQ65HwSAykvGPgt
         VWrA2i1vcoBB7plU/EFdmhLiwFy6mUZP/nPkS7DUKsgKPKj5z+Z3JTYBoZbl5tm/k35D
         C1JxgBJSz6ShPkmcjGwHe4rcPE7H5GhlmRQ6kOYLVQcYrn9a2adR6qgSFjprRySVVs4I
         ZwKo2iqg//noXHKJTFF1X9heiLv7F7K8qpvkO8WE7Hgw4oL7fglxvpak/x9naR9auppC
         yoZA==
X-Gm-Message-State: APzg51CEGlYjtorrBz016pK/YFbZXe9UJUsg6XTI12zt+EQM0R7sNPo5
        9vEpfvrL1cJtl38HAQ7cYm9Qr7lytQ+dn+X2YJwjMQ==
X-Google-Smtp-Source: ANB0VdbfMo1JfoxIKco2xDuLX8TSGUjiRh5wKw2K4RYo/z9xrgDJQjjxd0WfCZ7cCFLT2CckSqrAK3GRvG4HrgTa0ys=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr23969169ioa.277.1536148895953;
 Wed, 05 Sep 2018 05:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <e80a35c7-a9f4-46bf-7036-11375f368ba5@infradead.org>
In-Reply-To: <e80a35c7-a9f4-46bf-7036-11375f368ba5@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 14:01:24 +0200
Message-ID: <CACRpkdbhfsmpq28AcmbhswuvgYUvh+UQ5NUpsAyS2W+ROTHbNw@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix kernel-doc notation warning for 'request_key'
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 9:55 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kernel-doc warning for missing struct member 'request_key':
>
> ../include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
>
> Fixes: 39c3fd58952d ("kernel/irq: Extend lockdep class for request mutex")

Patch applied. Thanks for spending time with documentation!

Yours,
Linus Walleij

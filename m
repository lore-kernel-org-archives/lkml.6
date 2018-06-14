Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4B0AEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76F8208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gewkSmW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76F8208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbeFNLSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:18:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41954 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754782AbeFNLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:18:37 -0400
Received: by mail-io0-f196.google.com with SMTP id t5-v6so6743137ioa.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4HoIX4bc4UV+Q09TwFUEQ5PhzW6xhpXpuY/m6XJuB24=;
        b=gewkSmW/1j/euc8Q2U+DnDxz6Qm3XbwN0IxZJahBdvmrRKDjU0sdxZvNV0NPuHiMP/
         h4VEq+kEzr8yxKDLejM1Ia0MFa2jsFPUOCPu206Nvi64DKmhhO3px63CDhC6oPfLyawO
         uNKiRkmQx1tTKTSJQGkV14EKEMX5C+h33npRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4HoIX4bc4UV+Q09TwFUEQ5PhzW6xhpXpuY/m6XJuB24=;
        b=ZszL0IAXwYwTHV5LgxhAOv7Nlv8aNfkFNODLvn8dCib21+4UTfubRCQ9b6NIDnZ9Iz
         V8K/3AUsz9oqY9Cw6xAUMMaouhtuBN0ObZ6MFbOAHgf92HA8HBwgyi6nuHfcKuAanMFI
         5od04iGSUwTfDPE6PzFCzA+1pjnMZD0/WlvyVFJsu1bjBCG6kZQvX8lC0It2lI+Z+d02
         VK89IA+1/BeQ7S4A9RL2RTcuVubOmVRu+5oifvril6FLs41VeSAeQZABTZgp3d6s5/Ed
         1zDVT45hG6GQICNGGYPRFclwfg6N2+l31Q6r35ODp8wdci25thPH2Q3ONPRVcKi9Tik9
         I/Yw==
X-Gm-Message-State: APt69E0q3YpGCgQVP7Ph+T0EU9te4G00qdGgAf0X7qznyBtFtgx3YCuo
        mFf65NyfYp7kgP53B3g8l/JUPOJFtCNLcYgKxj1FkQ==
X-Google-Smtp-Source: ADUXVKJC1bQgCUMzpoy/NCnyabR9i0++/nnt3bubwWCb2leTzXtui2Mzg+l49+XUeBg4qgS42oyX5HqsW9yA6plnXSY=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr1871046ioz.304.1528975116800;
 Thu, 14 Jun 2018 04:18:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 04:18:36
 -0700 (PDT)
In-Reply-To: <711dc0a5-9099-dbc9-6f8f-f37caf69105f@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
 <1528276734-1483-2-git-send-email-j-keerthy@ti.com> <CACRpkdbFyZwG4S9t3ts3wmVWioadd7NjpdMUkq-wujH=g68zvw@mail.gmail.com>
 <711dc0a5-9099-dbc9-6f8f-f37caf69105f@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 13:18:36 +0200
Message-ID: <CACRpkdYOrg2M4zcomaGu_uUGMdnajwtoD-voETp-dRvL2WJpCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: davinci: Do not assume continuous IRQ numbering
To:     Keerthy <j-keerthy@ti.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:51 AM, Keerthy <j-keerthy@ti.com> wrote:

>> I think the idea is to make it possible to use GPIOLIB_IRQCHIP
>> for banked IRQs but the infrastructure is not yet inside the gpiolib
>> so it is a bit taped on the side right now.
>
> Okay. I will take a look at that. The key issue that this patch
> addresses is that currently driver only calls platform_get_irq once and
> assumes the rest are continuous which is wrong hence the key issue
> addressed with this patch is to call platform_get_irq for each interrupt.
>
> The version 4 is here:
>
> https://patchwork.kernel.org/patch/10461537/
>
> I will try to follow up with generic gpiochip_irq_map/unmap once i get
> that working. Hope that is okay?

Oh that's fine, I'll merge it.

Just wanted you to have a look at Thierry's stuff so we can share
more code, you're a core developer so I wanted some smart people
to look at this.

Yours,
Linus Walleij

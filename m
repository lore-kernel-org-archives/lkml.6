Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D25C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499C120833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JajU7+6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499C120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIJMSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:18:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39515 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJMSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:18:01 -0400
Received: by mail-it0-f65.google.com with SMTP id h1-v6so27397667itj.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bsxd32JTgHx/KvEoaZZ+VC3rS/J+CxzKB1YuanK1sjE=;
        b=JajU7+6EIFAac4zo+/eS+l0vJnkbvu8W2nMGPIGZuZjBZcrYgmv3tj/oAJbBt4sJ4w
         SXoKKoiGyRlSKa6wIuUbcbEvaHwM7ZwU456ZTsqMeEhQbZrvPyPYaJebDuyS+DUhw4DY
         XZzfNEoeMN1faiCUhpdP3JuTF9quuHO7FEIMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bsxd32JTgHx/KvEoaZZ+VC3rS/J+CxzKB1YuanK1sjE=;
        b=YvODN1/jHf/qkpfjVv0tR/M071DVbEbO23ceNSR6NTmZ6cskQRiDfKu0qgli2cVaNm
         pIy4oFBxjv1iuY9mjIW9DWH3qH2iKMXLmnSvipZfrw5Lcs1GTO0LOJwebg09CWuUdA+j
         LQ7Wd+kcyd2cUzdunjdNDAl+ox7TTdync52YhWKM8ObxJB5TFeKpq6YgApadCQlrqSv8
         APhjjdK5bJW5UWVuLcHpYJlyvoPJsZp4H1hmhnOXDZJb0gKw/9oDrzxhyL46sbReCiCb
         NG+EtvbChu+bMUtpANcARdajQzPcab++5o5Zxp+ZnoBwqE8L0/jjBvBP9Z/3YxNCbb1a
         Gnqg==
X-Gm-Message-State: APzg51Ct6b2ZiV/I7rkNJNoMSpDnwLwJuHEe8628nX3nmxyTuVsUFWwq
        /qCz44WGe4NByviGzaQmeflFfr7Sc+pt58bQLwuuNA==
X-Google-Smtp-Source: ANB0VdZox3S5IutTQbYQK/oijG8nAhurJxB4W779BS3iryGOopG08/X8ZQI1WaZWUNAzZP1VfqXgROpoDKPD9RxqaJ4=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr15393573itk.62.1536564322637;
 Mon, 10 Sep 2018 00:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180831191326.25106-1-afd@ti.com> <20180831191326.25106-2-afd@ti.com>
 <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com> <CACRpkdYvNeKyfRf5Et5zC4=hcu9cfDubftRFRHtrKLN-5Snd1Q@mail.gmail.com>
 <040ce524-f6e2-81a2-68db-57a645de22ea@ti.com> <0e199aa3-2d9d-4e7d-af23-8523722f017a@ti.com>
In-Reply-To: <0e199aa3-2d9d-4e7d-af23-8523722f017a@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 09:25:10 +0200
Message-ID: <CACRpkdYcuSpfZ0=UFUOx_-5kaAtCA4=AyXmSMbfrcqjf0r_xmQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Keerthy <j-keerthy@ti.com>, "Andrew F. Davis" <afd@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 9:41 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 09/06/2018 09:16 AM, Keerthy wrote:

> > Okay now its numbered differently:
> >
> > cat /sys/class/gpio/gpiochip340/ngpio
> > 144
> >
> > cat /sys/class/gpio/gpiochip272/ngpio
> > 68
(...)

So:

> >> Are there applications that rely on the sysfs ABI on DaVinci?
> >>
> >> In that case base needs to be prerseved.
>
> Not only base, but label also - /sys/class/gpio/gpiochip0/label, as this is
> the way to find proper GPIO chip in sysfs using legacy GPIO ABI.
>
> Linus, this platform is old and most of the users do not use new ABI (chardev),
> so we could try change this, but need to be prepared for regressions reports.

So what I'm trying to ask you guys is if there are applications that you
are aware of that use the old ABI, and who will upgrade their
kernels and be upset.

We must not break userspace, but as you know if a tree falls in the
forest and nobody is there to hear it, it doesn't make a sound.

If you're not aware of any such applications I guess we should try
changing this.

Yours,
Linus Walleij

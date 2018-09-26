Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE75C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166872152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkTEenG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166872152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeI0ADK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:03:10 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45369 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0ADJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:03:09 -0400
Received: by mail-qt1-f175.google.com with SMTP id l2-v6so18187425qtr.12;
        Wed, 26 Sep 2018 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60bpes0MGi/bqgWqMHIi0b4px+0rIt2wSm6eMIg9nx8=;
        b=QkTEenG9KiIGMXVRe8IEiHJuH5fuUizhMMkpZSRsiVTKbSogstv5uIfwmXoRwqQmQB
         KFINm4C2+4f4C8d5Dzmu+FbenAkOyNeM9xfWyToOnZA/vsLR+eBeLDVcox8lLUKFrALf
         FyvSLnCcYbWkY7SsYPh0sbw4K0mnKjM1yO6k7+oowLk/s6FJ53xqLByc97N02DczLHs3
         cXAQjqqP+5FlR42YvGW+5OxTklw8Opc+4nhHY8SeeYCvX0aMXrnE6S5Hda8d1Wdc6s9M
         1XMUBa8ByVw33yJTMpXgDMWRKGy+WY99YWLeAvteH9xG8YqUJ7eqZjtC/0nyqSmDQ6bJ
         t6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60bpes0MGi/bqgWqMHIi0b4px+0rIt2wSm6eMIg9nx8=;
        b=UBkAJZq+Pf7u/9cZlA1NzJuqadsmg/MSRb2grZXzkkCFprEbHFVIk+GkXOuSeED/ZX
         gZejrfJWUnpajV/Gk1RmfusBxQ9y+A4uIXO+OCD+sQa5mCSLxPdJCtB9D1GT4Gj4dvOo
         Cu+mxCKGFFw0GoY84MK5d4HbxViaJfi/7A0vuZdKqyorLSW1mG9kAXkN19xUjG2c9DX5
         iWDqtoCC9c1sb8uYNrIP341Vea1yrSy9baXq7p0igTT76+9xOKTN0Td/MenoCHgMmhxk
         VDRGnbv8ttlu57HA0fNILPyO8/yAiavetwjW3R9BG/kVukXR23nQH11Is9pnz1qbfmZe
         WfqQ==
X-Gm-Message-State: ABuFfogq78NICdnT67EiavpfqIVtwXrUuhuyVctm+8OwbAs4A7ShsrNu
        eWBmFTIk9O0go/DPyJ0baXMR63z2ZmOc1P9SZQc=
X-Google-Smtp-Source: ACcGV62n82xESZEXWbIxnLtN2qoconWB4qzsHCEnGtB8ZU1bA2cEqXP5AmdBJ+NkUIoL52PuDK1Vk3WpK94areBRKzk=
X-Received: by 2002:a0c:93c1:: with SMTP id g1-v6mr5251005qvg.136.1537984145819;
 Wed, 26 Sep 2018 10:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180816084104.434-1-jian-hong@endlessm.com> <CAPpJ_eeK68jvMQ02hR2i+eP8Xo9YyWWUGYqG7e6dsWP=XTTCyQ@mail.gmail.com>
In-Reply-To: <CAPpJ_eeK68jvMQ02hR2i+eP8Xo9YyWWUGYqG7e6dsWP=XTTCyQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 20:48:54 +0300
Message-ID: <CAHp75Vc18A6aUBrjyW6Df5gY563J0kbaEg2oi5yAVkJCKm0TZw@mail.gmail.com>
Subject: Re: [RFC PATCH] platform/x86: asus-wmi: Simplify the keyboard
 brightness updating process
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:57 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> 2018-08-16 16:41 GMT+08:00 Jian-Hong Pan <jian-hong@endlessm.com>:
> > The original asus-wmi queues a work which calls the ACPI/WMI methods to
> > update the keyboard LED brightness.  Similar drivers - acer-wmi,
> > dell-wmi-led just call the ACPI/WMI methods directly without workqueues.
> >
> > This patch simplifies the keyboard brightness updating process which
> > calls the kbd_led_update function directly without workqueue in
> > asus-wmi.

> Just gentle ping.  Any comment for this patch?

RFC patches are not supposed to be applied.
So, feel free to resend as non-RFC, or wait a bit more if anyone would
comment on it.

-- 
With Best Regards,
Andy Shevchenko

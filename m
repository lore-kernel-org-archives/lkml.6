Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710CCECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDA1204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxUDIM/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDA1204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeGUA27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:28:59 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33726 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbeGUA26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:28:58 -0400
Received: by mail-ua0-f194.google.com with SMTP id i4-v6so8464016uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5rESa4qzW1m0TrJmYgKHoDFTi0zK3Dsu4UYI5QUDlxY=;
        b=VxUDIM/1hP4PxPtAxrd9tLyDlhZzOhZCuD8dJNa7bl4yPUIW+FFnVULtv8Y1eKy+NO
         BQRVc5F1VzvKBdjdBOcZ8jbHh6VfabvyOoyfiQ9sS8yVBLl02Ro/O7sjAEfQDAjlMNut
         a6kA/Y/gf/Tb4lzYuXEsqUahqOfbXiOxjsbEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rESa4qzW1m0TrJmYgKHoDFTi0zK3Dsu4UYI5QUDlxY=;
        b=YGsANYLfCJ5hatzEbo1YVYG1nknPxKxmZd8nsbNEGg2o/7mxP9dNbGinfPU5+3sR09
         q8sspKq8UNqYPHRoYSnB6sgQh9coDJRTagYf0eaigkplK1hzNgE0oV/60jwjTyGUy+qZ
         iAcX6itaDg57/EyJKoF7EilifauXDrmemYCAiAw6f9g4bDGBSf3TiT4R1OxXNQgWXnBn
         bW4AQNrQz1BH7zTACOGZo6zwr05ixmO4PJGXIhxQgub7WROtLOKjSrVdbHy+Mrgz6miI
         dPBoizzgaxeSffBkF2ZsrOjmEZolsYUmWOl+njRDQSiQhZnbKqRhOMesCESCRPsQcgDs
         piNg==
X-Gm-Message-State: AOUpUlFa3U6KISpl+11UycgxDFhHEbCbplmWP+w62ykMixte4oiKZUwY
        IqCXp+wQSJCbGNe/cHBs1PmEjZzfQVD20kOejgWfbQ==
X-Google-Smtp-Source: AAOMgpeJ54KBIBVRaKo/Vs9zqSRINZSCHKDnjCdIdEPmvyppIp5dac4gu6gigvHfK13h9PZeq/kSllzOqRCR2+q1SOM=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr2742356uac.135.1532129908608;
 Fri, 20 Jul 2018 16:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180717005719.258905-1-djkurtz@chromium.org> <20180717005719.258905-2-djkurtz@chromium.org>
 <CAD8Lp446Zu=EhdzRE9pEoskMWeOHOovoAJ8qtrovEuZ2E7Z5VQ@mail.gmail.com>
In-Reply-To: <CAD8Lp446Zu=EhdzRE9pEoskMWeOHOovoAJ8qtrovEuZ2E7Z5VQ@mail.gmail.com>
From:   Daniel Kurtz <djkurtz@chromium.org>
Date:   Fri, 20 Jul 2018 17:38:17 -0600
Message-ID: <CAGS+omDPkC=Tv7SJ91cLxrFnab_VPC3VZRAugkvAUokkkoYSTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl/amd: use byte access to clear irq/wake status bits
To:     Daniel Drake <drake@endlessm.com>
Cc:     Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        Ken.Xue@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Jul 17, 2018 at 6:30 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Mon, Jul 16, 2018 at 7:57 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > Commit 6afb10267c1692 ("pinctrl/amd: fix masking of GPIO interrupts")
> > changed to the clearing of interrupt status bits to a RMW in a critical
> > section.  This works, but is a bit overkill.
> >
> > The relevant interrupt/wake status bits are in the Most Significant Byte
> > of a 32-bit word.  These two are the only write-able bits in this byte.
>
> I don't have the hardware to test this any more, and I also don't have
> any docs to double if those are really the only writable bits, but
> looking at the existing driver code it does seem to be the case.
>
> I think you should retain the comment noting that the value of the
> register may have changed since it was read just a few lines above
> (and hence explaining more precisely why we make the special effort
> just to modify the MSB), just in case there is further rework of this
> code in future and we end up walking into the same trap. It was one of
> those issues that took a frustratingly long time to figure out...

Sounds reasonable.  How about:

-                       /* Clear interrupt.
-                        * We must read the pin register again, in case the
-                        * value was changed while executing
-                        * generic_handle_irq() above.
+                       /*
+                        * Write-1-to-clear irq/wake status bits in MSByte.
+                        * All other bits in this byte are read-only.
+                        * This avoids modifying the lower 24-bits
because they may have
+                        *  changed while executing generic_handle_irq() above.
                         */


>
> Thanks
> Daniel

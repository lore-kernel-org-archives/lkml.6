Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4706AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105022086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKbstYlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105022086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeK1Cuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:50:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33775 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbeK1Cue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:50:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so22280396qtp.0;
        Tue, 27 Nov 2018 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSBS27Lb+H+ppje/JL4hQgwKKAkb9lzscvdbxKK+lp0=;
        b=lKbstYlZotF8DIfjM5+XZP7yl5oVEm0tMl/M43NjPZ2ZlzBVf9IlzdL2chinLL5sr3
         DiTFQaJMPei6/Tx8GtwJUgCwl0pcguhEnJet301lK9fCAW30ZBqiSiT0wnKIuc5coOyP
         xE8mb2RVLEs02q44hfLa/IyrYDVOrHLm7eNVNhJ8nO5rAGQPr2NmCjIL2AN8j21k5F62
         n3+pqTytMxqyBFpMxXdGUcDWrTvjtWVJ/5z69Ze92vMTSI3dYk7sgxmOVFm75C8fDv3C
         dwXHrLz2maqqcqqHKfM+0eAhjeeVTcMiNLTmZ4LEVypOR1ZnWo2p+LKWty8rVtQxudD+
         ztsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSBS27Lb+H+ppje/JL4hQgwKKAkb9lzscvdbxKK+lp0=;
        b=PPQKNQcrIL6EFpfulqVNtXcsjNTY8SS4IIMLu5zhFtsG4pA5kV62jbU/0VOufLI0ST
         dNuJ7v/034wl2QqKBxcQfPxS59ZFCLABrvJTxC8T3SP8JtI7jdd2O2//FPaWNY5oCFb6
         VoN4jiA2rhHF8zWqk8hrr/oOGfyksP+rvXrha7x0Otg2DJPo8Gl/ipgHs2r5ozkIzem2
         G9B8aikAXV5XzVeEWc6zD8Zk5aJS9S0dPezjMqxGdHuts/SrsAR5i9/qc9AnuADcnfvX
         Y9YkEhAEHRwrshQi2rHoalrizoExzm98zylb/bovqYJobrftoQjRHQfTlIaDCoaS/qdJ
         A1Dw==
X-Gm-Message-State: AGRZ1gIGpRElleFBBtoLEQNsb3N9YsqVq/dkfGic2EzvN9uUE7fqYtR+
        4kkFI2IA3kz99duVhwTtOiI/TST2SB/fORNJ0x0=
X-Google-Smtp-Source: AFSGD/WHMHGVxeQ5sj3WDc4LVGejCxaXR18AZnS8Om9PUyvBxlGf+HwOUh2Utg48cpMTyk7uRv91EshR0FVduMHyhsI=
X-Received: by 2002:ac8:1909:: with SMTP id t9mr30333331qtj.327.1543333933780;
 Tue, 27 Nov 2018 07:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
 <20181127025752.6459-3-ayman.bagabas@gmail.com> <s5hwooyye9c.wl-tiwai@suse.de>
In-Reply-To: <s5hwooyye9c.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Nov 2018 17:52:02 +0200
Message-ID: <CAHp75Vd_k3Gu93hOUOLXD90O_eM3wy2K3QfMN0789PQEOixS=w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] x86: add support for Huawei WMI hotkeys.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 1:02 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 27 Nov 2018 03:57:48 +0100,
> Ayman Bagabas wrote:

> > +     handle = ACPI_HANDLE(&inputdev->dev);
> > +     args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
> > +     args[1].integer.value = 0x04;
> > +
> > +     if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.SPIN")) {
>
> This looks ugly...  And checkpatch also complains.

Good point.
Actually another question is what handle do we get here? Can we check
method name by relative path, i.e. "SPIN" / "WPIN" instead?

> > +             args[0].integer.value = 0;
> > +             args[2].integer.value = on ? 1 : 0;
> > +     } else if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.WPIN")) {
> > +             args[0].integer.value = 1;
> > +             args[2].integer.value = on ? 0 : 1;
> > +     } else {
> > +             dev_err(&inputdev->dev, "Unable to find ACPI method\n");
> > +             return -ENOSYS;
> > +     }
>
> Can these checks be done at initialization phase?  It doesn't seem
> needed to be executed at each call.

Agree.

-- 
With Best Regards,
Andy Shevchenko

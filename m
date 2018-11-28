Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA78C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AF22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zny1c7BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AF22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeK1Lte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:49:34 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43784 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1Ltd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:49:33 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so14990658vsc.10;
        Tue, 27 Nov 2018 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9Fj4VPKXTz+zDbfOg3vokqFUCnPRrhHLLywuO5TdcIA=;
        b=Zny1c7BPYRV+GhI4U2Apop64DxXVGgI2xWDaRfObOjzknn8rbTZsvmlzZOp8qXbsXV
         3tC/0rKzRWMmCjtWf76dTgxt+J+8t0RGMt9xsZkdTsLZ/bDVgXoM+Af+7H+2qlpr//Oe
         +tvkENdilPBabvy11Mgj8NlHlfPt/lM1yfPJ2lJhuatCjQhpv4JDnpIdOyEi1U81yCam
         rMabm75cJZHQdVgAzqhdgtm/+3ZuukKYGZLfKQKb6CBoCz+cOkb8XbRrMnPcn9UBcq9/
         Oxt6/4ArKzWsL9QqF0ey1saq2h1FJ2rfzNdMSOrj6L+Dh8Bep2/oh0AdNNAOF7W/5xCo
         oP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9Fj4VPKXTz+zDbfOg3vokqFUCnPRrhHLLywuO5TdcIA=;
        b=lJ9bzGFQQb7Tx0Gks3+c86hjR3Ba1JJxfwBx5VXjYTs24EtoN3R6/96hsbBJffu4oj
         KLtvbIUbEgPkIBtobfFTHVq0ow087vuHUgTk+g9SVdUe/8gS+yVbEpj8XmFDsuywlm9B
         B59lW6qc0445+seN7eoGMGQQt8eTgDcDVqW0AacrxBo5SSPXyIXy/Hls1s/85VAZwLSl
         MdA7EW51M72uRGtMPkizVruOFLNqAZenIsOVpbXrArKsLjzNGa6y1TqzVmOMffhpExRz
         1rAG0i991tYb6XPUxaG5pAIDCCpvRPESxntN1aek0a4e1XzjOJNS6lm4D2efh7fj9vVQ
         /ulQ==
X-Gm-Message-State: AA+aEWZNEh2imW2Ij2JJ+alSIIhK1BP6J4cbv5cB4fZpIhQiE6jqpQiU
        68n3uSLg7aR3zmswkMNYCA==
X-Google-Smtp-Source: AFSGD/UDxelITMZxAijic3t+UF4VOKCzxB+nVtIK9btI7xpB4ea98hK5Pt4Jg9gF21wfihHACXfyIw==
X-Received: by 2002:a67:da93:: with SMTP id w19mr12390322vsj.144.1543366190693;
        Tue, 27 Nov 2018 16:49:50 -0800 (PST)
Received: from 960 (c-98-244-175-192.hsd1.ga.comcast.net. [98.244.175.192])
        by smtp.gmail.com with ESMTPSA id l123sm1658175vsd.26.2018.11.27.16.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 16:49:49 -0800 (PST)
Message-ID: <789965489e73fd543f0552090063fdff69363497.camel@gmail.com>
Subject: Re: [PATCH v7 2/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Date:   Tue, 27 Nov 2018 19:49:48 -0500
In-Reply-To: <CAHp75Vd_k3Gu93hOUOLXD90O_eM3wy2K3QfMN0789PQEOixS=w@mail.gmail.com>
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
         <20181127025752.6459-3-ayman.bagabas@gmail.com>
         <s5hwooyye9c.wl-tiwai@suse.de>
         <CAHp75Vd_k3Gu93hOUOLXD90O_eM3wy2K3QfMN0789PQEOixS=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-27 at 17:52 +0200, Andy Shevchenko wrote:
> On Tue, Nov 27, 2018 at 1:02 PM Takashi Iwai <tiwai@suse.de> wrote:
> > On Tue, 27 Nov 2018 03:57:48 +0100,
> > Ayman Bagabas wrote:
> > > +     handle = ACPI_HANDLE(&inputdev->dev);
> > > +     args[0].type = args[1].type = args[2].type =
> > > ACPI_TYPE_INTEGER;
> > > +     args[1].integer.value = 0x04;
> > > +
> > > +     if (acpi_has_method(handle, method =
> > > "\\_SB.PCI0.LPCB.EC0.SPIN")) {
> > 
> > This looks ugly...  And checkpatch also complains.
> 
> Good point.
> Actually another question is what handle do we get here? Can we check
> method name by relative path, i.e. "SPIN" / "WPIN" instead?

The handle is a NULL handle at "\". Should I use acpi_get_handle(NULL,
"\\_SB.PCI0.LPCB.EC0", &handle)?  EC0 is a acpi device HID:PNP0C09.

> 
> > > +             args[0].integer.value = 0;
> > > +             args[2].integer.value = on ? 1 : 0;
> > > +     } else if (acpi_has_method(handle, method =
> > > "\\_SB.PCI0.LPCB.EC0.WPIN")) {
> > > +             args[0].integer.value = 1;
> > > +             args[2].integer.value = on ? 0 : 1;
> > > +     } else {
> > > +             dev_err(&inputdev->dev, "Unable to find ACPI
> > > method\n");
> > > +             return -ENOSYS;
> > > +     }
> > 
> > Can these checks be done at initialization phase?  It doesn't seem
> > needed to be executed at each call.
> 
> Agree.
> 

Even if it was done in init phase, we still need to check what acpi
method should be used and based on that and micmute status we set the
arguments args[0] and args[2], args[1] is the pin value. We could check
these using event_guid, but that would assume the methods exist for
each guid.
For example, if event_guid == MBX_EVENT_GUID, then method SPIN should
be used.


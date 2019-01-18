Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3ADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480022086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="iRnhXj64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfARBrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:47:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40784 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfARBrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:47:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so13613626qtf.7;
        Thu, 17 Jan 2019 17:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTwo0yITEGKp6cTbipX0KbZvBbv3f4rj2ICmUTMtejg=;
        b=iRnhXj64b80HfZFXu0ykvlYD1yb6EzU65nI3rRetwsQrJhJno6kBwy1zerO1r1bRyJ
         W8MI+oCJo6yxh/jIbesF9YKyofkByp9Fg1r1e+Jok1LeOME0JvGL4UFwiz5AKXbC5Vna
         D9zI3xUEiJFNWxsMFEEFM6v/6DRzybcZMVKfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTwo0yITEGKp6cTbipX0KbZvBbv3f4rj2ICmUTMtejg=;
        b=Z0+w2x/G/4/tXxi9iJXR41MWUX2yrc1hfJIhrccTDEsqvNtLRPhVAT0B84yJXsrpni
         uZzdUeA1C+euIHJpif9NsnnTBeXC7TI/KJ+PqEKKe+P5YqplWpfQoYeH7KvPrbcRVppY
         azpk1cn5QuGaIM5f34C2ZXv7CEcpU1Lk2PsmIAQTlLiExeZDb0QcHqxtx+t0KrKSu5JD
         lrncy+YKLtKKKD+lJ+OLnNNvad0iJ+0q2SUZtmZqyCHILBWtCxdvbC6J1Ner1AyUMT93
         VkSOuXa62ueYECCrntDIj5m2AjZhkfFqDryA7GSkieFQJpRaCswidZ0xcs55RyarLSrq
         aSNQ==
X-Gm-Message-State: AJcUukcm4hFlte4eGLOXxWDjazUp7p6pdolCUtk0eU/yxz5nGIScCCgz
        4oXM3I/SBqO7aiJap8ho89wPz/YyKf+xXtqbONBiyffRsSE=
X-Google-Smtp-Source: ALg8bN5s1S18KgznjwO4dhn9Mq/f5WN9bFsBjlfPJ6opbGBWDw3+6eWXoCzFvZjJ9v+H4f/2X07g68z69fxED1Lqx+I=
X-Received: by 2002:ac8:3065:: with SMTP id g34mr14218910qte.136.1547776040664;
 Thu, 17 Jan 2019 17:47:20 -0800 (PST)
MIME-Version: 1.0
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1531342898-15790-10-git-send-email-eajames@linux.vnet.ibm.com> <alpine.DEB.2.21.1901180140150.1647@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1901180140150.1647@nanos.tec.linutronix.de>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 18 Jan 2019 12:47:08 +1100
Message-ID: <CACPK8Xf3=pTRubt0VnUJ6GyT7bG15oCL+XtqzfeAAtccqbR_xg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] hwmon (occ): Add sysfs attributes for additional
 OCC data
To:     Thomas Gleixner <tglx@linutronix.de>,
        Eddie James <eajames@linux.vnet.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-doc@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 11:44, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Eddie,
>
> On Wed, 11 Jul 2018, Eddie James wrote:
>
> > --- /dev/null
> > +++ b/drivers/hwmon/occ/sysfs.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * OCC hwmon driver sysfs interface
> > + *
> > + * Copyright (C) IBM Corporation 2018
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
>
> The above license information is inconsistent.
>
> The SPDX license identifier says GPL v2 only, but the license notice says
> GPL v2 or later. This is just wrong.
>
> Please decide which one to use and please also remove the boiler plate
> text. It is redundant.
>
> See Documentation/process/license-rules.rst

Thanks Thomas.

Eddie, as IBM contributed code our preferred license is GPLv2+. Be
sure to include the copyright line in your header (I noticed some OCC
files are missing this, please audit all of your recent
contributions):

// SPDX-License-Identifier: GPL-2.0+
// Copyright IBM Corp 2019

Cheers,

Joel

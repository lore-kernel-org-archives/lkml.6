Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E70AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BB321526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="tWXwoHNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BB321526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orbital-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQUMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:12:55 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37504 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJQUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:12:55 -0400
Received: by mail-vk1-f196.google.com with SMTP id y128-v6so6278488vky.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/DZXRTDDFMm0YvSerPmWog8u/aNkWQ8f2ajil3QGaB0=;
        b=tWXwoHNubPwpKIeVYZB4P2NHX0jC8c8/ZsKdlye8MzG1I7Q12pGnPxjthhWPHTcPh8
         2vHBA5VgccwOQN5YHmq4Qh+JMpVCKo9h1Y6csS1Xv7peKsV/d+WZuebgZ0uqvPt1KfOZ
         U1mCpexMLFv0o4lERn7a7onW6PFTtk95FeNxpfvT1mXNzARkZridGbgfN+Sr4DzL29Qp
         ubtNRFrTigeKtYBlMUIdYCVTaN4qpCOQMQj4w9cyitYgccijzqV+Z9zRUA9vsSW64MQY
         erflniAQgYPKpFEUil5/tchLVV2b9G6F1s6DAsIoAVm4xezAtoimlrswKQRd/OB0aCSO
         yMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/DZXRTDDFMm0YvSerPmWog8u/aNkWQ8f2ajil3QGaB0=;
        b=aj0qYpyXe69pDDrEElIxMrn/OdW4QRDe65SYKPh8h6+PcM1RlPVnnuuP3gFvYu6TJz
         50RVRmJby7xQvzklMYmlX6VOebvbN511f2hZFdzKuI1A3dHRYpUGOLWrf32GGCDvWYTk
         NVCKvmoUCqMd3/zAGVY0inJl7tUVm5fKgkqj6rSZJA3ijd+6fg/sDmGT4dppu5DJ/aqV
         qQX1XqqEaty8YGNg5Y4kPSuUbXrB17IHvXi3RXxHqi5KtgtETpCwQiNH/c274+hC6HtD
         df0YntqD74+IK4nrlqFt3dx80MaXzXr4UpeEaBp8CYuSvk/VKp+QG9XLZomlxTotdXjJ
         FqhA==
X-Gm-Message-State: ABuFfojz3jtWbOeMPQeOg+9Gfk2lfNj899xbZonqNdtTwFuuMcNS8KbD
        RGJT9jB0ZY5tupLfNyyIc+c3EU69OR/H/eVk8OrZzQ==
X-Google-Smtp-Source: ACcGV63yfYdbqNJuePFByfIE+JbulKwP2K3q45/Oyqc2K8Edm75uToc1CtmHwS9pXY8vCe6pPusT8OYfG4XR+40d0NE=
X-Received: by 2002:a1f:7cc4:: with SMTP id x187mr10974081vkc.38.1539778647199;
 Wed, 17 Oct 2018 05:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181007125815.8392-1-jonas@threetimestwo.org>
 <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com> <2351196.3BzoFE0xYq@ws-140106>
In-Reply-To: <2351196.3BzoFE0xYq@ws-140106>
From:   Jonas Danielsson <jonas@orbital-systems.com>
Date:   Wed, 17 Oct 2018 14:17:14 +0200
Message-ID: <CALDOjzhZg3X1y22KE1yw_0ZFjuvaa=3GhEF2iU=KUk6-eRZN2g@mail.gmail.com>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
To:     alexander.stein@systec-electronic.com
Cc:     Claudiu.Beznea@microchip.com, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 4:52 PM Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
>
> On Tuesday, October 16, 2018, 3:30:24 PM CEST Claudiu.Beznea@microchip.co=
m wrote:
> > Hi Jonas,
> >
> > On 07.10.2018 15:57, Jonas Danielsson wrote:
> > > From: Jonas Danielsson <jonas@orbital-systems.com>
> > >
> > > This fixes a bug where our embedded system (AT91SAM9260 based) would
> > > hang at reboot. At the most we managed 16 boot loops without a hang.
> > >
> > > With this patch applied the problem has not been observed and the boa=
rd
> > > has managed above 250 boot loops.
> > >
> > > The AT91SAM9260 datasheet tells us that with the instruction cache
> > > disabled all instructions are fetched from SDRAM. And we have an erra=
ta
> > > telling us we must power down the SDRAM before issuing cpu reset.
> > >
> > > This means we need the instruction cache enabled in at91sam9260_reset=
()
> > > At the moment it is being disabled in cpu_proc_fin() which is called =
from
> > > arch/arm/kernel/reboot.c.
> >
> > Are you using kexec reboot or implemented hibernate mode on this machin=
e?
> > I'm seeing cpu_proc_fin() is called only in case of kexec reboot or
> > switching to hibernate mode.
> >
> > In case of normal reboot (e.g. reboot command) machine_restart() from
> > arch/arm/kernel/reboot.c is called. Please correct me if I'm wrong.
>
> Another location is cpu_reset() aka cpu_arm926_reset() in proc-arm926.S
> which also disables I-cache. But I can't track down a callstack
> ending there.
>

We take the normal path of sys_reboot =3D> kernel_restart =3D> machine_rest=
art ...

I added code to print the c1 register in different paths. And I-cache
is enabled.
So now I am really confused about why the patch worked.

> Best regards,
> Alexander

Jonas

>
>
>


--=20






JONAS DANIELSSON
Software Developer

+46 72 361 5022
Malm=C3=B6 - Sweden

ORBITAL SYSTEMS
orbital-systems.com




The information contained in this message is intended for the personal
and confidential use of the designated recipients named above and may
contain confidential and/or privileged material. If the reader of this
message is not the intended recipient or an agent responsible for
delivering it to the intended recipient, you are hereby notified that
you have received this document in error, and that any review,
dissemination, distribution, or copying of this message is strictly
prohibited. If you have received this communication in error, please
notify the sender immediately and delete this e-mail from your system.

Although this transmission and any attachments are believed to be free
of any virus or other defect that might affect any computer system
into which it is received and opened, it is the responsibility of the
recipient to ensure that it is virus free and no responsibility is
accepted by ORBITAL SYSTEMS AB, its subsidiaries and affiliates, as
applicable, for any loss or damage arising in any way.

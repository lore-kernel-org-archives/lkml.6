Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3F2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4131B208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAHmRdFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4131B208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeH1K6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:58:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38504 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeH1K6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:58:46 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so1177017ite.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CM1f4v2Gm1g9CZxRkrkxYvEadt1xyirPu32l6wn+I1Y=;
        b=CAHmRdFHRaE02XMWYnGGIo7UDQ2sgdAZktmqPZIgct9GoovMa8CAMSkUY00YjOhL/V
         KGxpu6ftsDIXaThab+zxnsNGG/KTHKvi3021agKHn9Vugu7M1NPqfxrckXboMIdlzAAA
         pGFjjebUXph7ZpKwTqjPkRbio0FJWriwpxCdH1ooFCXsASw4EZle+pE0L3EmYxdG9FGH
         DTqkzrCqEAXF8Yo2i4OchKr09zjWUkHiehV0k8Z0tC9WUocbqGZ3E2j3B5eYMzrqwZxr
         01vN144b6M4uQQmUcPPEBabd7J2Ek8xJqSDFPlhdfXxROcY+GustNDMXrVONHYebKL1F
         qrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CM1f4v2Gm1g9CZxRkrkxYvEadt1xyirPu32l6wn+I1Y=;
        b=AfybQeoGB5Ru9r3gCSl86PUnz35gwGmsxI8J6MAeOCZXLYimvHN9DGY4IHRk6pukzQ
         qj/TB4AauApKOCU2y8AJyE4vEAN/kGDubLgh7y/TBP3iF4u0XbL6cu2pxia8bBi4q0kk
         FcjQsMgdtfyouIXxyJJCVRw5i1d0zBxeKvlFsqrnMhw2U7qDzKUODe255bIRlwy0b2fZ
         vT0GyVVkdDoSbN1iSsexcoQx0Obz7E4gcW8su50x/hMMnKC35J/yvSP1lTcd1kSOXRN7
         F90MCOrDRrglivDosci0RPNxEp3FASen/HiJv2eOA6s8yIQSFnOvvvPq/zQoxzg1iQ+c
         5vqg==
X-Gm-Message-State: APzg51Af8xLpqvE38vEy0E1ZR8rs3KVZbM7Z2IITOK6vF+2Q31uBRYQK
        15NipVFRFXhmmzVkrPBzy3zXN11Zj7qHwrWNx7M=
X-Google-Smtp-Source: ANB0VdYhZ3aMt4kHAMqBA+iW+Nx56hwWaZAkn7itpskBRUIGqv1Tg81qswcmn5sDCfDQW0ns5H1C9L9Z/4hgDE6NKWE=
X-Received: by 2002:a24:e47:: with SMTP id 68-v6mr450293ite.23.1535440111770;
 Tue, 28 Aug 2018 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1533537589-7202-1-git-send-email-Anson.Huang@nxp.com>
 <1533537589-7202-2-git-send-email-Anson.Huang@nxp.com> <CAHQ1cqGA37RNoo3KcESCOFeYZxAQCOFkuQQhRPRKCTp=gKLdKQ@mail.gmail.com>
 <CAHQ1cqEy0hQg3ByZVx4tW7f6cifzU++ptrV40TcH01GsKmHP3g@mail.gmail.com> <DB3PR0402MB3916B5A489F6CD0B679C273AF50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B5A489F6CD0B679C273AF50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 28 Aug 2018 00:08:20 -0700
Message-ID: <CAHQ1cqGAywG=fm1YzfC=iJ+YpxfUn+i7jiPUeiRpyya28Mkq-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for
 other i.MX platforms
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 7:32 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Andrey
>
> Anson Huang
> Best Regards!
>
>
> > -----Original Message-----
> > From: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Sent: Tuesday, August 28, 2018 7:04 AM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> > Estevam <fabio.estevam@nxp.com>; linux-arm-kernel
> > <linux-arm-kernel@lists.infradead.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH 2/2] soc: imx: gpcv2: make pgc driver more generic for
> > other i.MX platforms
> >
> > On Mon, Aug 27, 2018 at 3:51 PM Andrey Smirnov
> > <andrew.smirnov@gmail.com> wrote:
> > >
> > > On Sun, Aug 5, 2018 at 11:45 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > > >
> > > > i.MX8MQ and i.MX8MM share same gpc module with i.MX7D, they can
> > > > reuse gpcv2 pgc driver for power domain control, this patch renames
> > > > all functions and structure definitions started with "imx7" to
> > > > "imx", and check machine type to pass platform specific power domain
> > > > data for power domain driver, thus make
> > > > gpcv2 pgc driver more generic for i.MX platforms.
> > > >
> > >
> > > Just for the sake of
> >
> > Oops, forgot to type out the question I had about i.MX8MQ GPC in general. I've
> > noticed that vendor tree for i.MX8MQ has a separate driver for GPC that relies
> > on code in ARM Trusted Firmware binary blob to do the actual switching. Do
> > you by any chances know the relation between this code and the driver I
> > describe? Are they mutually exclusive or complimentary (I assume the former)?
> > Will the ATF-based driver be eventually deprecated?
>
> Yes, our internal NXP tree currently put all GPC registers operation in ARM Trusted Firmware, and
> Linux kernel has a gpc-psci.c which is a virtual GPC driver to call SMC and trap into ARM Trusted Firmware
> whenever it wants to read/write GPC registers. But for upstream, we plan to reuse i.MX7D's
> GPC driver for power domain control, since the GPC registers for power domain control are
> independent with other low power mode's control registers, it is NOT necessary to introduce
> another virtual GPC driver to call ARM Trusted Firmware for power domain control.
>
> So yes, ATF-based gpc driver for power domain control will be deprecated when we upstream the ATF for
> i.MX8MQ series SoCs. We prefer to reuse the i.MX7D's GPC driver in upstream Linux kernel. If you are OK
> with this, I will send out a V2 patch set to address your comments, thanks.

By all means, I have no objections, the more this code can be reused
the better. I just wanted to confirm if I understood the relation
between two drivers and their future right, that's all.

Thanks,
Andrey Smirnov

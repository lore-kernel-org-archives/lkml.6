Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9CAD6C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF7B20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF7B20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeFLSuJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:50:09 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54795 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933254AbeFLSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:50:07 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so608104itx.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j2B1JVw/dyYYjTOb3jlK3DCLQyupPoPbtuAptq4/WcY=;
        b=jJZDrLen5ISHqAUEesjtlsLecFBy2g0JY7eQDb3TiTsxJEyY1HSkQF2MJHDD4FleVs
         nx8YI7yAVycZP9B2OnT8byvgsI7+YdgiJh+kif49WVdIBwNQEhd6KY6BzorUJMbv193M
         w/BjSzppKLOQGzVKpdsyXU8kZBjGJBpNjUnCC8xL5U6EWtRN+FDYIWUXkjHeOWyEyF+7
         2D/fHIWB0FW/hfkKzqMYYkaXwZ3cLDhMUojZQEw16f1HIxkg112HVNKLsHmEfbNs6a44
         Dax/UCoTav076lvwVgFAlxFMU29ZVmkOzwIEvtOGkig5WZs6rvvstFY5VW/UldSlFGOn
         e3dg==
X-Gm-Message-State: APt69E2gFanVL1D6yi0q7VyGn1xX/5zp8D1tF/G2+vo8r633nI5kBh1S
        rIOj9dmi+yPKJvMd4vX3Vx2xkN5npFE=
X-Google-Smtp-Source: ADUXVKLJRH8oiv8U1+RUF+IyXnyazOSc3Uw7tBMlP6RgQVkGbbt8/nF0iloWJV8FjtBKv9vSTSPyFg==
X-Received: by 2002:a24:2495:: with SMTP id f143-v6mr1656594ita.37.1528829406556;
        Tue, 12 Jun 2018 11:50:06 -0700 (PDT)
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com. [209.85.214.46])
        by smtp.gmail.com with ESMTPSA id z11-v6sm132714ioc.8.2018.06.12.11.50.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 11:50:05 -0700 (PDT)
Received: by mail-it0-f46.google.com with SMTP id a3-v6so691460itd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:50:05 -0700 (PDT)
X-Received: by 2002:a24:6901:: with SMTP id e1-v6mr1756023itc.100.1528829405419;
 Tue, 12 Jun 2018 11:50:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:7b26:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 11:50:04
 -0700 (PDT)
In-Reply-To: <CAOMZO5C0pk-27ztxeJSENBN_-i9o+2sCoS9Cc75Q_Y=-_z_dQg@mail.gmail.com>
References: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com> <CAOMZO5C0pk-27ztxeJSENBN_-i9o+2sCoS9Cc75Q_Y=-_z_dQg@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 12 Jun 2018 13:50:04 -0500
X-Gmail-Original-Message-ID: <CADRPPNQCJ32KOvaO1RRPkxjep9WbXRVZm5CsdLB0k+6p4qRr+Q@mail.gmail.com>
Message-ID: <CADRPPNQCJ32KOvaO1RRPkxjep9WbXRVZm5CsdLB0k+6p4qRr+Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: Update to use SPDX identifiers
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 1:32 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Li,
>
> On Tue, Jun 12, 2018 at 3:28 PM, Li Yang <leoyang.li@nxp.com> wrote:
>
>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> index 7286b1e..f90c040 100644
>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>> @@ -1,45 +1,9 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> Here you use GPL-2.0+
>
>>  /*
>>   * Device Tree file for Freescale LS1012A Freedom Board.
>>   *
>>   * Copyright 2016 Freescale Semiconductor, Inc.
>>   *
>> - * This file is dual-licensed: you can use it either under the terms
>> - * of the GPLv2 or the X11 license, at your option. Note that this dual
>
> ,but the original text says  GPL-2.0, not  GPL-2.0+, so there is a mismatch.

The original text has a conflict probably because some people didn't
regard GPLv2+ as a license name.  But the following detailed
explanation mentioned "you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation;either version 2 of the License, or (at your
option) any later version."  I think we should honor the more verbosed
text than the briefing(same way for X11 vs MIT).

Regards,
Leo

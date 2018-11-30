Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F42C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6321479
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR6nWM3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF6321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeLAFKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeLAFKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:10:22 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B341A2147C;
        Fri, 30 Nov 2018 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543600817;
        bh=/QpuGKJw2ddCeYOK3BoT6q8Eh45edi10/QgSRj8sg4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fR6nWM3wBm1dMxNyAUPSbwdj1Q+K/XNmHKVIxb+tfplFWTz5Hf9UQePJG9BlCS+qO
         Bf+tw27Vw48FA0mSJiQ4QVwrMDXC1EEGZj3XbJh6TVqZe+eC0hdOB2ibCvO4cXY5VB
         hS0wpOT5xwQYG6bMvsnZX/wBPyPmQm8uSOExBHd4=
Received: by mail-qt1-f176.google.com with SMTP id y20so6841312qtm.13;
        Fri, 30 Nov 2018 10:00:17 -0800 (PST)
X-Gm-Message-State: AA+aEWbBXVIbhnwQv9UFPd+JxdLdom7av0vebS7NZRQhxZVIsz7ymYsG
        mXt4VFjO6HiqSMIzFVdWuh7ULvWIRU+Bux6LmA==
X-Google-Smtp-Source: AFSGD/UiLGFEHfl3xFMRQ6BqqrGeqaokngd70FI9UTO2I8nWvpdwvFH4mj26CvCmZOH7gYUq10ZoErtWi8ZQJGhpW+0=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr6546459qts.144.1543600816930;
 Fri, 30 Nov 2018 10:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
In-Reply-To: <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Nov 2018 12:00:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
Message-ID: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
To:     Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Tom Rini <trini@konsulko.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        Grant Likely <glikely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi Rob,
>
> On 05. 10. 18 18:58, Rob Herring wrote:
> > Convert ARM CPU binding to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-mediatek@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> >  2 files changed, 503 insertions(+), 490 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml

[...]

> I have take a look at xilinx part of this and try to build it for arm64
> platforms and I see errors coming from this cpu description.
> /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)

Thanks for actually giving this a spin!

> Based on grep this is used in a lot of places
> compatible = "arm,cortex-a53", "arm,armv8";
>
> Should this be moved to just simple?
> compatible = "arm,cortex-a53";

I'd normally go with the majority which would be to keep it. However,
'arm,armv8' is of questionable value, isn't actually documented, and
doesn't exist for any other version of the architecture. So we should
kill it IMO.

Paging Mark Rutland and other arm folks...

Rob

Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D5AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B572087A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPhyulct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B572087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeF1Gtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:49:32 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35835 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeF1Gtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:49:31 -0400
Received: by mail-it0-f67.google.com with SMTP id l16-v6so10187800ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HeiZel/M2UNAQDnj8GEo9FgxhyzScmMv6TKgmamsIM=;
        b=JPhyulctwbsRd7NUqFsCzdEuMUaDW6rw2hnYU9WWWTgAYCe9U7S358oXq19MGvCAKz
         l1SiCMynWEpXbeBw+uTR74tYKc/tcydFM+t+xcs2soJXEdice5bSIB3LfEEH/qTbTixU
         w1v1mxp+5Xg2wzgPrJ/1wDw2KndAJFY4ILnts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HeiZel/M2UNAQDnj8GEo9FgxhyzScmMv6TKgmamsIM=;
        b=pNLHCyRqyPqX2MTRahiiWaAvLnGgA/DzdYGYgXVZd49D2Jku+RlSIrCupiOs5wfujb
         FY0UDmrSwNhklKYIl7w7nQE3nJMr2xcgvlHC+bOjWRTV0D/AV+eFFxZK38zZJEBoEhtI
         5kW2jJ3fNb/+pxlfI93CzttSijrSNh5DJWNXP/taljUzj+TlpywW1xpVBGrSSWca0TSN
         geieD3cIbjUAN1Z1K3wafW8vFxH2Wm8vhwLUVbEpHPO3Hg4BNF4wwDMPZBpSsCe2uteF
         tPElNPVP0r+Zxna2vA16ioD2Z60alZhuKuOQs+sBM7ZXEut2NvRZzP582U5enYJcmojg
         nA8g==
X-Gm-Message-State: APt69E1E17/J9GpADCv7csdXhJvUz1rKk5VA/GV6g3Uqv4RrKpKB1Hb0
        cjY+pjT54fNPdciou5ukCWGDqkaJ1HJ+ukSXZD9Q5w==
X-Google-Smtp-Source: AAOMgpcOPuI4/XJ8Qm0XKO0HIA2NRwA/s479p0RH/vY6QbQNQE/efljvQNSRIQEHpKIOMxg2jmRcHk77QCjW//1Z62c=
X-Received: by 2002:a24:5746:: with SMTP id u67-v6mr7375461ita.38.1530168570589;
 Wed, 27 Jun 2018 23:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1529563351-2241-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 08:49:18 +0200
Message-ID: <CACRpkdZiY2vAXQSuAgjKfHKtYT_UZD-apEbpS1RT5ZGFutYQeA@mail.gmail.com>
Subject: Re: [[LINUX PATCH v10] 2/4] memory: pl353: Add driver for arm pl353
 static memory controller
To:     naga.sureshkumar.relli@xilinx.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>, ada@thorsis.com,
        honghui.zhang@mediatek.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:43 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

> Add driver for arm pl353 static memory controller. This controller is used in
> Xilinx Zynq SoC for interfacing the NAND and NOR/SRAM memory devices.
>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

(...)

> +config PL353_SMC
> +       tristate "ARM PL35X Static Memory Controller(SMC) driver"
> +       default y
> +       depends on ARM
> +       depends on ARCH_ZYNQ

depends on ARM_AMBA

> +#include <linux/platform_device.h>

This is a PrimeCell with the ARM primecell ID registers
specified, so it should not use platform device.

Use <linux/amba/bus.h>

It further needs to match on these magic values (found in
0xfe0 etc) and use the name "apb_pclk" for the peripheral
(silicon) clock.

See examples such as:
drivers/mmc/host/mmci.c
drivers/tty/serial/amba-pl011.c
drivers/video/fbdev/amba-clcd.c
drivers/hwtracing/coresight/*
etc for examples.

Also see and reference the special PrimeCell DT bindings:
Documentation/devicetree/bindings/arm/primecell.txt

Yours,
Linus Walleij

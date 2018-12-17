Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15BBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8958320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHCJW2xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbeLQSum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:50:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43154 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733216AbeLQSul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:50:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so15271239qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfIvJIC3raK4elOnbWTRrM6e7WEtzAL+9UOrTsakOjY=;
        b=CHCJW2xJmqTkw7l+NbgbyD+oHO4cSeGbUvWqtrISdReE8mkzv2Flo5JX3AJdpJUU+i
         QnkMIMKxteeTOxlia3cnnoG3aW8iIOxCIoRZFD2YJ5NIH1/DC57M+FjkDbpmu0H+kP7k
         XaiVVJ5Zcvfv72MZ33xg8/EIp6vU06Vxm5VXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfIvJIC3raK4elOnbWTRrM6e7WEtzAL+9UOrTsakOjY=;
        b=tqmA8uSR0/BZdB1STuV83ck/Iy5siM+LsAZM2RMbVHqKyzKDR8AaH858U8btDKJWmg
         fqO0QWJxTIbmvM4ndEylRh/Za7Wn/0owt5VcugMvOWYFyaWdsGVaXvEbFkNjXRRrGHzI
         bC5scuwbmWXsm7mtxgwOhjLoGwq6L6qcx0J8U/tnLHLwpRc+iwDZjbH/OUSsHXq49r76
         pPLV4KPf8OtW6gL4SFXNvt88JF51q9vl8r0SyOtQV3QjUcBDc9vgsS9rX0ksGj16+emQ
         U8nqVDrMVjQqUY5dRZINd9ehrrizp/YYvoumKJNS1rGCO/3Co75ShaPk534YRVDD5MlY
         F5aA==
X-Gm-Message-State: AA+aEWa6m3pNRDpgDWjY31QAXaETJwOxE3ljC+VL6IsKtH6HWXpH4Vc5
        x/2M6/L0GCyEEKwALdY0sWX8f6XDuLTbz9snVNDTfA==
X-Google-Smtp-Source: AFSGD/VUE0lsnwTvhpiIFqp1ETiHNQr9yS2noDdzST+hW4A8n1LFGYgcf1VbBaG2pZB+Uls7vpbSeiV3A0ICWJ4+nzo=
X-Received: by 2002:ac8:203:: with SMTP id k3mr15019645qtg.64.1545072640286;
 Mon, 17 Dec 2018 10:50:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545063166.git.amit.kucheria@linaro.org>
 <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
 <d45ce5f7612ef579a9bc687bab4339f27ee35660.camel@perches.com>
In-Reply-To: <d45ce5f7612ef579a9bc687bab4339f27ee35660.camel@perches.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 18 Dec 2018 00:20:28 +0530
Message-ID: <CAP245DWOSoZ4qXQ-CgUPdRQhHyg6X_7i9h0ctwafGXYS2yZLZQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
To:     joe@perches.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>, marc.w.gonzalez@free.fr,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-12-17 at 21:49 +0530, Amit Kucheria wrote:
> > Several drivers didn't have a specific maintainer (other than the
> > subsystem maintainer). Switch to using the 'qcom' and 'msm' regex
> > patterns to capture all of them and add exceptions to the couple of
> > drivers that contain 'msm' but are not related to qcom hardware.
> >
> > Thanks to Marc for the idea to use the N regex.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -1929,20 +1929,14 @@ M:    Andy Gross <andy.gross@linaro.org>
> >  M:   David Brown <david.brown@linaro.org>
> >  L:   linux-arm-msm@vger.kernel.org
> >  S:   Maintained
> > -F:   Documentation/devicetree/bindings/soc/qcom/
> > -F:   arch/arm/boot/dts/qcom-*.dts
> > -F:   arch/arm/boot/dts/qcom-*.dtsi
> > -F:   arch/arm/mach-qcom/
> > -F:   arch/arm64/boot/dts/qcom/*
> > +N:   qcom
> > +N:   msm
>
> It is generally better to use a comprehensive list of F: patterns
> over N: patterns as N: patterns are not used as properly maintained
> entries for files matched by the get_maintainer.pl script.

I did start with something like the following before the suggestion to use N:

diff --git i/MAINTAINERS w/MAINTAINERS
index 3318f30903b2..a04479053570 100644
--- i/MAINTAINERS
+++ w/MAINTAINERS
@@ -1930,16 +1930,38 @@ M: David Brown <david.brown@linaro.org>
 L: linux-arm-msm@vger.kernel.org
 S: Maintained
 F: Documentation/devicetree/bindings/soc/qcom/
+F: Documentation/devicetree/bindings/*/qcom*
 F: arch/arm/boot/dts/qcom-*.dts
 F: arch/arm/boot/dts/qcom-*.dtsi
 F: arch/arm/mach-qcom/
 F: arch/arm64/boot/dts/qcom/*
+F: drivers/edac/qcom*
+F: drivers/firmware/qcom*
+F: drivers/iio/adc/qcom*
+F: drivers/iommu/qcom*
 F: drivers/i2c/busses/i2c-qup.c
+F: drivers/irqchip/qcom*
+F: drivers/cpufreq/qcom*
 F: drivers/clk/qcom/
+F: drivers/crypto/qcom-*
 F: drivers/dma/qcom/
+F: drivers/hwspinlock/qcom_*
+F: drivers/media/platform/qcom/
+F: drivers/mfd/qcom-*
+F: drivers/mailbox/qcom-*
+F: drivers/misc/qcom-*
+F: drivers/mtd/*/qcom*
+F: drivers/perf/qcom*
+F: drivers/power/*/qcom*
+F: drivers/regulator/qcom*
+F: drivers/remoteproc/qcom*
+F: drivers/rpmsg/qcom*
+F: drivers/slimbus/qcom*
 F: drivers/soc/qcom/
 F: drivers/spi/spi-qup.c
 F: drivers/tty/serial/msm_serial.c
+F: drivers/tty/serial/qcom*
+F: drivers/watchdog/qcom*
 F: drivers/*/pm8???-*
 F: drivers/mfd/ssbi.c
 F: drivers/firmware/qcom_scm*

> git history is used by default for the N: entries and that can
> cause whitespace style commit authors to be cc'd on various changes
> to matched files.

Is that by design? Or can we fix get_maintainer.pl to be less
sensitive to whitespace authorship?

> Also msm is a pretty common filename pattern and the X: exclusions
> for various matching but not associated files might need to be added
> to quite often.
>
> From MAINTAINERS:
>
>         N: Files and directories with regex patterns.
>            N:   [^a-z]tegra     all files whose path contains the word tegra
>            One pattern per line.  Multiple N: lines acceptable.
>            scripts/get_maintainer.pl has different behavior for files that
>            match F: pattern and matches of N: patterns.  By default,
>            get_maintainer will not look at git log history when an F: pattern
>            match occurs.  When an N: match occurs, git log history is used
>            to also notify the people that have git commit signatures.
>
>

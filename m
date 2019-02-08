Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B554C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507C920869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/0xva+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfBHNvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:51:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45250 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfBHNvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:51:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so3012579ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PInxNDhRMPt7VBa2yep5M8Vl7JTh2r2fIfH8k75T0uo=;
        b=j/0xva+q5ABK30VwSTKQc1JZ8A55+OaDlCVzUlPvKf6Xy6+Ld7rYoumSJt3ySiTXpC
         OC0xWF79TXaRYxgGgmREnS4mRL1HfUBiRefvJKFAvPH7tZZIHCKZW57Ag5EMhaabNVk0
         nA/2p50p3+9gcX3v5IDt7iPUXus4wdHJhY7hXaVNPX7FWaTAECP4AUQwXIqJlR7eC2t5
         HZ7jiWHYOMjizclycjZWsH1+/RCFZXh848PKxLs440Jd6YqxiCSJDvJYcGpQmCHd4zpE
         NlHH9drKDoNeBOuTYYOMuA3gOtWGXlY9j12vwKODk2xL/tYLCdmBwpsvDjs3iSR7afII
         e+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PInxNDhRMPt7VBa2yep5M8Vl7JTh2r2fIfH8k75T0uo=;
        b=NjxINbEPFsYGPt3M/yMdAlR0M07GcvTI6l/SmpuH08cxiG6xa+FzHPGoyhfZ9UEZDr
         aQRDly2/MtEyxveMUbOe1Fqqim+Bu0LDK0QSZbXGgIcLuqSMnbUsOBMvJh4j2jFQahIf
         1hv8XNMlgH1DrQHWGFXQLAftkdQqyhmPLK5LtFdpS4Q09n3QRYfGixkgYXRJmy0fxJFG
         VCAPlv11A920o2Pa7WWmckXxgDHyQQp6ij6/sALOH+GMias+sDlPWZqUE3nR2G6wl7aw
         bC1cY0mMHuj7uDJFOQHCueOLOCFdEHvbE47IhwDZQUyrSwlXtv4TK3RI3Oe6+uhGcHkh
         FG7w==
X-Gm-Message-State: AHQUAublBJCpfgVcbYSB3Kb4XJhm3RnaM1pVPZrdIACFLDEZ1oOZqglb
        W5FFYMTh0MeZ1qcowGEOUi9d5vU9LO60YgG2j9pkGg==
X-Google-Smtp-Source: AHgI3IbIJ4/7SwTOSL4d2jgdklMWgrW10FpJNEH2K7Oc7kp/gD7o8goOOjgwej2vvJ4YAfq/bJ7m8aS5Zm8KLxyfbSU=
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr13767323ljb.153.1549633892650;
 Fri, 08 Feb 2019 05:51:32 -0800 (PST)
MIME-Version: 1.0
References: <1549290167-876-1-git-send-email-rogerq@ti.com> <1549290167-876-2-git-send-email-rogerq@ti.com>
In-Reply-To: <1549290167-876-2-git-send-email-rogerq@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:51:20 +0100
Message-ID: <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Roger Quadros <rogerq@ti.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        David Lechner <david@lechnology.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        nsaulnier@ti.com, jreeder@ti.com,
        Murali Karicheri <m-karicheri2@ti.com>,
        woods.technical@gmail.com, Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 3:24 PM Roger Quadros <rogerq@ti.com> wrote:

> From: Suman Anna <s-anna@ti.com>
>
> This patch adds the bindings for the Programmable Real-Time Unit
> and Industrial Communication Subsystem (PRU-ICSS) present on various
> SoCs such as AM33xx, AM437x, AM57xx, Keystone 66AK2G SoC, etc. It is
> present on the Davinci based OMAPL138 SoCs and K3 architecture
> based AM65x SoCs as well (not covered for now).
>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

(...)
> +               pruss_intc: intc@20000 {
> +                       compatible = "ti,am3356-pruss-intc";
> +                       reg = <0x20000 0x2000>;
> +                       reg-names = "intc";
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +                       interrupts = <20 21 22 23 24 25 26 27>;
> +                       interrupt-names = "host2", "host3", "host4",
> +                                         "host5", "host6", "host7",
> +                                         "host8", "host9";

If thsese interrupts are mapped 1-to-1 to a parent interrupt controller
then this is a hierarchical interrupt domain and then these should
be handled locally in the driver as offset from child to parent
statically encoded in the driver.

Several old drivers and old device tree bindings make this kind
of maps, but it is not how we do it anymore, if we can avoid it.

To be able to use hierarchical interrupt domain in the kernel, the top
interrupt controller must use the hierarchical (v2) irqdomain, so
if this is anything else than the ARM GIC it will be an interesting
undertaking to handle this.

The more I understand of hierarchical irqdomains, the more of
workarounds where we should be using it I see, we really need
to spread this knowledge. Using it requires a lot of upfront work
sometimes, sorry about that but the end result is so much better.

Yours,
Linus Walleij

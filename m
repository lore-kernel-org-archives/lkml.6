Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89754C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F0520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS+o1moM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F0520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbeKGBV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:21:27 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35442 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbeKGBV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:21:26 -0500
Received: by mail-ua1-f68.google.com with SMTP id d8so4705558ual.2;
        Tue, 06 Nov 2018 07:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8CFiC9qoWiZ8PuMbq5wQdVB142bl+0OdoVp6/aqLEw=;
        b=FS+o1moM9EoOOf+MfEj2unU5Ipqipn482mRNc0fCKtJhbjHRC7RD8YBMFF4ewcKsn+
         rQMoiMonFvS4oAqLNqME5k1DeYkMFBfky/6bJNyRo/fwUwfSN+0IU6FfwigXbd75em+z
         Zk3Wg/CoouhJ47G0fCQOQOGM98GLbd7XxghzC/QO4VymNhYS5mUiptOkGkCoSCxaWV6w
         0o3Z3SX/jQlq9w2iqbULwk5L4Rey6/TA01fZAt7PWimhTuquKyu973OmBHac+pn3N1cP
         eu91Wy1FSpEcKjnhQpbUJ4fa73T+mzUpa+0mZS2PNexUXQNF5c9mhJmPEMlAFXkcsl02
         ouRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8CFiC9qoWiZ8PuMbq5wQdVB142bl+0OdoVp6/aqLEw=;
        b=ueXVm1RGwGdncQRZokDs0pM770hi/inPgd13ufpYURinSfig4O5YlW06zAa/5dFTqW
         lz2XRIMnMb/v+NiKFEJEeX5MN51l1Z/ZkxCcZT0dfwZoql5vVm0wxecRMYWkckQB7rtx
         WlL8V8g2rFXfAiDu2KdODI6jeSC+q9mYOk/pN/55xDaQIn1nthrVhHQWduvykVeIZBAD
         c90k4F6fW45mo+unVrOyD2cE0IH8FIT9vFAv+E0WUu2swlg1p0SBURvO2AZwpYAOVJ9i
         /44SxdlHChJ45c+HFJANvqb1X86+VPAigiEEMamc1QVzSW3hBnBGe1koMRWbGLtUCixn
         0aWQ==
X-Gm-Message-State: AGRZ1gLUbxLKPART/eDwddPL1GnIF1XDWAXn8wWN9ee8HHGrx2utCia9
        u121Fa3TPOdawFoFHx54dpMQh9RiPuhl/R3Hi5w=
X-Google-Smtp-Source: AJdET5fJ4JEMpd6p+94wmJhggC++6CiL3qeWdhQwGgcg2FZKz1WhIb1WiFnlAEUT3zWBSuu2tH4NIU9dc8XOPOp4xow=
X-Received: by 2002:ab0:1d17:: with SMTP id j23mr3161465uak.133.1541519734723;
 Tue, 06 Nov 2018 07:55:34 -0800 (PST)
MIME-Version: 1.0
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
 <1541453493-34981-7-git-send-email-alcooperx@gmail.com> <CAK8P3a0AoHuaiPsMTqhWm3a4X95NpPTPUHkt9vS9Z2ow8NobhA@mail.gmail.com>
In-Reply-To: <CAK8P3a0AoHuaiPsMTqhWm3a4X95NpPTPUHkt9vS9Z2ow8NobhA@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 6 Nov 2018 10:55:31 -0500
Message-ID: <CAOGqxeX1FckLz7XEm-doh_AHUjvRtn00yZfir6dRNMYNOMY5_g@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] usb: host: Add ability to build new Broadcom STB
 USB drivers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        chunfeng yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB list <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/5/18, Al Cooper <alcooperx@gmail.com> wrote:
>
> > +
> > +config USB_BRCM
> > +     tristate "Broadcom STB USB support"
> > +     depends on ARCH_BRCMSTB
> > +     select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> > +     select USB_EHCI_BRCM if USB_EHCI_HCD
> > +     select USB_XHCI_BRCM if USB_XHCI_HCD
> > +     select USB_XHCI_PLATFORM if USB_XHCI_HCD
> > +     select BRCM_USB_PHY if USB_OHCI_HCD || USB_EHCI_HCD || USB_XHCI_HCD
> > +     select GENERIC_PHY if BRCM_USB_PHY
> > +     default ARCH_BRCMSTB
>
> Is there a build time dependency on the PHY layer? If not, I would suggest
> dropping the last two 'select' statements. I would also suggest
> making the dependency 'depends on ARCH_BRCMSTB || COMPILE_TEST'
> to allow building it on other architecture for better build testing, and
> dropping the 'default' line. Just add this to the defconfig like the other
> drivers you have.

I added COMPILE_TEST and dropped the last 2 select lines.
Most of our other drivers default to "y" for "ARCH_BRCMSTB", would it
be better if I changed it to "default y"?

Thanks
Al

>
>       Arnd

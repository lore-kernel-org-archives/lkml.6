Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51299C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157CD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDfPVVTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157CD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbeKFUea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:34:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33735 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFUea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:34:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so2067762qtp.0;
        Tue, 06 Nov 2018 03:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8KZc47z7i/urlrVRquuSSOL2R8rnnIO7Cshemc+Qki0=;
        b=CDfPVVTBW+fEnSC9pS4cK8OmICNx+V6x+CyCdcBzQWvaFcjbpICWh52Y4y8dVe3Zqo
         wHjPll/tYwUSmaR4C9sjb6ln4YkrjMe0PgoNyaCgVAarxjmi2B3viO03XmXNT1mr2tlN
         t9kMhLur8dPFkum6FplDIOZIjA71hYF/8zGLLN5vEdunc4OIvp7FcEImNa9eqHCG3vn+
         XhvOoWjVeU2pDoVd965iEAo+r8ct7UyOi5E7OFwKghbNVHWUbSVCaHQps2dlk9TNwlqo
         NIXrCLkiMCBqaAyZ8s2IjJZEJCUmvSyy4Pli/wEUzJrwyUDWXIP/gMUkKG9gzD+F6P/a
         +dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8KZc47z7i/urlrVRquuSSOL2R8rnnIO7Cshemc+Qki0=;
        b=GSaUe/3MExRjtr3cq393SelsUVf4DH3Pbd8jZO4G5qohQowYqqbEbheOvii2OmrbKJ
         QhiuFz6aaUx3Npix4WdVkzm0xAosVbxyBjv2hwoitmR6eLjlzl4FOkjvlGuyVHNvK3+C
         LdnWpyxxrNVRo0zqRnE3IoyANpaHEkAejGDogzzfHTakGkkhw71liWiMXjXjYX2vvOWr
         QMAEckOeK0o6ScK0Ryb6/5BvlFwgdqSS0eVCYRK0fVFzCe3cxWm4NyHpXboV9wQvB6Gr
         MVJxt2z5v67g9MlXxxJ2vgpsO3D2/y6XU20dkcnksV18Krx7xxbSJNuSlC7qr37flHaj
         w8cg==
X-Gm-Message-State: AGRZ1gIleN5QAyBxE40Hkn1LMJq1nWmdq1QK3dPG8OtHnsZzGL9iRLby
        1g9T2GXl2oMr9zXFp/W7F1+Mqi0QuzXZdL6wCds=
X-Google-Smtp-Source: AJdET5fmRHOfX9hxV8MTYiAJBhp6LvZD+asz1iZ9hAvxRxnWmUdPRyDseuU8UCIcSJ9sqiVuUBEro6McowbMIBT4vyQ=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr198923qtr.319.1541502588190;
 Tue, 06 Nov 2018 03:09:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 03:09:47 -0800 (PST)
In-Reply-To: <1541453493-34981-7-git-send-email-alcooperx@gmail.com>
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com> <1541453493-34981-7-git-send-email-alcooperx@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Nov 2018 12:09:47 +0100
X-Google-Sender-Auth: vDmIKsgVfNSZ8JYY9D1g74VslZo
Message-ID: <CAK8P3a0AoHuaiPsMTqhWm3a4X95NpPTPUHkt9vS9Z2ow8NobhA@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] usb: host: Add ability to build new Broadcom STB
 USB drivers
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
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

On 11/5/18, Al Cooper <alcooperx@gmail.com> wrote:

> +
> +config USB_BRCM
> +	tristate "Broadcom STB USB support"
> +	depends on ARCH_BRCMSTB
> +	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> +	select USB_EHCI_BRCM if USB_EHCI_HCD
> +	select USB_XHCI_BRCM if USB_XHCI_HCD
> +	select USB_XHCI_PLATFORM if USB_XHCI_HCD
> +	select BRCM_USB_PHY if USB_OHCI_HCD || USB_EHCI_HCD || USB_XHCI_HCD
> +	select GENERIC_PHY if BRCM_USB_PHY
> +	default ARCH_BRCMSTB

Is there a build time dependency on the PHY layer? If not, I would suggest
dropping the last two 'select' statements. I would also suggest
making the dependency 'depends on ARCH_BRCMSTB || COMPILE_TEST'
to allow building it on other architecture for better build testing, and
dropping the 'default' line. Just add this to the defconfig like the other
drivers you have.

      Arnd

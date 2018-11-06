Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22136C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71722085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdBoq14U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71722085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbeKGE7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:59:55 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35718 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKGE7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:59:55 -0500
Received: by mail-vk1-f193.google.com with SMTP id b18so3161898vke.2;
        Tue, 06 Nov 2018 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TduehDfaomBTPPDfXcBlFgUI2m0b+zODRnRbOn2Bb2U=;
        b=sdBoq14UPCv0z9GypZx0euV7j3t3vWoyCjk+FB0A56q1Iw7kZXjroESRpqupdtIzMO
         Lf+TK5YwXdhBq64alIAlilQVjVCIUSiy6zwbuDARnVqMYL89PocjryFo9FA+/yWCUwfb
         /lrpPQeEuV6d+yn8Cdi5X59vvarHozxhx+jkPcD0Cu7ac7vPArOcRsb+yUhSq0EGqJW0
         P3Nbebz3hFLNLDeGZlahnCYCdi7kqTItOL5BfKmYYFjnqlvm3/CQ0MysCI6d52yYIOAJ
         vLgfrBQuJMD5vaDBYkjHGhJYwjLUXNbD3TrK0E8TJKBAPbjmb2Q6qX9jZbdyL6VuSEkO
         D7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TduehDfaomBTPPDfXcBlFgUI2m0b+zODRnRbOn2Bb2U=;
        b=WvDcANGV5GOxNKoeeJ4AOVjgNAjT6WGgLcBE5wxamJJGt1em66EJWzg6SMsfd+Sq7R
         0LPzF1xHIF7Uq8eL0cU4xsrdccQCB3gg4c5zb+g6YJs17ozpnbF5vSBfZOpYA6RsoLTI
         5M6cBBd60VSOHGPLThxpAdbK9TmaAgn13obVddG5KPX8Lsjp7YAbzH6i48CcxexPqF2J
         P4+QPPN8KObhCVj18gPXDvjFG6ZuxzWTPD4LwrznCB2gLHg/QiewueYp+QK/C8Phfy4n
         SUvA6t7KGGAudbA/RvqivVNj+zdDQXbNRDRcLCniz5ChaPrMQ0XX/a+CyQnkEvF8WaL/
         1hhA==
X-Gm-Message-State: AGRZ1gKTz9XsmfqGZVO6yiuFfS4C3xpG5ycn8xFrghb2wsiO3S8ozic4
        PGtBS1aMVbWXpXSgyA7IOQ2PxnvVAK+824/37cU=
X-Google-Smtp-Source: AJdET5e8m/8BV8N6QMpTL+Soqb+2CjNDo+QlglP2lk0/WBSxdqPAfJZqfUFO2vKBqu5o0iO0r6ZqfII10Yq+lB2VEy0=
X-Received: by 2002:a1f:83ca:: with SMTP id f193mr11614580vkd.75.1541532787599;
 Tue, 06 Nov 2018 11:33:07 -0800 (PST)
MIME-Version: 1.0
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
 <1541453493-34981-7-git-send-email-alcooperx@gmail.com> <CAK8P3a0AoHuaiPsMTqhWm3a4X95NpPTPUHkt9vS9Z2ow8NobhA@mail.gmail.com>
 <CAOGqxeX1FckLz7XEm-doh_AHUjvRtn00yZfir6dRNMYNOMY5_g@mail.gmail.com> <CAK8P3a2Xuq77sXKy4QX1YhStOEhm+oAM_AErEGuwqB115pHB_w@mail.gmail.com>
In-Reply-To: <CAK8P3a2Xuq77sXKy4QX1YhStOEhm+oAM_AErEGuwqB115pHB_w@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 6 Nov 2018 14:33:04 -0500
Message-ID: <CAOGqxeVC0atR0neerxLNDbHWgpuXYCVUW0YLhHxvQzDO0CHWZw@mail.gmail.com>
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

On Tue, Nov 6, 2018 at 1:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/6/18, Alan Cooper <alcooperx@gmail.com> wrote:
> > On Tue, Nov 6, 2018 at 6:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On 11/5/18, Al Cooper <alcooperx@gmail.com> wrote:
> >>
> >> > +
> >> > +config USB_BRCM
> >> > +     tristate "Broadcom STB USB support"
> >> > +     depends on ARCH_BRCMSTB
> >> > +     select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> >> > +     select USB_EHCI_BRCM if USB_EHCI_HCD
> >> > +     select USB_XHCI_BRCM if USB_XHCI_HCD
> >> > +     select USB_XHCI_PLATFORM if USB_XHCI_HCD
> >> > +     select BRCM_USB_PHY if USB_OHCI_HCD || USB_EHCI_HCD ||
> >> > USB_XHCI_HCD
> >> > +     select GENERIC_PHY if BRCM_USB_PHY
> >> > +     default ARCH_BRCMSTB
> >>
> >> Is there a build time dependency on the PHY layer? If not, I would
> >> suggest
> >> dropping the last two 'select' statements. I would also suggest
> >> making the dependency 'depends on ARCH_BRCMSTB || COMPILE_TEST'
> >> to allow building it on other architecture for better build testing, and
> >> dropping the 'default' line. Just add this to the defconfig like the
> >> other
> >> drivers you have.
> >
> > I added COMPILE_TEST and dropped the last 2 select lines.
> > Most of our other drivers default to "y" for "ARCH_BRCMSTB", would it
> > be better if I changed it to "default y"?
>
> No, "default ARCH_BRCMSTB" is better than "default y", but I'd recommend
> to just not have non-essential drivers default-on.
>
>       Arnd

Okay.

Thanks
Al

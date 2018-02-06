Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1096172-1517922365-2-16097306100895365780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517922364; b=rDby6JUS+vxGig77/e5IjTqJhP7zcVjfHWYV2Lv9GTJnY9H
    f+Bdr056q9lEz3DFQk9MTTKlPRyOHED+0JJOgAJF32vKRCAqNLYdK0jk3xFytz06
    M7f/SjsF89GRVFVma3PjrX0xvOW7mRrA9Oidi5FkOhfITD8dxQtEGk1tUXMMMUlt
    qc2rGS4awYNaaLdCewgsJanIUDoY+gnftUcLBu2Oz3qUQt9O3BoYV8+Gy64zTZ2d
    HWo+U0vqREBdGXHAzpv9FXm1X4HnP6MWxwY/skeHRAJQ7yemPoC3qttTwGol6yQf
    dPXkSo5Ycw8KmXwS3O2GKN/0ZM87JcPZUw02IxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517922364; bh=ZdqIU0ZTVTNJKQpk3MyqvdmQ70MV6zVWfXICZB7v4TI=; b=w
    GkelPmkSwtWEnFmaHwD8UUoiDH3T1tqbze5eJpge8MepdTSlZOa66ziQW1jgj98Z
    fMXz8apeZu6avk2FSFrf4oQihC583K3yTkwTI70fMTAm4s1eF5VKXwJYcOfxIhBy
    ByF7j/c3rZ4UeV4yTJsNufwxslHh0+judsZaXoEw2ah9VXfNEwpI9lRj3KsmV+Xq
    HUTwZZ8HUwe4bvju64PfMAfzzMvcmuZO1+PDnH2dH62twsdWZHESmgkmZAleP4wx
    VZr1KjETtU6V0YI7bVcRkeBQG9TuYBXt2fjYnVk14bn+hlrQZVFefCEPUTrzku33
    hJaqgRVwgHgf6oC2yh1qQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeBFNFu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 08:05:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36726 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeBFNFs (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 6 Feb 2018 08:05:48 -0500
Subject: Re: [PATCH/RFC 0/6] Allow compile-testing NO_DMA
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c68d8b8b-dc46-2066-0341-558f57ad113f@arm.com>
Date: Tue, 6 Feb 2018 13:05:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517912092-15470-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/02/18 10:14, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> If NO_DMA=y, get_dma_ops() returns a reference to the non-existing
> symbol bad_dma_ops, thus causing a link failure if it is ever used.
> 
> The intention of this is twofold:
>    1. To catch users of the DMA API on systems that do no support the DMA
>       mapping API,
>    2. To avoid building drivers that cannot work on such systems anyway.
> 
> However, the disadvantage is that we have to keep on adding dependencies
> on HAS_DMA all over the place.
> 
> Thanks to the COMPILE_TEST symbol, lots of drivers now depend on one or
> more platform dependencies (that imply HAS_DMA) || COMPILE_TEST, thus
> already covering intention #2.  Having to add an explicit dependency on
> HAS_DMA here is cumbersome, and hinders compile-testing.
> 
> Hence I think the time is ripe to reconsider the link failure.
> This patch series:
>    - Changes get_dma_ops() to return NULL instead,
>    - Adds a few more dummies to enable compile-testing,
>    - Removes dependencies on HAS_DMA for symbols that already have
>      platform dependencies implying HAS_DMA.
> 
> Note that adding more platform dependencies and/or dependencies on
> COMPILE_TEST is encouraged!
> 
> This may make life harder for UML, though, as UML usually satisfies all
> other platform dependencies for HAS_DMA.  Similarly, HAS_IOMEM is even
> more complicated.  Can/do we want to do something similar for
> HAS_IOMEM?

It looks like we have only one real arch (score) without IOMEM, and two 
(s390 and tile) where it is possible to configure out, so it does seem 
like a reasonable feature to assume. Maybe we could have something like 
asm-generic/no-io.h to provide an "unimplemented" version of those 
interfaces.

Anyway, for this series:

Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> This series is against my current local tree, which has a few more
> "depends on HAS_DMA" than upstream.  Of course I will rebase, and split
> the last patch per subsystem, if this RFC is welcomed positively.
> 
> Compile-tested with allmodconfig and allyesconfig for m68k/sun3.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (6):
>    [RFC] dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
>    [RFC] dma-coherent: Add NO_DMA dummies for managed DMA API
>    [RFC] usb: gadget: Add NO_DMA dummies for DMA mapping API
>    [RFC] mm: Add NO_DMA dummies for DMA pool API
>    [RFC] scsi: Add NO_DMA dummies for SCSI DMA mapping API
>    [RFC] Treewide: Remove depends on HAS_DMA in case of platform
>      dependency
> 
>   drivers/ata/Kconfig                             |  2 --
>   drivers/crypto/Kconfig                          | 14 +++------
>   drivers/firewire/Kconfig                        |  1 -
>   drivers/fpga/Kconfig                            |  1 -
>   drivers/gpu/ipu-v3/Kconfig                      |  1 -
>   drivers/i2c/busses/Kconfig                      |  3 --
>   drivers/iio/adc/Kconfig                         |  3 --
>   drivers/iommu/Kconfig                           |  5 ++--
>   drivers/lightnvm/Kconfig                        |  2 +-
>   drivers/mailbox/Kconfig                         |  2 --
>   drivers/media/pci/dt3155/Kconfig                |  1 -
>   drivers/media/pci/solo6x10/Kconfig              |  1 -
>   drivers/media/pci/sta2x11/Kconfig               |  1 -
>   drivers/media/pci/tw5864/Kconfig                |  1 -
>   drivers/media/pci/tw686x/Kconfig                |  1 -
>   drivers/media/platform/Kconfig                  | 40 ++++++++-----------------
>   drivers/media/platform/am437x/Kconfig           |  2 +-
>   drivers/media/platform/atmel/Kconfig            |  4 +--
>   drivers/media/platform/blackfin/Kconfig         |  1 -
>   drivers/media/platform/davinci/Kconfig          |  6 ----
>   drivers/media/platform/marvell-ccic/Kconfig     |  3 +-
>   drivers/media/platform/rcar-vin/Kconfig         |  2 +-
>   drivers/media/platform/soc_camera/Kconfig       |  3 +-
>   drivers/media/platform/sti/c8sectpfe/Kconfig    |  2 +-
>   drivers/mmc/host/Kconfig                        | 10 ++-----
>   drivers/mtd/nand/Kconfig                        |  8 ++---
>   drivers/mtd/spi-nor/Kconfig                     |  2 +-
>   drivers/net/ethernet/amd/Kconfig                |  2 +-
>   drivers/net/ethernet/apm/xgene-v2/Kconfig       |  1 -
>   drivers/net/ethernet/apm/xgene/Kconfig          |  1 -
>   drivers/net/ethernet/arc/Kconfig                |  6 ++--
>   drivers/net/ethernet/broadcom/Kconfig           |  2 --
>   drivers/net/ethernet/calxeda/Kconfig            |  2 +-
>   drivers/net/ethernet/hisilicon/Kconfig          |  2 +-
>   drivers/net/ethernet/marvell/Kconfig            |  8 ++---
>   drivers/net/ethernet/mellanox/mlxsw/Kconfig     |  2 +-
>   drivers/net/ethernet/renesas/Kconfig            |  2 --
>   drivers/net/ethernet/socionext/Kconfig          |  4 +--
>   drivers/net/wireless/broadcom/brcm80211/Kconfig |  1 -
>   drivers/net/wireless/quantenna/qtnfmac/Kconfig  |  2 +-
>   drivers/remoteproc/Kconfig                      |  1 -
>   drivers/scsi/hisi_sas/Kconfig                   |  2 +-
>   drivers/spi/Kconfig                             | 12 ++------
>   drivers/staging/media/davinci_vpfe/Kconfig      |  1 -
>   drivers/staging/media/omap4iss/Kconfig          |  1 -
>   drivers/staging/vc04_services/Kconfig           |  1 -
>   drivers/tty/serial/Kconfig                      |  4 ---
>   drivers/usb/gadget/udc/Kconfig                  |  4 +--
>   drivers/usb/mtu3/Kconfig                        |  2 +-
>   drivers/video/fbdev/Kconfig                     |  3 +-
>   include/linux/dma-mapping.h                     | 19 ++++++++----
>   include/linux/dmapool.h                         | 21 +++++++++++--
>   include/linux/usb/gadget.h                      | 12 ++++++++
>   include/scsi/scsi_cmnd.h                        |  5 ++++
>   sound/soc/bcm/Kconfig                           |  3 +-
>   sound/soc/kirkwood/Kconfig                      |  1 -
>   sound/soc/pxa/Kconfig                           |  1 -
>   sound/soc/qcom/Kconfig                          |  6 ++--
>   58 files changed, 108 insertions(+), 148 deletions(-)
> 

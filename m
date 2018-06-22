Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9656BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07924133
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C07924133
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeFVL3Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:29:16 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45933 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeFVL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:29:14 -0400
Received: by mail-ot0-f193.google.com with SMTP id a5-v6so7100869otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DmGSeCdjffrcnTc4AF9BmHBEuUkkB61WLfe5OIN/e4Y=;
        b=A2c5rRjX7x1qn2KTNrWl6mfrrTtt1x0YbLmk2nnTuIXdbExxe9kk/lvQp0QtjDm3zO
         E+TIrPXP2Xv2K3RNp0DKEEbW9r1wwEWnAX8fX/5QQJGlGFS/zzC8BfTKI9jBAXga5SYH
         yVuILb5PgHxH0+BsQTP3zYdd+x+U+ClS5fh4oq/DtjiRk1Whd4EV9n+Utmg79L14M46p
         dl2YpjJrlXqnYTOfwKbLDCkwEc54ri4t5IRutAXtlXAyekVq3/aPcCrI96mIXzzSsIfx
         WvwaHXCloYcDXO8v9JwgfTTZI1A1s1csFdYfy4wP6HgE9A0236qcNPBWME0baMgZNW/l
         1zqQ==
X-Gm-Message-State: APt69E1l6B4lLv93RTIHvl4Tt8NvSMbhyr3DjEyc/Kz8tH9B4VoEjQFa
        hUuROalUeN8LvwkNtP38tMwkW3/4K6jmFTM552A=
X-Google-Smtp-Source: ADUXVKI1/AMpyA0+7z2Qv5Cts5iUh8bcf2G1TL2Xj+13HRRgadZs9dkfHCePa0ZSquBCbFtRZMDbTeryYFjJWdZmasw=
X-Received: by 2002:a9d:56ec:: with SMTP id b41-v6mr629379otj.339.1529666954319;
 Fri, 22 Jun 2018 04:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180322202007.23088-8-malat@debian.org> <20180328193935.1338-1-malat@debian.org>
In-Reply-To: <20180328193935.1338-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 22 Jun 2018 13:29:03 +0200
Message-ID: <CA+7wUsxL=r6hip9hwt9xsrFYAZeqqFBmf89N37sPVeMdOsJjGw@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] powerpc/powermac: Make some functions static
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one should also be good to go.

On Wed, Mar 28, 2018 at 9:39 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
>
>   arch/powerpc/platforms/powermac/pci.c:1022:6: error: no previous prototype for ‘pmac_pci_fixup_ohci’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/pci.c:1057:6: error: no previous prototype for ‘pmac_pci_fixup_cardbus’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/powermac/pci.c:1094:6: error: no previous prototype for ‘pmac_pci_fixup_pciata’ [-Werror=missing-prototypes]
>
> Remove has_address declaration and assignment since not used. Also add gcc
> attribute unused to fix a warning treated as error with W=1:
>
>   arch/powerpc/platforms/powermac/pci.c:784:19: error: variable ‘has_address’ set but not used [-Werror=unused-but-set-variable]
>   arch/powerpc/platforms/powermac/pci.c:907:22: error: variable ‘ht’ set but not used [-Werror=unused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: remove has_address variable since not used
>  arch/powerpc/platforms/powermac/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
> index 0b8174a79993..67c497093e0a 100644
> --- a/arch/powerpc/platforms/powermac/pci.c
> +++ b/arch/powerpc/platforms/powermac/pci.c
> @@ -781,12 +781,12 @@ static int __init pmac_add_bridge(struct device_node *dev)
>         struct resource rsrc;
>         char *disp_name;
>         const int *bus_range;
> -       int primary = 1, has_address = 0;
> +       int primary = 1;
>
>         DBG("Adding PCI host bridge %pOF\n", dev);
>
>         /* Fetch host bridge registers address */
> -       has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
> +       of_address_to_resource(dev, 0, &rsrc);
>
>         /* Get bus range if any */
>         bus_range = of_get_property(dev, "bus-range", &len);
> @@ -904,7 +904,7 @@ static int pmac_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
>  void __init pmac_pci_init(void)
>  {
>         struct device_node *np, *root;
> -       struct device_node *ht = NULL;
> +       struct device_node *ht __maybe_unused = NULL;
>
>         pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
>
> @@ -1019,7 +1019,7 @@ static bool pmac_pci_enable_device_hook(struct pci_dev *dev)
>         return true;
>  }
>
> -void pmac_pci_fixup_ohci(struct pci_dev *dev)
> +static void pmac_pci_fixup_ohci(struct pci_dev *dev)
>  {
>         struct device_node *node = pci_device_to_OF_node(dev);
>
> @@ -1054,7 +1054,7 @@ void __init pmac_pcibios_after_init(void)
>         }
>  }
>
> -void pmac_pci_fixup_cardbus(struct pci_dev* dev)
> +static void pmac_pci_fixup_cardbus(struct pci_dev *dev)
>  {
>         if (!machine_is(powermac))
>                 return;
> @@ -1091,7 +1091,7 @@ void pmac_pci_fixup_cardbus(struct pci_dev* dev)
>
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_ANY_ID, pmac_pci_fixup_cardbus);
>
> -void pmac_pci_fixup_pciata(struct pci_dev* dev)
> +static void pmac_pci_fixup_pciata(struct pci_dev *dev)
>  {
>         u8 progif = 0;
>
> --
> 2.11.0
>

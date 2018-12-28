Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB83C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328C6214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545970968;
	bh=9P9bj2GpqfXMQrbDK+jNI2hArfw/ksMRCA/lNIqFCsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ggME1sk0yN6pn0hqLPt8H7Dd8QLk9SKQJ8WSXYqvflUnU4imniQWpQAk8ovcJCdAC
	 l9Y8b/MxZ29y70c1elN3oxIuiWjHqmD86jKgHeF/p3RVdZBeTHgTN0z9y6vmFRAsx6
	 6rIosG3A6L7H0bnp0Y5GsZfrenX7v6oyTCIQI0Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbeL1EWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 23:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbeL1EWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 23:22:44 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3597214C6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545970964;
        bh=9P9bj2GpqfXMQrbDK+jNI2hArfw/ksMRCA/lNIqFCsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s7zKeWWVQBUNxCPdsCGr253RzL8R895QY/ylptPOc5VxpWAHhV+M4mlPMwy4ZZbP2
         wMBA427bRslOdvcfPLi2WHIQ3ZtUge86gfhZlqHNmFpqqIWhX0cOjo1I2kYdFZ6j2F
         dOZSsVCbFfvMOUHw/0mD5gerJhOutv/C4ORjW4hM=
Received: by mail-ot1-f52.google.com with SMTP id i20so17855973otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 20:22:43 -0800 (PST)
X-Gm-Message-State: AJcUukcSO7tPr18udAZYGw4aFYeXJi/diP/eYAQB9qpwoyG6WDioEvz4
        B3f10mXDl2OZ2qnC4ArwsAAjA4Mui12Wxii3daQ=
X-Google-Smtp-Source: ALg8bN6F8S0ZoFoRogqllux7p9cjFEtygQl0ssXhPsaJm6Jny6wUMLjSOZKmJQCzJgXw80w4luomQuAOZyuDw/9xdn0=
X-Received: by 2002:a9d:2c5:: with SMTP id 63mr18006286otl.271.1545970963127;
 Thu, 27 Dec 2018 20:22:43 -0800 (PST)
MIME-Version: 1.0
References: <1545929198-15733-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1545929198-15733-1-git-send-email-linux@roeck-us.net>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Fri, 28 Dec 2018 07:22:31 +0300
X-Gmail-Original-Message-ID: <CAK9iUCP8WLe2+oNpX6WaDZ9oP4thjdTARWKOGrV1T=JjC1F_uQ@mail.gmail.com>
Message-ID: <CAK9iUCP8WLe2+oNpX6WaDZ9oP4thjdTARWKOGrV1T=JjC1F_uQ@mail.gmail.com>
Subject: Re: [PATCH] h8300: pci: Remove local declaration of pcibios_penalize_isa_irq
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 7:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> h8300 builds fail with:
>
> In file included from drivers/of/address.c:11:
> include/linux/pci.h:1966:20: error: redefinition of 'pcibios_penalize_isa_irq'
>
> This is because CONFIG_PCI is not enabled, and pcibios_penalize_isa_irq()
> is now declared as inline static function in generic code if this is the
> case. Since h8300 does not support PCI to start with, fix the problem by
> removing the architecture specific pci.h.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Cc: Sinan Kaya <okaya@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/h8300/include/asm/Kbuild |  1 +
>  arch/h8300/include/asm/pci.h  | 18 ------------------
>  2 files changed, 1 insertion(+), 18 deletions(-)
>  delete mode 100644 arch/h8300/include/asm/pci.h
>

Thanks, makes sense.

Reviewed-by : Sinan Kaya <okaya@kernel.org>


> diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
> index a5d0b2991f47..cd400d353d18 100644
> --- a/arch/h8300/include/asm/Kbuild
> +++ b/arch/h8300/include/asm/Kbuild
> @@ -33,6 +33,7 @@ generic-y += mmu.h
>  generic-y += mmu_context.h
>  generic-y += module.h
>  generic-y += parport.h
> +generic-y += pci.h
>  generic-y += percpu.h
>  generic-y += pgalloc.h
>  generic-y += preempt.h
> diff --git a/arch/h8300/include/asm/pci.h b/arch/h8300/include/asm/pci.h
> deleted file mode 100644
> index d4d345a52092..000000000000
> --- a/arch/h8300/include/asm/pci.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_H8300_PCI_H
> -#define _ASM_H8300_PCI_H
> -
> -/*
> - * asm-h8300/pci.h - H8/300 specific PCI declarations.
> - *
> - * Yoshinori Sato <ysato@users.sourceforge.jp>
> - */
> -
> -#define pcibios_assign_all_busses()    0
> -
> -static inline void pcibios_penalize_isa_irq(int irq, int active)
> -{
> -       /* We don't do dynamic PCI IRQ allocation */
> -}
> -
> -#endif /* _ASM_H8300_PCI_H */
> --
> 2.7.4
>

Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE46C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64F521735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64F521735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeH0KmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:42:21 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37872 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeH0KmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:42:21 -0400
Received: by mail-vk0-f68.google.com with SMTP id s6-v6so5941837vks.4;
        Sun, 26 Aug 2018 23:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjXk1EcPC7+lNtYbFDdbw88QI/ZCk2Bm3D9cRUGLBdk=;
        b=bkkQrjlIuTgA/pDZ90PZ99hEDF3eNBFFLei2N1mMdmd7zhF830GHhVFVoKpOl8bhmZ
         A3mf67kq9qeZJRopbAiawsO40wjx52SmXhxER7/EI6TjzbMYJQ1lJf6BL1gw6k8hT4RH
         5ogZC2U5oDNEfJh5yH+D4/6Jzc9pD19J4dfq8ha2vmDGQEUfDtH2XVHECGVDAW38AYVB
         MneyOT/qklCxO2a7ysanE4MAIIxhviOk2IX+eTCMyQz9TQXtzOIPPoBEVXZUHruHOqYU
         8SNwqvgxj9MDcO/hvRa/FgiQzmL5s04ZnXW59YSAM6IKDKxo5l3uqaeoda5QNdXiTEMH
         aXdg==
X-Gm-Message-State: APzg51DzgF5OWQ+1izh6qxHBdm51sZudVaSeWf0/ix7+CFuRjSzjs3rP
        iOFPPtzNJK/chMW3pHeCB8gplehomhy7Ro23Vhg=
X-Google-Smtp-Source: ANB0VdYxHy88qpoWKGrVUjkXA5YA6jPAuFhCqraXFkKOGc7xueRLEKgaT82wrqksOcCJH8hztayIBRp++q8DpSqD8Lk=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr368224vkg.40.1535353021635;
 Sun, 26 Aug 2018 23:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <152883965482.1936.13657625103232933481.stgit@taos> <152883969032.1936.15155267369758178246.stgit@taos>
In-Reply-To: <152883969032.1936.15155267369758178246.stgit@taos>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Aug 2018 08:56:50 +0200
Message-ID: <CAMuHMdVf-QDAVh-vHF_xyvX73_nsO9X7RnDc=yCK_FS68i6zTw@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To:     gary.hook@amd.com
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

On Tue, Jun 12, 2018 at 11:42 PM Gary R Hook <gary.hook@amd.com> wrote:
> Implement a skeleton framework for debugfs support in the AMD
> IOMMU.  Add an AMD-specific Kconfig boolean that depends upon
> general enablement of DebugFS in the IOMMU.
>
> Signed-off-by: Gary R Hook <gary.hook@amd.com>

This is now commit 7d0f5fd3e4d68742 ("iommu/amd: Add basic debugfs
infrastructure for AMD IOMMU").

> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -146,6 +146,18 @@ config AMD_IOMMU_V2
>           hardware. Select this option if you want to use devices that support
>           the PCI PRI and PASID interface.
>
> +config AMD_IOMMU_DEBUGFS
> +       bool "Enable AMD IOMMU internals in DebugFS"
> +       depends on AMD_IOMMU && IOMMU_DEBUGFS
> +       ---help---
> +         !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
> +
> +         DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
> +         Exposes AMD IOMMU device internals in DebugFS.
> +
> +         This option is -NOT- intended for production environments, and should
> +         not generally be enabled.

If it is that bad, shouldn't this option be protected by some Kconfig
trickery to avoid it being enabled in allmodconfig/allyesconfig builds?

I forgot the way to do that, so some CCs added.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

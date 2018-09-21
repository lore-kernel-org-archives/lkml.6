Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4FEECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B380021550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B380021550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391315AbeIVAzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:55:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37825 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:55:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so4355937wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cQOKo9QwYrmRxIA1o8B3UUJEJaQa7L51o+26ywNnwFs=;
        b=eLPMHB21fWgjG5pKM5DADED/fTFjK3nzFZ/Y+mGmYgPNWbQGspuDQgLpSeRXSMhdRz
         I/Ya0OjG6GtSyteFfr525rQFrw3B28Hu9KWGKbHGr84DhxEvAfy3vkrY/OSceZ4pU3Lc
         lbhcJDC5yu1udEqJWoVemPvBzqjsaY6b1F8la0z33wpv5ghuYCYUKtTy3l3ro3xc94QB
         pJx13nWzNkfIzJx0sraDdT60WbIo38RbTCNZwJ6Dy8Q/xVpgVogImHHHC8RiEFCKRr8E
         rUWj+gdlfa+uFDLcvaGL70hvnjaVLzqS7iRQQbmcVsWZMNpzp7khLvD0r9RTBydcbMY1
         k01w==
X-Gm-Message-State: ABuFfojKs1tiYT1aK8Skuij1TXWmMNVtteOHT2diHsvIDinuNfCf6v19
        6sO2J9YL/iYszsrvV/Nc6d6ftohFCIOu5JjksaAiYiVw
X-Google-Smtp-Source: ANB0VdZ9T/jSH5nSKaNoXLXCQgiQZd7ghM15uog4mrG4eQQzWVYwQ9pra3Yl5i0yxWlacOcGNqZfFC4DL0hW/w91j/A=
X-Received: by 2002:a1c:1a49:: with SMTP id a70-v6mr8414227wma.91.1537556722911;
 Fri, 21 Sep 2018 12:05:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:918b:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 12:05:22
 -0700 (PDT)
In-Reply-To: <20180919171353.29648-1-lyude@redhat.com>
References: <20180919171353.29648-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 21 Sep 2018 21:05:22 +0200
Message-ID: <CACO55tsma8=OKB-wLAqE_fD+Ao05PWPsiJEsb3jzT+XU1RRjzQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 0/2] drm/nouveau: Allow parsing vbios.rom with
 nvbios from debugfs
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both patches are Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Wed, Sep 19, 2018 at 7:13 PM, Lyude Paul <lyude@redhat.com> wrote:
> This is a small patch series that adds a strap_peek file into our
> debugfs, and sets the size of the vbios.rom debugfs file so that nvbios
> can easily be used to parse the vbios even on systems where the normal
> BIOS retrieval methods (for example, laptops that need ACPI to access
> the vbios for the nvidia GPU) won't work. This should make it a little
> easier to collect vbioses.
>
> Lyude Paul (2):
>   drm/nouveau: Add strap_peek to debugfs
>   drm/nouveau: Add size to vbios.rom file in debugfs
>
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 46 ++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 5 deletions(-)
>
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

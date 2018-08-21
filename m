Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAF8C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F9120C01
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alexfeinman-com.20150623.gappssmtp.com header.i=@alexfeinman-com.20150623.gappssmtp.com header.b="Mwm9xk9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F9120C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alexfeinman.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeHVDMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 23:12:51 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34900 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHVDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 23:12:51 -0400
Received: by mail-yb0-f179.google.com with SMTP id o17-v6so55199yba.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alexfeinman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZoCTziB1BK4w5K6aOMYwcKsdM5pkb6Gpmm70xX5LjA=;
        b=Mwm9xk9Nh5oXJJwinOCqdhC4/AmayU0cz/GvrWyMCR5cVbR1HN0Fv7TRWB4e9ZPuD2
         5rVe9RDwtxRSsOSYSH88bwiRMzPqlvj1tgxF/H8zNuq/qJflBnt7Ly6MUNgnUH4SQFNT
         CaTVFohBcS6FG/dGRGoXKG+7WTGpW6eh2ZCLf78q2sStsRufUwud9MEGwkk/mVUrJYui
         4gSpYJrd5nCC5/Ssj1Fz7wOeisE61MDLta2Z9IzVZAWtcNaQv0chzoS6P06Q+xHpDJNG
         G3aijKm6T3Vxmncr0uBRWUz1v6/a/w8QKgRj95UmBHrWRkJSETa+QG1gUrCzj1w7zBPp
         lwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZoCTziB1BK4w5K6aOMYwcKsdM5pkb6Gpmm70xX5LjA=;
        b=XwkfekQsXrzy96Nfk5Rr86DjoKQX4JMv73cJz29WvqGXxepk98/zTtXb+KHwyeOBxe
         aP7TnOVcBi985ZBk1z9WD48NhuGxVk+zH68jjSG/GaljrLv13Ukhlck47nLYFtSXAtHa
         YN7Xaqg3WV3isFbdGCyInrjeyt/RMOaqtpBLXeRvTEJ3xr37yZcnVrGcll4sSZ0XJK0d
         ZwsXAlJehNyw3fI0ktjVlItCL4aAo9dLwOOsG2fNdv86PqgrYEP+R+jg4VCRsIvp/Srt
         AXXHHzfMQuPiErO+yW9ymB9rj4tO9JMuJ883xlqJcIrKievhMaQ61nz9+KGiUFRqOJCa
         8BQg==
X-Gm-Message-State: AOUpUlFTmb/vN3GonWJSMv2rwpbsC61Uqw4LKMuqy/o9qVgobVzvZMPL
        MxQbOv3XvvGc68B0A4iaI3W8fETHcuGTfXhau4lCXg==
X-Google-Smtp-Source: AA+uWPy09+f1wIK09Qbgq00fu6LYRSyzZHhTkcoEvZh3/UJsKT6HSSuwno0DeZoSzPlNLFn+2iky2z0yC9MiQ5GyEOc=
X-Received: by 2002:a25:8b:: with SMTP id 133-v6mr16303595yba.11.1534895433629;
 Tue, 21 Aug 2018 16:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXJtFFjVTqYraM0OFipYnNbdLt_BojP5U8WhJETLgw4XWehGQ@mail.gmail.com>
 <20180820215804.67c78e3d@alans-desktop>
In-Reply-To: <20180820215804.67c78e3d@alans-desktop>
From:   Alex Feinman <alex@alexfeinman.com>
Date:   Tue, 21 Aug 2018 16:50:22 -0700
Message-ID: <CAGXJtFG+9N_X_pn1XW02aqxuMKU_icaY55m9q3expxDvdv2TgQ@mail.gmail.com>
Subject: Re: Contiguous DMA buffer view for a custom device (Intel/x86)
To:     gnomes@lxorguk.ukuu.org.uk
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, this sounds like what I need. However, since this is a
custom-purpose system, I am tempted to go with CMA and simply
preallocated 200MB on start

On Mon, Aug 20, 2018 at 1:58 PM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> > b) IOMMU can solve this problem for me by providing a device-specific
> > contiguous view of a fragmented physical memory allocation
> > c) In order to enable IOMMU do the above, I need to allocate DRHDs and
> > DMARs in BIOS initialization (I build my own BIOS)
>
> Yes. The EDK2 firmware toolkit has all the bits you need in it I think.
>
> https://firmware.intel.com/sites/default/files/Intel_WhitePaper_Using_IOMMU_for_DMA_Protection_in_UEFI.pdf
>
> isn't quite on the topic you want but it does explain it fairly well in
> passing.
>
> https://software.intel.com/en-us/blogs/2009/03/02/intels-virtualization-for-directed-io-aka-iommu-part-1
>
> is a bit out of date but may help too.
>
> > Please, let me know if I am on the right track? Of course I realize that
> > implementing SGDMA would be the best option, but short of that and blocking
> > out some physical memory on boot, what are my options?
>
> If performance is absolutely critical simply stealing a chunk of memory
> in the firmware and describing it your device some other way is ugly, but
> for a custom solution I guess anything goes 8)
>
> Alan

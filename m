Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F3ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458A520676
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="0HHQd7tS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458A520676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bofh.nu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeIWTr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:47:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40371 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:47:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id g14-v6so3799023otj.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKAJg5t3pbkKEc1clO1zASicptBCjIlapThmeObdAKs=;
        b=0HHQd7tSH6RLhxan3Y1Umv2nYE0l/hAL1HXnP3QqnO0kqWiEVvsvDsn9r17JVfxsRs
         +yxKQvbWb9w6X+61IVKcRFP71nA07qL246ATcTo6ht8VEA8omhaSQMYAIxWiBKVj6oH0
         8YSkOk95QpwLHI+HIEJfeKRCeJ0KPEJ/35qwdZcpuXVuqGurgR2KA3XEUiRYhwc5Wo6S
         A1Fja8Nm/CcTEcJptGjZv6RnxtveHwb5W1N3wqPxyxT27oLUCh99OaMaGu+cyt5Je/dC
         8lLqdlprZK0fy5NpQSC5Pg2n5E8YB0iIBqGmoyWk6eT4owBvsOZTY2489yjZUrXNWQVh
         qmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKAJg5t3pbkKEc1clO1zASicptBCjIlapThmeObdAKs=;
        b=FEabG86b6CNn166jmxglVnQB8ek6CYAK7cabIzukeLmqu9x/Su//Qocc3IGPeGp3xB
         m8vx3LvfEYhxPDerv1NO4adwXb90VNYOlh47ttk6ZeqSv2JQJ/KnCLmBClEOpNB2bnBa
         /bygf/NVYjViBTxKhVYAm5bw3IKk/n9qDctZptFyqf60ewH2MSyFs8Ky2CQgNijCgNcn
         7yh9zjWa1LtixV2tGpFl6MDdF14FAH0y+hpPejjHrMSLyf/46ZQrDS5oYSXIZrirCJ4D
         3rpBegaS6IRPI/JbwRBmf3A8KzxRjCAgO8HflihEZOcgzU96D8++JlQHTzqFHkjsxszU
         F4vA==
X-Gm-Message-State: ABuFfogl/IVNXylMxIYwm9ihnK/u+2rlL9SHLUj0jdhOBmAFa/VhVJ9U
        EkaUVSSyoPlPuMtCEaudkTmmZ5zR7gl//bqwuRQTSQ==
X-Google-Smtp-Source: ACcGV62IU0eVf4k8s5zAWyLBHwOtPDdtNZgZzaoo2WN+TZ1wFCvBilclLx7zewYTdiVrsbvFhWWpHMyY2pjrkEZK14I=
X-Received: by 2002:a9d:4a14:: with SMTP id h20-v6mr2808332otf.160.1537710593973;
 Sun, 23 Sep 2018 06:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180701160757.138608453@linuxfoundation.org> <20180701160759.928145668@linuxfoundation.org>
 <CADnJP=s+Lu8BiKeM6vsVbHtfYQCPudXHqrA+hKbXOR5FLxTK6g@mail.gmail.com> <2076412.mQRaXglRsh@blindfold>
In-Reply-To: <2076412.mQRaXglRsh@blindfold>
From:   Lars Persson <lists@bofh.nu>
Date:   Sun, 23 Sep 2018 15:49:42 +0200
Message-ID: <CADnJP=sJE6hpG6inp5Yu+5P2F-d0=6GP-2dAXJTmBOb_rPzgvw@mail.gmail.com>
Subject: Re: [PATCH 4.9 069/101] ubi: fastmap: Correctly handle interrupted
 erasures in EBA
To:     richard@nod.at
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martinbayern@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 2:58 PM Richard Weinberger <richard@nod.at> wrote:
>
> Lars,
>
> Am Sonntag, 23. September 2018, 14:49:23 CEST schrieb Lars Persson:
> > On Sun, Jul 1, 2018 at 6:27 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Richard Weinberger <richard@nod.at>
> > >
> > > commit 781932375ffc6411713ee0926ccae8596ed0261c upstream.
> > >
> > > Fastmap cannot track the LEB unmap operation, therefore it can
> > > happen that after an interrupted erasure the mapping still looks
> > > good from Fastmap's point of view, while reading from the PEB will
> > > cause an ECC error and confuses the upper layer.
> > >
> > > Instead of teaching users of UBI how to deal with that, we read back
> > > the VID header and check for errors. If the PEB is empty or shows ECC
> > > errors we fixup the mapping and schedule the PEB for erasure.
> > >
> > > Fixes: dbb7d2a88d2a ("UBI: Add fastmap core")
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: martin bayern <Martinbayern@outlook.com>
> > > Signed-off-by: Richard Weinberger <richard@nod.at>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > >
> > Hi Greg
> >
> > This commit belongs to a series of 3 commits that are intended to be
> > used together. Currently the stable branches have only the first
> > commit from the series and we get a UBI speed regression because an
> > extra NAND page read is always performed for each access to a UBI LEB.
> >
> > 3e5e4335cc0ffd668054564b113fb3c9c97badb8 ubi: fastmap: Detect EBA
> > mismatches on-the-fly
> > 34653fd8c46e771585fce5975e4243f8fd401914 ubi: fastmap: Check each
> > mapping only once
> > 781932375ffc6411713ee0926ccae8596ed0261c ubi: fastmap: Correctly
> > handle interrupted erasures in EBA
> >
> > This will in turn require also this follow-up patch:
> > 25677478474a91fa1b46f19a4a591a9848bca6fb ubi: Initialize Fastmap
> > checkmapping correctly
>
> Wait.
> Commit 34653fd8c46e771585fce5975e4243f8fd401914 was not scheduled for stable
> on purpose.
> It is just an optimization. How much is the performance regression you see?
> Commit 3e5e4335cc0ffd668054564b113fb3c9c97badb8 does not fix anything, all it
> does is adding another paranoia check to UBI.
>
> I'd appreciate if you would come up with regression reports on linux-mtd first
> before asking Greg to pick patches up...
>

Hi Richard

Sorry, I assumed this omission from -stable was a mistake.

The timing for our boot increased from 45 seconds to 55 seconds on one
chip and 42 seconds to 48 seconds on another chip. The regression was
completely fixed by applying the extra patches. The way I see it the
first patch is a significant slow-down so the second patch is required
to restore performance.

- Lars

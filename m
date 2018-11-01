Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24252C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01D02064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ruwHktGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01D02064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeKALiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:38:06 -0400
Received: from casper.infradead.org ([85.118.1.10]:48134 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeKALiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v582I658xJZBYNH0IpcXMvoIysVIBW4QVIrNaZtwU58=; b=ruwHktGjEX4v0t2/+bcfxbCHDr
        TMPGiUy/zfYd3j2cHRCaB6jmNdhDvbdIBZTUMyCnZaEBCtN5igoB/ejD9rImrFFsofrVzSmJKI46M
        5KYSwmk/pJzc8KjOQtcozlUNAJfQLWyaXPYg9M4cfesP1iDuyMzqoAGsR4cU/fxSV07Ugwyfy9ofu
        erQXWEhvUcBK3y5Vt6TZ1cMfVdCKhuk3/PlL2p9SZxKv4f1xEWqrWYM2ZbTD5srb1F98HwMLv7B86
        PPg2YibjFE2uHHPp5nX5139wTOj3bBpPjtAlZkm4MpQWHP7wg0TWtcpmzTrVvVZMFj+ngucpFPV0H
        PzspXJbQ==;
Received: from 177.206.134.103.dynamic.adsl.gvt.net.br ([177.206.134.103] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI2r5-0004Y7-W2; Thu, 01 Nov 2018 02:37:08 +0000
Date:   Wed, 31 Oct 2018 23:37:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL for v4.20-rc1] new experimental media request API
Message-ID: <20181031233702.13a501ea@coco.lan>
In-Reply-To: <CAHk-=wi5wkZtwZQfjVudLtS-Ej9pvaqu6=xM1msoBF8sMuTc_A@mail.gmail.com>
References: <20181030105328.0667ec68@coco.lan>
        <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
        <CAHk-=wi5wkZtwZQfjVudLtS-Ej9pvaqu6=xM1msoBF8sMuTc_A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 31 Oct 2018 15:32:03 -0700
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Wed, Oct 31, 2018 at 11:05 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But pulled,  
> 
> I have no idea how I missed this during the actual test compile after
> the pull (and yes, I'm sure I did one), but after doing a couple of
> more pulls I finally did notice.
> 
> After the media pull I get this warning:
> 
>   ./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64}
> type without #include <linux/types.h>
> 
> and sure enough, the recent changes to
> 
>   include/uapi/linux/v4l2-controls.h
> 
> add those new structures use the "__uXY" types without including the
> header to define them.
> 
> It's harmless in the short term and the kernel build itself obviously
> doesn't care apart from the warning, but please fix it.

I also missed this one. Perhaps it depends on gcc version, or is it
a new warning after some changes? I remember there was some patchsets
floating around related to change some warnings.

Anyway, I'll send you a fix for it soon.

Thanks,
Mauro

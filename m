Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49FC2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ff569I06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49FC2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeKADju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:39:50 -0400
Received: from casper.infradead.org ([85.118.1.10]:46454 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730360AbeKADju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JN6gLWfE8PoDiVm5A/aVBebgG4pjGaMk/vS9QABSoFA=; b=Ff569I06bKgaaYyYa97TtLiv3P
        Zo1SzSZWMxWfWZmL88YoIvMVqA/liQ2zGb6bz+uCxELignejAlEa2ukm1nZCVLu7N2IYrBXQMnpAQ
        wNxucrmfB0aIXEvZaYTCV1/1DqEOsLNotGkOSJynftRs/GBKXwIVY82r4+PMlwQk9QtRpM5Or6qs9
        A7zFwN4K/TCsAE3z+yJRWgR7kDFND5+IzHNrht+0bJP0SocKFxmEU7HRHxWghNXCVqq7+abNKpI2D
        D5Fb7XHZRN0mXiqlYa9OGaoyRTjTmQoc2IwoxQf+6vCDmIjGmaAwaG+GWhtGB4p/i27pAO3/Lpbnv
        LkAaytQQ==;
Received: from 177.206.134.103.dynamic.adsl.gvt.net.br ([177.206.134.103] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHvPu-0006Js-I0; Wed, 31 Oct 2018 18:40:34 +0000
Date:   Wed, 31 Oct 2018 15:40:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL for v4.20-rc1] new experimental media request API
Message-ID: <20181031154030.3fab5a00@coco.lan>
In-Reply-To: <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
References: <20181030105328.0667ec68@coco.lan>
        <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Em Wed, 31 Oct 2018 11:05:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Tue, Oct 30, 2018 at 6:53 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > For a new media API: the request API  
> 
> Ugh. I don't know how much being in staging matters - if people start
> using it, they start using it.
> 
> "Staging" does not mean "regressions don't matter".

Yes, I know.

This shouldn't affect normal cameras and generic V4L2 apps, as this
is for very advanced use cases. So, we hope that people won't start
using it for a while. 

The main interested party on this is Google CromeOS. We're working 
together with them in order to do upstream first. They are well aware
that the API may change. So, I don't expect any complaints from their
side if the API would require further changes.

The point is that this API is complex and ensuring that it will
work properly is not easy. We've been thinking about a solution for
the Camera HAL 2 for a long time (I guess the first discussions were
done back in 2008).

The big problem is that V4L2 API was designed to work with a stream,
while Google HAL API expects to have control for each individual
frame.

The Google API allows, for example that, inside a stream, the
first frame would have a VGA resolution, the next one a 4K resolution
(for example, when the user clicks on a camera button) and then returning
back to VGA (it actually allows full control for every single frame). 

This is something that it is not possible to do with the "standard" 
V4L2 API without stopping and restarting a stream (with increases
a lot the latency).

Solving it is so complex that we decided to start with a completely
new type of Linux media drivers (stateless decoders). In long term, 
the same API should be used by not only by decoders, but also for 
encoders and complex cameras (those with an image signal processor 
inside a SoC chipset).

In order to be sure that it is possible to implement the way we did,
We need to be able to add it to the Kernel somehow and to have
enough drivers that will let us test all possible scenarios.

That will allow to adapt a version of the camera HAL for testing
and see if it behaves as expected.

> But pulled,

Thanks! Anyway, we'll try to rush the tests for this API in order to
try sending any fixes that might be disruptive before the final
release.

Regards,
Mauro

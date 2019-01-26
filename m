Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8363BC282C9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E897217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAZRLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:11:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:36881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfAZRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:11:33 -0500
Received: from ls3530.dellerweb.de ([92.116.161.75]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M936L-1gtFy73bmH-00CTzl; Sat, 26
 Jan 2019 18:11:26 +0100
Date:   Sat, 26 Jan 2019 18:11:24 +0100
From:   Helge Deller <deller@gmx.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: DMA-related cleanups for parisc
Message-ID: <20190126171124.GA8151@ls3530.dellerweb.de>
References: <20190114112353.30616-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114112353.30616-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:YN/j6+6GRIo9i69bFm8eA+HczDTZnFbMlqoV5wrJSvyailEexIl
 FKRfECkHr8fsg9w4YQgF+8Tm0Z0ScM+4me84lhGQ7lct/FpTgZg/sMe0mpZc+ecVGbg+3vw
 lQK61ndxYaO9GkN/VUbBjkuSEGriq2LgZmGSs/cRkgMzzln5u4agbh3qEv9oaZAysW6cBx9
 6vEcV8haESYZOvG/1pYbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VaD54G3Y7vo=:kRQGcG+Ke5Kgi+tCRSNCc1
 bjo5tUVj0ljPViHJyZCGhilkoxdIn3DFdYV9Fk353SU8MdAkWJJCiqZVRw5ucqu2Ib2GEF9eq
 +hxZ8ah1US7S8k+v3GLipo/u/nlX3wpvoB+jibuZfLJROYogKfT6cqGLZp53cxJy06rhu31HR
 svYVaidNJsXbAYOOGFRdHFgV+dRWRQkF++lmGEGczOUX6oZdew60QNyPeY4WJhLeN6FfRUYpc
 jsoNkBPWFqQAJy/jX7RP8HLY7fi7rfgu44BoCZUvsVn3QSROgRXNsheW2JHig/qv/5dl9Dp5t
 ytO0mfACZxhIi1wgd6Q87cNhB+HW5DwtaxGigGlc90zAsnu3nIrx+iEtsUR9U/H+p8qRXrXFW
 qR3a+RhTrTLJl2sRdP30ggww1oIVPxYrMxuG4BM7XsfuY7lNEuxNjVCaPfAdR+P2+oIabA3pb
 Vf+1mu9Wf/Nw9/6Fe2K+kEEGGef5Won5To+vZHXUwaiS+OEt2YOV1xpYXoctgE+oPGb3WQSEh
 YhCasXWUH/GQ1zFdilRhQ1nmGyXv2ZQuBKt8fyju0Fk5q2BRytGdAss5YpCrJ+4xifiZBDdFu
 kJA5dpdKAJ2sNuhjkix4dRy/zYBGSTZolewesuAB0Nq2RFHYOoYBsS1VYBrSSXPQa1nx9+wxO
 B2vWHZfHcvR995Dc1e5o0AiwTE7sbBHwiITbgl9Et+E+i6J6xv/yN2MN7wjProBMzTDQMgF03
 aWgkZOppgfh8q3gOrwK4Vq/EJg8s86Bdac6Rt7xytKmRNG1Hz6JukBnK+5MqKEMVWrErzbVJt
 qeCHC/+Ld+OtOSG/spMd2fepskWrkgsqHlnhyL2gPlccyajZPtjc8JY4NFMYbZ/dwgk+2TIwB
 fvqrCgEuzAVo0Q7HH8cWOde0n+hJ6jq4xdkVIXnVFT9Dkp2vX8XI3KhjJz4kug
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig <hch@lst.de>:
> Hi James and Helge,

Hi Christoph, 

> this series has a couple DMA-related cleanups for parisc.  The main aim
> is to move anything not required by drivers out of <asm/dma-mapping.h>,
> but I noticed a few related bits and cleaned them up as well.

Thanks for doing that!
I tested it. Your patches work, but you need the fixup below (0-day
testing complained as well).

With the one below, you may add
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge


diff --git a/drivers/parisc/hppb.c b/drivers/parisc/hppb.c
index 3b3481c..65a8148 100644
--- a/drivers/parisc/hppb.c
+++ b/drivers/parisc/hppb.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 
 #include <asm/io.h>
+#include <asm/pci.h>
 #include <asm/hardware.h>
 #include <asm/parisc-device.h>
 

Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA29C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7670525177
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7670525177
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeGBV6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:58:07 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:45851 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753131AbeGBV6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:58:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AD4A0182CED34;
        Mon,  2 Jul 2018 21:58:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rat62_63529679bfe5a
X-Filterd-Recvd-Size: 2638
Received: from XPS-9350 (unknown [172.58.94.179])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Jul 2018 21:58:02 +0000 (UTC)
Message-ID: <578ce3d69b43c580d5e810741364b4d86174c3f0.camel@perches.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: add subfolders for nuvoton *npcm*
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>, avi.fishman@nuvoton.com
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        avifishman70@gmail.com, tmaimon77@gmail.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Date:   Mon, 02 Jul 2018 14:58:00 -0700
In-Reply-To: <20180702144514.18b45671a29cf5250aacb153@linux-foundation.org>
References: <20180701093028.10174-1-avi.fishman@nuvoton.com>
         <20180701093028.10174-2-avi.fishman@nuvoton.com>
         <20180702144514.18b45671a29cf5250aacb153@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 14:45 -0700, Andrew Morton wrote:
> On Sun,  1 Jul 2018 12:30:28 +0300 avi.fishman@nuvoton.com wrote:
> 
> > From: Avi Fishman <AviFishman70@gmail.com>
> > 
> > Add several subfolders to look for *npcm* files under
> > ARM/NUVOTON NPCM ARCHITECTURE
> > 
> > Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e0ce3c5f32e5..23c450adad44 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1727,7 +1727,10 @@ F:	arch/arm/mach-npcm/
> >  F:	arch/arm/boot/dts/nuvoton-npcm*
> >  F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> >  F:	drivers/*/*npcm*
> > +F:	drivers/*/*/*npcm*
> >  F:	Documentation/*/*npcm*
> > +F:	Documentation/*/*/*npcm*
> > +F:	Documentation/*/*/*/*npcm*
> 
> The Docuemntation/ pathnames have changed.  Please refresh to the
> current Linus tree.

$ git ls-files Documentation | grep npcm
Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
Documentation/devicetree/bindings/arm/npcm/npcm.txt
Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt

So maybe:

F:	Documentation/devicetree/bindings/*/*npcm*
F:	Documentation/devicetree/bindings/*/*/*npcm*


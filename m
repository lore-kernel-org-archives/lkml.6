Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C15C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58C9206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58C9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeLBMIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 07:08:04 -0500
Received: from shell.v3.sk ([90.176.6.54]:60823 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbeLBMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 07:08:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D067CC7E48;
        Sun,  2 Dec 2018 13:07:59 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AIXGf2VCgmwL; Sun,  2 Dec 2018 13:07:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D65DBC7E49;
        Sun,  2 Dec 2018 13:07:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8BKPUDjRjWDg; Sun,  2 Dec 2018 13:07:56 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D74E7C7E48;
        Sun,  2 Dec 2018 13:07:55 +0100 (CET)
Message-ID: <dc775f9fd360ecbd3e4c00c02c9ff6e655502d0a.camel@v3.sk>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     arm-soc <arm@kernel.org>, Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, quozl@laptop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 02 Dec 2018 13:07:54 +0100
In-Reply-To: <20181130234424.vx5y46wqvziywbk2@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
         <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
         <20181130234424.vx5y46wqvziywbk2@localhost>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 15:44 -0800, Olof Johansson wrote:
> Hi,
> 
> On Wed, Nov 28, 2018 at 10:39:06PM +0100, Arnd Bergmann wrote:
> > On Wed, Nov 28, 2018 at 6:53 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > Hi,
> > > 
> > > this series contains contains a bunch of MMP2 platform fixes.
> > > 
> > > Previous spins of the patch set were sent out over the course of last
> > > three months to the MMP platform maintainers, with Arnd and
> > > linux-arm-kernel@lists.infradead.org on copy.
> > > 
> > > Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> > > seem to respond anymore. That's a shame, because the MMP2 support seems to
> > > in need for some love. The DT/multiplatform kernels can't even boot without
> > > 14/20, 15/20 and perhaps more.
> > > 
> > > I'm wondering if this cat gen in via the arm-soc tree? Would it be
> > > appropriate if I followed up with a MAINTAINERS update in that case?
> > 
> > Yes, sounds good to me. I looked through the series again, and
> > found one patch that seems wrong to me. Everything else should
> > just go in.
> 
> I've applied the DT patches and the ones that touch only arch/arm/mach-*.
> There are a few driver patches here that should be reviewed/acked by the
> corresponding maintainers as well, so I didn't apply most of them yet.

Thank you.

> > > The patch set has been tested on an OLPC XO-1.75 laptop.
> > 
> > Excellent!
> 
> OOooh, I have one of those... somewhere.

I'm working on adjusting the machine's OFW to provide a devicetree that
matches what mainline Linux expects. I'll follow up with a boot script
in a few days -- once it's good enough to be actually useful.

There also seems to be a good chance that we'll get an updated firmware
image at some point.

Until then, CONFIG_ARM_APPENDED_DTB can be used, though a zImage header
needs to be modified to account for the DTB at the end:

https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75

> -Olof

Lubo


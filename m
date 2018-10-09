Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D9EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C6321479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C6321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJIWI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:08:29 -0400
Received: from shell.v3.sk ([90.176.6.54]:48851 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeJIWI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:08:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5764EBCDC3;
        Tue,  9 Oct 2018 16:51:08 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Wh1kxoSUvfw6; Tue,  9 Oct 2018 16:51:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D9F1ABCDC2;
        Tue,  9 Oct 2018 16:51:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j6RmDb8zX_Ab; Tue,  9 Oct 2018 16:51:04 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E600EBCDC0;
        Tue,  9 Oct 2018 16:51:03 +0200 (CEST)
Message-ID: <f54219e7b164a8eb259e956f312a090b67fd8fd8.camel@v3.sk>
Subject: Re: [PATCH 01/14] phy: phy-pxa-usb: add a new driver
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Date:   Tue, 09 Oct 2018 16:51:03 +0200
In-Reply-To: <20181008132148.GC20703@kroah.com>
References: <20180822204307.13251-1-lkundrak@v3.sk>
         <20180822204307.13251-2-lkundrak@v3.sk>
         <f36abb62-e8a4-e69f-4732-95a0db466034@ti.com>
         <1981ce54ce960d21976ce71b08a8779bfeb13be4.camel@v3.sk>
         <20181008132148.GC20703@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 15:21 +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 07, 2018 at 08:47:28PM +0200, Lubomir Rintel wrote:
> > On Tue, 2018-09-25 at 10:53 +0530, Kishon Vijay Abraham I wrote:
> > > On Thursday 23 August 2018 02:12 AM, Lubomir Rintel wrote:
> > > > Turned from arch/arm/mach-mmp/devices.c into a proper PHY driver,
> > > > so
> > > > that in can be instantiated from a DT.
> > > > 
> > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > 
> > > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > 
> > > If this has to be merged via linux-phy tree, please let me know.
> > 
> > Yes, either linux-phy or the usb tree.
> > 
> > The EHCI patches have already been pulled into the usb tree, presumably
> > because they got an Ack from Alan Stern. That includes "USB: EHCI:
> > ehci-mv: use phy-pxa-usb" that depends on this. Perhaps the  rest of
> > the patches can go via the same tree?
> > 
> > I haven't submitted a patchset that would have dependencies spanning
> > across different subsystems before. I don't know what's usually done in
> > such cases. Advice welcome.
> > 
> > Greg?
> 
> You can either send them through the same tree, or wait a release cycle
> and get the rest in through a different one.  As I usually take the phy
> tree into the USB tree for issues like this, I can take them all if you
> get the phy maintainer to ack them.

I believe that would be Kishton, who acked this one (see above). Please
add it ("PATCH 01/14] phy: phy-pxa-usb: add a new driver") to the usb
tree than.

The rest is DT bindings and MMP2 platform changes (DT, board files and
removal of dead code) which are not strictly dependent on this and
don't need to go through phy or usb trees. I still need to get someone
to review them.

Thank you
Lubo

> 
> thanks,
> 
> greg k-h


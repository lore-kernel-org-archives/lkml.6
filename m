Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B51C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE241208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE241208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeH0Me3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:34:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32990 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0Me3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:34:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8439C20787; Mon, 27 Aug 2018 10:48:45 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2A22C203EC;
        Mon, 27 Aug 2018 10:48:45 +0200 (CEST)
Date:   Mon, 27 Aug 2018 10:48:42 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>
Subject: Re: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
Message-ID: <20180827104842.26bce912@bbrezillon>
In-Reply-To: <20180827084414.GZ14967@localhost>
References: <20180827082153.22537-1-johan@kernel.org>
        <20180827082153.22537-6-johan@kernel.org>
        <20180827102820.3abf7291@bbrezillon>
        <20180827084414.GZ14967@localhost>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 10:44:14 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Mon, Aug 27, 2018 at 10:28:20AM +0200, Boris Brezillon wrote:
> > Hi Johan
> > 
> > On Mon, 27 Aug 2018 10:21:49 +0200
> > Johan Hovold <johan@kernel.org> wrote:
> >   
> > > Use the new of_get_compatible_child() helper to lookup the nfc child
> > > node instead of using of_find_compatible_node(), which searches the
> > > entire tree from a given start node and thus can return an unrelated
> > > (i.e. non-child) node.
> > > 
> > > This also addresses a potential use-after-free (e.g. after probe
> > > deferral) as the tree-wide helper drops a reference to its first
> > > argument (i.e. the node of the device being probed).
> > > 
> > > While at it, also fix a related nfc-node reference leak.
> > > 
> > > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > > Cc: stable <stable@vger.kernel.org>     # 4.11
> > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > Cc: Josh Wu <rainyfeeling@outlook.com>
> > > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>  
> > 
> > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> Thanks for the ack.
> 
> > I'll let Miquel queue this patch to the nand/next branch, unless you
> > want it to be merged in 4.19, in which case I'll queue it to the
> > mtd/fixes branch.  
> 
> Note that there's a dependency on the first patch of the series which
> adds the new helper.

I was not Cc-ed on this patch :P.

> Rob can pick up the entire series if the various
> maintainers agree, otherwise I'll try to get at the least the helper
> into -rc2.

If everything goes in 4.19-rc2 through Rob's tree that's fine, but if
it's queued for 4.20 we might need an immutable tag just in case we
queue conflicting changes to the NAND tree.

Thanks,

Boris

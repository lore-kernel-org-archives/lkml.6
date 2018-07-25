Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9356C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709CD20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709CD20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbeGYOhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:37:47 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:40310 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbeGYOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:37:47 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992289AbeGYN0EdPWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 2 others);
        Wed, 25 Jul 2018 15:26:04 +0200
Date:   Wed, 25 Jul 2018 15:26:03 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Marek Belisko <marek@goldelico.com>,
        =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH 09/32] ARM: dts: omap3-gta04: make NAND partitions
 compatible with recent U-Boot
Message-ID: <20180725132603.GA21902@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com>
 <20180725080735.GA7467@lenoch>
 <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
 <20180725083305.GB8303@lenoch>
 <85BC9F70-2E58-4915-9405-7CC1855975C4@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85BC9F70-2E58-4915-9405-7CC1855975C4@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 02:27:31PM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 25.07.2018 um 10:33 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > 
> > On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
> >> 
> >>> Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
> >>> 
> >>> On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:
> >>>> Vendor defined U-Boot has changed the partition scheme a while ago:
> >>>> 
> >>>> * kernel partition 6MB
> >>>> * file system partition uses the remainder up to end of the NAND
> >>>> * increased size of the environment partition (to get an OneNAND compatible base address)
> >>>> * shrink the U-Boot partition
> >>>> 
> >>>> Let's be compatible (e.g. Debian kernel built from upstream).
> >>> 
> >>> That, in fact, is breaking compatibility.
> >> 
> >> With what? Nobody is using the old u-boot partition scheme any more
> >> (it is >5 years old).
> >> 
> >>> So once you are touching this
> >>> what about relying on partitioning provided by bootloader just to prevent
> >>> something like this happening again?
> >> 
> >> Well, we define what compatible means here (since we are the vendor).
> >> And people complain with us. We simply recommend them to upgrade the
> >> boot-loader.
> > 
> > Fair enough. Suggestion was to remove partitioning scheme from DTB alltogether
> > and let U-Boot provide one. But you being vendor you decide, of course :)
> > (I'd use only two partitions: MLO and UBI, latter one with BCH8, and store
> > everything in UBI volumes. That's a bit more flexible approach)
> 
> Yes, that is a good goal for a future setup and would of course be better.
> Like U-Boot already provides the memory layout for RAM.
> 
> Hopefully, someone will work out patches for u-boot plus kernel (which is always
> painful to keep these two in sync and tested). But I don't want to do that now.

At kernel side the only patch needed is to remove partitioning scheme from DTB
and u-boot setup can be merely copied from board/isee/igep00x0
Not having hardware I cannot really test it ;-)

Best regards,
	ladis

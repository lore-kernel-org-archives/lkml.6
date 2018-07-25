Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F03C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F5320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F5320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeGYVUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:20:39 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:46908 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbeGYVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:20:39 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992289AbeGYUHXGkuy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Wed, 25 Jul 2018 22:07:23 +0200
Date:   Wed, 25 Jul 2018 22:07:19 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org
Subject: Re: [Letux-kernel] [PATCH 09/32] ARM: dts: omap3-gta04: make NAND
 partitions compatible with recent U-Boot
Message-ID: <20180725200719.GA28936@lenoch>
References: <cover.1532501910.git.hns@goldelico.com>
 <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com>
 <20180725080735.GA7467@lenoch>
 <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
 <20180725083305.GB8303@lenoch>
 <20180725182745.6e436abc@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725182745.6e436abc@aktux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 06:27:45PM +0200, Andreas Kemnade wrote:
> On Wed, 25 Jul 2018 10:33:05 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
> > >   
> > > > Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > > > 
> > > > On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:  
> > > >> Vendor defined U-Boot has changed the partition scheme a while ago:
> > > >> 
> > > >> * kernel partition 6MB
> > > >> * file system partition uses the remainder up to end of the NAND
> > > >> * increased size of the environment partition (to get an OneNAND compatible base address)
> > > >> * shrink the U-Boot partition
> > > >> 
> > > >> Let's be compatible (e.g. Debian kernel built from upstream).  
> > > > 
> > > > That, in fact, is breaking compatibility.  
> > > 
> > > With what? Nobody is using the old u-boot partition scheme any more
> > > (it is >5 years old).
> > >   
> > > > So once you are touching this
> > > > what about relying on partitioning provided by bootloader just to prevent
> > > > something like this happening again?  
> > > 
> > > Well, we define what compatible means here (since we are the vendor).
> > > And people complain with us. We simply recommend them to upgrade the
> > > boot-loader.  
> > 
> > Fair enough. Suggestion was to remove partitioning scheme from DTB alltogether
> > and let U-Boot provide one. But you being vendor you decide, of course :)
> > (I'd use only two partitions: MLO and UBI, latter one with BCH8, and store
> > everything in UBI volumes. That's a bit more flexible approach)
> > 
> hmm, so using mtdparts kernel commandline parameter? Somehow it sounds
> to be sane to not have partition tables in kernel. What only is needed
> is to have a nice transition scheme for systems in the wild, can
> commandline mtdparts overwrite dtb? So dtb is a fallback?

That's beginning to be offtopic here...  Anyway, see U-Boot's
CONFIG_FDT_FIXUP_PARTITIONS. Probably better to start a thread on
U-Boot mailing list if needed.

> But I think all that is a future improvement?

Depends on vendor decision, it could be done in a few days :)

Best regards,
	ladis

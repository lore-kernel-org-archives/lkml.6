Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5D3C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E12D21582
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8QiJ04+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E12D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJUAh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeJUAh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:37:27 -0400
Received: from localhost (unknown [109.144.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755E72157C;
        Sat, 20 Oct 2018 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540052787;
        bh=+9lQvA3kKmPLDcwdgOmvwuz3IurevflUfdpChJlC9wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8QiJ04+6a1rKaU5EwM5/iw+FEfcUUCpfW9hxWb9tawCUvG8tdDGUpaPY48Rz42lb
         s129Fbr6qF7WW2bIF9zbRxJlXknXWyt5O4M7mDCKF1dgDw5kETA5efmdfAYCkdHHR4
         1ezLdYPsqUhy0bwgnlCgkXf0eb2kAfat2pqMI8vQ=
Date:   Sat, 20 Oct 2018 21:56:24 +0530
From:   Vinod <vkoul@kernel.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: Re: [[PATCH] 8/9] DMA-UART-Driver-for-AST2500
Message-ID: <20181020162624.GC2894@vkoul-mobl>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <1539749466-3912-9-git-send-email-open.sudheer@gmail.com>
 <20181017060531.GU2400@vkoul-mobl>
 <351eecd5b1b21893e94f76b34c058c6257b7f837.camel@kernel.crashing.org>
 <20181018095507.GC2400@vkoul-mobl>
 <a3fecf7913d6a85a6294afbc5a1a18b7714d6756.camel@kernel.crashing.org>
 <20181019071154.GE13642@Pilot130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019071154.GE13642@Pilot130>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-18, 12:41, sudheer.v wrote:
> On Fri, Oct 19, 2018 at 10:32:24AM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-10-18 at 15:25 +0530, Vinod wrote:
> > > 
> > > > It's not a dmaengine driver. It's a serial UART driver that happens to
> > > > use a dedicated DMA engine.
> > > 
> > > Then I see no reason for it to use dmaengine APIs. The framework allows
> > > people to share a controller for many clients, but if you have dedicated
> > > one then you may use it directly
> > 
> > Well... the engine is shared by a few UARTs, they have dedicated rings
> > but there's a common set of regs for interrupt handling etc.
> > 
> > That said, I still think it could be contained within a UART driver,
> > there's little benefit in adding the framework overhead, esp since
> > these are really weak cores, any overhead will be felt.
> > 
> > Ben.
> > 
> > > > It's unclear whether it should be split into two drivers, or just have
> > > > the serial driver directly use the dma engine since that engine is
> > > > dedicated in HW to only work on those UARTs and nothing else...
> > > > 
> > > > Cheers,
> > > > Ben.
> 
> Initially we wanted to have  a single driver,
> however we had an informal discussion with one of the maintainer 
> and based on the feedback, followed the Linux DMA and UART architecture.
> 
> If this seperate DMA-engine driver adds more overhead than benifit,
> we will merge them into a single UART driver and resubmitt the patches.
> Vinod,
>       can this dma-controller driver sit under dma subsystem?.
>       or better to move it under UART framework.


My advise would be to see what you can do with the DMA IP block. If this
can/would be used in different places then it would make sense to do a
dmaengine driver and solve the problem for everyone.

If this is always going to be hidden behind serial then maybe it makes
sense to be inside serial driver and not use dmaengine APIs

If you decide to prefer the former case, please move it to dmaengine and
resubmit :)

HTH
-- 
~Vinod

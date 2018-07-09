Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D33C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CAA2089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CAA2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbeGIMDW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:03:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeGIMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:03:21 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D48F7B78;
        Mon,  9 Jul 2018 12:03:20 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:03:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
Message-ID: <20180709120317.GC5196@kroah.com>
References: <20180704093449.vryluk7khaudstgp@kili.mountain>
 <20180707153255.GA29925@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D968DBA@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D968DBA@hasmsx108.ger.corp.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:36:21AM +0000, Winkler, Tomas wrote:
> > 
> > On Wed, Jul 04, 2018 at 12:34:49PM +0300, Dan Carpenter wrote:
> > > We accidentally removed the check for negative returns without
> > > considering the issue of type promotion.  The "if_version_length"
> > > variable is type size_t so if __mei_cl_recv() returns a negative then
> > > "bytes_recv" is type promoted to a high positive value and treated as
> > > success.
> > >
> > > Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC
> > > fixup")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > Didn't apply to my tree at all :(
> 
> I will rework this, anyhow I would prefer if you can wait for my signoff before applying, 
> I believe we are reasonably responsive. 

Yes you are, but for trusted developers, it's fine to merge their stuff
as well.  Remember, maintainers are not "gatekeepers" :)

thanks,

greg k-h

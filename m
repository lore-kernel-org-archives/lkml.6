Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2428C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D34F2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D34F2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbeG0KXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:23:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeG0KXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:23:46 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E77684B;
        Fri, 27 Jul 2018 09:02:50 +0000 (UTC)
Date:   Fri, 27 Jul 2018 11:02:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [GIT PULL] FSI updates round 4 (last) for 4.19
Message-ID: <20180727090247.GC17942@kroah.com>
References: <81553544b2004efd42f256147d0d9f45df01df25.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81553544b2004efd42f256147d0d9f45df01df25.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:10:57AM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> This adds a few fixes for things reported since the last merge,
> and the latch batch of changes pending for FSI for 4.19.
> 
> That batch is a rather mechanical conversion of the misc devices
> into proper char devices.
> 
> The misc devices were ill suited, the minor space for them is
> limited and we can have a lot of chips in a system creating FSI
> devices.
> 
> This also allows us to better control (and fix) object lifetime
> getting rid of the bad devm_kzalloc() of the structures containing
> the devices etc...
> 
> Finally, we add a chardev to the core FSI that provides raw CFAM
> access to FSI slaves as a replacement for the current "raw" binary
> sysfs file which will be ultimately deprecated and removed.
> 
> Thanks !
> Ben.
> 
> The following changes since commit 0a213777d1dd879092225a7aa847b6e9b3a1c267:
> 
>   fsi: Add support for device-tree provided chip IDs (2018-07-23 16:27:32 +1000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-07-27

Pulled in and pushed out, thanks.

greg k-h

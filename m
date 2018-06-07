Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CrhvFZ/2GFsbRwAAmS7hNA
	; Thu, 07 Jun 2018 09:14:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A260607F7; Thu,  7 Jun 2018 09:14:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="STjeTFBB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6385607DC;
	Thu,  7 Jun 2018 09:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6385607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeFGJOU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbeFGJOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:14:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB3672087F;
        Thu,  7 Jun 2018 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528362857;
        bh=+gq/XdxrLa0zt2rREwYIblERQcfZo/Bo7cETNwyvQlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STjeTFBBrdfZEOZANanKs369ixJ0RDsPVV3+ztZIaXpTe2fypwY7uWTqQbW4LJs4V
         hoesluInbivq6BT0Y7n9c2aMziItBJ19ixN+nbTDQjx4CD0dje7DabqQAbHb6OUf0V
         NKuFaOCL6jPK5mjKtpDn0P2KSwBpEm224EbQ33UE=
Date: Thu, 7 Jun 2018 11:13:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Kim Phillips <kim.phillips@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
Message-ID: <20180607091353.GA20438@kroah.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
 <20180607083401.GE16651@kroah.com>
 <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:04:33AM +0100, Suzuki K Poulose wrote:
> Hi Greg,
> 
> On 06/07/2018 09:34 AM, Greg Kroah-Hartman wrote:
> > On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
> > > On Wed, 6 Jun 2018 10:46:36 +0100
> > > Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > > 
> > > > On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
> > > > > On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
> > > > > > Increment the refcnt for driver modules in current use by calling
> > > > > > module_get in coresight_build_path and module_put in release_path.
> > > > > > 
> > > > > > This prevents driver modules from being unloaded when they are in use,
> > > > > > either in sysfs or perf mode.
> > > > > 
> > > > > Why does it matter?  Shouldn't you be allowed to remove any module at
> > > > > any point in time, much like a networking driver?
> 
> The user doesn't have an explicit refcount on the individual components
> in a trace session. So, when a trace session is in progress, it is as
> good as having a "file" open on each component that is part of the
> active trace session. So, we don't want the driver to be removed when
> the component is being used in the trace collection.

Why not?  What's wrong with that happening and then the trace collection
starts failing with -ENODEV or something?

Remember, removing a kernel module is something that only happens very
rarely, and is an explicit choice by someone with root permissions.  If
you want to remove that module, it should be able to go, as you know
what you are doing at that point in time.

Don't try to "protect the user from themselves" here, they want to shoot
their foot, make it hurt if they are aiming it there :)

> This will be
> released as soon as the session is ended. It is just like a PMU driver
> where the module refcount is held to ensure the module stays until the
> session is over. In this case, we have multiple components, each with
> its own driver invisible to the PMU driver. Hence the coresight driver
> must hold the reference.

Again, please think this through and don't add extra complexity to the
normal path, and get it right if you do it (the existing patch is not
right as I pointed out.)  Personally, I feel the code should just be
able to be unloaded whenever they want, user beware...

thanks,

greg k-h

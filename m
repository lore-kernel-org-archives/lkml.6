Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9286B2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548261802;
	bh=98pFJQTh12NEcRLdIk+cctLbJ0lwG4xknUep+F6JcLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pb+1X/+QO1k88su0UD3NvCjjoTirFs63VQo5FUESBFdKrcj+Qoee8VuER13nvF9WB
	 HO5lqXAdbrsDrL6eP7fCv6DVdh03vZ5N7Tl/w1x60cB89VOV3cT4de71DgFVKxzg7N
	 NcM1GE7AWjkb8mKZ9yxZPxuQH5A1QufCUuTcWn30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAWQnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAWQnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:43:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 935F32085A;
        Wed, 23 Jan 2019 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548261800;
        bh=98pFJQTh12NEcRLdIk+cctLbJ0lwG4xknUep+F6JcLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuMVNilTbZjBubpFThrlDSzqmOlo2i0qfTBAmAwfwsri/wDRcqAbI/O3SbdqmyZIi
         +t7WRb4IEqJfRQAktdRm3xmE7RxPykmI8Hxv0IcPkCq8TW29l7Va2PxlcH/fBpu8Y1
         1mbMWlJqcdc52/1X131dA4aDeN9dF7jH4rfOd9VY=
Date:   Wed, 23 Jan 2019 17:43:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Richard Gong <richard.gong@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        todd.riffel@intel.com, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] firmware: intel_stratix10_service: add hardware
 dependency
Message-ID: <20190123164317.GA16162@kroah.com>
References: <1548258476-16821-1-git-send-email-richard.gong@linux.intel.com>
 <20190123160019.GB4764@kroah.com>
 <CANk1AXR2K5j6iU1y8GGn_8agOUY6ca8xKXPrFGT5Ht6_La7VrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXR2K5j6iU1y8GGn_8agOUY6ca8xKXPrFGT5Ht6_La7VrA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 10:37:07AM -0600, Alan Tull wrote:
> On Wed, Jan 23, 2019 at 10:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> Hi Greg,
> 
> >
> > On Wed, Jan 23, 2019 at 09:47:56AM -0600, richard.gong@linux.intel.com wrote:
> > > From: Richard Gong <richard.gong@intel.com>
> > >
> > > Add a Kconfig dependency to ensure Intel Stratix10 service layer driver
> > > can be built only on the platform that supports it.
> > >
> > > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > > ---
> > >  drivers/firmware/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > > index f754578..cac16c4 100644
> > > --- a/drivers/firmware/Kconfig
> > > +++ b/drivers/firmware/Kconfig
> > > @@ -218,7 +218,7 @@ config FW_CFG_SYSFS_CMDLINE
> > >
> > >  config INTEL_STRATIX10_SERVICE
> > >       tristate "Intel Stratix10 Service Layer"
> > > -     depends on HAVE_ARM_SMCCC
> > > +     depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
> >
> > That's lame, what about building for testing?
> 
> Do you mean this instead?
> 
> depends on (ARCH_STRATIX10 && HAVE_ARM_SMCCC) || COMPILE_TEST

Yes, that would be better, right?

> >
> > And is this needed now, for 5.0-final, or can it wait for 5.1?
> 
> This change will reduce kernel size for most arm64.  It can go into
> whichever kernel.  We can resubmit allowing for COMPILE_TEST.

So it's not fixing a bug, but rather just allowing you to shrink an
image?  If so, then 5.1 is good.

Please resubmit, after making sure it doesn't break the normal builds :)

thanks,

greg k-h

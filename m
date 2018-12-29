Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFDFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4120220857
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546087766;
	bh=K5tHIdGxD5w9c0Sx/kxQmPHSmItASLtP1uBdx5nzfRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JakioBhHmQipIvCL9yiRLIChnPjNah8hpKvm8f4+IYJfPp75Bk/1bxr7QudTN5wy8
	 1vSKBiQ+CwJmyelIQfL9Rckh2+fGKukKxmI/1pyvGNh82OX28zhas6Jyv9EXcuf9hL
	 wb7DfIObmN2FPaqAOGN9/1Pjb5V6PetyfQYesauE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeL2MtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeL2MtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:49:25 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 879D42081B;
        Sat, 29 Dec 2018 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546087764;
        bh=K5tHIdGxD5w9c0Sx/kxQmPHSmItASLtP1uBdx5nzfRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjvzESE6CL4QcJGlKulO0+63qOHs9wGcaff+WFcOpeMkSruNjBj6TPBtkM2U5/M3M
         WB49wDfnQnoSKEqpbyHyYgnahPAGieK+omVP3SjA4jM4TRLIZgGhuza0v9tt8tRXwC
         vUY3GpktIKxQnSGIx4mtUS4cl85otqKYuFhm0Hh4=
Date:   Sat, 29 Dec 2018 13:49:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: devio: update max count of DPs per interval for ISOC
Message-ID: <20181229124921.GA5959@kroah.com>
References: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
 <20181228105148.GA22073@kroah.com>
 <1546051720.32173.139.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546051720.32173.139.camel@mhfsdcap03>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 10:48:40AM +0800, Chunfeng Yun wrote:
> Hi,
> On Fri, 2018-12-28 at 11:51 +0100, Greg Kroah-Hartman wrote:
> > On Fri, Dec 28, 2018 at 06:27:44PM +0800, Chunfeng Yun wrote:
> > > The host shall be able to accept and send up to 96 DPs for
> > > devices operating at Gen 2 speed.
> > 
> > Why?  What is this keeping from working properly today?
> 
> The failure happened when I tried to send up to 96DPs per an interval
> for SSP ISOC transations by libusb, this is used to verify SSP ISOC
> function of USB3 GEN2 controller. Maybe for normal scenarios they
> needn't transfer greater than 48 DPs in an ISOC interval.
> (refer usb3.1r1.0 section 8.12.6 Isochronous Transactions)

Ok, please add this information in the changelog text please.

> > 
> > I need a much better changelog text here in order to be able to accept
> > this patch.
> I'll make the change in next version
> > 
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > >  drivers/usb/core/devio.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > > index a75bc0b8a50f..82c16210e34c 100644
> > > --- a/drivers/usb/core/devio.c
> > > +++ b/drivers/usb/core/devio.c
> > > @@ -1564,12 +1564,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
> > >  		}
> > >  		for (totlen = u = 0; u < number_of_packets; u++) {
> > >  			/*
> > > -			 * arbitrary limit need for USB 3.0
> > > -			 * bMaxBurst (0~15 allowed, 1~16 packets)
> > > -			 * bmAttributes (bit 1:0, mult 0~2, 1~3 packets)
> > > -			 * sizemax: 1024 * 16 * 3 = 49152
> > > +			 * arbitrary limit need for USB 3.1 Gen2
> > > +			 * sizemax: 96 DPs at SSP, 96 * 1024 = 98304
> > >  			 */
> > > -			if (isopkt[u].length > 49152) {
> > > +			if (isopkt[u].length > 98304) {
> > 
> > Are we going to have to keep bumping this up as speeds get faster and
> > faster?
> Or remove the check of data length? I'm not sure which way is better

No, we added that check for a good reason, please see the git log for
the details :)

thanks,

greg k-h

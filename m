Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006D4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19A32098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NTVJMVqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19A32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJRUrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:47:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55400 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJRUrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:47:11 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9ICkEtm061349;
        Thu, 18 Oct 2018 07:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539866774;
        bh=0dRb7QaflCU71CDf5NND2FQDGjc5rSTNk3z1oh2tLTY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NTVJMVqDbs5AxZuf86oZ67di/gxy51Ck9KYM/XKsm+9xeBWiKG+irCeqwl6XcRShm
         8qX6tJ1nZRCdn/WWePZv893fzvLgeuU7CMWAdvSLf9YyMBuNlKwNDFjCrCLGEeHVqH
         sdh+ojnR57ehTgz/RHSkDQHApTIecozA9tMzv++0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9ICkEBj026082;
        Thu, 18 Oct 2018 07:46:14 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 18
 Oct 2018 07:46:14 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 18 Oct 2018 07:46:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9ICkEbK005709;
        Thu, 18 Oct 2018 07:46:14 -0500
Date:   Thu, 18 Oct 2018 07:46:14 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Paul Elder <paul.elder@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <stern@rowland.harvard.edu>, <rogerq@ti.com>
Subject: Re: [PATCH 4/6] usb: gadget: add functions to signal udc driver to
 delay status stage
Message-ID: <20181018124614.GE8763@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu, rogerq@ti.com
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
 <20181010024903.1633-5-paul.elder@ideasonboard.com>
 <20181011161021.GB8763@uda0271908>
 <3055233.Lvy0NcWSZ5@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3055233.Lvy0NcWSZ5@avalon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent,

On Thu, Oct 18, 2018 at 02:45:32AM +0300, Laurent Pinchart wrote:
> Hi Bin,
> 
> On Thursday, 11 October 2018 19:10:21 EEST Bin Liu wrote:
> > On Tue, Oct 09, 2018 at 10:49:01PM -0400, Paul Elder wrote:
> > > A usb gadget function driver may or may not want to delay the status
> > > stage of a control OUT request. An instance it might want to is to
> > > asynchronously validate the data of a class-specific request.
> > > 
> > > Add a function usb_ep_delay_status to allow function drivers to choose
> > > to delay the status stage in the request completion handler. The UDC
> > > should then check the usb_ep->delayed_status flag and act accordingly to
> > > delay the status stage.
> > > 
> > > Also add a function usb_ep_send_response as a wrapper for
> > > usb_ep->ops->send_response, whose prototype is added as well. This
> > > function should be called by function drivers to tell the UDC what to
> > > reply in the status stage that it has requested to be delayed.
> > > 
> > > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/usb/gadget/udc/core.c | 35 +++++++++++++++++++++++++++++++++++
> > >  include/linux/usb/gadget.h    | 11 +++++++++++
> > >  2 files changed, 46 insertions(+)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > > index af88b48c1cea..1ec5ce6b43cd 100644
> > > --- a/drivers/usb/gadget/udc/core.c
> > > +++ b/drivers/usb/gadget/udc/core.c
> > > @@ -443,6 +443,41 @@ void usb_ep_fifo_flush(struct usb_ep *ep)
> > >  }
> > >  EXPORT_SYMBOL_GPL(usb_ep_fifo_flush);
> > > 
> > > +/**
> > > + * usb_ep_ep_delay_status - set delay_status flag
> > > + * @ep: the endpoint whose delay_status flag is being set
> > > + *
> > > + * This function instructs the UDC to delay the status stage of a control
> > > + * request. It can only be called from the request completion handler of
> > > a
> > > + * control request.
> > > + */
> > > +void usb_ep_delay_status(struct usb_ep *ep)
> > > +{
> > > +	ep->delayed_status = true;
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_ep_delay_status);
> > 
> > Is usb_ep_set_delay_status() better? I thought it implies get/return
> > action if a verb is missing in the function name.
> 
> For what it's worth, I understand the function name as "delay the status 
> stage", with "delay" being a verb. Maybe the short description could be 
> updated accordingly.

Okay, maybe it is just my own understanding problem. I thought about
delay as the verb, but then notice the var is called delayed_status,
then I was thinking delay_status in the function name as the flag.

No worries.

Regards,
-Bin.

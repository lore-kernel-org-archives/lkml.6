Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D98FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C9D2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C9D2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754305AbeGEPOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:14:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753874AbeGEPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:21 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6DCBBA0;
        Thu,  5 Jul 2018 15:14:20 +0000 (UTC)
Date:   Thu, 5 Jul 2018 17:14:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>
Subject: Re: [PATCH 01/15] Introduce Cadence USBSSP DRD Driver - added
 gadget.c file.
Message-ID: <20180705151417.GC10795@kroah.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
 <1530647879-10007-2-git-send-email-pawell@cadence.com>
 <20180704091342.GA25518@kroah.com>
 <BYAPR07MB4709E76774739A793CACE0D7DD400@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB4709E76774739A793CACE0D7DD400@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:15:04AM +0000, Pawel Laszczak wrote:
> > On Tue, Jul 03, 2018 at 08:57:45PM +0100, Pawel Laszczak wrote:
> > > From: Laszczak Pawel <pawell.cadence.com>
> > >
> > > Signed-off-by: Laszczak Pawel <pawell@cadence.com>
> > > ---
> > 
> > I can't take patches without any changelog text at all, sorry.
> > 
> > Also, your subject lines need work, look at how all other usb patches are
> > written, your long prefix is not really helping out here.
> > 
> > >  drivers/usb/usbssp/gadget.c | 2082
> > > +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 2082 insertions(+)
> > >  create mode 100644 drivers/usb/usbssp/gadget.c
> > 
> > 
> > Just splitting the driver up by file is hard to review, as you are just dumping
> > individual files on us, not functionality, and we can not review anything until
> > all of them are added.  Can you break this up into logical chunks?  Make
> > these in a way that is easy to review, would you want to review this patch
> > series in this way?
> 
> It's quite large driver and I thought that this form will be better and faster to review. 

How can you review it file-by-file without seeing how they all interact?

> I didn't want to prepare too much patches.

Yes, it is more work, but that is how we do kernel development as you
want us to review the code.  Just think about what you would want if you
had to review all of this.

thanks,

greg k-h

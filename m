Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15B1C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3121471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F3121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeGLRRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:17:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeGLRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:17:50 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F88ED0E;
        Thu, 12 Jul 2018 17:07:24 +0000 (UTC)
Date:   Thu, 12 Jul 2018 19:07:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: Re: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Message-ID: <20180712170722.GA23030@kroah.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-3-git-send-email-pawell@cadence.com>
 <20180712061030.GB20905@kroah.com>
 <BYAPR07MB4709D8EB760716D0F9B0F4FBDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20180712063506.GA25007@kroah.com>
 <BYAPR07MB47093E425A14049C036D97CFDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB47093E425A14049C036D97CFDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:43:27PM +0000, Pawel Laszczak wrote:
> > > > > This patch add additional functions that converts some fields to string.
> > > > >
> > > > > For example function usbssp_trb_comp_code_string take completion c
> > > > > ode value and return string describing completion code.
> > > >
> > > > Odd line-wrapping :(
> > > Do you mean additional space character between "c" and "ode"
> > 
> > It wrapped lines at that point for me, yes.
> > 
> > > > And why do you want a string for these things?  Who cares about them?
> > > It will be used in next version of driver. I have plan to add gadget-debugfs.c
> > file.
> > > At this moment this functions can be useful during debugging driver if
> > > someone want to display some debug information.
> > >
> > > Should I remove this function ?
> > 
> > If no one is using it now, yes, it does not need to be there, right?  We don't
> > have dead code around for no reason, otherwise someone will come along
> > and remove it :)
> 
> I checked again, and these functions are used in gadget-trace.h file added in [PATCH 03/31].
> I didn't want to create too big patch, so I split it into two separate part. [PATCH 02/31] add debugging 
> function used in trace* functions, and [PATCH 03/31/] add all trace* function used in driver.

Ok, that's fine then.

And please wrap your lines in your emails to a sane limit :)

thanks,

greg k-h

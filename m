Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14660C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD93321A3A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD93321A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeHFQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:15:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59644 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeHFQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:15:03 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34419E47;
        Mon,  6 Aug 2018 14:05:15 +0000 (UTC)
Date:   Mon, 6 Aug 2018 16:05:12 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhang, Ning A" <ning.a.zhang@intel.com>
Cc:     "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Ting" <ting.li@intel.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "markus@trippelsdorf.de" <markus@trippelsdorf.de>
Subject: Re: [PATCH] firmware: make sure builtin firmware is page alignment
Message-ID: <20180806140512.GA19844@kroah.com>
References: <20180803014521.21527-1-ning.a.zhang@intel.com>
 <20180803053948.GB1852@kroah.com>
 <1533285744.20683.67.camel@intel.com>
 <20180803103121.GB6557@kroah.com>
 <1533520123.20683.71.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533520123.20683.71.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:48:44AM +0000, Zhang, Ning A wrote:
> 在 2018-08-03五的 12:31 +0200，gregkh@linuxfoundation.org写道：
> > On Fri, Aug 03, 2018 at 08:42:25AM +0000, Zhang, Ning A wrote:
> > > 在 2018-08-03五的 07:39 +0200，Greg KH写道：
> > > > On Fri, Aug 03, 2018 at 09:45:21AM +0800, Zhang Ning wrote:
> > > > > when firmware is in filesystem, request_firmware will load it,
> > > > > and copy it to vmalloc memory, that is page align memory.
> > > > > 
> > > > > but when firmware is builtin, it is 8 bytes or 4 bytes
> > > > > alignment.
> > > > > 
> > > > > make sure builtin firmware is page algnment, that can simplify
> > > > > algorithm
> > > > > to handle firmware.
> > > > 
> > > > How is it simplified?  I don't see any such change like that here
> > > > :(
> > > > 
> > > 
> > > Thank you for review this patch.
> > > 
> > > When driver handles its firmware based on  page, like below:
> > > 
> > > 	struct page *p;
> > > 	p = vmalloc_to_page(fw->data);  // for filesystem firmware
> > > 	p = virt_to_page(fw->data); // for builtin firmware
> > > 
> > > but if builtin firmware is not page alignment, page pointer for
> > > builtin
> > > firmware is wrong, it contains memory not belong to firmware.
> > > drivers
> > > has to use additional code to handle this. 
> > > 
> > > if builtin firmware is also page alignment, no need additional code
> > > to
> > > handle builtin firmware. simplified.
> > 
> > But you did not change anything like this in your code, so why would
> > I
> > know this?
> 
> I understand it is very difficult to review this patch without context.
> The driver is not opensource, I can't show the patch for driver.

Then I can not accept your patch.  Go talk to your corporate lawyers
about changing core kernel code for a closed source driver and what that
implies about that closed driver (hint, your driver can not be
closed...) :)

Then come back with a proper open sourced driver, that's the only way
Linux drivers can be written sorry.

best of luck,

greg k-h

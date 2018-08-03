Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31642174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31642174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbeHCM1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:27:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeHCM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:27:06 -0400
Received: from localhost (ip-213-127-46-170.ip.prioritytelecom.net [213.127.46.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6ED34720;
        Fri,  3 Aug 2018 10:31:24 +0000 (UTC)
Date:   Fri, 3 Aug 2018 12:31:21 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhang, Ning A" <ning.a.zhang@intel.com>
Cc:     "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Ting" <ting.li@intel.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "markus@trippelsdorf.de" <markus@trippelsdorf.de>
Subject: Re: [PATCH] firmware: make sure builtin firmware is page alignment
Message-ID: <20180803103121.GB6557@kroah.com>
References: <20180803014521.21527-1-ning.a.zhang@intel.com>
 <20180803053948.GB1852@kroah.com>
 <1533285744.20683.67.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533285744.20683.67.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 08:42:25AM +0000, Zhang, Ning A wrote:
> 在 2018-08-03五的 07:39 +0200，Greg KH写道：
> > On Fri, Aug 03, 2018 at 09:45:21AM +0800, Zhang Ning wrote:
> > > when firmware is in filesystem, request_firmware will load it,
> > > and copy it to vmalloc memory, that is page align memory.
> > > 
> > > but when firmware is builtin, it is 8 bytes or 4 bytes alignment.
> > > 
> > > make sure builtin firmware is page algnment, that can simplify
> > > algorithm
> > > to handle firmware.
> > 
> > How is it simplified?  I don't see any such change like that here :(
> > 
> Thank you for review this patch.
> 
> When driver handles its firmware based on  page, like below:
> 
> 	struct page *p;
> 	p = vmalloc_to_page(fw->data);  // for filesystem firmware
> 	p = virt_to_page(fw->data); // for builtin firmware
> 
> but if builtin firmware is not page alignment, page pointer for builtin
> firmware is wrong, it contains memory not belong to firmware. drivers
> has to use additional code to handle this. 
> 
> if builtin firmware is also page alignment, no need additional code to
> handle builtin firmware. simplified.

But you did not change anything like this in your code, so why would I
know this?

Please fix this up submit this properly.

greg k-h

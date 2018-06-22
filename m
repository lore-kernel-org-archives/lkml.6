Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4791923D6A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4791923D6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeFVFJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:09:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeFVFJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:09:44 -0400
Received: from localhost (s169.156.222.122.fls.vectant.ne.jp [122.222.156.169])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4A9D2C;
        Fri, 22 Jun 2018 05:09:43 +0000 (UTC)
Date:   Fri, 22 Jun 2018 14:09:41 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] devres: Add devm_of_iomap()
Message-ID: <20180622050941.GA28638@kroah.com>
References: <acf43685e55ff104ed3bf59d91264fdeec029cf2.camel@kernel.crashing.org>
 <5a28adfe74dcea35d704d98e54b2bbb72bcd6b8f.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a28adfe74dcea35d704d98e54b2bbb72bcd6b8f.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:13:15PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2018-06-14 at 13:31 +1000, Benjamin Herrenschmidt wrote:
> > There are still quite a few cases where a device might want
> > to get to a different node of the device-tree, obtain the
> > resources and map them.
> > 
> > This is generally open coded in drivers which is quite error prone
> > 
> > We have of_iomap() and of_io_request_and_map() but they both
> > have shortcomings, such as not returning the size of the
> > resource found (which can be useful) and not being "managed".
> > 
> > This adds a devm_of_iomap() that provides all of these and
> > should probably replace uses of the above in most drivers.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> 
> Greg, which tree should this go through ? Rob, ack pls ? :-)
> 
> I have dependencies on this coming up... I can put it in the FSI tree
> if you want, it will be part of my next pull request.

Usually new devres patches just go through whatever tree needs it, so no
objection from me for you to take these in your next pull request.

thanks,

greg k-h

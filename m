Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1798EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ADA20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5ADA20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeILMwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:52:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeILMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:52:11 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6519CE64;
        Wed, 12 Sep 2018 07:48:53 +0000 (UTC)
Date:   Wed, 12 Sep 2018 09:48:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        fan.du@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: fix is_source param for check_copy_size() in
 copy_to_iter_mcsafe()
Message-ID: <20180912074850.GA362@kroah.com>
References: <153617950046.33664.13445188581267552601.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153617950046.33664.13445188581267552601.stgit@djiang5-desk3.ch.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:31:40PM -0700, Dave Jiang wrote:
> copy_to_iter_mcsafe() is passing in the is_source parameter as "false"
> to check_copy_size(). This is different than what copy_to_iter() does.
> Also, the addr parameter passed to check_copy_size() is the source so
> therefore we should be passing in "true" instead.
> 
> Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
> Cc: Fan Du <fan.du@intel.com>
> Reported-by: Wenwei Tao <wenwei.tww@alibaba-inc.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Cc: stable <stable@vger.kernel.org>
> ---
>  include/linux/uio.h |    2 +-

I am not the maintainer of this file, sorry, please work with the -mm
developers for this.

thanks,

greg k-h

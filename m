Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB447C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FEE21473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FEE21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeHBKbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:31:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:31:51 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8257ABAC;
        Thu,  2 Aug 2018 08:41:43 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:41:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: mt29f_spinand: fix memory leak while
 programming pages
Message-ID: <20180802084141.GA2052@kroah.com>
References: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
 <1533196290-9669-1-git-send-email-goodwater.wu@gmail.com>
 <20180802080258.GA13222@kroah.com>
 <CALtPoQCskvbkEYE2m6Q=h_gPEV6+Abt+SJqLjVtAa+jReHGrzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALtPoQCskvbkEYE2m6Q=h_gPEV6+Abt+SJqLjVtAa+jReHGrzA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Aug 02, 2018 at 04:31:40PM +0800, Jheng-Jhong Wu wrote:
> Dear greg k-h,
> 
> Before device is removed and freed memory automatically, programming
> pages may run many many times.

What do you mean by "programming pages"?

> Assume we erase and rewrite a large part of the flash, then
> spinand_program_page() might exhaust memory if memory is not large
> enough.

I do not understand what you mean here.

> We may not remove and re-add the device between each programming page, right?

I have no idea how your hardware works :)

> In fact, OOM indeed occurred when I tested programming multi-pages by
> mtd_debug tool.
> Erased first, then programmed pages.

Please provide more information like this in the patch when you resend
it, spelling out exactly why you are making this change.  It is not that
the current code is "leaking" anything, it is that you want the
functionality to be different from what it currently is.

thanks,

greg k-h

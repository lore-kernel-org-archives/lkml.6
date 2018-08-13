Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879321834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879321834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeHMJPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:15:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbeHMJPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:15:49 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E821A59;
        Mon, 13 Aug 2018 06:34:59 +0000 (UTC)
Date:   Mon, 13 Aug 2018 08:34:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Todd <thomas.m.a.todd@gmail.com>
Cc:     joe@perches.com, stern@rowland.harvard.edu,
        dan.carpenter@oracle.com, arvind.yadav.cs@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: core: devio: Restructured proc_ioctl for
 readability
Message-ID: <20180813063455.GA29496@kroah.com>
References: <10f9f13a5421299a6efda1e1f84ab304ef18ddec.camel@perches.com>
 <20180812222653.3341-1-thomas.m.a.todd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180812222653.3341-1-thomas.m.a.todd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 11:26:54PM +0100, Tom Todd wrote:
> On, Sun, 12 Aug 2018 11:34:59 -0700 Joe Perches wrote:
> >On Sun, 2018-08-12 at 19:06 +0100, Tom Todd wrote:
> >> Fixed a code styling issue
> >while it's OK to fix style only issues, it's much better
> >to reorganize the code for reader clarity.
> 
> Ok, thank you, I've taken your suggestions and created the a new version
> 
> Restructured method proc_ioctl for readability and fixed code style
> errors.

Please always be very specific as to exactly what code style issues you
are fixing.  And never do more than one type of fix at a time, otherwise
it is hard to review, and you can cause errors to be added, like you did
here :(

Please do not start working on code cleanups in any other area of the
kernel other than drivers/staging/ as that is what that is for.  To do
so in other areas of the kernel causes more work for maintainers.

thanks,

greg k-h

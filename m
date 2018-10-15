Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFAC208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ2skZte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFAC208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJPCsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbeJPCsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:48:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5785208B3;
        Mon, 15 Oct 2018 19:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539630097;
        bh=eiazFKZ9+NMXhr8XNPOQYMwqdtLgfzda3bxx8qyvjI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJ2skZteAFjx8e0MeZsX1mxk2Sx0YDVN0zEFR5YeNt1Iaw73DfBlOsfcj2qyL6Pcd
         MgB6X8i8q7eOm0dE2cOto3FA+8tUAzYJf/6HaXkhA78i4J5a33v4zlKB3eB96h18zR
         n7JEU03PzR7+fRvi90TukQEsen+yOMyUxpvYF/eY=
Date:   Mon, 15 Oct 2018 21:01:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 09/15] platform: goldfish: pipe: Move goldfish_pipe to
 goldfish_pipe_v2
Message-ID: <20181015190134.GA6700@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-9-rkir@google.com>
 <20181015183807.GA6905@kroah.com>
 <CAOGAQeo31ggKCHsJw3D297J6Ya1kq8MptTaDR7q6H7-q99sdGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQeo31ggKCHsJw3D297J6Ya1kq8MptTaDR7q6H7-q99sdGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:55:26AM -0700, Roman Kiryanov wrote:
> > > This is the v2 driver. v1 will be added later.
> >
> > If you want to add a new driver later, great, but don't change the name
> > of an existing driver for no good reason.
> 
> I want our "v2" driver to be in a "v2" file and our "v1" driver in a
> "v1" file. I think this is reasonable.

The in kernel driver is the "v1" one.  Why do you need a totally new
driver file at all anyway?

And again, can you GUARANTEE that userspace will not break if you rename
the kernel module?  Also, "vX" is an odd naming schemes for drivers,
don't take naming lessons from qualcomm :)

thanks,

greg k-h

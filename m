Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAF92089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R88K+ow8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAF92089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeJPTlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPTlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:41:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B43720866;
        Tue, 16 Oct 2018 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539690700;
        bh=dYLnipXoNnU0ufY6QJ/KR9eNnSjTT3rO1vnRW6Ffrj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R88K+ow8C3A1JZ1sU8wag4HIY0RtSlVmzXlZJiwzdPkRTlNPbZ265Rww+f4gnhoMR
         UdcpEQqeyTThRMnPK2B8+fvVCuodqaRffjzi8XbU9lMQlNCqbRhyQxeKAyOU98i85l
         JZbpe2KrXGgH9gQXqb72WJrsqguREuckINo/ILGU=
Date:   Tue, 16 Oct 2018 13:51:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Subject: Re: patch "staging: MAINTAINERS: remove obsolete IPX staging
 directory" added to staging-testing
Message-ID: <20181016115137.GA28641@kroah.com>
References: <15396867728666@kroah.com>
 <249981aa5af26de07565946fbe806e3c01f26c07.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249981aa5af26de07565946fbe806e3c01f26c07.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:43:30AM -0700, Joe Perches wrote:
> On Tue, 2018-10-16 at 12:46 +0200, gregkh@linuxfoundation.org wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     staging: MAINTAINERS: remove obsolete IPX staging directoryts
> []
> > From dd71c89b2c1ae049d2018107e9d7a41261db3f7b Mon Sep 17 00:00:00 2001
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Tue, 16 Oct 2018 12:45:13 +0200
> > Subject: staging: MAINTAINERS: remove obsolete IPX staging directory
> > 
> > The IPX code was removed from staging back in November 2017, but the
> > MAINTAINERS entry stuck around.  Remove the invalid directory from the
> > file as it does not actually point to anything anymore.
> 
> As the uapi ipx file still exists but the functionality
> has been removed, perhaps some compiler message like
> 
> #pragma message "IPX functionality removed as of linux kernel v4.18"
> 
> should be added to the uapi file.

Eventually those files should be removed by the networking developers.
It will take a bit of work for them to do it, it's not a straight
"delete the file" work.

thanks,

greg k-h

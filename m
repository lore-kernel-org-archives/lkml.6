Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E31C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A372089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A372089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeGJGpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:45:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeGJGpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:45:09 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B9B9C03;
        Tue, 10 Jul 2018 06:45:08 +0000 (UTC)
Date:   Tue, 10 Jul 2018 08:45:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] docs, debugfs: start explicit debugfs documentation
Message-ID: <20180710064506.GA2316@kroah.com>
References: <alpine.DEB.2.21.1807091459410.118937@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807091459410.118937@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:00:17PM -0700, David Rientjes wrote:
> There is no canonical location for debugfs docuemntation, so start one.
> 
> This is primarily motivated to describe the oom_free_timeout_ms interface
> but it is extended for all the debugfs files that I am personally
> interested in.
> 
> Hopefully this can be expanded in the future for better insight into how
> the various interfaces can be used.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Documentation/clearing-warn-once.txt       |   7 --
>  Documentation/debugfs/00-INDEX             |   8 ++
>  Documentation/debugfs/extfrag.txt          |  46 +++++++
>  Documentation/debugfs/provoke-crashes.txt  |   8 ++
>  Documentation/debugfs/root.txt             | 137 +++++++++++++++++++++
>  Documentation/filesystems/debugfs.txt      |  46 +++++++
>  Documentation/power/basic-pm-debugging.txt |  25 +---
>  Documentation/sysctl/vm.txt                |   7 +-

This is a mix of a lot of different things all at once.

I'll gladly take the update to the debugfs.txt file for the newer api
calls as a separate file.

For the "this is what a specific debugfs file contains", those should go
into Documenation/ABI/ if you really want to document those types of
things.

But as it is, this single patch does too many different things all at
once.

thanks,

greg k-h

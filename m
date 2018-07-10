Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE9DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5A920883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5A920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeGJLq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:46:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeGJLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:46:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0B841EBC;
        Tue, 10 Jul 2018 11:46:26 +0000 (UTC)
Date:   Tue, 10 Jul 2018 13:46:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] docs, debugfs: start explicit debugfs documentation
Message-ID: <20180710114624.GA14261@kroah.com>
References: <alpine.DEB.2.21.1807091459410.118937@chino.kir.corp.google.com>
 <20180710064506.GA2316@kroah.com>
 <20180710052835.581cdf28@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710052835.581cdf28@lwn.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 05:28:35AM -0600, Jonathan Corbet wrote:
> On Tue, 10 Jul 2018 08:45:06 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > For the "this is what a specific debugfs file contains", those should go
> > into Documenation/ABI/ if you really want to document those types of
> > things.
> 
> Do we really want to start populating Documentation/ABI with stuff that's
> explicitly *not* ABI?  Keeping it separate might make more sense, IMO.
> I'd put extfrag_index with the MM docs, for example.

I personally don't think that debugfs files should be documented
anywhere, unless it makes sense from a "help debug the kernel" point of
view.  And yes, you are right, we don't want to document things in /ABI/
that are not ABI stuff, as debugfs files can, and do, change at random
times.

Putting the info in the subsystem specific documents makes sense.

thanks,

greg k-h

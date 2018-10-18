Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B50C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A2C2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2lXoKDC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A2C2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeJRSON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeJRSOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:14:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2516C2148E;
        Thu, 18 Oct 2018 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539857629;
        bh=DzZbeqmv+BFpusqIGxC5Zlgyc5U2PYNysgq3bhaK2EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lXoKDC1zG1/nFpDHKv0L5dqr/q0Q+wnJR3Pt0CuNj0MqtI3Rvmdgcnsn7Ytt1zz7
         pUxerZk5PR5hVP8tydLgxng1nHof2iWCZHAxaeP+oAaA73xPzBfoZd8KsO0bdPXejh
         kCoFarX9nEJj4XsDExLHABHtnuZiAYIOuL8QoP64=
Date:   Thu, 18 Oct 2018 12:03:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [GIT PULL] IDA/IDR fixes for 4.19
Message-ID: <20181018100355.GB8451@kroah.com>
References: <20181016171608.GA19184@bombadil.infradead.org>
 <20181018062634.GA27494@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018062634.GA27494@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:26:34PM -0700, Christoph Hellwig wrote:
> On Tue, Oct 16, 2018 at 10:16:08AM -0700, Matthew Wilcox wrote:
> > > >   git://git.infradead.org/users/willy/linux-dax.git ida-fixes-4.19-rc8
> > > 
> > > How about you at least test these in linux-next?  Putting things on top
> > > of the most recent change is a huge tip-off that this branch got no
> > > testing :(
> > 
> > One of the two changes is a comment line in a doc file.
> > The other has been tested by 0day (which originally reported the issue).
> > 
> > I don't see how spending time in linux-next is going to achieve anything.
> 
> Especialy if we miss 4.19 final with that.  The documentation patch
> avoids the probem of CC-BY-SA-4.0 including larger amounts of GPL files
> in the output document, so we should have this before the release for
> sure, and the other is just a test that isn't even in a normal kernel
> build.

Ok, both patches are now pulled.

> Also after idr.rst is removed we should include something like this:
> 
> ---
> >From c3660257f981e7a7254d18f52af64a2077f7bb49 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Thu, 18 Oct 2018 08:22:39 +0200
> Subject: LICENSES: Remove CC-BY-SA-4.0 license text

<snip>

Great idea, I've also merged this now as well after checking linux-next
to ensure that no one else is using this license there either.

thanks,

greg k-h

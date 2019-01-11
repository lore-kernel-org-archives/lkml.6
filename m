Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6978EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3837521841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547210801;
	bh=NgsbN67vGaMMn8SHTFLBqxawmnUOuuLW9RX8Y4PxvGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ec3bCwGDKeizrKDHLyNuKaiw4XBq9LIWl0Rtnsu42x79w+bNztMXuPvAUowyyKz7q
	 RJmH7d4aEtujCA61aVcYRQbRVOmlsNdKYe8gSmopDoaYDaUwrxFwysc8Tni9t8wZ51
	 jJrw1ua7T6FYzkOz3M2LbFQpSbMngpW371WI2sxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfAKMqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfAKMqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:46:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0A120872;
        Fri, 11 Jan 2019 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547210799;
        bh=NgsbN67vGaMMn8SHTFLBqxawmnUOuuLW9RX8Y4PxvGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVk1+9TXGmaK8LoYHNe5sUTlwukGRP09wJGDgxHHIFKPrw6f9lOK6lE9FiqoeDfkO
         b5qQ8TFDhztFYQHre0e+Wsn4lWZK3/yIkpZUReN/xfxTJZf9CKgbRrYINgNj9u3CkJ
         jVxrl6sXFMcU1+QSwnTzePqXIJdAj08l3yl0l2fw=
Date:   Fri, 11 Jan 2019 13:46:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        joel@joelfernandes.org, tkjos@google.com
Subject: Re: [RESEND PATCH] binderfs: reserve devices for initial mount
Message-ID: <20190111124636.GA12978@kroah.com>
References: <20190111101940.24965-1-christian@brauner.io>
 <20190111102055.fryctkdngibd56dq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111102055.fryctkdngibd56dq@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:20:56AM +0100, Christian Brauner wrote:
> On Fri, Jan 11, 2019 at 11:19:40AM +0100, Christian Brauner wrote:
> > The binderfs instance in the initial ipc namespace will always have a
> > reserve of 4 binder devices unless explicitly capped by specifying a lower
> > value via the "max" mount option.
> > This ensures when binder devices are removed (on accident or on purpose)
> > they can always be recreated without risking that all minor numbers have
> > already been used up.
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Cherry-picked this commit on top of char-misc-linus and it applied
> cleanly. I hope I took the right branch?

Yes, that was the right one, and the patch worked just fine, thanks.

greg k-h

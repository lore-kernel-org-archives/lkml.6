Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02535C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B792A2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547889174;
	bh=2QPsAC4AYXyGNZKN2TilCJ4WEB28fTy0LOIevQZyPA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUVCWFm+QxG4Nf3TyAGfMSRIgmCEZPZ+nsAjNQjDVigvxp2XzVlF537ODS3te7DTl
	 yMrpY6SwcDYijnpFoRzExsAUmcJPY2SbayIzx33bOC++jWl6CA2i8duw2oG5dcTDuA
	 LVdQQmXEDvonUfMnf66wxoQTgAncMpcOK4V5Qo5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfASJLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfASJLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:11:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD3A2086D;
        Sat, 19 Jan 2019 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547889071;
        bh=2QPsAC4AYXyGNZKN2TilCJ4WEB28fTy0LOIevQZyPA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQzV5CVDTKiGv3Y/By0Dkfxqwe5TiRI+ht5YQZaiF4Nb4aRzw2vGNtZFDsXw7IR/y
         15sTmS2RAjKKLif+0VRw6DZNaQGTQA8RlBz8VUGXO3ZhNAvprGv6rXKLgMc1/SAjIw
         xvQWDn12QygkX3bBU44xpQhTxCuhnW0Z90qEMR1k=
Date:   Sat, 19 Jan 2019 10:11:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] tiocsti() NULL dereference if ld->ops->receive_buf==NULL
Message-ID: <20190119091108.GF10836@kroah.com>
References: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 08:09:07PM +0100, Jann Horn wrote:
> Hi!
> 
> When a line discipline doesn't have a ->receive_buf handler, tiocsti()
> attempts to call a NULL pointer. Both tty_n_tracesink and
> spk_ttyio_ldisc_ops don't have such a handler.
> 
> To reproduce, build a kernel with CONFIG_SPEAKUP=y and
> CONFIG_SPEAKUP_SYNTH_SOFT=y, set speakup.synth=soft in the kernel
> command line, and run the following code as root:

<snip>

Ugh, thanks for finding this.  I'll look at it later this afternoon...

greg k-h

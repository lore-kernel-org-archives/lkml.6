Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE94920989
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MReYaiGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE94920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeKKFGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 00:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbeKKFG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 00:06:29 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BAA20684;
        Sat, 10 Nov 2018 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541877627;
        bh=yHEjlh1S+M2kqb2D80PkFcukg2D68LO5ActflyYTMyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MReYaiGrXOHTGbou/MMsw+5CloOYJxQzgKsy+tLEiso3CF2sn614u6eJQKXA6yE0I
         8wN9PHkKlq6HOLWgqKiri3p28PtIZ8PIoifooTbu+JmWrWhA5d0SzEkbCyzZsujeLM
         e66E2JTfGk4PC8nMih4vjkyF5NKB0sYwn5V+o/pU=
Date:   Sat, 10 Nov 2018 11:20:27 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181110192027.GA29892@kroah.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 10:52:06AM -0800, Daniel Colascione wrote:
> Now that glibc is basically not adding any new system call wrappers,

Why are they not doing that anymore?

And there's no reason you have to use glibc, there are many other libcs
out there that hopefully are adding the new syscalls :)

> how about publishing an "official" system call glue library as part of
> the kernel distribution, along with the uapi headers? I don't think
> it's reasonable to expect people to keep using syscall(__NR_XXX) for
> all new functionality, especially as the system grows increasingly
> sophisticated capabilities (like the new mount API, and hopefully the
> new process API) outside the strictures of the POSIX process.

Patches are always welcome to be reviewed.  But watch out that they
don't conflict with the libc headers.  I know we had a "klibc" proposed
a long time ago but that died off for various reasons before it could
get merged.

Also, what about the basic work of making sure our uapi header files can
actually be used untouched by a libc?  That isn't the case these days as
the bionic maintainers like to keep reminding me.  That might be a good
thing to do _before_ trying to add new things like syscall wrappers.

thanks,

greg k-h

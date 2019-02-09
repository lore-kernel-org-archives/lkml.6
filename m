Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9CBC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E4921903
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549703507;
	bh=Uf++Xmvwu1F8qbwN+AvIWWfPTCJiJXhbLII53pVEM50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yMzNfSJIPfU3yKadBDwavG+1+Qmq3Gtc0q7XzcdpCQQc0SC+IAhQ0h0wz4Aa3TkEz
	 quJLSTXzGZVP1fzZR9mj21qG73vkv702Ya7LEVqHRHUNoOZfF3bOP+WzhkvstzFlF8
	 rKOku430qx9bJ2Ei1jqWk3FxSXMOMEYQJngFCoDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfBIJLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:11:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfBIJLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:11:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD72520823;
        Sat,  9 Feb 2019 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549703504;
        bh=Uf++Xmvwu1F8qbwN+AvIWWfPTCJiJXhbLII53pVEM50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrulZc7MhBBrC/GTh3kZUGNRla797vD7lVXT9UiyhN0hQFcFbHNyV7jkYooJqlZdZ
         VCDaTtcHS7LmwkO1KFvYM8cdrUiJLX9BG6iuj3Alhu0Isuc8/1UiVhzMbljobifdUQ
         Vnwg7PIpbpoGuuSL83/K6+HyVuQz0GKbdkUCTFXM=
Date:   Sat, 9 Feb 2019 10:11:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190209091142.GC3377@kroah.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <20190124201251.15159-2-TheSven73@googlemail.com>
 <20190208121810.GD23483@kroah.com>
 <CAGngYiXjJtGNLAV_jvoj2NsjD+UCnK_Q+ZssgSwAukYAXdgE2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXjJtGNLAV_jvoj2NsjD+UCnK_Q+ZssgSwAukYAXdgE2A@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:30:22AM -0500, Sven Van Asbroeck wrote:
> On Fri, Feb 8, 2019 at 7:18 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > > +static DEFINE_IDA(fieldbus_ida);
> >
> > You forget to destroy this ida structure when the module is removed.
> > It's a common thing to get wrong :(
> >
> 
> But fieldbus_ida is allocated on the heap. So as long as calls to
> ida_simple_get() and ida_simple_remove() are matched, there
> should be no resource leak?
> 
> What am I missing?

the ida structure does some internal allocations and ida_destroy() has
to be called when your code is being removed to properly free it.

Again, it's not obvious at all, but it is needed :(

thanks,

greg k-h

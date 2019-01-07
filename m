Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195532089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546856724;
	bh=uNE8/Fp952I1YzT9nYo00usViur7+0hvjXc69Mi1k6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MNeOV/ahVedSQh6RXsUixIVjiUrXkEjXqPVikBbpSUaMek78qn6exHU2tnYHHI4Dt
	 tij1WI/yiJ5FPZn7uKq3AnJZR3KtJD5VtRW0rzHaknxYgDNziaTR5jvLm/4SJUDG3J
	 gvUAsH5MWccc5z2X5dd8SgILCLYlwAkDZ0zHrz/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfAGKZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfAGKZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:25:22 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6982087F;
        Mon,  7 Jan 2019 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546856722;
        bh=uNE8/Fp952I1YzT9nYo00usViur7+0hvjXc69Mi1k6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=daQTDIqis86xdB8ViWb7/1eQYTbGXhXIjGSyK952rhfk1zu1Ckp/rQWtmyOQqAJle
         KWK3zdZez6T842aaxbex9+jjRIr5Tbrr7SuE9NQsjfDYybpY+pPfTLjsyDOd8h+Eif
         y+Gi28edej9KxTzrgaYswIpC3GLqmYr7NcAdS9ag=
Date:   Mon, 7 Jan 2019 11:25:08 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alban Bedel <albeu@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [LKP] [mtd] c4dfa25ab3: kernel_BUG_at_fs/sysfs/file.c
Message-ID: <20190107112459.2fcdebaf@bbrezillon>
In-Reply-To: <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
References: <20190102005704.GC17624@shao2-debian>
        <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Wed, 2 Jan 2019 11:53:34 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Hmm..
> 
> Adding a few more mtd people to the cc.

Sorry for the late reply, I don't have access to my @bootlin.com
address anymore and it took me some time to realize you had replied to
this bug report.

> 
> On Tue, Jan 1, 2019 at 4:57 PM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: c4dfa25ab307a277eafa7067cd927fbe4d9be4ba ("mtd: add support for reading MTD devices via the nvmem API")
> >
> > [   81.780248] kernel BUG at fs/sysfs/file.c:328!
> > [   81.781914] Call Trace:
> > [   81.781914]  sysfs_create_files+0x60/0x180
> > [   81.781914]  mtd_add_partition_attrs+0x14/0x30
> > [   81.781914]  add_mtd_partitions+0x11f/0x260
> > [   81.781914]  mtd_device_parse_register+0x38d/0x4c0
> > [   81.781914]  ns_init_module+0x1033/0x117d
> > [   81.781914]  do_one_initcall+0x18f/0x39e
> > [   81.781914]  kernel_init_freeable+0x2b4/0x353
> > [   81.781914]  kernel_init+0xa/0x120  
> 
> This actually looks like a very old bug, just exposed by a new error case.
> 
> In particular, the mtd code seems to do this in mtd_add_partition():
> 
>         int ret = 0;
>      ...
>         add_mtd_device(&new->mtd);
> 
>         mtd_add_partition_attrs(new);
> 
>         return ret;
> 
> where 'ret' is actually never set to anything but that initial zero.
> 
> And in fact, it looks like it never was used.
> 
> I _think_ that what's going on is that "add_mtd_device()" historically
> never really failed (although it *can* fail), and then
> mtd_add_partition_attrs() is called on something that doesn't really
> exist.
> 
> It looks like the error handling for the add_mtd_device() case nmever
> actually existed, and now the nvmem patch makes that fail in the
> test-case, and the lack of error handling is exposed.
> 
> There is another call-site of add_mtd_device() (in
> add_mtd_partitions() - same pattern, notice the "s" at the end of the
> function name) that also lacks the error handling.

Yep, I fixed the root cause of the crash here [1] and plan to queue the
patch to the mtd/fixes branch soon.

Regards,

Boris

[1]http://patchwork.ozlabs.org/patch/1020008

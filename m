Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83431C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70186206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544808644;
	bh=kX1magIw4mGkzhRAABt7Aqvexh6OV7mW7HDHPgg3Q/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f1DLXWOpt9V7yAoV5bm1aUzvbK3U/Cab+RWrpnjhGopfzMUyUhghdg8oxHbHUB4l+
	 et7CILuwH+rqAx/cDtGgN5B6EfoE4fW2aGgpNBYt4bYsbQDwDeP012dInVtimooYTN
	 jWgL8NJZHg7lFZYLoiwP6OUH5wQj5Eb02cYcCGfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbeLNRam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbeLNRal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:30:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5278D206C0;
        Fri, 14 Dec 2018 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544808641;
        bh=kX1magIw4mGkzhRAABt7Aqvexh6OV7mW7HDHPgg3Q/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HkREVfhcyGFkY9Z4GPZ+UsxBRzeL7sOtp6FxgJ7f+6zuAJBZqDQH7zOV1PikEy7XR
         sK7GhXKbqgaram/7t30UKyH/4MceFpgokRXNNAPcwXFnhoY2dQxb28Ol2i0S1NWt2u
         1YHGhFUgoof9U+/flGT9x0Wfo73facZjjbeK+CXY=
Date:   Fri, 14 Dec 2018 18:30:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [regression] Mute button LED stopped working on Lenovo X1 Extreme
Message-ID: <20181214173038.GA29601@kroah.com>
References: <CAMRc=MdGYG55s2=Z6pCA90TbUVLgfhE3hohsCnm5QDGy1NEg=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdGYG55s2=Z6pCA90TbUVLgfhE3hohsCnm5QDGy1NEg=A@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:20:10PM +0100, Bartosz Golaszewski wrote:
> Hi,
> 
> I'm not sure what the connection is exactly but commit dcd51305cd41
> ("ALSA: hda/realtek - fix the pop noise on headphone for lenovo
> laptops") broke the mute button LED on my Lenovo X1 Extreme laptop.
> 
> I don't have any more info frankly and don't even know where to start
> debugging. Other LEDs work fine. This mute button LED never had any
> entry in /sys/class/leds, I'm not sure how it's handled.
> 
> Let me know if you need more debugging on my part.

There is a fix for this in the 4.19-rc tree right now.  It's in Linus's
tree if you want to just use that repo, or just wait a few days and it
will be in the next 4.19.y release.

thanks,

greg k-h

Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E094A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J12TGaXW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="HL1cjrUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbfAKUKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:10:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54161 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388733AbfAKUKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:10:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C4F94C73F;
        Fri, 11 Jan 2019 15:10:11 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=kkrE9YisWBq+U+vW3r9pRIYmxZE=; b=J12TGa
        XW/vXhh/ec48FcCxxrGSJyfOPx1cotm9VnMtNgaauJizvUYKM0nJGIzjYayzkpFL
        U3Szgu9/kfj9QmzzyJGyzg2FjdtpZ5zEVoAXDk60cr4GjhexQU6lSDxV6GtukVEV
        pmVxuZ33wdo3SywlWYgQZdVsjIG8M0YqSu1zk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43BE74C73E;
        Fri, 11 Jan 2019 15:10:11 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=UzVLl53IBiZ2pvwvJrj8NTZYlsX6CwkG9eBswrXVHjw=; b=HL1cjrUCvq1Myy1GfXstNDY7d4CNbKVHyXItlNxF88gcn0aHQeDFoJoZsTxRlQoHJZLJByxXCwJ2suImiAWfuruBiuZhBve1g5C6pg9Db254WUQdoQAaCFGKmYMt9+jmF5bH83GOwdvvFk4IIRr5YRifKy2TFBjWV7n0XBK6HTc=
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3996E4C73D;
        Fri, 11 Jan 2019 15:10:08 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 2C8602DA0173;
        Fri, 11 Jan 2019 15:10:06 -0500 (EST)
Date:   Fri, 11 Jan 2019 15:10:04 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Dmitry Safonov <dima@arista.com>, Jiri Slaby <jslaby@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tycho Andersen <tycho@tycho.ws>, Dave Mielke <dave@mielke.cc>,
        linux-kernel@vger.kernel.org
Subject: Re: commit 83d817f410 broke my ability to use Linux with a braille
 display
In-Reply-To: <20190111193259.GA14966@kroah.com>
Message-ID: <nycvar.YSQ.7.76.1901111503390.2566@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1901111239510.1512@knanqh.ubzr> <20190111193259.GA14966@kroah.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: E486562A-15DC-11E9-9045-D889C09F693B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019, Greg Kroah-Hartman wrote:

> On Fri, Jan 11, 2019 at 01:33:09PM -0500, Nicolas Pitre wrote:
> > I use Linux with the help of a braille display and the brltty daemon. It 
> > turns out that the latest mainline kernel I can work with comes from 
> > commit 231f8fd0cc. Anything past that and I lose the ability to read the 
> > console barely a few seconds after the system has booted as brltty is 
> > thrown a wrench and the braille display becomes completely inoperable.
> 
> Please try the patch below, it was just queued up to my tree and should
> resolve the issue.  If not, please let us know.

Yes, it works. Thanks.

I also re-validated all the vt/vcs patches I sent you this week for 
which I started entertaining some doubts about their stability. But they 
all work fine again with the tty fix applied.


Nicolas

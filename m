Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D0CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E702084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E702084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJ2WGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:06:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeJ2WGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:06:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42FA7AD88;
        Mon, 29 Oct 2018 13:18:11 +0000 (UTC)
Date:   Mon, 29 Oct 2018 14:18:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Harry Cutts <hcutts@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Logitech high-resolution scrolling..
In-Reply-To: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm>
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018, Linus Torvalds wrote:

> So I use a Logitech MX Anywhere 2S mouse, and really like it. I have
> the scroll-wheel unlocked, because I like flicking once to scroll a
> lot.
> 
> However, the new high-res scroll code means that the scroll wheel
> action is now much too sensitive. It's not even stable - it will
> scroll back-and-forth a bit occasionally, and in fact it sometimes
> seems to scroll not because I touch the scroll-wheel, but because the
> movement of the mouse itself causes the scroll wheel to move slightly
> and wiggle the scroll action.
> 
> So the recent change to enable the high-res scrolling really seems a
> bit *too* extreme.
> 
> Is there some middle ground that turns the mouse from "look at it
> sideways and it starts scrolling" to something slightly more
> reasonable?

Benjamin indicated that Peter probably has found the issue in the code 
(failure to properly reset on direction change) that might be causing 
this. Adding to CC.

Peter?

Thanks,

-- 
Jiri Kosina
SUSE Labs


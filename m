Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936B12075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="JJU0cO4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936B12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeKTFMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:12:54 -0500
Received: from imap.thunk.org ([74.207.234.97]:52602 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbeKTFMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BQgxlnAxoJVx48OYCx5r90OpNrmgW99ycT4H1lJdPZE=; b=JJU0cO4f4LMJuHl9iX0ji1I1Ug
        0uxvuDiKOy7a01M0SdzJeF5puqhjBA0HNnYs0H3HWqMcLd2P0mYQNk7IgCwdC7d+5H8Ft8YhdiosL
        9nlZLnhtqL56tGbacQq8jfxT6HyICjlJ/E0l2LJvYrL7SmnNmR1lflVvr8UTqeKQNW0I=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gOoaa-0008M5-5H; Mon, 19 Nov 2018 18:48:04 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 422BA7A046D; Mon, 19 Nov 2018 13:48:03 -0500 (EST)
Date:   Mon, 19 Nov 2018 13:48:03 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     AIAMUZZ <muzafsh.113@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Magic Sysrq key option ... What is the option to record the boot
 logs to my hard disk before i issue a reboot command ?
Message-ID: <20181119184803.GB19377@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        AIAMUZZ <muzafsh.113@gmail.com>, linux-kernel@vger.kernel.org
References: <CAC_t1uu7DDwA6do9sXnNhjcY4T=Q5PhmP2JtejSJ+FfpwJkaeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_t1uu7DDwA6do9sXnNhjcY4T=Q5PhmP2JtejSJ+FfpwJkaeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 08:51:17PM +0530, AIAMUZZ wrote:
> Hi,
> 
> I have this nagging and frustrating boot freeze i often face on my
> Deepin OS boot ... Deepin OS i think uses 'journalctl' to record logs
> on its system.
> 
> 'journalctl' however seems to record boot logs ONLY for successful
> boots ... boot logs for instances of boot freezes/hangs that are
> issued with a ... 'Ctrl+Alt+Del' ... key combination or the ... Magic
> Sysrq 'b' ... key combination to get out of the frozen/hung machine
> state are just not aved in the 'journalctl' log ...
> 
> Is there any option using Magic Sysrq that will enable me to record
> the failed/frozen/hung boot information to a file for troubleshooting
> before i reboot the system using the option 'b' ?
> 
> If not ... Isn't it a good idea to have such an option added to Magic
> Sysrq options, that can save/record the boot/system logs upto that
> point, until just before we restart the machines ?

This is a hard problem to solve, because there's no place to store the
information, at least not in the general case.  The problem is on an
unsuccessful boot, the root file system may not have been mounted yet.
Heck, the storage devices might not have been probed at all!

If your hardware has a place to store dmesg output across reboots (via
one of the CONFIG_PSTORE_* kernel configuration options) then this
would be an easy problem --- in fact, it would be the default even
with out needing a magic sysrq to request it.  The problem is that
most x86 devices do not have hardware capable of supporting
CONFIG_PSTORE.  If you have a custom BIOS which doesn't clear memory
across a warm reset, that would make things easy.  Unless, unless you
are a big cloud company using custom hardware and/or a custom BIOS,
life is much more difficult.  :-(

One alternative solution you can use is to simply use a serial
console, and have a another computer monitoring the output from the
serial console.  This will allow you to see all of the kernel messages
during early bootup and afterwards.  So this is also useful for when
your X server dies and your system mysteriously reboot; either
CONFIG_PSTORE_* hardware or using a serial console might allow you to
see the kernel oops message which took out your desktop machine.  (Or
in the case of servers, you can cross connect your servers' serial
ports so that one server is monitoring another server's serial
consoles.)

Cheers,

					- Ted

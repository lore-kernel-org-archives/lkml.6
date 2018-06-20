Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4120874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A4120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeFTOH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeFTOH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:07:56 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0CA20872;
        Wed, 20 Jun 2018 14:07:55 +0000 (UTC)
Date:   Wed, 20 Jun 2018 10:07:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Message-ID: <20180620100753.7acaee14@gandalf.local.home>
In-Reply-To: <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
References: <20180619115726.3098-1-hdegoede@redhat.com>
        <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 13:03:35 +0200
Petr Mladek <pmladek@suse.com> wrote:

> I find it a bit confusing that "quiet" would mean something different
> on different systems.

I disagree. "quiet" to me is for people that really don't care to see
anything from the kernel except for real issues that they need to
report. The first thing that I do, and many other kernel developers I
know, when installing a new distro, is to remove the "quiet" from the
command line. Because *I* care about the output.


> 
> Why did not you use loglevel=<whatever_you_need> instead of "quiet"?
> 
> Alternative solution would be to add "silent" or so to calm down
> everything. But I am afraid that any change in this area would
> just create a mess similar to grep -s and -q options.
> 
> 
> Best Regards,
> Petr
> 
> PS: I will not block it if Steven and Sergey are fine with this. But
> I want to be sure that they considered the above views. It looked like
> a no-brainer to me at the beginning. I even pushed this to printk.git.
> But the pushing gave me some more time to think about it...

I prefer this patch over adding yet another kernel command line command
that will just add to the confusion. I can imagine people saying
"what's the difference between 'quiet' and 'silent'?". I would.

I think having it as a config option is the perfect solution. I imagine
that as soon as Red Hat changes the meaning of "quiet" so will all the
other distros. The alternative is for the distros to add a patch to
make the change, which honestly is a worse solution.

I've only seen "quiet" added by distros and not by average developers.
I don't think adding this option will be confusing to anyone that
tinkers with kernel command lines anyway.

I'm for the patch.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


-- Steve

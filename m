Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AA4ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7614F2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7614F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeITNrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:47:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58139 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeITNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:47:25 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 07e10c98588f6ad0; Thu, 20 Sep 2018 10:05:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-next <linux-next@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input-current tree
Date:   Thu, 20 Sep 2018 10:02:24 +0200
Message-ID: <2643253.QO5Q8yoTPK@aspire.rjw.lan>
In-Reply-To: <CAKdAkRR8NH8FxfRVsB2DCiyh7QVZLisqZgd1ZgHCnGpUO6KP-g@mail.gmail.com>
References: <20180919082500.74401754@canb.auug.org.au> <CAKdAkRR8NH8FxfRVsB2DCiyh7QVZLisqZgd1ZgHCnGpUO6KP-g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 19, 2018 12:32:03 AM CEST Dmitry Torokhov wrote:
> On Tue, Sep 18, 2018 at 3:25 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Dmitry,
> >
> > After merging the input-current tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > ERROR: "mem_sleep_current" [drivers/input/serio/i8042.ko] undefined!
> >
> > Caused by commit
> >
> >   1685830e59d4 ("Input: i8042 - enable keyboard wakeups by default when s2idle is used")
> >
> > I have used the version of input-current from next-20180918 for today.
> 
> Ugh, sorry, I dropped that patch from my tree for now.
> 
> Daniel, Rafael, I guess we can't make pm_suspend_via_s2idle() static
> inline, but instead move it into kernel/power/suspend.c and make it
> EXPORT_SYMBOL().

Either that, or mem_sleep_current would need to be exported.  Sorry for
missing that.

Daniel, I prefer the wrapper to be a regular function in suspend.c.

Thanks,
Rafael


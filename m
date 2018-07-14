Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AB2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B257220897
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 20:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B257220897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeGNUgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:36:32 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55249 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeGNUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:36:31 -0400
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 52F0B40002;
        Sat, 14 Jul 2018 20:16:13 +0000 (UTC)
Date:   Sat, 14 Jul 2018 13:16:10 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
Message-ID: <20180714201610.GB17877@localhost>
References: <20180712130733.11510-1-adrian@lisas.de>
 <87sh4o5s82.fsf@xmission.com>
 <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
 <CAGXu5jJMBDd3-Yab78aYwQ1N6VG7=BjARoTF1pDygPhaWA9VNQ@mail.gmail.com>
 <87pnzpvdtd.fsf@xmission.com>
 <20180714191030.GA17877@localhost>
 <871sc5vc7n.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sc5vc7n.fsf@xmission.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 02:39:24PM -0500, Eric W. Biederman wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > On Sat, Jul 14, 2018 at 02:04:46PM -0500, Eric W. Biederman wrote:
> >> For a config option that no one has come forward with an actual real
> >> world use case for disabling, that cost seems much too high.
> >
> > The real-world use case is precisely as stated: code size, both storage
> > and RAM.
> 
> That is theoretical.

No, it isn't. I've *watched* the kernel's size trend steadily upward
over time. And it largely happens in individual features that don't
think *their* contribution to size is all that large.

> > I regularly encounter systems I'd *like* to put Linux in that have
> > around 1MB of storage and 1MB of RAM, or even less.
> 
> Yes.  There is so little code behind CONFIG_CHECKPOINT_RESTART that it
> won't help with that.

It adds up; there are hundreds more small features like it.

> But if minification is the actual requirement for disabling
> CONFIG_CHECKPOINT_RESTART than CONFIG_CHECKPIONT_RESTART is properly
> behind expert and it needs to be default y instead of default n.

I don't have any objection to *that*, as long as the option remains.

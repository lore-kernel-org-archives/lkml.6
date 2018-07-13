Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67519ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DCD205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DCD205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lisas.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGMOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:35:14 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:38712 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeGMOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:35:14 -0400
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 1203)
        id 2165C22444F9; Fri, 13 Jul 2018 16:20:22 +0200 (CEST)
Date:   Fri, 13 Jul 2018 16:20:22 +0200
From:   Adrian Reber <adrian@lisas.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Pavel Emelyanov <xemul@virtuozzo.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
Message-ID: <20180713142022.GF15300@lisas.de>
References: <20180712130733.11510-1-adrian@lisas.de>
 <87sh4o5s82.fsf@xmission.com>
 <23f87cb4-cdf5-0f9c-c7b9-a0abb228b77f@virtuozzo.com>
 <87sh4nz1se.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh4nz1se.fsf@xmission.com>
X-Url:  <http://lisas.de/~adrian/>
X-Operating-System: Linux (4.14.16-300.fc27.x86_64)
X-Load-Average: 3.86 3.62 3.58
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 08:46:25AM -0500, Eric W. Biederman wrote:
> Pavel Emelyanov <xemul@virtuozzo.com> writes:
> 
> > On 07/12/2018 07:33 PM, Eric W. Biederman wrote:
> >> 
> >> Adrian Reber <adrian@lisas.de> writes:
> >> 
> >>> The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
> >>> combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
> >>> distribution kernels and also part of the defconfigs of various
> >>> architectures.
> >>>
> >>> To make it easier for distributions to enable CHECKPOINT_RESTORE this
> >>> removes EXPERT and moves the configuration option out of the EXPERT
> >>> block.
> >> 
> >> I think we should change the help text at the same time, to match
> >> our improve understanding of the situation.
> >> 
> >> Does anyone remember why this option was added at all?
> >
> > Sure! Quoting Andrew's ~7 years ago akpm branch merge e-mail:
> >
> >    However I'm less confident than the developers that it will all
> >    eventually work! So what I'm asking them to do is to wrap each piece
> >    of new code inside CONFIG_CHECKPOINT_RESTORE.  So if it all
> >    eventually comes to tears and the project as a whole fails, it should
> >    be a simple matter to go through and delete all trace of it.
> >
> > the best link with full e-mail I googled for is
> > https://gitlab.imag.fr/kaunetem/linux-kaunetem/commit/099469502f62fbe0d7e4f0b83a2f22538367f734
> 
> Good explanation.  Thank you.
> 
> At this point we even have not CRIU users of some of the pieces.
> The project as a whole has not failed.
> 
> The code is old enough an common enough (enabled in some distros) that
> we need to do the whole watch out for regressions if we remove any part
> of it.
> 
> Which is a long way of saying the original justifiction for
> CONFIG_CHECKPOINT_RESTORE is gone.  So please let's remove the entire
> config option and simplify everyone's lives who has to test this stuff.

Sounds good.

> Unless someone can come up with a justification for keeping some of this
> behind a config option.

I can provide a patch removing CONFIG_CHECKPOINT_RESTORE if there are no
further objections against it.

		Adrian

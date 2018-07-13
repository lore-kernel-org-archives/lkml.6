Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F554ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEDB208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEDB208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeGMVL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:11:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbeGMVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:11:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F814CC2;
        Fri, 13 Jul 2018 20:55:42 +0000 (UTC)
Date:   Fri, 13 Jul 2018 13:55:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Adrian Reber <adrian@lisas.de>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] kconfig: remove EXPERT from CHECKPOINT_RESTORE
Message-Id: <20180713135541.7ada72437862c32f4563a9a8@linux-foundation.org>
In-Reply-To: <87sh4o5s82.fsf@xmission.com>
References: <20180712130733.11510-1-adrian@lisas.de>
        <87sh4o5s82.fsf@xmission.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 11:33:33 -0500 ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> Adrian Reber <adrian@lisas.de> writes:
> 
> > The CHECKPOINT_RESTORE configuration option was introduced in 2012 and
> > combined with EXPERT. CHECKPOINT_RESTORE is already enabled in many
> > distribution kernels and also part of the defconfigs of various
> > architectures.
> >
> > To make it easier for distributions to enable CHECKPOINT_RESTORE this
> > removes EXPERT and moves the configuration option out of the EXPERT
> > block.
> 
> I think we should change the help text at the same time, to match
> our improve understanding of the situation.
> 
> Does anyone remember why this option was added at all?

Because at the time it was quite unclear that the overall project would
produce a viable result.  But the code is splattered over so many
places that getting it all going out-of-tree was impractical.  So the
#ifdef CONFIG_CHECKPOINT_RESTORE markers were initially there to a)
identify places where we should go if we decide to rip the whole thing
out and to b) ensure that the kernel would still compile and work OK
after that removal.

This caution eventually proved to be unnecessary.

> Why this option was placed under expert?

Dunno.

> What is the value of disabling this functionality ever?
> 
> Is there any reason why we don't just delete CONFIG_CHECKPOINT_RESTORE
> entirely?

For the vast number of Linux machines which aren't servers?  Check out
some defconfigs - only one of arm's 119 defconfigs selects it.



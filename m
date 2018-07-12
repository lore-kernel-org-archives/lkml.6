Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11192C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B955B20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B955B20BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeGLMRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:17:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbeGLMRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:17:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531FDED1;
        Thu, 12 Jul 2018 05:08:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2BD83F5B1;
        Thu, 12 Jul 2018 05:08:23 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:08:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     dsterba@suse.cz, Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] refcount: always allow checked forms
Message-ID: <20180712120821.3qw3erubpok5csd7@lakrids.cambridge.arm.com>
References: <20180703100102.16615-1-mark.rutland@arm.com>
 <20180704084641.GL3126@suse.cz>
 <20180711054946.wdkfoou6kt2a2vml@salmiak>
 <20180711173705.j6qfye4rq3ccmdyq@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711173705.j6qfye4rq3ccmdyq@twin.jikos.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 07:37:05PM +0200, David Sterba wrote:
> On Wed, Jul 11, 2018 at 06:49:46AM +0100, Mark Rutland wrote:
> > > > Dave pointed out that it would be useful to be able to opt-in to full checks
> > > > regardless of CONFIG_REFCOUNT_FULL, so that we can simplify callsites where we
> > > > always want checks. I've spotted a few of these in code which is still awaiting
> > > > conversion.
> > > 
> > > The motivation was code like
> > > 
> > > 	WARN_ON(refcount_read(&ref));
> > > 	if (refcount_dec_and_test(&ref)) { ... }
> > > 
> > > so the warning is redundant for REFCOUNT_FULL, but I'm going to use the
> > > _checked versions everywhere the performance of refcounts is not
> > > critical.
> > 
> > If you will have conversion patches, do you want to pick this up as the start
> > of a series?
> 
> The patches where I'd use the enhanced refcounts are nice-to-have and I
> don't have an ETA so it would be better if the patch gets merged
> independently. Thanks.

Ok.

Kees, I will leave this to you.

Mark.

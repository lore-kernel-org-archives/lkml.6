Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93B620C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93B620C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbeGKRmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732492AbeGKRmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:42:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F1B3ACC3;
        Wed, 11 Jul 2018 17:37:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99B5DDAC99; Wed, 11 Jul 2018 19:37:05 +0200 (CEST)
Date:   Wed, 11 Jul 2018 19:37:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] refcount: always allow checked forms
Message-ID: <20180711173705.j6qfye4rq3ccmdyq@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20180703100102.16615-1-mark.rutland@arm.com>
 <20180704084641.GL3126@suse.cz>
 <20180711054946.wdkfoou6kt2a2vml@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711054946.wdkfoou6kt2a2vml@salmiak>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 06:49:46AM +0100, Mark Rutland wrote:
> > > Dave pointed out that it would be useful to be able to opt-in to full checks
> > > regardless of CONFIG_REFCOUNT_FULL, so that we can simplify callsites where we
> > > always want checks. I've spotted a few of these in code which is still awaiting
> > > conversion.
> > 
> > The motivation was code like
> > 
> > 	WARN_ON(refcount_read(&ref));
> > 	if (refcount_dec_and_test(&ref)) { ... }
> > 
> > so the warning is redundant for REFCOUNT_FULL, but I'm going to use the
> > _checked versions everywhere the performance of refcounts is not
> > critical.
> 
> If you will have conversion patches, do you want to pick this up as the start
> of a series?

The patches where I'd use the enhanced refcounts are nice-to-have and I
don't have an ETA so it would be better if the patch gets merged
independently. Thanks.

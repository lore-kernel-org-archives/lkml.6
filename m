Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91709C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E212081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E212081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeLJRwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:52:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeLJRwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:52:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A39DEBD;
        Mon, 10 Dec 2018 09:52:18 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07E423F6A8;
        Mon, 10 Dec 2018 09:52:16 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:52:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/atomic: change 'fold' to 'grep'
Message-ID: <20181210175211.hqw4usnzh43a4kab@lakrids.cambridge.arm.com>
References: <20181204214713.5812-1-anders.roxell@linaro.org>
 <20181206155244.GA4389@arm.com>
 <20181206161528.GA118885@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206161528.GA118885@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thu, Dec 06, 2018 at 05:15:28PM +0100, Ingo Molnar wrote:
> 
> * Will Deacon <will.deacon@arm.com> wrote:
> 
> > [+ Ingo and Mark]
> > 
> > On Tue, Dec 04, 2018 at 10:47:13PM +0100, Anders Roxell wrote:
> > > Some distibutions and build systems doesn't include 'fold' from
> > > coreutils default.
> > > 
> > > .../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found
> > > 
> > > Rework to use 'grep' instead of 'fold' to use a dependency that is
> > > already used a lot in the kernel.
> > > 
> > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > Suggested-by: Will Deacon <will.deacon@arm.com>
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > >  scripts/atomic/atomic-tbl.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
> > > index 9d6be538a987..81d5c32039dd 100755
> > > --- a/scripts/atomic/atomic-tbl.sh
> > > +++ b/scripts/atomic/atomic-tbl.sh
> > > @@ -180,7 +180,7 @@ gen_proto_variants()
> > >  #gen_proto(meta, ...)
> > >  gen_proto() {
> > >  	local meta="$1"; shift
> > > -	for m in $(echo "${meta}" | fold -w1); do
> > > +	for m in $(echo "${meta}" | grep -o .); do
> > >  		gen_proto_variants "${m}" "$@"
> > >  	done
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Ingo -- please can you take this one via -tip?
> 
> I'm still waiting for a reply to my previous concerns expressed in:
> 
>    Re: [tip:locking/core] locking/atomics: Check generated headers are up-to-date
>    <20181128083057.GA7879@gmail.com>
> 
> Will remove it from linux-next if there's no good resolution for this 
> cycle.

I've just sent a couple of patches for that; please see:

https://lkml.kernel.org/r/20181210175035.45096-1-mark.rutland@arm.com

Thanks,
Mark.

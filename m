Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8982083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfBYQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:23:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbfBYQXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:23:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D1CE308ED67;
        Mon, 25 Feb 2019 16:23:14 +0000 (UTC)
Received: from treble (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E66E05D9CC;
        Mon, 25 Feb 2019 16:23:11 +0000 (UTC)
Date:   Mon, 25 Feb 2019 10:23:10 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] objtool: Replace STACK_FRAME_NON_STANDARD annotation
Message-ID: <20190225162310.nn4z7w3zhkqxx5i3@treble>
References: <20190225124330.613028745@infradead.org>
 <20190225125232.107098740@infradead.org>
 <20190225161124.cq6c45r3wlwktyuz@treble>
 <20190225161722.GN32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225161722.GN32477@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 25 Feb 2019 16:23:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 05:17:22PM +0100, Peter Zijlstra wrote:
> > Including the file creates the section, which is a bit nasty.  Instead
> > just change STACK_FRAME_NON_STANDARD to prefix every string with a \0?
> 
> That would get us \0\0 between every string, which I suppose is in-spec,
> but weird. I figured that since it is a .discard. section, getting it
> wasn't a problem.

It would just bother me, as a power user of readelf, to see those unused
sections everywhere :-)  Maybe it's not a big deal though.

-- 
Josh

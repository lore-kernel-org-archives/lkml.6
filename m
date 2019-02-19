Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A34C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D03B20851
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfBSURQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:17:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:60547 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSURQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:17:16 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1JKG2F2030402;
        Tue, 19 Feb 2019 14:16:02 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x1JKFfcP030368;
        Tue, 19 Feb 2019 14:15:41 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 19 Feb 2019 14:15:41 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Balbir Singh <bsingharora@gmail.com>, erhard_f@mailbox.org,
        jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
Message-ID: <20190219201539.GT14180@gate.crashing.org>
References: <20190214062339.7139-1-mpe@ellerman.id.au> <20190216105511.GA31125@350D> <20190216142206.GE14180@gate.crashing.org> <20190217062333.GC31125@350D> <87ef86dd9v.fsf@concordia.ellerman.id.au> <20190217215556.GH31125@350D> <87imxhrkdt.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imxhrkdt.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:49:18AM +1100, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> > Fair enough, my point was that the compiler can help out. I'll see what
> > -Wconversion finds on my local build :)
> 
> I get about 43MB of warnings here :)

Yes, -Wconversion complains about a lot of things that are idiomatic C.
There is a reason -Wconversion is not in -Wall or -Wextra.


Segher

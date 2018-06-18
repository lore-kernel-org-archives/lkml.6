Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39572C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9AD2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9AD2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936180AbeFRTVl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:21:41 -0400
Received: from foss.arm.com ([217.140.101.70]:39708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936048AbeFRTVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:21:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99FBA80D;
        Mon, 18 Jun 2018 12:21:39 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6710A3F25D;
        Mon, 18 Jun 2018 12:21:36 -0700 (PDT)
Date:   Mon, 18 Jun 2018 20:21:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mingo@kernel.org, albert@sifive.com,
        arnd@arndb.de, benh@kernel.crashing.org, geert@linux-m68k.org,
        ink@jurassic.park.msu.ru, linux@armlinux.org.uk,
        mattst88@gmail.com, mpe@ellerman.id.au, palmer@sifive.com,
        paulus@samba.org, rth@twiddle.net, vgupta@synopsys.com
Subject: Re: [PATCHv3 00/18] atomics: API cleanups
Message-ID: <20180618192126.l7qyuthsc6eqkigb@salmiak>
References: <20180618101919.51973-1-mark.rutland@arm.com>
 <20180618163805.GE11612@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618163805.GE11612@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:38:06PM +0100, Will Deacon wrote:
> On Mon, Jun 18, 2018 at 11:19:01AM +0100, Mark Rutland wrote:
> > This series contains a few cleanups of the atomic API, fixing
> > inconsistencies between atomic_* and atomic64_*, and minimizing
> > repetition in arch code. This is nicer for arch code, and the improved
> > regularity will help when generating the atomic headers in future.
> 
> Apart from the Alpha patch:
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Cheers! I assume that also holds with patch 7 fixes up to use s64.

> I also tried to compare disassembly before/after, but the changes to
> add_unless made that quite fiddly for anything using it as a backend.
> 
> Do you plan to move arm64 over to atomic-instrumented.h at some point?

That's the plan -- there's still a way to go with the generated atomic headers
for that to work.

Thanks,
Mark.

Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21591C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA86F26390
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA86F26390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeF0DIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:08:55 -0400
Received: from ozlabs.org ([203.11.71.1]:38173 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751604AbeF0DIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:08:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41FntW2qgyz9s0n;
        Wed, 27 Jun 2018 13:08:51 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
In-Reply-To: <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
References: <cover.1528885172.git.fthain@telegraphics.com.au> <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
Date:   Wed, 27 Jun 2018 13:08:50 +1000
Message-ID: <874lhp6i4d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn, Geert,

Finn Thain <fthain@telegraphics.com.au> writes:
> On Wed, 13 Jun 2018, I wrote:
>
>> Finn Thain (12):
>>   macintosh/via-pmu: Fix section mismatch warning
>>   macintosh/via-pmu: Add missing mmio accessors
>>   macintosh/via-pmu: Don't clear shift register interrupt flag twice
>>   macintosh/via-pmu: Enhance state machine with new 'uninitialized'
>>     state
>>   macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
>>   macintosh/via-pmu: Add support for m68k PowerBooks
>>   macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps explicit
>>   macintosh/via-pmu68k: Don't load driver on unsupported hardware
>>   macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
>>   macintosh: Use common code to access RTC
>>   macintosh/via-pmu: Clean up interrupt statistics
>>   macintosh/via-pmu: Disambiguate interrupt statistics
>> 
>
> Patch 10/12 ("macintosh: Use common code to access RTC") conflicts with 
> Arnd's RTC work, but the rest of this series can still be reviewed and 
> merged as-is.

OK so you're saying we should drop 10/12 for now.

> I will rewrite patch 10/12 after Arnd's fixes and this series have all 
> made their way through both powerpc and m68k trees, and submit it 
> separately.

drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
series is high on his todo list.

Should it just go in via the m68k tree?

Or I can create a topic branch to share it between ppc and m68k?

cheers

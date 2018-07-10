Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE373C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B144E208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B144E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933854AbeGJOa0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:30:26 -0400
Received: from foss.arm.com ([217.140.101.70]:47712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933634AbeGJOaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:30:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A478680D;
        Tue, 10 Jul 2018 07:30:24 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 757D13F589;
        Tue, 10 Jul 2018 07:30:24 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 3DD991AE53F3; Tue, 10 Jul 2018 15:31:06 +0100 (BST)
Date:   Tue, 10 Jul 2018 15:31:06 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, julien.thierry@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH v5 0/7] arm64: perf: Support for chained counters
Message-ID: <20180710143105.GC9022@arm.com>
References: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Jul 10, 2018 at 09:57:57AM +0100, Suzuki K Poulose wrote:
> This series adds support for counting PMU events using 64bit counters
> for arm64 PMU.
> 
> The Arm v8 PMUv3 supports combining two adjacent 32bit counters
> (low even and hig odd counters) to count a given "event" in 64bit mode.
> This series adds the support for 64bit events in the core arm_pmu driver
> infrastructure and adds the support for armv8 64bit kernel PMU to use
> chained counters to count in 64bit mode. For CPU cycles, we use the cycle
> counter in 64bit mode, only when requested. If the cycle counter is not
> available, we fall back to chaining the counters.
> 
> Tested on Juno, Fast models. Applies on 4.18-rc4

Thanks, this looks pretty good to me. How far did you get with the perf
fuzzer?

Will

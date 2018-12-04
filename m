Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F8B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F8B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeLDOF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:05:57 -0500
Received: from foss.arm.com ([217.140.101.70]:60664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeLDOF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:05:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D4780D;
        Tue,  4 Dec 2018 06:05:56 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 337C03F59C;
        Tue,  4 Dec 2018 06:05:56 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 8C6611AE121C; Tue,  4 Dec 2018 14:06:16 +0000 (GMT)
Date:   Tue, 4 Dec 2018 14:06:16 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3] perf: tests: Disable breakpoint tests on ARM (32-bit)
Message-ID: <20181204140615.GB5837@arm.com>
References: <20181203191138.2419-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203191138.2419-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:11:36AM -0800, Florian Fainelli wrote:
> breakpoint tests on the ARM 32-bit kernel are broken in several ways.
> 
> The breakpoint length requested does not necessarily match whether the
> function address has the Thumb bit (bit 0) set or not, and this does
> matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
> background.
> 
> [1]: https://lkml.org/lkml/2018/11/15/205
> 
> As Will indicated, the overflow handling would require single-stepping
> which is not supported at the moment. Just disable those tests for the
> ARM 32-bit platforms and update the comment above to explain these
> limitations.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v3:
> 
> - directly incorporate Will's comment, Will can you add your
>   Signed-off-by?

Of course:

Co-developed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>

Will

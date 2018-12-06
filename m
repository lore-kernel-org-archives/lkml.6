Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5419C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740B320850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740B320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeLFJ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:58:08 -0500
Received: from foss.arm.com ([217.140.101.70]:43350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbeLFJ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:58:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FCDCA78;
        Thu,  6 Dec 2018 01:58:06 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DA333F5AF;
        Thu,  6 Dec 2018 01:58:06 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6267D1AE0BA8; Thu,  6 Dec 2018 09:58:27 +0000 (GMT)
Date:   Thu, 6 Dec 2018 09:58:27 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        vladimir.murzin@arm.com, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: capabilities: Merge entries for
 ARM64_WORKAROUND_CLEAN_CACHE
Message-ID: <20181206095825.GA22201@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
 <1543598286-2663-2-git-send-email-suzuki.poulose@arm.com>
 <20181205150252.GB16171@arm.com>
 <b61f749d-9d65-fb76-74b5-b999fecad42b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b61f749d-9d65-fb76-74b5-b999fecad42b@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:14:53PM +0000, Suzuki K Poulose wrote:
> On 05/12/2018 15:02, Will Deacon wrote:
> >On Fri, Nov 30, 2018 at 05:18:00PM +0000, Suzuki K Poulose wrote:
> >>diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> >>index 12f93e4d..2e26375 100644
> >>--- a/arch/arm64/include/asm/cputype.h
> >>+++ b/arch/arm64/include/asm/cputype.h
> >>@@ -151,6 +151,7 @@ struct midr_range {
> >>  		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
> >>  	}
> >>+#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
> >
> >What's the point of this macro?
> 
> That can be used to specify a set of MIDRs which has the same "variant" but a
> range of "revisions". This is used for the A53 errata and also for the Cavium
> errata in the following patch.

Gah, I read this at least 10 times and I /still/ failed to spot the extra
'v' argument to MIDR_RANGE!

Ignore my silly comment; I'll queue this up today. Thanks.

Will

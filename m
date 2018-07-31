Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E4CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C2D208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C2D208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeGaJmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:42:45 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:55332 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728750AbeGaJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:42:45 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id D6AFE1C2649
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:03:37 +0100 (IST)
Received: (qmail 19266 invoked from network); 31 Jul 2018 08:03:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.66])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 31 Jul 2018 08:03:37 -0000
Date:   Tue, 31 Jul 2018 09:03:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eero.t.tamminen@intel.com, ggherdovich@suse.cz,
        currojerez@riseup.net
Subject: Re: [PATCH] cpufreq: intel_pstate: Limit the scope of HWP dynamic
 boost platforms
Message-ID: <20180731080337.nomq6pwophsvib4s@techsingularity.net>
References: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:00:29PM -0700, Srinivas Pandruvada wrote:
> Dynamic boosting of HWP performance on IO wake showed significant
> improvement to IO workloads. This series was intended for Skylake Xeon
> platforms only and feature was enabled by default based on CPU model
> number.
> 
> But some Xeon platforms reused the Skylake desktop CPU model number. This
> caused some undesirable side effects to some graphics workloads. Since
> they are heavily IO bound, the increase in CPU performance decreased the
> power available for GPU to do its computing and hence decrease in graphics
> benchmark performance.
> 
> For example on a Skylake desktop, GpuTest benchmark showed average FPS
> reduction from 529 to 506.
> 
> This change makes sure that HWP boost feature is only enabled for Skylake
> server platforms by using ACPI FADT preferred PM Profile. If some desktop
> users wants to get benefit of boost, they can still enable boost from
> intel_pstate sysfs attribute "hwp_dynamic_boost".
> 
> Fixes: 41ab43c9c89e (cpufreq: intel_pstate: enable boost for Skylake Xeon)
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=107410
> Reported-by: Eero Tamminen <eero.t.tamminen@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs

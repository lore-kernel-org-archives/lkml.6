Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F45C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A03E2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A03E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbeKPGxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:53:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbeKPGxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3122B5A1C3;
        Thu, 15 Nov 2018 20:44:15 +0000 (UTC)
Received: from krava (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id A73EE19747;
        Thu, 15 Nov 2018 20:44:12 +0000 (UTC)
Date:   Thu, 15 Nov 2018 21:44:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/2] perf vendor events: Add stepping in CPUID string for
 x86
Message-ID: <20181115204411.GO9600@krava>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114212416.15665-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 15 Nov 2018 20:44:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 01:24:15PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf tools cannot find the proper event list for Cascadelake server.
> Because Cascadelake server and Skylake server have the same CPU model
> number, which are used by perf tools to find the event list.
> 
> The stepping for Skylake server is up to 4.
> The stepping for Cascadelake server starts from 5.
> The stepping can be used to distinguish between them.
> 
> The stepping is added in get_cpuid_str().
> The stepping information for Skylake server is updated in mapfile.csv.
> A x86 specific strcmp_cpuid_cmp() function is added to handle two CPUID
> formats in mapfile.csv, "vendor-family-model-stepping" and
> "vendor-family-model".
> - If a cpuid-regular-expression from the mapfile.csv using the new
>   stepping format, a cpuid-string generated on the machine must include
>   stepping. Otherwise, it is a mismatch.
> - If the cpuid-regular-expression using the old non-stepping format,
>   the stepping in the cpuid-string will be ignored.
> 
> The script, which using environment string "PERF_CPUID" without stepping
> on Skylake server, will be broken. If so, users must fix their scripts.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

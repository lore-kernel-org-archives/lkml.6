Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679B020857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679B020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIGIG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:06:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:32874 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeIGIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:06:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 20:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="89689902"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 20:28:11 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7B4D3300B65; Thu,  6 Sep 2018 20:28:11 -0700 (PDT)
Date:   Thu, 6 Sep 2018 20:28:11 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, kan.liang@intel.com, peterz@infradead.org,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v2 1/8] perf/x86: add a function to get the lbr stack
Message-ID: <20180907032811.GO27886@tassilo.jf.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536233456-12173-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int perf_get_lbr_stack(struct perf_lbr_stack *stack)
> +{
> +	stack->lbr_nr = x86_pmu.lbr_nr;
> +	stack->lbr_tos = x86_pmu.lbr_tos;
> +	stack->lbr_from = x86_pmu.lbr_from;
> +	stack->lbr_to = x86_pmu.lbr_to;
> +
> +	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
> +		stack->lbr_info = MSR_LBR_INFO_0;
> +	else
> +		stack->lbr_info = 0;

Seems weird to export the enum value if the enum isn't exported.
How can it be used?

-Andi

Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5120123C63
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5120123C63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934210AbeFVCgL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:36:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:47688 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933775AbeFVCgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:36:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 19:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="69034933"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2018 19:36:04 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 31D57300D7B; Thu, 21 Jun 2018 19:36:04 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 4/4] perf stat: Add transaction flag (-T) support for s390
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
        <20180621080452.61012-4-tmricht@linux.ibm.com>
Date:   Thu, 21 Jun 2018 19:36:04 -0700
In-Reply-To: <20180621080452.61012-4-tmricht@linux.ibm.com> (Thomas Richter's
        message of "Thu, 21 Jun 2018 10:04:52 +0200")
Message-ID: <87in6bsg2z.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Richter <tmricht@linux.ibm.com> writes:
>  
> +		/* Handle -T as -M transaction. Once platform specific metrics
> +		 * support has been added to the json files, all archiectures
> +		 * will use this approach.
> +		 */
> +		if (!strcmp(perf_env__arch(NULL), "s390")) {

Use pmu_have_event() instead.

You may need to add support for wildcard pmus to it.

-Andi

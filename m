Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F6EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DE3243AE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DE3243AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeFVObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:31:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:52591 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeFVObJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:31:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 07:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="scan'208";a="49748567"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2018 07:31:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id EED8C300D7B; Fri, 22 Jun 2018 07:31:08 -0700 (PDT)
Date:   Fri, 22 Jun 2018 07:31:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 4/4] perf stat: Add transaction flag (-T) support for s390
Message-ID: <20180622143108.GW30690@tassilo.jf.intel.com>
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
 <20180621080452.61012-4-tmricht@linux.ibm.com>
 <87in6bsg2z.fsf@linux.intel.com>
 <57f6e02e-a8e8-73fb-11d1-24fb6b5e2e9a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f6e02e-a8e8-73fb-11d1-24fb6b5e2e9a@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > You may need to add support for wildcard pmus to it.
> > 
> > -Andi
> > 
> 
> Currently only one PMU on s390 does support transactions, its the PMU with counters
> named cpum_cf.

Right, but you don't want to hard code that pmu into builtin-stat.

-Andi

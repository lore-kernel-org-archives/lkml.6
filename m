Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D771EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7598A21798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7598A21798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeHMVll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:41:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:40073 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeHMVll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:41:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 11:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,234,1531810800"; 
   d="scan'208";a="81006376"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2018 11:58:05 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2F933301A82; Mon, 13 Aug 2018 11:58:05 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:58:05 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC] perf/x86/intel: Export mem events only if there's PEBs
 support
Message-ID: <20180813185805.GA10097@tassilo.jf.intel.com>
References: <20180813154820.16991-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813154820.16991-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 05:48:20PM +0200, Jiri Olsa wrote:
> hi,
> we had some reports that we show mem* events on KVM servers
> where they are not available, this patch hides them if there's
> no PEBs available
> 
> currently on those servers we fail to open mem* events,
> because we can't access LDLAT msr
> 
> however that's not so easy/straight forward to check,
> so I thought we could use check on PEBs instead, which
> needs to be there for mem events as well and seems to
> be enough to check
> 
> thoughts? thanks,
> jirka

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi

Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D588C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651F52082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651F52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJXXQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:16:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:32896 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeJXXQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:16:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 07:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,420,1534834800"; 
   d="scan'208";a="94661264"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2018 07:48:18 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4F55B30137B; Wed, 24 Oct 2018 07:48:18 -0700 (PDT)
Date:   Wed, 24 Oct 2018 07:48:18 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Message-ID: <20181024144818.GF6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <2679413.U8bCfAhSQu@agathebauer>
 <20181023040356.GA6218@tassilo.jf.intel.com>
 <2086866.px82jjA6i7@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2086866.px82jjA6i7@agathebauer>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Can someone at least confirm whether unwinding from a function prologue via 
> .eh_frame (but without .debug_frame) should actually be possible?

Yes it should be possible. Asynchronous unwind tables should work
from any instruction.

-Andi

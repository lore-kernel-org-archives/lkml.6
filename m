Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D2ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9146020857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9146020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeKIBvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:51:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:63445 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbeKIBvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:51:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 08:14:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="94690639"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2018 08:14:47 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Vince Weaver <vincent.weaver@maine.edu>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: perf: perf_fuzzer triggers NULL pointer dereference
In-Reply-To: <alpine.DEB.2.21.1811081100490.7406@macbook-air>
References: <alpine.DEB.2.21.1811081041070.7406@macbook-air> <alpine.DEB.2.21.1811081100490.7406@macbook-air>
Date:   Thu, 08 Nov 2018 18:14:47 +0200
Message-ID: <87a7mj5yx4.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vince Weaver <vincent.weaver@maine.edu> writes:

> On Thu, 8 Nov 2018, Vince Weaver wrote:
>
>> [91760.326510] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
>> [91760.334876] PGD 0 P4D 0 
>> [91760.337596] Oops: 0000 [#1] SMP PTI
>> [91760.341332] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W         4.20.0-rc1+ #119
>> [91760.349816] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
>> [91760.357723] RIP: 0010:perf_prepare_sample+0x82/0x4a0
>
> so what's the best way to do the equivelent of addr2line on something like 
> this, now that we aren't allowed to know the RIP anymore?

scripts/decode_stacktrace.sh works most of the time.

Sounds like BTS needs fixing up again. Thanks for looking at it though!

Regards,
--
Alex

Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89404C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5596220849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5596220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeLKQk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:40:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:60044 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeLKQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:40:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 08:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="129012135"
Received: from wpong-mobl1.amr.corp.intel.com ([10.252.193.64])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2018 08:40:21 -0800
Message-ID: <1913c8d0be777a59d59135c067abf270b0594c63.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] tracing: Fix a couple of memory leaks in the event
 trigger code
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 11 Dec 2018 10:40:19 -0600
In-Reply-To: <20181210204126.603121253@goodmis.org>
References: <20181210204126.603121253@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2018-12-10 at 15:41 -0500, Steven Rostedt wrote:
> Tom,
> 
> While testing other changes, kmemleak pointed out a few leaks in the
> trigger code. Can you take a look at them and give me a Reviewed-by
> or Ack.
> 
> Thanks!
> 
> -- Steve
> 
> 
> Steven Rostedt (VMware) (2):
>       tracing: Fix memory leak in create_filter()
>       tracing: Fix memory leak in set_trigger_filter()
> 

Sure, these look fine to me.

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks,

Tom

> ----
>  kernel/trace/trace_events_filter.c  | 5 ++++-
>  kernel/trace/trace_events_trigger.c | 6 ++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)


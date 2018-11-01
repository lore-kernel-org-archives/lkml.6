Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA627C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837A2205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837A2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeKBBqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:46:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:22788 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKBBqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:46:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 09:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,452,1534834800"; 
   d="scan'208";a="87868864"
Received: from kohsamui.iil.intel.com (HELO [10.236.193.12]) ([10.236.193.12])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2018 09:42:21 -0700
To:     sbates@raithlin.com, danielmentz@google.com,
        mathieu.desnoyers@efficios.co
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>
From:   Alexey Skidanov <alexey.skidanov@intel.com>
Subject: lib/genalloc
Message-ID: <a170cf65-6884-3592-1de9-4c235888cc8a@intel.com>
Date:   Thu, 1 Nov 2018 18:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use gen_pool_first_fit_align() as pool allocation algorithm allocating
buffers with requested alignment. But if a chunk base address is not
aligned to the requested alignment(from some reason), the returned
address is not aligned too.

The reason is the allocation algorithm works on bitmap, omitting the
base address. Is this behavior by design?

Thanks,
Alexey

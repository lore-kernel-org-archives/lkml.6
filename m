Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8729E214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8729E214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeHBNOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:14:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:30149 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbeHBNOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:14:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 04:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,435,1526367600"; 
   d="scan'208";a="72729801"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2018 04:23:18 -0700
Message-ID: <5B62EAAC.8000505@intel.com>
Date:   Thu, 02 Aug 2018 19:27:40 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@kernel.org>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com> <1532683495-31974-3-git-send-email-wei.w.wang@intel.com> <20180730090041.GC24267@dhcp22.suse.cz> <5B619599.1000307@intel.com> <20180801113444.GK16767@dhcp22.suse.cz> <5B62DDCC.3030100@intel.com> <87d7ae45-79cb-e294-7397-0e45e2af49cd@I-love.SAKURA.ne.jp>
In-Reply-To: <87d7ae45-79cb-e294-7397-0e45e2af49cd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 07:00 PM, Tetsuo Handa wrote:
> On 2018/08/02 19:32, Wei Wang wrote:
>> On 08/01/2018 07:34 PM, Michal Hocko wrote:
>>> Do you have any numbers for how does this work in practice?
>> It works in this way: for example, we can set the parameter, balloon_pages_to_shrink,
>> to shrink 1GB memory once shrink scan is called. Now, we have a 8GB guest, and we balloon
>> out 7GB. When shrink scan is called, the balloon driver will get back 1GB memory and give
>> them back to mm, then the ballooned memory becomes 6GB.
> Since shrinker might be called concurrently (am I correct?),

Not sure about it being concurrently, but I think it would be called 
repeatedly as should_continue_reclaim() returns true.


Best,
Wei

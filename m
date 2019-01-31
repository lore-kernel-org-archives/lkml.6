Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE5C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076CE2184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfAaAGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:06:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:17898 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfAaAGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:06:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 16:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,542,1539673200"; 
   d="scan'208";a="129898688"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2019 16:06:37 -0800
To:     Waiman Long <longman@redhat.com>,
        "Wang, Kemi" <kemi.wang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "lkp@01.org" <lkp@01.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20181105050813.GP24195@shao2-debian>
 <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
 <f901e346-6203-371d-a39a-ed9231187570@suse.cz>
 <CAHk-=wjZ1C2iL79jOuC9ysvX2oRpUjoqXirvY0NRuLC0eQ8nbg@mail.gmail.com>
 <60ef3584-6f3a-1a9a-94d1-3d4a5b9f1e56@redhat.com>
 <25017BF213203E48912DB000DE5F5E1E76365678@SHSMSX101.ccr.corp.intel.com>
 <9a6fdc15-4ce1-9c55-d660-a9825b9ae104@redhat.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 dvVU867d07PlWksfYwCeYP4bs+4GSLzI1w==
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1%
 regression
Message-ID: <907779d2-09a8-47fb-4d77-c907cd716b3c@linux.intel.com>
Date:   Wed, 30 Jan 2019 16:06:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <9a6fdc15-4ce1-9c55-d660-a9825b9ae104@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/18 6:55 PM, Waiman Long wrote:
> On 12/27/2018 08:31 PM, Wang, Kemi wrote:
>> Hi, Waiman
>>    Did you post that patch? Let's see if it helps.
> 
> I did post the patch a while ago. I will need to rebase it to a new
> baseline. Will do that in a week or 2.
> 
> -Longman
> 

Waiman,

In a large scale OLTP benchmark, we are also seeing a 1% loss in performance
from patch 9bc8039e71. We'll be interested to try out your patch to
restore some optimistic spinning on reader held sem.

Thanks.

Tim

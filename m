Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF4C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB152080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB152080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeJ3Ccg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:32:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:35293 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeJ3Ccf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:32:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 10:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,441,1534834800"; 
   d="scan'208";a="245325145"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 29 Oct 2018 10:42:58 -0700
Received: from [10.251.20.185] (kliang2-mobl1.ccr.corp.intel.com [10.251.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E077658037D;
        Mon, 29 Oct 2018 10:42:57 -0700 (PDT)
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
References: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
 <20181029130331.GC21857@kernel.org>
 <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
 <20181029.104008.791032322062574758.davem@davemloft.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b488a063-276c-ab8f-954e-f68e951146b4@linux.intel.com>
Date:   Mon, 29 Oct 2018 13:42:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029.104008.791032322062574758.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2018 1:40 PM, David Miller wrote:
> From: "Liang, Kan" <kan.liang@linux.intel.com>
> Date: Mon, 29 Oct 2018 10:33:06 -0400
> 
>> I just realized that the problem in KNL will be back if we switch
>> back to non-overwrite mode.
> 
> What is KNL?
>
Intel Xeon Phi Processor, Knights Landing.

Thanks,
Kan


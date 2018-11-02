Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C862081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C862081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeKCBSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:18:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:17962 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKCBSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:18:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 09:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="270895065"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2018 09:11:07 -0700
Received: from [10.252.30.191] (abudanko-mobl.ccr.corp.intel.com [10.252.30.191])
        by linux.intel.com (Postfix) with ESMTP id AC2D5580145;
        Fri,  2 Nov 2018 09:11:04 -0700 (PDT)
Subject: Re: [PATCH v14 2/3]: perf record: enable asynchronous trace writing
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>
References: <d6bd3626-8c7c-ca12-8adf-31fe15726446@linux.intel.com>
 <32a39baa-7078-e76b-0157-e6808af4812c@linux.intel.com>
 <CAPhsuW76iDvxwqxpH3bdGGGW_5ye5eLM=R2cZsF=P5iPsuB_pQ@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <376b0d96-a3d7-d136-ef1a-0af5735d7c08@linux.intel.com>
Date:   Fri, 2 Nov 2018 19:11:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW76iDvxwqxpH3bdGGGW_5ye5eLM=R2cZsF=P5iPsuB_pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.11.2018 21:42, Song Liu wrote:
> On Sun, Oct 14, 2018 at 11:45 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
<SNIP>
>> +       if (verbose > 0)
>> +               pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>> +
> 
> nit: I guess we don't really need this pr_info()?

Diagnostic aid.

Thanks,
Alexey

> 
> Other than this,
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 

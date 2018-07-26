Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93952C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7A02083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7A02083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeGZLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:20:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:53973 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbeGZLUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:20:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 03:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,404,1526367600"; 
   d="scan'208";a="74672233"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2018 03:04:36 -0700
Message-ID: <5B599DB7.4050700@intel.com>
Date:   Thu, 26 Jul 2018 18:08:55 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dgilbert@redhat.com, Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com> <CAHp75VcFZ7jS-M6+O95XTfyg1m05UOQMVgdQb5wC-0bNWkyvMg@mail.gmail.com>
In-Reply-To: <CAHp75VcFZ7jS-M6+O95XTfyg1m05UOQMVgdQb5wC-0bNWkyvMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 04:48 PM, Andy Shevchenko wrote:
> On Thu, Jul 26, 2018 at 11:07 AM, Wei Wang <wei.w.wang@intel.com> wrote:
>> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
>> 0. This patch changes the macro to return 0 when there is no bit needs to
>> be masked.
>>
> Can you provide a practical example of what's going wrong before this
> patch applied?
>

The reason of making this patch is that I saw some other software which 
ports this function and has possibilities to fall into bugs with usages 
which pass 0 to the macro. So I wonder if it would be necessary to make 
such changes in case we would get a similar bug. Or adding something to 
explain that "0" is not applicable to this macro as a reminder to people 
who would use it.

Best,
Wei


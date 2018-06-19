Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DF2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81842075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81842075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030206AbeFSRGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:06:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:37932 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966578AbeFSRGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:06:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 10:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48295944"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.129]) ([10.24.14.129])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 10:06:39 -0700
Subject: Re: [PATCH V6 07/38] x86/intel_rdt: Initialize new resource group
 with sane defaults
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <68030110df15615d95731fd354ff7adfb0476d37.1527593970.git.reinette.chatre@intel.com>
 <44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1806191418460.1684@nanos.tec.linutronix.de>
 <fa7e3fa0-cf3b-df77-4b45-988ec3420843@intel.com>
 <alpine.DEB.2.21.1806191851520.10546@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <c97ad611-a040-f3a9-0aae-632a6f1f4dc6@intel.com>
Date:   Tue, 19 Jun 2018 10:06:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806191851520.10546@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/19/2018 9:53 AM, Thomas Gleixner wrote:
> On Tue, 19 Jun 2018, Reinette Chatre wrote:
>> On 6/19/2018 5:31 AM, Thomas Gleixner wrote:
>>> On Thu, 7 Jun 2018, Reinette Chatre wrote:
>>>> +static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
>>>> +{
>>>> +	unsigned long *val = (unsigned long *)_val;
>>>
>>> I'm a bit worried about the u32 to unsigned long case here. I know that
>>> cbm_len cannot exceed 32, but still. At least it wants a comment.
>>
>> Will do.
>>
>> I am planning to add the following to the next version.
> 
> Don't bother. I'm picking up the delta as I'm halfways through the whole
> thing by now and if there is no major update pending from your side, I'm
> going to merge it as is.

Thank you very much. I do not have anything else pending from my side at
this time.

Reinette

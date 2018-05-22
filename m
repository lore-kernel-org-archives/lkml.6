Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeEVVJu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:09:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:1541 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752717AbeEVVJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:09:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="43396067"
Subject: Re: [PATCH V4 13/38] x86/intel_rdt: Introduce "bit_usage" to display
 cache allocations details
To: Randy Dunlap <rdunlap@infradead.org>, tglx@linutronix.de,
        fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1526987654.git.reinette.chatre@intel.com>
 <ce0208727776e5a523657ce5607325fc6c33cf98.1526987654.git.reinette.chatre@intel.com>
 <06e4e2d6-aeb0-21c1-1472-47c14ff37f00@infradead.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <949cb2bb-a5b2-3287-acaf-48a0fd53df87@intel.com>
Date: Tue, 22 May 2018 14:09:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <06e4e2d6-aeb0-21c1-1472-47c14ff37f00@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 5/22/2018 2:03 PM, Randy Dunlap wrote:
> On 05/22/2018 04:29 AM, Reinette Chatre wrote:
>> With cache regions now explicitly marked as "shareable" or "exclusive"
>> we would like to communicate to the user how portions of the cache
>> are used.
>>
>> Introduce "bit_usage" that indicates for each resource
>> how portions of the cache are configured to be used.
>>
>> To assist the user to distinguish whether the sharing is from software or
>> hardware we add the following annotation:
>>
>> 0 - currently unused
>> X - currently available for sharing and used by software and hardware
>> H - currently used by hardware only but available for software use
>> S - currently used and shareable by software only
>> E - currently used exclusively by one resource group
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>  arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 79 ++++++++++++++++++++++++++++++++
>>  1 file changed, 79 insertions(+)
>>
> 
> Hi,
> 
> All occurrences of seq_puts(f, one_char_string); should instead be
> seq_putc(f, one_char);
> 
> Same for patch 14.

Thank you very much for catching this. Will do.

Reinette

Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A374BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653F620869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653F620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeJSPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:17:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:65429 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeJSPRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:17:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 00:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,399,1534834800"; 
   d="scan'208";a="83865265"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2018 00:12:34 -0700
Subject: Re: [LKP] [mm/memory.c] 6558038e45: general_protection_fault:#[##]
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
References: <20181017013600.GA16117@shao2-debian>
 <20181017152621.7e716f4906f81c52c67d59c3@linux-foundation.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <35a54261-965e-dc03-ef8e-3a44faa8846e@intel.com>
Date:   Fri, 19 Oct 2018 15:12:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181017152621.7e716f4906f81c52c67d59c3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2018 06:26 AM, Andrew Morton wrote:
> On Wed, 17 Oct 2018 09:36:00 +0800 kernel test robot <rong.a.chen@intel.com> wrote:
>
>> FYI, we noticed the following commit (built with gcc-6):
>>
>> commit: 6558038e4540a22ee4f99a5def74791189102bc0 ("mm/memory.c: recheck page table entry with page table lock held")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> in testcase: trinity
>> with following parameters:
>>
>> 	runtime: 300s
>>
>> test-description: Trinity is a linux system call fuzz tester.
>> test-url: http://codemonkey.org.uk/projects/trinity/
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu qemu64,+ssse3 -smp 4 -m 4G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> mm-recheck-page-table-entry-with-page-table-lock-held-fix.patch ("mm:
> fix the crash observed with syzkaller run") will most likely fix this.
> Was it applied during this testing?

It wasn't applied during this testing.

Best Regards,
Rong Chen

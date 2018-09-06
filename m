Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C738420857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C738420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeIFFJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:09:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:62427 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeIFFJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:09:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 17:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="86376567"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2018 17:36:35 -0700
Subject: Re: [LKP] 3f906ba236 [ 71.192813] WARNING: possible circular locking
 dependency detected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180905090553.GA6655@shao2-debian>
 <alpine.DEB.2.21.1809051459130.1416@nanos.tec.linutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <7f0deb2e-f946-75fb-8ca9-5308fd5e5a9c@intel.com>
Date:   Thu, 6 Sep 2018 08:37:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809051459130.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2018 09:02 PM, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, kernel test robot wrote:
>
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> commit 3f906ba23689a3f824424c50f3ae937c2c70f676
>> Author:     Thomas Gleixner <tglx@linutronix.de>
>> AuthorDate: Mon Jul 10 15:50:09 2017 -0700
>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Mon Jul 10 16:32:33 2017 -0700
> So it identified a more than one year old commit. Great.
>
>> vm86 returned ENOSYS, marking as inactive. 20044 iterations. [F:14867 S:5032 HI:3700] [ 57.651003] synth uevent: /module/pcmcia_core: unknown uevent action string [ 71.189062] [ 71.191953] ====================================================== [ 71.192813] WARNING: possible circular locking dependency detected [ 71.193664] 4.12.0-10480-g3f906ba #1 Not tainted [ 71.194355] ------------------------------------------------------ [ 71.195211] trinity-c0/1666 is trying to acquire lock: [ 71.195958] (mem_hotplug_lock.rw_sem){.+.+.+}, at: show_slab_objects+0x14b/0x440 [ 71.197284] [ 71.197284] but task is already holding lock:
> along with completely unparseable information. What am I supposed to do
> with this mail?
Hi,

Attached please find the dmesg/reproduce files in previous mail.
please ignore the report if it's a false positive.

Best Regards,
Rong Chen

>
> Thanks,
>
> 	tglx
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp


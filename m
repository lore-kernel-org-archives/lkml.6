Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCUFdd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 01:33:33 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39022 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751382AbeCUFd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 01:33:28 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38028661"
Subject: Re: [PATCH 1/5] x86/smpboot: Add the missing description of
 possible_cpus
To: Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <corbet@lwn.net>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <hpa@zytor.com>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-2-douly.fnst@cn.fujitsu.com>
 <20180320123712.GR4043@hirez.programming.kicks-ass.net>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f64cb207-3851-9a26-2001-653fc0068540@cn.fujitsu.com>
Date: Wed, 21 Mar 2018 13:33:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180320123712.GR4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 2B3454D0EFC9.AA8F3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

At 03/20/2018 08:37 PM, Peter Zijlstra wrote:
> On Tue, Mar 20, 2018 at 07:04:28PM +0800, Dou Liyang wrote:
> 
>> +	possible_cpus=	[s390,x86_64] Use this to set hotpluggable cpus.
>> +			This option sets possible_cpus bits in cpu_possible_map.
>> +			Thus keeping the numbers of bits set constant even if
>> +			the machine gets rebooted.
> 
> That description, esp. the last sentence, doesn't make any kind of sense
> to me. What?
> 

Ah, sure enough, I can't be lazy. :-) I stole that from the commit
   3b11ce7f542e ("x86: use possible_cpus=NUM to extend the possible cpus 
allowed")

How about:

possible_cpus=	[s390,x86_64] Set the number of possible CPUs which
		are determined by the ACPI tables MADT or mptables by
		default. possible_cpus=n : n >= 1 enforces the possible
		number to be 'n'.
		While nr_cpus is also be set: nr_cpus=m, choice the
		minimum one for the number of possible CPUs.

Thank,
	dou

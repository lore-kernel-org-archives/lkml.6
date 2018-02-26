Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBZAvv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:51:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52068 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751904AbeBZAvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:51:48 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37242722"
Subject: Re: [PATCH v3 2/2] x86/apic: Replace common tools with new ones
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>
References: <20180223075430.12395-1-douly.fnst@cn.fujitsu.com>
 <20180223075430.12395-2-douly.fnst@cn.fujitsu.com>
 <CAHp75Vf8ChDopMygXPj05+hivUtymt+i=WDOVKrB=dPt7Sp1Pw@mail.gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <6bd94039-966d-6212-2afe-92f601d87421@cn.fujitsu.com>
Date: Mon, 26 Feb 2018 08:51:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf8ChDopMygXPj05+hivUtymt+i=WDOVKrB=dPt7Sp1Pw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 1CC1148AE761.AA15C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

At 02/23/2018 08:40 PM, Andy Shevchenko wrote:
> On Fri, Feb 23, 2018 at 9:54 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>> The pending interrupt check code is old, update the following code.
>>
>>    -Replace for() with for_each_set_bit()
> 
>> -                       for (j = 31; j >= 0; j--) {
>> -                               if (value & (1<<j)) {
>> +                       for_each_set_bit(j, &value, 32) {
> 
> for_each_set_bit(), mind 'set' part, is equivalent to for-if pair...
> 
>> +                               if (j) {
> 
> ...here you just exclude bit 0 from consideration by unknown reason.
> 

Oops! my fault, will modify it.

Thanks,
	dou

>>                                          ack_APIC_irq();
>>                                          acked++;
>>                                  }
>>                          }
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeBSQqq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:46:46 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36637 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeBSQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:46:44 -0500
X-Google-Smtp-Source: AH8x224ks7zdHYqCRwzL4mnSBCR1AhIaJJc1m0aCxiNlchp5Z+uk2BEXf4oNrllUHJemisy09w4dcA==
Subject: Re: [v3,04/11] watchdog/hpwdt: white space changes
To: Jerry.Hoemann@hpe.com
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
References: <20180215234400.5022-5-jerry.hoemann@hpe.com>
 <20180217161734.GA671@roeck-us.net>
 <20180217193208.GA27788@anatevka.americas.hpqcorp.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a1e024b2-ab29-a10b-08b8-d9f184b1a63e@roeck-us.net>
Date: Mon, 19 Feb 2018 08:46:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180217193208.GA27788@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17/2018 11:32 AM, Jerry Hoemann wrote:
> On Sat, Feb 17, 2018 at 08:17:34AM -0800, Guenter Roeck wrote:
>> On Thu, Feb 15, 2018 at 04:43:53PM -0700, Jerry Hoemann wrote:
>>> Minor white space changes and some name clean up.
>>>
>>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>>> ---
>>>   MODULE_DEVICE_TABLE(pci, hpwdt_devices);
>>>   
>>> @@ -102,7 +100,7 @@ static int hpwdt_time_left(void)
>>>   	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
>>>   }
>>>   
>>> -#ifdef CONFIG_HPWDT_NMI_DECODING
>>> +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
>>>   static int hpwdt_my_nmi(void)
>>>   {
>>>   	return ioread8(hpwdt_nmistat) & 0x6;
>>> @@ -133,7 +131,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>>>   
>>>   	return NMI_HANDLED;
>>>   }
>>> -#endif /* CONFIG_HPWDT_NMI_DECODING */
>>> +#endif					/* } */
>>
>> I disagree with those changes. While I don't object to adding the '{'
>> per se, I find it very useful to have the 'CONFIG_HPWDT_NMI_DECODING'
>> with an endif to be able to associate it with the matching #ifdef.
> 
> The matching /* { */ and /* } */ allow for quickly the finding of the
> matching ifdef/endif.
> 
> In the "vim" editor, the command '%' will take one from one curly paren to its
> matching curly paren...
> 
> There is a similar sequence for emacs.
> 
This isn't about you, it is about the community.

Looking again into this patch, the only acceptable change is the copyright update.
The driver is still based on softdog. The other changes are your personal preference
only and don't fix any checkpatch issues (and even those would be arguable for
some maintainers). This means that, long term, we might get another patch from
someone else changing indentations and variable names again ... and again ...
and again. This adds no value.

Guenter

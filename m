Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeEUVgj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:36:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:44999 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754451AbeEUVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:36:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="57849084"
Subject: Re: [v4 09/11] drivers/hwmon: Add PECI cputemp driver
To: Guenter Roeck <linux@roeck-us.net>, Andrew Lunn <andrew@lunn.ch>
Cc: Jean Delvare <jdelvare@suse.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Stef van Os <stef.van.os@prodrive-technologies.com>
References: <20180521195952.28073-1-jae.hyun.yoo@linux.intel.com>
 <20180521204238.GA26471@roeck-us.net>
 <f8824489-a0d7-6a13-baab-a6fc50164b67@linux.intel.com>
 <20180521210158.GH8077@lunn.ch> <20180521210606.GC26644@roeck-us.net>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <48604cd2-90bb-b2e2-ac2e-f35b8eac1ab0@linux.intel.com>
Date: Mon, 21 May 2018 14:36:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180521210606.GC26644@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/2018 2:06 PM, Guenter Roeck wrote:
> On Mon, May 21, 2018 at 11:01:58PM +0200, Andrew Lunn wrote:
>>>>> +#if IS_ENABLED(CONFIG_X86)
>>>>> +#include <asm/intel-family.h>
>>>>> +#else
>>>>> +#define INTEL_FAM6_HASWELL_X   0x3F
>>>>> +#define INTEL_FAM6_BROADWELL_X 0x4F
>>>>> +#define INTEL_FAM6_SKYLAKE_X   0x55
>>>>> +#endif
>>>>
>>>> The entire code is very Intel specific. Why this #if instead of
>>>> making the driver dependent on X86 ?
>>>>
>>>
>>> This code will be running on ARM kernel at this moment with a purpose
>>> of monitoring remote x86 CPUs through PECI connection
>>
>> How about moving what you need from asm/intel-family.h into a header
>> file in include/linux/. Or move the entire header?
>>
> That might be another option. The one non-option is the #if IS_ENABLED()
> in the driver.
> 
> Thanks,
> Guenter
> 

Looks like only this module includes the header file like this way. So
I'm going to keep this code for now after adding a comment like Guenter
suggested. We could consider moving the header file location later if
other module also needs the header in the same way. Thanks Andrew and
Guenter!

-Jae

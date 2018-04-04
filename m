Return-Path: <martin@martingkelly.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522859500; cv=none;
        d=google.com; s=arc-20160816;
        b=QCdAJEKsnCBZoBdhSlM8JwP2/MRvA+roPM66KcpmXnz7swuuSDyGfoe8IXgKPCzrsv
         TMFsUhBe7Q2iuyXlp8UgogMLxGT/NtocEC0auQGaP4JiRXYUVxA2e35DH0YESJg634Yx
         8b0WIu+BJvRSEkOheyCKwBCvpuwUBf/BbN/rH6exWPWNr3hjIRDy15qBPBu8GoQAKAbH
         FI+SLlOo70TSRgq3KXtRURZdZV7ReJJUD4QfI9bv+Sm7Cvm+F7Nfv7s4rxZxNvF9ERxG
         DSEivnXcf8W7+LNBm9cIjTOpjV3QenCyLUj9LP5jeaMoyK/YrMaFuWkdKBJIm0IXaXlr
         xCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=iTkwI1q9bP+P2oi2w9zpx0jBWjiO1FbAlM5lqTyW/q8=;
        b=oYTuFrzHWVInS77BsPCx6w4K4RiItN2syIXTqZN6rvojVMNZy/n/m4XQ7z5v/cQWSm
         doh1VrcUDrodigeA7F2CKv3X1x3QSHLQ+5XhLMIZ/uhHH4LlC1wuykS29GyvvnpbtcQq
         de8+MGtGZfjntCp+jd728MdPVj48e8xakLw9Zev8UyovazmZJCyxJQkZTXerJ/uX9Juf
         iUCpHOIwax6juK8RCHcMMxoXPNkYA4AtrQYwIMF5eyS9Zjod20LIxGeS72BsZ4mPtu8U
         iUyMSy/0gHj2U82qw75AxIp/c+zDI3SDAvCOu2xjlhF58WHxXGK2e3hRaisB4vY7eVw3
         VfTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@martingkelly-com.20150623.gappssmtp.com header.s=20150623 header.b=u3i45uGE;
       spf=pass (google.com: domain of martin@martingkelly.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=martin@martingkelly.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@martingkelly-com.20150623.gappssmtp.com header.s=20150623 header.b=u3i45uGE;
       spf=pass (google.com: domain of martin@martingkelly.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=martin@martingkelly.com
X-Google-Smtp-Source: AIpwx49r1LgtD0JiuULPYiOWRHu80adOjuJ+sE/O364tZtAM6qxlqchPEXHgtDoO3rFAEQ4A+HwS+w==
Subject: Re: [PATCH v2] tools: fix cross-compile var clobbering
To: Jiri Slaby <jslaby@suse.cz>, linux-kbuild@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?=
 <pali.rohar@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>,
 Mario Limonciello <mario.limonciello@dell.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20180106201601.11074-1-martin@martingkelly.com>
 <20180107214028.23771-1-martin@martingkelly.com>
 <cc9e8b57-b2e0-91a5-aa9f-9488c78a9860@suse.cz>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <54661ff7-5c2a-473b-e08c-1cd267353c03@martingkelly.com>
Date: Wed, 4 Apr 2018 09:31:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cc9e8b57-b2e0-91a5-aa9f-9488c78a9860@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588971508260159741?=
X-GMAIL-MSGID: =?utf-8?q?1596833923134905483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/2018 06:20 AM, Jiri Slaby wrote:
> On 01/07/2018, 10:40 PM, Martin Kelly wrote:
>> From: Martin Kelly <martin@martingkelly.com>
> ...
>> --- a/tools/power/acpi/Makefile.config
>> +++ b/tools/power/acpi/Makefile.config
>> @@ -56,9 +56,6 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
>>   # to compile vs uClibc, that can be done here as well.
>>   CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
>>   CROSS_COMPILE ?= $(CROSS)
>> -CC = $(CROSS_COMPILE)gcc
>> -LD = $(CROSS_COMPILE)gcc
> 
> This one makes difference -- acpi is special. This used to be:
> LD = gcc
> 
> Now it is:
> LD = ld
> 
> And due to that, we get:
> ld: unrecognized option '-D_LINUX'
> 
> Should we do:
> LD = $(CC)
> 
> or fix this elsewhere differently?
> 
> thanks,
>
Yes, I think LD = $(CC) should work. $(CC) will be defaulted to 
$(CROSS_COMPILE)gcc due to the call to $(call 
allow-override,CC,$(CROSS_COMPILE)gcc) in 
tools/scripts/Makefile.include. The allow-override function will 
correctly handle env and command-line settings.

This will clobber any special $(LD) settings that the user has set, but 
that was true as well for the acpi Makefile before this patch.

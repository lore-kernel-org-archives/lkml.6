Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+2E9eQ6XGUwyYir3dT8dTWmb9MuPR3Hd7jF17IniSQqtPjOVzVQ+FiaOBqHaOzuk0djZsK
ARC-Seal: i=1; a=rsa-sha256; t=1523922514; cv=none;
        d=google.com; s=arc-20160816;
        b=g/fSVAECRJ/aqS4wG/PoLQygxpBomsecst4jm3M2VjqG2tBAmmyZ4O88ICg4IQLXxN
         2MzKBuFVGNbJH6Q+vvAqwYulj1AmAsbjhWSo5bW0k50q1Xq3Ud13rBP8gWkp2xju+Yra
         4D8wdfmxcuDEUHVobFPxWq1Ida8FGc0+4y50zNY7T1Hr0qNiB26AI6/S+eEDkwCASNkT
         X36aOxiLVsQEe/GzoCFmz7idS95lzgK/h8wYWJeLDb75/NmoAZkD4X3+nykRng/E3ggS
         CLKm//66cR86XoCE7fqB/Vtxu9ZzLNxtqhKVN1Atb7qXGpGgIFn+5dxLDrIPMxEZQyMK
         iA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=hgXxXXZVhnKQHADBdgKAYvqlw/W5Ju+YsV2FYEac33I=;
        b=I4OGWZe9RHl5ZZiUiLLp0/m8/BpRzVbT9anFQsROHlU9Y/xOqllCDrd8abJ8dkEJ3J
         NDC6qBQYb8JgHKXm+vFt2BYCupVi8YOOgt6SKXehBMxbnlCgcEbjSht/gaFXBobe3qoT
         IlXlIcuzd4gSagVMUUM/ZFlevGCwp/JT68nyTdD71qHkM770618/+Bl1eqZ+UhjXVAz0
         NGesru9EoOA0dbgHrnE+EIPSJqipRXhmPhZyC0weLrCywD2G1yAm/NTYMkbpMXJgH14X
         FfKyeYelubyPlFGL8a5ooBmZCmpTH4MGNZhXldtQ/c2I0BdHf554eU/z8+jUmvsGHArv
         /Y2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W9i7TmTu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZbOMooWa;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W9i7TmTu;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZbOMooWa;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 583E96021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 1/2] parisc: use the asm-generic version for writeX()
To: John David Anglin <dave.anglin@bell.net>, arnd@arndb.de,
 timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
 <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
 <a7b59f43-cea5-0ead-f528-61899570e353@codeaurora.org>
 <7a9d139e-978b-750d-1bac-8b27e934f781@bell.net>
 <1152a7d4-a8f4-ae68-2737-067fa05409cd@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4eea352e-07f0-3a99-c9bd-57e117288778@codeaurora.org>
Date: Mon, 16 Apr 2018 19:48:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1152a7d4-a8f4-ae68-2737-067fa05409cd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597941834039295294?=
X-GMAIL-MSGID: =?utf-8?q?1597948574680782819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 7:44 PM, Sinan Kaya wrote:
>> John David Anglin  dave.anglin@bell.net
>>
>>
>> io.log
>>
>>
>>   CC      arch/parisc/kernel/asm-offsets.s
>> In file included from ./arch/parisc/include/asm/io.h:262:0,
>>                  from ./include/linux/io.h:25,
>>                  from ./include/linux/irq.h:25,
>>                  from ./arch/parisc/include/asm/hardirq.h:13,
>>                  from ./include/linux/hardirq.h:9,
>>                  from arch/parisc/kernel/asm-offsets.c:34:
>> ./include/asm-generic/io.h:37:21: error: redefinition of '__raw_readb'
>>  #define __raw_readb __raw_readb
>>                      ^
> This one is easy to fix:
> 
> https://elixir.bootlin.com/linux/latest/source/arch/parisc/include/asm/io.h#L146
> 
> Remove 146..179.

I'll try to get a hold of a cross compiler and re-test. The above is a hack.
I need to do a better job on this.

Thanks for the help. I'll post V2 when it is ready.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

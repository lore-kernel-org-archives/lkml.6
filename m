Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeBBXG4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:06:56 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:11856 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeBBXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:06:35 -0500
X-IronPort-AV: E=Sophos;i="5.46,451,1511827200";
   d="scan'208";a="592663351"
Subject: Re: [PATCH] x86: e820: Implement a range manipulation operator
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180201231313.28458-1-jschoenh@amazon.de>
 <CAHp75Vf--xVkNoEaNRntzygQYHorbNQYhSCDVcxyLAz2PHEWEQ@mail.gmail.com>
From: "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Message-ID: <d4741079-eeda-c063-795f-60f5f1036a25@amazon.de>
Date: Sat, 3 Feb 2018 00:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf--xVkNoEaNRntzygQYHorbNQYhSCDVcxyLAz2PHEWEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 09:50 PM, Andy Shevchenko wrote:
> On Fri, Feb 2, 2018 at 1:13 AM, Jan H. Schönherr <jschoenh@amazon.de> wrote:
> 
>> +                       [KNL,ACPI] Convert memory within the specified region
>> +                       from <oldtype> to <newtype>. If "-<oldtype>" is left
>> +                       out, the whole region will be marked as <newtype>,
>> +                       even if previously unavailable. If "+<newtype>" is left
>> +                       out, matching memory will be removed. Types are
>> +                       specified as e820 types, eg, 1==RAM, 2==reserved,
>> +                       3==ACPI, 12==PRAM.
> 
> s/==/ = /g

Sure. I've also properly abbreviated that "e.g.".

>> +       } else if (*p == '%') {
>> +               enum e820_type from = 0, to = 0;
>> +
>> +               start_at = memparse(p + 1, &p);
>> +               if (*p == '-')
>> +                       from = simple_strtoull(p + 1, &p, 0);
>> +               if (*p == '+')
>> +                       to = simple_strtoull(p + 1, &p, 0);
>> +               if (*p != 0)
> 
> if (*p)
> 
> or
> 
> if (*p != '\0')
> 
> ?

Something similar to the latter is used in the function already. The latter it is.

Regards
Jan

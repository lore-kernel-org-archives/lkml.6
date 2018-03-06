Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520348101; cv=none;
        d=google.com; s=arc-20160816;
        b=YH5CGfOSD5brQvyaQ5FdAug0QsY3S1uoOdvU9N7u9z4W5EfkLtmBcUjPAlgBB9wsr1
         s2hXKUbU6H69IQ8aIXI8wRtXy/KXPz6t7AVjb9vq83M6Qb1AvXoBTs2mjRlmBn3J44ih
         kkTnFU+SstoxpqNZgTVrEaRO3LMZ/iv/DcVxX2/YJJzN1NNVH5BK8OL0TtwdSdoCOxr9
         FDR7sq3LVTv4SSk+fr2vI6yTaNlXJkxN6csq24DS/X013ihydtBkAS31KlIiYkTnzlHD
         V7/3Tyo9YtihqdIFYVe8l4T+dgOoY36PDlmGin6JVAYzePxFSAX7IYCJuNIrTSARab2j
         CRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Ow3nNislkwBRpaDLp6o+YLB+4s3o1jDyzBg/MwYrvqs=;
        b=bsaRK0vkHsRO+hIE6PHzrb9MexmGaJNRRzVOUt8cA/4vRirQYkik3RZSjmo3moEW27
         7on6KFFGGDOOxwYM4Aj8gXlRzGk+JLCSc4WCXF1qneEjRf2xDGZ1Z6WGYeiNm8AvgTPo
         WjiZ62JDXPeRzCjvzgfV5VtUt7xXtiAhZMA8+F1ZZds7ok0A3Dj1NaVl2reAYUc1/SGo
         n4OfeT6NwYAsn+FRv/Jp1+9gyMIANC6jZhZbJuvALddowbFzA5tElpzM3htrTH/Yyh5n
         zdekRsgFYpHqPTtedxRND/i1aYxHQNz2UxSElNnafe8MRNKLBlMOFgUj4QfNYrq+/z0O
         baLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BB42/afK;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BB42/afK;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELvHKxNW6FNHjtEZn8qZ8RZGiK9OPyjYtKCaijkC6tcOA6YRULWkFyGPjxwnvNVgqjLEgb7IncR1R4bkFL23W7c=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <93bd3861-6b3c-95f0-466e-e5022e0ab3d2@virtuozzo.com>
References: <20180223170325.997716448@linuxfoundation.org> <20180223170351.424191376@linuxfoundation.org>
 <1520346571.23626.5.camel@codethink.co.uk> <93bd3861-6b3c-95f0-466e-e5022e0ab3d2@virtuozzo.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 15:55:00 +0100
X-Google-Sender-Auth: st2i_7cjeWuotRInf3EmJXTzQgA
Message-ID: <CAK8P3a267Kj5i-DE6yx2yC=pkFKYHdU-AJo3FDE-EOgCKmOe7g@mail.gmail.com>
Subject: Re: [PATCH 4.4 163/193] kasan: rework Kconfig settings
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593218140126518943?=
X-GMAIL-MSGID: =?utf-8?q?1594200531418156984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 3:33 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
> On 03/06/2018 05:29 PM, Ben Hutchings wrote:
>> On Fri, 2018-02-23 at 19:26 +0100, Greg Kroah-Hartman wrote:
>>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> commit e7c52b84fb18f08ce49b6067ae6285aca79084a8 upstream.
>> [...]
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -197,7 +197,7 @@ config ENABLE_MUST_CHECK
>>>  config FRAME_WARN
>>>      int "Warn for stack frames larger than (needs gcc 4.4)"
>>>      range 0 8192
>>> -    default 0 if KASAN
>>> +    default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>>      default 1024 if !64BIT
>>>      default 2048 if 64BIT
>>>      help
>>
>> This doesn't make sense for 4.4.  There is no GCC_PLUGIN_LATENT_ENTROPY
>> in 4.4, and this line wasn't added by the upstream commit.
>>
>> I think all that was really needed in the backport was to delete the
>> 'default 0', right?
>>
>
> Yep, 'default 0 if KASAN' to be precise.

Right. I sent the correct fix for v4.9, but it must have gotten mangled
during my backport to v4.4. There difference is harmless, as the
extraneous line has no effect on v4.4, but if one of you thinks I
should send a patch to remove that line for consistency, I'll gladly
do that.

        Arnd

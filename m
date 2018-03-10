Return-Path: <kernel-hardening-return-12393-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsM2DbHUXEFBFup9sMIDfwR/misgvJioYRIyiwyYsulnRkmZHOPQ8WHW6b3TCONh9ZKGpQx
ARC-Seal: i=1; a=rsa-sha256; t=1520767148; cv=none;
        d=google.com; s=arc-20160816;
        b=WXBkboMSskW6xSGav9T7jJ/3vuVz7SyqBYLpDYxom1wMlIFcVhHm4M7gf/nv7if/TV
         VQa3xxWBXoKXP5+9bu1pGj4lwIj7FuJEoOg8GLvRYqWhNVCWEhGzzkGoA0c6NcoVLAk+
         4U7SGZTQdJGCeAvm2vTph8l8N30AkXjF4F3XuVgR2R4pe2uv8CyIkmgieHKWvpp9x0k3
         MEV1FUJPSj8Ieg0t9f8fj0mq5rcJMSySDgfYeR+vMVCjAzhR9d44Qx2y1/wLc3jb99lm
         7CXtHqycv0yoQGLca3c0jK5uVNviIx76kPG6mH6l0zdfZOSC0iZVZ4XYlpLC998NBS6C
         petg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=SEs06PooPZiHXaWeFrCBXaxACmMzQhvVJnxP0nV59yw=;
        b=QV8Vv8dRRoQdXpdk9Jcc9XUzGfVCfwQBn/5oJKF4MTDU/N/vB/eEFy8+Teool58czp
         fJ9Y9QSIH+BFNesRmcvd6iK8WfXxjeEQn3G772VJvqh3AFdE96lRKsSX3MV0r3qwa2aD
         mSvh6U6qQ7po7yOOiXOkiyAMryeAZSvaJAMCm/4JimzNco7jAWA/KYf+mVeU4VmJGeSN
         ip8Fy8w33c+FM3UxSWXkwlAc/aDbhHRsEOyCdv27k1tE6prPEo48BLMafnmPw18w3joR
         gC5XbLYiXBEvXv24FMaIrWT2qo6ZUSH1Zlz3+7yUqpbtKXwQE2Govp79jXw02OGJqiGz
         P8Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12393-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12393-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12393-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12393-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] scsi: resolve COMMAND_SIZE at compile time
To: James Bottomley <jejb@linux.vnet.ibm.com>, Stephen Kitt <steve@sk2.org>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hare@suse.com" <hare@suse.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
 <20180309223355.21222-1-steve@sk2.org> <1520635631.2907.16.camel@wdc.com>
 <20180310142930.0692200b@heffalump.sk2.org>
 <1520714957.4495.5.camel@linux.vnet.ibm.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <ef5dc446-b60f-662a-678b-786088526458@interlog.com>
Date: Sat, 10 Mar 2018 16:16:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520714957.4495.5.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501214170730131?=
X-GMAIL-MSGID: =?utf-8?q?1594639933035981843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-10 03:49 PM, James Bottomley wrote:
> On Sat, 2018-03-10 at 14:29 +0100, Stephen Kitt wrote:
>> Hi Bart,
>>
>> On Fri, 9 Mar 2018 22:47:12 +0000, Bart Van Assche <Bart.VanAssche@wd
>> c.com>
>> wrote:
>>>
>>> On Fri, 2018-03-09 at 23:33 +0100, Stephen Kitt wrote:
>>>>
>>>> +/*
>>>> + * SCSI command sizes are as follows, in bytes, for fixed size
>>>> commands,
>>>> per
>>>> + * group: 6, 10, 10, 12, 16, 12, 10, 10. The top three bits of
>>>> an opcode
>>>> + * determine its group.
>>>> + * The size table is encoded into a 32-bit value by subtracting
>>>> each
>>>> value
>>>> + * from 16, resulting in a value of 1715488362
>>>> + * (6 << 28 + 6 << 24 + 4 << 20 + 0 << 16 + 4 << 12 + 6 << 8 + 6
>>>> << 4 +
>>>> 10).
>>>> + * Command group 3 is reserved and should never be used.
>>>> + */
>>>> +#define COMMAND_SIZE(opcode) \
>>>> +	(16 - (15 & (1715488362 >> (4 * (((opcode) >> 5) &
>>>> 7)))))
>>>
>>> To me this seems hard to read and hard to verify. Could this have
>>> been
>>> written as a combination of ternary expressions, e.g. using a gcc
>>> statement
>>> expression to ensure that opcode is evaluated once?
>>
>> That’s what I’d tried initially, e.g.
>>
>> #define COMMAND_SIZE(opcode) ({ \
>> int index = ((opcode) >> 5) & 7; \
>> index == 0 ? 6 : (index == 4 ? 16 : index == 3 || index == 5 ? 12 :
>> 10); \
>> })
>>
>> But gcc still reckons that results in a VLA, defeating the initial
>> purpose of
>> the exercise.
>>
>> Does it help if I make the magic value construction clearer?
>>
>> #define SCSI_COMMAND_SIZE_TBL (	\
>> 	   (16 -  6)		\
>> 	+ ((16 - 10) <<  4)	\
>> 	+ ((16 - 10) <<  8)	\
>> 	+ ((16 - 12) << 12)	\
>> 	+ ((16 - 16) << 16)	\
>> 	+ ((16 - 12) << 20)	\
>> 	+ ((16 - 10) << 24)	\
>> 	+ ((16 - 10) << 28))
>>
>> #define COMMAND_SIZE(opcode)						
>> \
>>    (16 - (15 & (SCSI_COMMAND_SIZE_TBL >> (4 * (((opcode) >> 5) &
>> 7)))))
> 
> Couldn't we do the less clever thing of making the array a static const
> and moving it to a header?  That way the compiler should be able to
> work it out at compile time.

And maybe add a comment that as of now (SPC-5 rev 19), COMMAND_SIZE is not
valid for opcodes 0x7e and 0x7f plus everything above and including 0xc0.
The latter ones are vendor specific and are loosely constrained, probably
all even numbered lengths in the closed range: [6,260].


If the SCSI command sets want to keep up with NVMe, they may want to think
about how they can gainfully use cdb_s that are > 64 bytes long. WRITE
SCATTERED got into SBC-4 but READ GATHERED didn't, due to lack of interest.
The READ GATHERED proposed was a bidi command, but it could have been a
a simpler data-in command with a looong cdb (holding LBA, number_of_blocks
pairs).

Doug Gilbert

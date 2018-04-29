Return-Path: <kernel-hardening-return-13162-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoSjGmy2AwXVfLkz4tRq6tDT8Rl/wAtpSfhDFQypeOk3IyhceH5OFyNOAF/Eu9bd3EDWJOY
ARC-Seal: i=1; a=rsa-sha256; t=1525041613; cv=none;
        d=google.com; s=arc-20160816;
        b=YNUOpFuo1CDuBWkeJfFHy/SP0pHYoY2jWV3rSIUG9oXFFHZwNgbZ/wQq0L3TgJ0lzE
         ZEelj9tNUyyH2rxNEs2iCVY7t3soArZ4YkGFrh4S4InsyRAFUiFXlUIhlnRoMOYDWzXi
         pwUcrG1T0zsYO44mVE+f+ArzlYt8VWZRgXR1uzAkT7Sf0D7UkByf5uyoXEDwON4YYIwk
         50kXIJfXxq3cAGt5/nC6VRtEZK4wTaP8A1xYnVJVBN3XQ87f3i7rV3NDbD41KCMZucXf
         nf0KhiA0bN3Mq3jT0t5xfedJxBOkoSVbDKQeESi5zqh+MAE2Peg+qawuPd6BMqSYkPZJ
         MYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=cU8p0pcOjP1X5WD1GpJD/HVPO4IUUaZmRnCwAaGVAB8=;
        b=YJ1tJLwBNAhRT+e+/j6jsS4MGooOME6EP7PgZEDQ9fQf94Zl9I1u8rlR1ycL7qglBx
         6PsVWbOyD9APU8ApOqRIgyOcMsJejDVKFn1xiAd+plrfVnud1vr0fo1x0uZkbddmcJHs
         LTSP46lS/bmm/4PtbuCSfmP5smiSz6C5Nt6Xocxpb9/mt4VYkK9hDq7qjsXiNjVlSwz3
         p5FIbseTovPsPj3YI1yVwiZ8xuytk6454T7RB/evmGYUo3M730h+62/Pz9zTGE1EEpxv
         1c1u2BxfzRbeVxLsgascwgKq1bXrCtEs9r4UbbdhvhI2zuYNICgvYaKbYuSNX93/ory+
         V8AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rd0hucCV;
       spf=pass (google.com: domain of kernel-hardening-return-13162-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13162-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rd0hucCV;
       spf=pass (google.com: domain of kernel-hardening-return-13162-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13162-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/3] genalloc: selftest
To: Randy Dunlap <rdunlap@infradead.org>, mhocko@kernel.org,
 akpm@linux-foundation.org, keescook@chromium.org, linux-mm@kvack.org,
 kernel-hardening@lists.openwall.com, linux-security-module@vger.kernel.org
Cc: willy@infradead.org, labbott@redhat.com, linux-kernel@vger.kernel.org,
 igor.stoppa@huawei.com
References: <20180429024542.19475-1-igor.stoppa@huawei.com>
 <20180429024542.19475-4-igor.stoppa@huawei.com>
 <01ec5680-b1de-5473-f32b-89729d9fcc70@infradead.org>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <649d5e8a-6a5a-01c0-d261-c303cf8137fb@gmail.com>
Date: Mon, 30 Apr 2018 02:39:53 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <01ec5680-b1de-5473-f32b-89729d9fcc70@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599046957115635253?=
X-GMAIL-MSGID: =?utf-8?q?1599122034194898183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 29/04/18 07:36, Randy Dunlap wrote:
> On 04/28/2018 07:45 PM, Igor Stoppa wrote:

[...]

>> +	test_genalloc();
> 
> Is there a stub for test_genalloc() when its config option is not enabled?
> I don't see it.

I failed to add to the patch include/linux/test_genalloc.h :-/
That's where the stub is hiding.

>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 09565d779324..2bf89af50728 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -303,6 +303,21 @@ config DECOMPRESS_LZ4
>>   config GENERIC_ALLOCATOR
>>   	bool
>>   
> 
> These TEST_ kconfig symbols should be in lib/Kconfig.debug, not lib/Kconfig.

ok, I will fix it

>> +config TEST_GENERIC_ALLOCATOR
>> +	bool "genalloc tester"
>> +	default n
>> +	select GENERIC_ALLOCATOR
> 
> This should depend on GENERIC_ALLOCATOR, not select it.
> 
> See TEST_PARMAN, TEST_BPF, TEST_FIRMWARE, TEST_SYSCTL, TEST_DEBUG_VIRTUAL
> in lib/Kconfig.debug.

I was actually wondering about this.
The dependency I came up with allows to perform the test even if nothing 
is selecting genalloc, but ok, if this is how it is done, I'll adjust to 
it.

>> +	help
>> +	  Enable automated testing of the generic allocator.
>> +	  The testing is primarily for the tracking of allocated space.
>> +
>> +config TEST_GENERIC_ALLOCATOR_VERBOSE
>> +	bool "make the genalloc tester more verbose"
>> +	default n
>> +	select TEST_GENERIC_ALLOCATOR
> 
> 	depends on TEST_GENERIC_ALLOCATOR

ok

[...]

>> + * guarranteed; allowing the boot to continue means risking to corrupt
> 
>        guaranteed;

hmmm

--

thanks, igor

Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0556FF83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968AC20893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mmTZ6kJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968AC20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeG2JId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 05:08:33 -0400
Received: from m12-14.163.com ([220.181.12.14]:56889 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbeG2JId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 05:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=kmzQA
        dLZX9IiIFHVFzD73Tm3wj0vUOManPHQUekbSeA=; b=mmTZ6kJcxzdeShDxAqtjK
        4i/6B0qqV7pPVwWy+p0oU6p2mYgAixoMuKOcwtGVvVJsv/dWUJSYu8nj/TCbJe8v
        526fW7MslqYZ8pOFudlgtk1VyvS2wHxlGQU2JLsAujQr/AW/plBub51F56VXrGDj
        IomhqqocqEsywQwPsVGXfo=
Received: from [192.168.0.103] (unknown [223.73.7.176])
        by smtp10 (Coremail) with SMTP id DsCowABHHsPIbl1bCa88Lg--.19356S3;
        Sun, 29 Jul 2018 15:37:47 +0800 (CST)
Subject: Re: [PATCH 1/1] lib: use sunday algorithm to do strstr() and
 strnstr()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
References: <20180722173715.25327-1-zengzhaoxiu@163.com>
 <20180722183706.GA7979@kroah.com>
 <9b18802b-a451-eb81-3317-1de406f03118@163.com>
 <6dc928cd-adbb-0304-1308-fb556d48698d@163.com>
 <CAHp75Vd2Lu110om-hPE2bx_XFa0zpNHHC4RC_uLsTBSywJO2KQ@mail.gmail.com>
 <6b33eb08-b7f8-0104-4fe0-1c0f4cd5edfc@163.com>
 <20180728143838.GC3681@kroah.com>
From:   Zhaoxiu Zeng <zengzhaoxiu@163.com>
Message-ID: <0e26f061-484b-b6c9-41c1-77de97e1c662@163.com>
Date:   Sun, 29 Jul 2018 15:37:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180728143838.GC3681@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABHHsPIbl1bCa88Lg--.19356S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFy3JrW7Jr1kuF47ur1DAwb_yoWxCr4kpF
        WkCa4Sqws8t34ayrn2yr1xWw40k393Ary8Xry8trsrA3Z0qFs5Kr45KF4Y9F4fW34kur1I
        vr4Fq34avF4UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiuc_UUUUU=
X-Originating-IP: [223.73.7.176]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbivwuSgFWBeUjERQAAsC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018/7/28 22:38, Greg Kroah-Hartman 写道:
> On Sat, Jul 28, 2018 at 10:02:51PM +0800, Zhaoxiu Zeng wrote:
>> 在 2018/7/27 18:39, Andy Shevchenko 写道:
>>> On Fri, Jul 27, 2018 at 8:48 AM, Zhaoxiu Zeng <zengzhaoxiu@163.com> wrote:
>>>> 在 2018/7/27 1:17, Zhaoxiu Zeng 写道:
>>>>> 在 2018/7/23 2:37, Greg Kroah-Hartman 写道:
>>>>>> On Mon, Jul 23, 2018 at 01:37:15AM +0800, Zhaoxiu Zeng wrote:
>>>
>>>>>>> The Sunday algorithm is a variation of Boyer-Moore algorithm, it is easy and fast.
>>>>>>> For the Sunday algorithm, to see
>>>>>>>     http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.htm
>>>>>>
>>>>>> So you say, but what does this really buy us?  Why make this change?
>>>>>> How was it tested?  What is the downside of not taking this?
>>>
>>>>> I use the following program to test on fc28.
>>>>> Compile with O2, the new version is almost 2X faster than the original.
>>>
>>>>> The code size of the original is 0x80, the newer is 0xB0.
>>>
>>> So, output of bloat-o-meter would be good to have in commit message.
>>>
>>>>> The test result:
>>>
>>> Compact performance statistics as well.
>>>
>>>>> Thanks!
>>>
>>>> The original strnstr might has a bug too!
>>>> For example, assume s1 is "123\0abc...." and s2 is "abc\0",
>>>> call strnstr(s1, s2, 7) will return &s1[4], but the correct result is NULL.
>>>
>>> If there is a bug, send another patch to fix the bug first.
>>>
>>
>> The bug could be fixed by this patch.
> 
> Given that there doesn't seem to be a good reason to take your patch
> yet, that might be hard :)
> 
> You need to convince us that the patch is a valid thing to accept, by
> writing a correct changelog and showing proof of its correctness as this
> is modifying a core function in the kernel.
> 
> thanks,
> 
> greg k-h
> 

Thanks for responses!
I wrote a new changelog as described below. If it's ok, I will commit a new patch.
The details are as follow:


The Sunday algorithm is a variation of Boyer-Moore algorithm, it is easy and fast.
For the Sunday algorithm, to see
	http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/sundayen.htm

The new strstr implementation steps:
	1) Gets the pattern length, and is denoted as l2.
	2) Compares the first l2 bytes of the text with the pattern.
	   If the comparison has matched, returns the pointer to starting of the text.
	   Else, gets the index of the symbol which causes a mismatch, and is denoted as i.
	3) Scans the text from index i to l2, to test whether the text is terminated.
	   If the text is terminated early, returns NULL.
	   Else, gets the symbol at index l2, and is denoted K.
	4) Finds the index of K's last presence in the pattern, and is denoted as j.
           If there is no occurence of K in the pattern, j is -1.
	5) Shifts the text window "l2 - j" bytes, and repeats step 2.

The original strstr scans the text two times. The 1st time gets the text length,
the 2nd time does the matches. The new strstr scans the text only one time.

The original strnstr has a bug. If the text length is smaller than the argument "len",
it maybe returns a wrong result. The bug could be fixed by this patch too.

I have tested using the following program on fc28.x86_64.
When compile with O2, the new version is almost 2X faster than the original,
the code size of the original strstr is 0x80 and the newer is 0xB0.


#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

/**
 * strstr - Find the first substring in a %NUL terminated string
 * @s1: The string to be searched
 * @s2: The string to search for
 */
char *strstr1(const char *s1, const char *s2)
{
	size_t l1, l2;

	l2 = strlen(s2);
	if (!l2)
		return (char *)s1;
	l1 = strlen(s1);
	while (l1 >= l2) {
		l1--;
		if (!memcmp(s1, s2, l2))
			return (char *)s1;
		s1++;
	}
	return NULL;
}

char *strstr2(const char *s1, const char *s2)
{
	size_t l2;
	const char *pchk = s1;

#if 1//def __HAVE_ARCH_STRLEN
	l2 = strlen(s2);
#else
	for (l2 = 0; s2[l2] != 0; l2++)
		/* nothing */;
#endif
	if (!l2)
		return (char *)s1;

	/*
	 * Sunday matching
	 */
	while (1) {
		size_t i;
		char k;

		/* compare */
		for (i = 0; i < l2; i++) {
			if (s1[i] != s2[i])
				break;
		}
		if (i >= l2)
			return (char *)s1;

		/* if s1 terminate early? */
		if (pchk < s1 + i)
			pchk = s1 + i;
		do {
			k = *pchk;
			if (k == 0)
				return NULL;
		} while (pchk++ != s1 + l2);

		/* find the k's last presence in s2 (k = s1[l2]) */
		for (i = l2; --i != (size_t)-1; ) {
			if (k == s2[i])
				break;
		}

		/* shift */
		s1 += l2 - i;
	}
}

#ifdef __i386__
#  define RDTSC_CLOBBER "%eax", "%ebx", "%ecx", "%edx"
#elif __x86_64__
#  define RDTSC_CLOBBER "%rax", "%rbx", "%rcx", "%rdx"
#else
# error unknown platform
#endif

#define RDTSC_START(cycles)                                \
    do {                                                   \
        register unsigned cyc_high, cyc_low;               \
        asm volatile("CPUID\n\t"                           \
                     "RDTSC\n\t"                           \
                     "mov %%edx, %0\n\t"                   \
                     "mov %%eax, %1\n\t"                   \
                     : "=r" (cyc_high), "=r" (cyc_low)     \
                     :: RDTSC_CLOBBER);                    \
        (cycles) = ((uint64_t)cyc_high << 32) | cyc_low;   \
    } while (0)

#define RDTSC_STOP(cycles)                                 \
    do {                                                   \
        register unsigned cyc_high, cyc_low;               \
        asm volatile("RDTSCP\n\t"                          \
                     "mov %%edx, %0\n\t"                   \
                     "mov %%eax, %1\n\t"                   \
                     "CPUID\n\t"                           \
                     : "=r" (cyc_high), "=r" (cyc_low)     \
                     :: RDTSC_CLOBBER);                    \
        (cycles) = ((uint64_t)cyc_high << 32) | cyc_low;   \
    } while (0)

typedef unsigned long long TIME_T;
#define start_time(start)		RDTSC_START(start)
#define stop_time(stop)			RDTSC_STOP(stop)
#define diff_time(start, stop)	(stop - start)

#define MAX_HAYSTACK_LENGTH 64
#define MAX_NEEDLE_LENGTH 16
#define TEST_LOOPS 1000

char haystack[MAX_HAYSTACK_LENGTH + 1];
char needle[MAX_NEEDLE_LENGTH + 1];

int main(int argc, char **argv)
{
    size_t i, j, n;
    void *p1, *p2;

    srand(time(0));

    for (i = 0; i < MAX_HAYSTACK_LENGTH; ) {
        haystack[i] = rand();
        if (haystack[i] != 0)
            i++;
    }
    haystack[i] = 0;

    for (i = 0; i < MAX_HAYSTACK_LENGTH; i++) {
        TIME_T start, stop;
        unsigned long long elapsed1, elapsed2;

        j = rand() % MAX_NEEDLE_LENGTH;
        if (i <= MAX_HAYSTACK_LENGTH - (MAX_NEEDLE_LENGTH - j))
            n = i;
        else
            n = MAX_HAYSTACK_LENGTH - (MAX_NEEDLE_LENGTH - j);
        memcpy(needle + j, haystack + n, MAX_NEEDLE_LENGTH - j);
        needle[MAX_NEEDLE_LENGTH] = 0;

        elapsed1 = ~0UL;
        for (n = 0; n < TEST_LOOPS; n++) {
            start_time(start);
            asm volatile("":::"memory");
            p1 = strstr1(haystack, needle + j);
            asm volatile("":::"memory");
            stop_time(stop);

            if (elapsed1 > diff_time(start, stop))
                elapsed1 = diff_time(start, stop);
        }

        elapsed2 = ~0UL;
        for (n = 0; n < TEST_LOOPS; n++) {
            start_time(start);
            asm volatile("":::"memory");
            p2 = strstr2(haystack, needle + j);
            asm volatile("":::"memory");
            stop_time(stop);

            if (elapsed2 > diff_time(start, stop))
                elapsed2 = diff_time(start, stop);
        }

        if (p1 != p2)
            fprintf(stderr, "Error: %p != %p\n", p1, p2);
        else
            fprintf(stdout, "%3d, %3d:\t%lld,\t%lld\n", i, j, elapsed1, elapsed2);
    }

    return 0;
}


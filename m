Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D97C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126E020866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126E020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeKKXY5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:24:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:57637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeKKXY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:24:57 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MYg42-1g0PHy24Ys-00VOo1; Sun, 11
 Nov 2018 14:36:12 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: crashkernel=512M is no longer working on this aarch64 server
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <20181111123553.3a35a15c@mschwideX1>
Date:   Sun, 11 Nov 2018 08:36:09 -0500
Cc:     linux kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <77E3BE32-F509-43B3-8C5F-252416C04B7C@gmx.us>
References: <1A7E2E89-34DB-41A0-BBA2-323073A7E298@gmx.us>
 <20181111123553.3a35a15c@mschwideX1>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:wHzD+jcGGx4cz+LdvtO3mX3LRe5RR7+FuHSJ2ZOodndobH+M//f
 fs4eTCWNQiP8xDBldBBIpXk06mvExyxyeB69CZ0vim99g8NPkxaqY5x7FyS2zAjUhoPSP91
 d3Yp4uaHaE330VMFzO/9CroXJIBkF0w4lPs8zglDkGiJlONJfWEZuNE9h4lhPRSF8iiYdGQ
 y0EhOHTx/1mofN9tY2K4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FZmwPqAQ5cc=:e8plgWwOeo3o3mhW2F5SDG
 x04KFjCNmPcUGP4vg8kuMWD4MUvinMZlhgM66JEMr7Km8dTXDHiEgIEWhW57VeIxei5LrNTlr
 eRkWMU/KTvrnQv7i6qkIhmmSjqXmENLjmbFOK0LdMPoOM+3yNC54yD6OIAJahgpGuYYPPg3xS
 5dyJIE83URi+v4Q89cjbbX6MAEpL+ah4UEDEKnKBEhyOpyq1Jy3CeUJxLMfCUqkffj8ZxPCtv
 suW1NtDH4Ny7IG9TXU/w48c3nXfZj0tjkd7n08ycgirmTyxrpm94HTaNuqw5JhwpEDt0yehym
 jUoSVHdmpHfm51LLVuu2mExFm0cwXgq7GYHcY22J9gs1xIOMVRaHS1fGJ8a8/cxUvPV/mfHK9
 rgmyuZmlOECVRzRADPISGZiAGiAgXD6NKY2vSbsp6bveoehyfCdAKUhYDHkN3asadHO9oq32m
 UqAQm3YANbVlEFpbY6JANredzmNGbNnOVjYs81Z7Pr1QcQd0EuNoVn8e+1jN/4t4JIw/NgKlU
 xBAAJUVwfu0y1y/NIuVdiohBtVIAk3Ikr5XeH1TovwG0NFNEssU21A0/bTHpXOgwO6ORHsw9X
 +woMINZzgcNphCZu05TNDQaNHFvbF2x5nz2YtAQVA212/G50sHAdmKV0c4CVLlRIaHcDHiNzl
 tPlk9UoP1hs2uIpFE15C61E1xad88vqagAYSMWHSoys8zBuZJ6ImAIRcZG58+3AQCIet/zuwK
 57AwMQyOSotVIKTDbEj2u1fchvaEQUu68Ce1v+pN5N0Y+/SSrf7hVf00lPEV1iQFVdP8OiYCx
 KQQUm3LSmGJnYav60dT0W8vFNSleu6/QyXIfaLn/9yKfG7GCJmPaPcw5vx+Ibeg8MkCeDfowl
 anx4DfaEVcXbjFNRRBHC1v0zukpeFhETXn6obcc+nPsoBlNQtCIeO8JSd5l9aH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 11, 2018, at 6:35 AM, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> On Sat, 10 Nov 2018 23:41:34 -0500
> Qian Cai <cai@gmx.us> wrote:
> 
>> It was broken somewhere between b00d209241ff and 3541833fd1f2.
>> 
>> [    0.000000] cannot allocate crashkernel (size:0x20000000)
>> 
>> Where a good one looks like this,
>> 
>> [    0.000000] crashkernel reserved: 0x0000000008600000 - 0x0000000028600000 (512 MB)
>> 
>> Some commits look more suspicious than others.
>> 
>>      mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
>>      mm: introduce mm_[p4d|pud|pmd]_folded
>>      mm: make the __PAGETABLE_PxD_FOLDED defines non-empty
> 
> The intent of these three patches is to add extra checks to the
> pgtable_bytes accounting function. If applied incorrectly the expected
> result would be warnings like this:
>  BUG: non-zero pgtables_bytes on freeing mm: 16384
> 
> The change Linus worried about affects the __PAGETABLE_PxD_FOLDED defines.
> These defines are used with #ifdef, #ifndef, and __is_defined() for the
> new mm_p?d_folded() macros. I can not see how this would make a difference
> for your iomem setup.
> 
>> # diff -u ../iomem.good.txt ../iomem.bad.txt 
>> --- ../iomem.good.txt	2018-11-10 22:28:20.092614398 -0500
>> +++ ../iomem.bad.txt	2018-11-10 20:39:54.930294479 -0500
>> @@ -1,9 +1,8 @@
>> 00000000-3965ffff : System RAM
>>   00080000-018cffff : Kernel code
>> -  018d0000-020affff : reserved
>> -  020b0000-045affff : Kernel data
>> -  08600000-285fffff : Crash kernel
>> -  28730000-2d5affff : reserved
>> +  018d0000-0762ffff : reserved
>> +  07630000-09b2ffff : Kernel data
>> +  231b0000-2802ffff : reserved
>>   30ec0000-30ecffff : reserved
>>   35660000-3965ffff : reserved
>> 39660000-396fffff : reserved
>> @@ -127,7 +126,7 @@
>>   7c5200000-7c520ffff : 0004:48:00.0
>> 1040000000-17fbffffff : System RAM
>>   13fbfd0000-13fdfdffff : reserved
>> -  16fba80000-17fbfdffff : reserved
>> +  16fafd0000-17fbfdffff : reserved
>>   17fbfe0000-17fbffffff : reserved
>> 1800000000-1ffbffffff : System RAM
>>   1bfbff0000-1bfdfeffff : reserved
> 
> The easiest way to verify if the three commits have something to do with your
> problem is to revert them and run your test. Can you do that please ?
Yes, you are right. Those commits have nothing to do with the problem. I should
realized it earlier as those are virtual memory vs physical memory. Sorry for the
nosie.

It turned out I made a wrong assumption that if kmemleak is disabled by default,
there should be no memory reserved for kmemleak at all which is not the case.

CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=600000
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y

Even without kmemleak=on in the kernel cmdline, it still reserve early log memory
which causes not enough memory for crashkernel.

Since there seems no way to turn kmemleak on later after boot, is there any
reasons for the current behavior? 

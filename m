Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C247AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C420852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3C420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeGYFR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:17:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeGYFR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:17:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B78BFAC4F;
        Wed, 25 Jul 2018 04:08:08 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] lib/test_crc: Add test cases for crc calculation
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Noah Massey <noah.massey@gmail.com>
References: <20180718165545.1622-1-colyli@suse.de>
 <20180718165545.1622-4-colyli@suse.de>
 <20180724044420.GB1944@sol.localdomain>
 <2feeece1-6d92-aa08-c9b6-1b0c646eed29@suse.de>
 <20180724173930.GA194165@gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fa19dc99-30de-98e5-eea2-804ad0466e34@suse.de>
Date:   Wed, 25 Jul 2018 12:07:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724173930.GA194165@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/25 1:39 AM, Eric Biggers wrote:
> On Wed, Jul 25, 2018 at 12:28:15AM +0800, Coly Li wrote:
>> On 2018/7/24 12:44 PM, Eric Biggers wrote:
>>> On Thu, Jul 19, 2018 at 12:55:45AM +0800, Coly Li wrote:
>>>> This patch adds a kernel module to test the consistency of multiple crc
>>>> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
>>>>
>>>> The test results are printed into kernel message, which look like,
>>>>
>>>> test_crc: crc64_be: FAILED (0x03d4d0d85685d9a1, expected 0x3d4d0d85685d9a1f)
>>>>
>>>> kernel 0day system has framework to check kernel message, then the above
>>>> result can be handled by 0day system. If crc calculation inconsistency
>>>> happens, it can be detected quite soon.
>>>>
>>>> lib/test_crc.c is a testing frame work for many crc consistency
>>>> testings. For now, there is only one test caes for crc64_be().
>>>
>>> Are you aware there's already a CRC-32 test module: CONFIG_CRC32_SELFTEST and
>>> lib/crc32test.c?  Confusingly, your patch uses a different naming convention for
>>> the new CRC-64 one, and puts the Kconfig option in a different place, and makes
>>> it sound like it's a generic test for all CRC implementations rather than just
>>> the CRC-64 one.  Please use the existing convention (i.e. add
>>> CONFIG_CRC64_SELFTEST and lib/crc64test.c) unless you have a strong argument for
>>> why it should be done differently.
>>>
>>> (And I don't think it makes sense to combine all CRC tests into one module,
>>> since you should be able to e.g. enable just CRC32 and CRC32_SELFTEST without
>>> also pulling in a dependency on all the other CRC variants.)
>>>
>>
>> Hi Eric,
>>
>> The purpose of test_crc is to provide a unified crc calculation
>> consistency testing for 0day. So far it is only crc64, and I will add
>> more test cases later. I see there is crc-32 test module, which does
>> more testing then consistency check, and no unified format for 0day
>> system to detect. This is why people suggested me to add this test
>> framework.
>>
> 
> Actually the code in crc32test is nearly the same as what you're adding for
> CRC-64.  The CRC-32 test is longer because it's testing two different
> polynomials "crc32" and "crc32c" as well as combining CRC's; neither of those is
> relevant for CRC-64 yet, as you've implemented just one polynomial and there is
> no function provided to combine CRC64's yet.  The CRC-32 test also tests
> performance, but if you don't believe CRC performance should be tested, then you
> should remove the performance test from the existing module rather than
> implementing a brand new test module just to remove the performance test...
> 
> I still don't understand why you decided to do things differently for CRC-64,
> when there were already CRC-32 tests that used a certain convention for the
> Kconfig option, filename, etc.  It's inconsistent and confusing.  Again, please
> use the existing convention unless you have a strong argument for why it should
> be done differently.  (And if you do want to do things differently, the existing
> test should be converted first.)

Hi Eric,

So far only crc32 has selftesting code, it is hardly to be a convention
IMHO. Anyway, considerate your comments and suggestion, I feel crc_test
can be a separate patch from this series.

Later I will post another series, which unify all crc test together into
test_crc, including other crc calculations which don't have their
testing code.

Thanks.

Coly Li


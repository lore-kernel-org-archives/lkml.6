Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B38ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B6F20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B6F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeGXRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:36:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:42264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388350AbeGXRg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:36:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B646AFBD;
        Tue, 24 Jul 2018 16:29:40 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] lib: add crc64 calculation routines
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20180718165545.1622-1-colyli@suse.de>
 <20180718165545.1622-2-colyli@suse.de>
 <20180724042637.GA1944@sol.localdomain>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dd95ab25-562e-1318-19e9-c8163969252f@suse.de>
Date:   Wed, 25 Jul 2018 00:29:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724042637.GA1944@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/24 12:26 PM, Eric Biggers wrote:
> On Thu, Jul 19, 2018 at 12:55:43AM +0800, Coly Li wrote:
>> This patch adds the re-write crc64 calculation routines for Linux kernel.
>> The CRC64 polynomical arithmetic follows ECMA-182 specification, inspired
> 
> "polynomical" => "polynomial".  Same everywhere else in the patches.
> 

Hi Eric,

Thanks for your careful review. I will post a fixing patch to fix all
these issues.

Coly Li

>> + * crc64table[256] is the lookup table of a table-driver 64-bit CRC
> 
> "table-driver" => "table-driven"
> 
>> + * calculation, which is generated by gen_crc64table.c in kernel build
>> + * time. The polynomial of crc64 arithmetic is from ECMA-182 specification
>> + * as well, which is defined as,
>> + *
>> + * x^64 + x^62 + x^57 + x^55 + x^54 + x^53 + x^52 + x^47 + x^46 + x^45 +
>> + * x^40 + x^39 + x^38 + x^37 + x^35 + x^33 + x^32 + x^31 + x^29 + x^27 +
>> + * x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
>> + * x^7 + x^4 + x + 1
>> + *
>> + * Copyright 2018 SUSE Linux.
>> + *   Author: Coly Li <colyli@suse.de>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +#include "crc64table.h"
>> +
>> +MODULE_DESCRIPTION("CRC64 calculations");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +/**
>> + * crc64_be - Calculate bitwise big-endian ECMA-182 CRC64
>> + * @crc: seed value for computation. 0 for a new CRC computing, or the
>> + *	previous crc64 value if computing incrementally.
> 
> "0 or (u64)~0 for a new CRC calculation".  Both conventions are common in CRCs.
> In fact the all-ones convention is generally considered better, because it
> causes leading zeroes in the data to affect the checksum.
> 
>> + * @p: pointer to buffer over which CRC64 is run
>> + * @len: length of buffer @p
>> + */
>> +u64 __pure crc64_be(u64 crc, const void *p, size_t len)
>> +{
>> +	size_t i, t;
>> +
>> +	const unsigned char *_p = p;
>> +
>> +	for (i = 0; i < len; i++) {
>> +		t = ((crc >> 56) ^ (*_p++)) & 0xFF;
>> +		crc = crc64table[t] ^ (crc << 8);
>> +	}
>> +
>> +	return crc;
>> +}
>> +EXPORT_SYMBOL_GPL(crc64_be);
>> diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
>> new file mode 100644
>> index 000000000000..8296b0c3ea30
>> --- /dev/null
>> +++ b/lib/gen_crc64table.c
>> @@ -0,0 +1,68 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Generate lookup table for the talbe-driven CRC64 calculation.
> 
> "talbe-driven" => "table-driven"
> 
>> + *
>> + * gen_crc64table is executed in kernel build time and generates
>> + * lib/crc64table.h. This header is included by lib/crc64.c for
>> + * the table-driver CRC64 calculation.
> 
> "table-driver" => "table-driven"
> 
>> + *
>> + * See lib/crc64.c for more information about which specification
>> + * and polynomical arithmetic that gen_crc64table.c follows to
>> + * generate the lookup table.
>> + *
>> + * Copyright 2018 SUSE Linux.
>> + *   Author: Coly Li <colyli@suse.de>
>> + */
>> +#include <inttypes.h>
>> +#include <stdio.h>
>> +
>> +#include <linux/swab.h>
>> +
>> +#define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL
>> +
>> +static int64_t crc64_table[256] = {0};
> 
> This really should be uint64_t, not int64_t.
> 
>> +
>> +static void generate_crc64_table(void)
>> +{
>> +	uint64_t i, j, c, crc;
>> +
>> +	for (i = 0; i < 256; i++) {
>> +		crc = 0;
>> +		c = i << 56;
>> +
>> +		for (j = 0; j < 8; j++) {
>> +			if ((crc ^ c) & 0x8000000000000000ULL)
>> +				crc = (crc << 1) ^ CRC64_ECMA182_POLY;
>> +			else
>> +				crc <<= 1;
>> +			c <<= 1;
>> +		}
>> +
>> +		crc64_table[i] = crc;
>> +	}
>> +}
>> +
>> +static void print_crc64_table(void)
>> +{
>> +	int i;
>> +
>> +	printf("/* this file is generated - do not edit */\n\n");
>> +	printf("#include <linux/types.h>\n");
>> +	printf("#include <linux/cache.h>\n\n");
>> +	printf("static const u64 ____cacheline_aligned crc64table[256] = {\n");
>> +	for (i = 0; i < 256; i++) {
>> +		printf("\t0x%016" PRIx64 "ULL", crc64_table[i]);
>> +		if (i & 0x1)
>> +			printf(",\n");
>> +		else
>> +			printf(", ");
>> +	}
>> +	printf("};\n");
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	generate_crc64_table();
>> +	print_crc64_table();
>> +	return 0;
>> +}
>> -- 
>> 2.17.1
>>
> 
> - Eric
> 


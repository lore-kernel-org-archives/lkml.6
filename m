Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6CEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030A8208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030A8208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeGQEIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:08:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725722AbeGQEIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:08:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 455A5ACB1;
        Tue, 17 Jul 2018 03:37:50 +0000 (UTC)
Subject: Re: [PATCH 4/4] lib/test_crc: Add test cases for crc calculation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180716165507.23100-1-colyli@suse.de>
 <20180716165507.23100-5-colyli@suse.de>
 <02a39b74-918b-a9ab-5023-99c11a8ac832@infradead.org>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBFYX6S8BEAC9VSamb2aiMTQREFXK4K/W7nGnAinca7MRuFUD4JqWMJ9FakNRd/E0v30F
 qvZ2YWpidPjaIxHwu3u9tmLKqS+2vnP0k7PRHXBYbtZEMpy3kCzseNfdrNqwJ54A430BHf2S
 GMVRVENiScsnh4SnaYjFVvB8SrlhTsgVEXEBBma5Ktgq9YSoy5miatWmZvHLFTQgFMabCz/P
 j5/xzykrF6yHo0rHZtwzQzF8rriOplAFCECp/t05+OeHHxjSqSI0P/G79Ll+AJYLRRm9til/
 K6yz/1hX5xMToIkYrshDJDrUc8DjEpISQQPhG19PzaUf3vFpmnSVYprcWfJWsa2wZyyjRFkf
 J51S82WfclafNC6N7eRXedpRpG6udUAYOA1YdtlyQRZa84EJvMzW96iSL1Gf+ZGtRuM3k49H
 1wiWOjlANiJYSIWyzJjxAd/7Xtiy/s3PRKL9u9y25ftMLFa1IljiDG+mdY7LyAGfvdtIkanr
 iBpX4gWXd7lNQFLDJMfShfu+CTMCdRzCAQ9hIHPmBeZDJxKq721CyBiGAhRxDN+TYiaG/UWT
 7IB7LL4zJrIe/xQ8HhRO+2NvT89o0LxEFKBGg39yjTMIrjbl2ZxY488+56UV4FclubrG+t16
 r2KrandM7P5RjR+cuHhkKseim50Qsw0B+Eu33Hjry7YCihmGswARAQABzRhDb2x5IExpIDxj
 b2x5bGlAc3VzZS5kZT7CwX8EEwEIACkFAlYX6ZACGyMFCQlmAYAHCwkIBwMCAQYVCAIJCgsE
 FgIDAQIeAQIXgAAKCRDHOQeTa334/CncD/9B97EIjcDOm0TS164bpMlsbZWEm8GQnV6nVzm8
 QsywPRM8S8nqkqX1atTYl/fTdJsasH8mgryUqL0eHBPs5RmJhDk3YgYsTrzbOjMdsdRwv24W
 J5RXdulRag2XDPIhSP7rWsOSh66gljdAp8XQQZD0zFXi4IytoAuLtx8RMjzzKk1iP6uz8MIv
 em7iFu6NYcHd3cmvSPo7CnBVaG0dZ6P2p2gS7ydSWOGsWkNh/XM4ojJaX1ZdCeFR0XLS76Gi
 6e01DoN2UsqZE/TQu1czYMMA1uM/Es6ZTYgobTrrnNB79ctqgtbBrjME5sOHLX40ccbBI3QB
 Ta4opSp8VqUMXw/yd5ckLPocnkJBTVxuaOfRhpxr6gWeudrkMetMj+39yeklskP7up0JvAUG
 7/HjjqwWR7xAaZHmZORYsIxJ9ploBb8eSqHHx+7489ZDNLP+WCsAonpKTdJNAzGJClnLFxKS
 DY4cOPs7o4IFBk6dVXJWMqyLGwmMQ51Pq6BID4epaAuuBAL6x7n7NrFPuS68Fn/VaxqMEld9
 L2eCi4cv++1AJyMF3iQKT56I8BjHEuf0wo1tmZ3BgBT19xRsEl7YItixxtYQm66Pb4lSQQmE
 Ep+uQNwaqPpeAU+vkDg/0Q+dhPTsvwx0OAI30HwhuzNA8OIfHBx7dJNm0b0fg5x0pg3LDM7B
 TQRWF+kvARAA2T/tnJeA0RWkmgZrNPFvP7JnOU9gjmIQKMoGZ+9awew45pdmXb6y0Y0fEG59
 EP9i9oBlFXOt6SZ2645V0sdi3wBRNEpX2CCddWhXRfcO0b6lgckIwyaK92dH1rzxMaZTYDL8
 aQ9FNEK1U+XSBk8fYWnXowpf7oNPS6+jD0J/muPqrGkVsIAkh2iLg5B98yNTCV4ql1xSlMyf
 xcseke9q6ojDxx9p38JjLusDlwF2+/rF42c+T6PRiYNjnBHPq6VLSlCRsnkLJwg8VHKiV2Qw
 Yvxp4TwnK2kLqokOxBlriX45Odb2iP61uG2ZAPchDwfawWJ4G8+3EMplLH8bk0/DkpYcYz95
 eGSGRSiIQ2kHmTI/KbpgXxFVMoheilUn4HzUP+T6TEeP6Zhm0aqwABJYa0T2ykJwpBlg6/Mx
 vgIzdSheqx2hYACDu07WfhdvI6uK3i5Lq9DebUBcMMBcMc0TnXix7mYy+3hLXJzZ80pFx3My
 5FeJEN/r6/+xpuuZkH51aYOiacKVa2w2EHjhZcWfPhhEWOQ2oOCoCmv+HEmV9sf+fipEMfcB
 8GnJMOYAwrwHWfkPNZ5urUcRGAQYlQ0GWKju97LYE2cq5McpFG0CMvDyPoO1zAwjJz4g53EK
 oH/eikd3L8OMDfEK4AOsUaPMTnNgt1+40zEFMrQs/dDMldUAEQEAAcLBZQQYAQgADwUCVhfp
 LwIbDAUJCWYBgAAKCRDHOQeTa334/PtREACDN8W/pHeHyPW/mTt6MEe/GICG5YdlBW5ft7HY
 Cf6rTz+uLZolGc5SYKuJJ0JC/L2Ifh3BWmwLIOxV868KB3oEfmGszBY+4n/icLyIEAkkthBb
 2V5sP5KgB3bOg7mSFBxfHi2pyO9K9d+Lr+UkORjCGyV33QFrcN+OQdPDactontnQglB7xm2K
 phGWqxoqepHCqFIulZ3yKGhQhmdpyz0J19Ry6GkxPE85MG/NC98D5+4Yn/V3G+yZpbGsuFhE
 CP26JvdXh1jNCUdU46pEjZwu0GXBIo6r1cb1v+swfYB86NeFUHWtvxamh8i6RBl1FLDhN6xb
 r9f7M++xoADyzPQYQPQUxWK+iG6lz3qVVq5312z/is3fcdyESPNs09DMT43xCCBr9UOMq6dZ
 IC9EsSeMYv4librfuSRqH4R0MuVbVWLJFg/Q7s+nbPb2YjhqIYr51hBDyXpzUDoIz43maIPk
 UmCNKa43mNFktMrwU21J5lVXEwBuTY6JlHOAl0Fgo28X+eTa8fx2Uiz9OVgWe03ebJGIGowe
 XTgqVWJMsKM1tmW+QFmgtczDGRYCZ6OQYpqt0SoTg1yx5MN4RzUtlLka2qLfPiOGUUN3qNJ5
 nP+spvF+s+dHtLjjhy7AL86N01a6S0rwaClVVv0XTucvIntwccIx0CZfUKlfn5BWnB64Ig==
Message-ID: <d29ac200-afed-6cb3-063a-ba2b00251416@suse.de>
Date:   Tue, 17 Jul 2018 11:37:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <02a39b74-918b-a9ab-5023-99c11a8ac832@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/17 2:05 AM, Randy Dunlap wrote:
> On 07/16/2018 09:55 AM, Coly Li wrote:
>> This patch adds a kernel module to test the consistency of multiple crc
>> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
>>
>> The test results are printed into kernel message, which look like,
>>
>> test_crc: crc64_le: PASSED (0x4e6b1ff972fa8c55, expval 0x4e6b1ff972fa8c55)
>> test_crc: crc64_le_bch: PASSED (0x0e4f1391d7a4a62e, expval 0x0e4f1391d7a4a62e)
>> test_crc: crc64_le_update: FAILED (0x03d4d0d85685d9a1, expval 0x3d4d0d85685d9a1f)
>>
>> kernel 0day system has framework to check kernel message, then the above
>> result can be handled by 0day system. If crc calculation inconsistency
>> happens, it can be detected quite soon.
>>

Hi Randy,

>> lib/test_crc.c can is a testing frame work for all crc consistency
> 
>             drop ^^^ "can"
> 

All the following issues are fixed in v2 series, thank you for the review.

> Well, we already have (from lib/Makefile):
> obj-$(CONFIG_CRC32_SELFTEST)	+= crc32test.o
> 
> so lib/test_crc.c isn't exactly "for all crc".
> 

My plan is to add extra consistency test cases for crc32/crc32c for
consistency testing. Consistency testing case is much simpler than the
code in crc32test.c, the results of test_crc.c are in unified format so
0day testing can handle them in a simple way.

I agree with you that 'for all crc' is inaccurate before the
crc32/crc32c test cases added into test_crc. So in v2 series, it will be
modified to 'for many crc consistency testings'.

Thanks.

Coly Li

> 
>> testings. For now, there are only test caes for 3 crc routines,
>> - crc64_le()
>> - crc64_le_bch()
>> - crc64_le_update()
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Luis R. Rodriguez <mcgrof@suse.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> ---
>>  lib/Kconfig.debug |  11 ++++
>>  lib/Makefile      |   1 +
>>  lib/test_crc.c    | 136 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 148 insertions(+)
>>  create mode 100644 lib/test_crc.c
> 
> 
>> diff --git a/lib/test_crc.c b/lib/test_crc.c
>> new file mode 100644
>> index 000000000000..3a9442252de5
>> --- /dev/null
>> +++ b/lib/test_crc.c
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * CRC test driver
>> + *
>> + * Copyright (C) 2018 Coly Li <colyli@suse.de>
>> + *
>> + * This module provides an simple framework to check the consistency of
>> + * Linux kernel crc calculation routines in lib/crc*.c. This driver
> 
>                    CRC
> 
>> + * requires CONFIG_CRC* items to be enabled if the associated routines are
>> + * tested here. The test results will be printed to kernel message
>> + * when this test driver is loaded.
>> + *
>> + * Current test routines are,
>> + * - crc64_le()
>> + * - crc64_le_bch()
>> + * - crc64_le_update()
>> + *
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +#include <linux/fs.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/async.h>
>> +#include <linux/delay.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/crc64.h>
>> +
>> +struct crc_test_record {
>> +
>> +	char	*name;
>> +	__le64	data[4];
>> +	__le64	initval;
>> +	__le64	expval;
>> +	int	(*handler)(struct crc_test_record *rec);
>> +};
>> +
>> +static int chk_and_msg(const char *name, __le64 crc, __le64 expval)
>> +{
>> +	int ret = 0;
>> +
>> +	if (crc == expval) {
>> +		pr_info("test_crc: %s: PASSED:(0x%016llx, expval 0x%016llx)",
>> +			name, crc, expval);
>> +	} else {
>> +		pr_err("test_crc: %s: FAILED:(0x%016llx, expval 0x%016llx)",
>> +			name, crc, expval);
> 
> For both pr_err() lines, please print "expected" instead of "expval".
> 
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/* Add your crc test caese here */
> 
>                CRC test cases
> 
>> +static int test_crc64_le(struct crc_test_record *rec)
>> +{
>> +	__le64 crc;
>> +
>> +	crc = crc64_le(rec->data, sizeof(rec->data));
>> +	return chk_and_msg(rec->name, crc, rec->expval);
>> +
>> +}
>> +
>> +static int test_crc64_le_bch(struct crc_test_record *rec)
>> +{
>> +	__le64 crc;
>> +
>> +	crc = crc64_le_bch(rec->data, sizeof(rec->data));
>> +	return chk_and_msg(rec->name, crc, rec->expval);
>> +}
>> +
>> +static int test_crc64_le_update(struct crc_test_record *rec)
>> +{
>> +	__le64 crc = rec->initval;
>> +
>> +	crc = crc64_le_update(crc, rec->data, sizeof(rec->data));
>> +	return chk_and_msg(rec->name, crc, rec->expval);
>> +}
>> +
>> +/*
>> + * Set up your crc test initial data here.
>> + * Do not change the existing items, they are hard coded with
>> + * pre-calculated values.
>> + */
>> +static struct crc_test_record test_data[] = {
>> +	{ .name		= "crc64_le",
>> +	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
>> +			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
>> +	  .initval	= 0,
>> +	  .expval	= 0xe2b9911e7b997201,
>> +	  .handler	= test_crc64_le,
>> +	},
>> +	{ .name		= "crc64_le_bch",
>> +	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
>> +			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
>> +	  .initval	= 0,
>> +	  .expval	= 0xd2753a20fd862892,
>> +	  .handler	= test_crc64_le_bch,
>> +	},
>> +	{ .name		= "crc64_le_update",
>> +	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
>> +			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
>> +	  .initval	= 0x61C8864680B583EB,
>> +	  .expval	= 0xb2c863673f4292bf,
>> +	  .handler	= test_crc64_le_update,
>> +	},
>> +	{ .name = NULL, }
>> +};
>> +
>> +
>> +static int __init test_crc_init(void)
>> +{
>> +	int i;
>> +	int v, ret = 0;
>> +
>> +	pr_info("Kernel crc consitency testing:");
> 
> 	                CRC consistency
> 
>> +	for (i = 0; test_data[i].name; i++) {
>> +		v = test_data[i].handler(&test_data[i]);
>> +		if (v < 0 && ret == 0)
>> +			ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +late_initcall(test_crc_init);
>> +
>> +static void __exit test_crc_exit(void) { }
>> +module_exit(test_crc_exit);
>> +
>> +MODULE_DESCRIPTION("CRC consistency testing driver");
>> +MODULE_AUTHOR("Coly Li <colyli@suse.de>");
>> +MODULE_LICENSE("GPL");
>>
> 
> 
> thanks,
> 


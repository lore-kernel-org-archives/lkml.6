Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B490FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8FB208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoOE90lH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8FB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeGQHpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:45:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45150 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeGQHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:45:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id i26-v6so45164pfo.12;
        Tue, 17 Jul 2018 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0H2ETm9T7MS7Gx6vOgqc7Zg9BQAT3iJojWnCEDWJaas=;
        b=CoOE90lHYNeMOYwfBmZggBUTejlFJh0SienH7Maw+b9sI5Nj5Rv4QGh0VmzIVSACeN
         qbCXnprcOfGM5cpy4idaYeZIPgKAyF6XYzylYWOkLxp+gfNnMVgOFMWv+J2iMu6dAV62
         frHAUVf1XHI+962QIJLN2P1bLmVB2FXPfdPQQ3p96V6NBjLZOV+P8d1fFU3HJHA/Qb9e
         M8z6lFuSM4bgvJs4xiAUoTaoZIwJyyHTKXrXNOuo7oW2wKOhpB96t/N+5NZFMcJ9UwAQ
         gWisOy8EUpWuWzRGHGduYk/uBi5TDZnRyy/GGWEGL7iqUSV60aMNLxBn50aPNX5taFPh
         3imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0H2ETm9T7MS7Gx6vOgqc7Zg9BQAT3iJojWnCEDWJaas=;
        b=I96vr+v9p9sV1vodGjG+B5XeuNXbSURMZn6rRGJqXbpMhwXM/PR6YXtX+DXozuT0i2
         Ui9j41Y2W0pKY3lRUlQdDby79YiFtW29ef0H57gzyTRnvnscwB+iQlzLi4rPiiNeMFT+
         mZRI3zWL+uKrThNAFZ1jmeasn5lTD9PlnrRlUIlSKd9bt5juzMZ4z7FuOd78twYvc9sE
         uSJEejM1fFIbkgu2oDrg8zELZWwUAy37hp/0j4FWfCtCa/KJ1D2juK3x3BXxHateZa6g
         1gJonMZLBL3fazUnM3g+n+0MjUj1X0bk2J4vTtyKgUAhgv4117/bTV5HX4nE4af0O9qu
         5btQ==
X-Gm-Message-State: AOUpUlF01IYlTaBuqWBXeq+FfJbV2gYq9M8oGbJL9yVyWZcHWn6EwXOU
        UMBBb/ejkvGla4vitgVfFvQ=
X-Google-Smtp-Source: AAOMgpcxb1dPf7j4Wf7KTB0jmoDeaBBwLylBECpgdYm2oQI940WpZ7d0BsLI4oDcm8vXEArTacuB1A==
X-Received: by 2002:a63:4924:: with SMTP id w36-v6mr449679pga.143.1531811634978;
        Tue, 17 Jul 2018 00:13:54 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id u69-v6sm1542139pgd.43.2018.07.17.00.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 00:13:54 -0700 (PDT)
Date:   Tue, 17 Jul 2018 00:13:52 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 2/4] lib: add crc64 calculation routines
Message-ID: <20180717071352.GB1728@sol.localdomain>
References: <20180716165507.23100-1-colyli@suse.de>
 <20180716165507.23100-3-colyli@suse.de>
 <20180717033425.GA1728@sol.localdomain>
 <40ed7be1-fb4d-7ae0-53db-cce8461c66b9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ed7be1-fb4d-7ae0-53db-cce8461c66b9@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:25:24PM +0800, Coly Li wrote:
> On 2018/7/17 11:34 AM, Eric Biggers wrote:
> > Hi Coly,
> > 
> > On Tue, Jul 17, 2018 at 12:55:05AM +0800, Coly Li wrote:
> >> This patch adds the re-write crc64 calculation routines for Linux kernel.
> >> The CRC64 polynomical arithmetic follows ECMA-182 specification, inspired
> >> by CRC paper of Dr. Ross N. Williams
> >> (see http://www.ross.net/crc/download/crc_v3.txt) and other public domain
> >> implementations.
> >>
> >> All the changes work in this way,
> >> - When Linux kernel is built, host program lib/gen_crc64table.c will be
> >>   compiled to lib/gen_crc64table and executed.
> >> - The output of gen_crc64table execution is an array called as lookup
> >>   table (a.k.a POLY 0x42f0e1eba9ea369) which contain 256 64bits-long
> >>   numbers, this talbe is dumped into header file lib/crc64table.h.
> >> - Then the header file is included by lib/crc64.c for normal 64bit crc
> >>   calculation.
> >> - Function declaration of the crc64 calculation routines is placed in
> >>   include/linux/crc64.h
> >>
> > [...]
> >> diff --git a/lib/crc64.c b/lib/crc64.c
> >> new file mode 100644
> >> index 000000000000..03f078303bd3
> >> --- /dev/null
> >> +++ b/lib/crc64.c
> >> @@ -0,0 +1,71 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Normal 64bit CRC calculation.
> >> + *
> >> + * This is a basic crc64 implementation following ECMA-182 specification,
> >> + * which can be found from,
> >> + * http://www.ecma-international.org/publications/standards/Ecma-182.htm
> >> + *
> >> + * Dr. Ross N. Williams has a great document to introduce the idea of CRC
> >> + * algorithm, here the CRC64 code is also inspired by the table-driven
> >> + * algorithm and detail example from this paper. This paper can be found
> >> + * from,
> >> + * http://www.ross.net/crc/download/crc_v3.txt
> >> + *
> >> + * crc64table_le[256] is the lookup table of a table-driver 64bit CRC
> >> + * calculation, which is generated by gen_crc64table.c in kernel build
> >> + * time. The polynomial of crc64 arithmetic is from ECMA-182 specification
> >> + * as well, which is defined as,
> >> + *
> >> + * x^64 + x^62 + x^57 + x^55 + x^54 + x^53 + x^52 + x^47 + x^46 + x^45 +
> >> + * x^40 + x^39 + x^38 + x^37 + x^35 + x^33 + x^32 + x^31 + x^29 + x^27 +
> >> + * x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
> >> + * x^7 + x^4 + x + 1
> >> + *
> >> + * Copyright 2018 SUSE Linux.
> >> + *   Author: Coly Li <colyli@suse.de>
> >> + *
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <uapi/linux/types.h>
> >> +#include "crc64table.h"
> >> +
> >> +MODULE_DESCRIPTION("CRC64 calculations");
> >> +MODULE_LICENSE("GPL");
> >> +
> >> +__le64 crc64_le_update(__le64 crc, const void *_p, size_t len)
> >> +{
> >> +	size_t i, t;
> >> +
> >> +	const unsigned char *p = _p;
> >> +
> >> +	for (i = 0; i < len; i++) {
> >> +		t = ((crc >> 56) ^ (__le64)(*p++)) & 0xFF;
> >> +		crc = crc64table_le[t] ^ (crc << 8);
> >> +	}
> >> +
> >> +	return crc;
> >> +}
> >> +EXPORT_SYMBOL_GPL(crc64_le_update);
> >> +
> >> +__le64 crc64_le(const void *p, size_t len)
> >> +{
> >> +	__le64 crc = 0x0000000000000000ULL;
> >> +
> >> +	crc = crc64_le_update(crc, p, len);
> >> +
> >> +	return crc;
> >> +}
> >> +EXPORT_SYMBOL_GPL(crc64_le);
> >> +
> >> +/* For checksum calculation in drivers/md/bcache/ */
> >> +__le64 crc64_le_bch(const void *p, size_t len)
> >> +{
> >> +	__le64 crc = 0xFFFFFFFFFFFFFFFFULL;
> >> +
> >> +	crc = crc64_le_update(crc, p, len);
> >> +
> >> +	return (crc ^ 0xFFFFFFFFFFFFFFFFULL);
> >> +}
> >> +EXPORT_SYMBOL_GPL(crc64_le_bch);
> > 
> 
> Hi Eric,
> 
> > Using __le64 here makes no sense, because that type indicates the endianness of
> > the *bytes*, whereas with CRC's "little endian" and "big endian" refer to the
> > order in which the *bits* are mapped to the polynomial coefficients.
> > 
> > Also as you can see for lib/crc32.c you really only need to provide a function
> > 
> > 	u64 __pure crc64_le(u64 crc, unsigned char const *p, size_t len);
> > 
> > and the callers can invert at the beginning and/or end if needed.
> 
> Let me explain why I explicit use __le64 here. When crc64 is used as
> on-disk checksum, the input of crc64 calculation should be in a explicit
> specific byte order. Currently check sum in bcache code assumes the CPU
> is in little endian and just feeds in-memory data into crc64
> calculation, then the code does not work on big endian machine like s390x.
> 
> To solve such problem, before calculating CRC the in-memory data should
> be swapped into a specific byte order (in bcache case it should be
> little endian). For data storage or transfer, CRC calculation without
> explicit endian is more easy to introduce bugs.

No, the implementation never loads multi-byte values, so CPU endianness doesn't
matter for the input.  CPU endianness *does* matter when serializing the final
calculated CRC into a byte array for storing on-disk, so maybe bcache gets that
part wrong, I don't know.  Either way, that has nothing to do with how the
polynomial coefficients (bits) are ordered *within bytes*, which is what the
"_be" and "_le" refer to in the CRC-32 implementation.  Yes, the naming is
unfortunate as it can easily be confused with the usual "bytewise" endianness,
but you need to understand it.

Again, using __le64 makes absolutely no sense.  You're even doing operations
like shifts directly on a "__le64" which sparse will (correctly) complain about.

> 
> When I declare the type of input and output value as __le64, on big
> endian machine, I expect a type mismatch warning if the input memory
> buffer is not swapped into little endian. For u64, there is no such type
> checking warning.
> 
> This is the initial version of lib/crc64.c, people may add their crc64
> calculation routines when necessary, e.g. crc64_be() or crc64(). I only
> add crc64_le_update() and crc64_le_bch() because bcache code needs them.
> 
> Indeed there is no user of crc64_le() for now, but the file is name as
> lib/crc64.c, I think there should be a crc64 calculation at least, so I
> add crc64_le().
> 
> > 
> > Also your function names make it sound like inverting the bits is the exception
> > or not recommended, since you called the function which does the inversions
> > "crc32_le_bch()" so it sounds like a bcache-specific hack, while the one that
> > doesn't do the inversions is simply called "crc32_le()".  But actually it's
> > normally recommended to do CRC's with the inversions, so that leading and
> > trailing zeroes affect the resulting CRC.
> > 
> 
> I notice this, normally there are two crc routines provided, with and
> without inversion. The reason that there is no inversion version is
> no-user in Linux kernel. Indeed there is no user of crc64_le() in Linnux
> kernel so far. For performance reason, I doubt whether there will be
> more user to do 64bit crc in kernel.
> 
> I prefer two crc32 calculation for a 64bit value, but meta data checksum
> by crc64 calculation is used in bcache for years, the consistency has to
> be kept.

Well, your response didn't actually address my points.  But it raises the
question: if there won't be any other users, then why move CRC-64 to lib/ at
all?

> 
> 
> >> diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
> >> new file mode 100644
> >> index 000000000000..5f292f287498
> >> --- /dev/null
> >> +++ b/lib/gen_crc64table.c
> >> @@ -0,0 +1,77 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Generate lookup table for the talbe-driven CRC64 calculation.
> >> + *
> >> + * gen_crc64table is executed in kernel build time and generates
> >> + * lib/crc64table.h. This header is included by lib/crc64.c for
> >> + * the table-driver CRC64 calculation.
> >> + *
> >> + * See lib/crc64.c for more information about which specification
> >> + * and polynomical arithmetic that gen_crc64table.c follows to
> >> + * generate the lookup table.
> >> + *
> >> + * Copyright 2018 SUSE Linux.
> >> + *   Author: Coly Li <colyli@suse.de>
> >> + *
> >> + */
> >> +
> >> +#include <inttypes.h>
> >> +#include <linux/swab.h>
> >> +#include <stdio.h>
> >> +#include "../usr/include/asm/byteorder.h"
> >> +
> >> +#define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL
> > 
> > Okay, that's actually the ECMA-182 polynomial in "big endian" form (highest
> > order bit is the coefficient of x^63, lowest order bit is the coefficient of
> > x^0), so you're actually doing a "big endian" CRC.  So everything in your patch
> > series that claims it's a little endian or "le" CRC is incorrect.
> > 
> >> +
> >> +#ifdef __LITTLE_ENDIAN
> >> +#  define cpu_to_le64(x) ((__le64)(x))
> >> +#else
> >> +#  define cpu_to_le64(x) ((__le64)__swab64(x))
> >> +#endif
> >> +
> >> +static int64_t crc64_table[256] = {0,};
> >> +
> >> +static void generate_crc64_table(void)
> >> +{
> >> +	uint64_t i, j, c, crc;
> >> +
> >> +	for (i = 0; i < 256; i++) {
> >> +		crc = 0;
> >> +		c = i << 56;
> >> +
> >> +		for (j = 0; j < 8; j++) {
> >> +			if ((crc ^ c) & 0x8000000000000000ULL)
> >> +				crc = (crc << 1) ^ CRC64_ECMA182_POLY;
> >> +			else
> >> +				crc <<= 1;
> >> +			c <<= 1;
> > 
> > See here, it's shifting out the most significant bit, which means it's the
> > coefficient of the x^63 term ("big endian" or "normal" convention), not the x^0
> > term ("little endian" or "reversed" convention).
> 
> I see your point here. I am not expert in coding theory, the knowledge I
> have is from wikipedia, ECMA-182 and the document from Dr. Ross
> Williams. From ECMA-182 document, I don't see any word with 'big
> endian', so I take it as a standard poly and regardless the byte order.
> 
> And on wikepedia page
> https://en.wikipedia.org/wiki/Cyclic_redundancy_check , CRC-64-ECMA
> references the same poly and call "0x42F0E1EBA9EA3693" as normal poly,
> which one links to polynomial
> 	"x^64 + x^62 + x^57 + x^55 + x^54 + ....x^7 + x^4 + x + 1"
> if I understand correctly. But from your information, it seems the
> polynomial in generate_crc64_table() is x^64 + x^61 ..... Maybe I
> misunderstand you, could you please give me more hint ?

As I said, the "normal" convention is the same as "big endian", and the
"reversed" convention is the same as "little endian" (again, meaning "bitwise"
endianness, not the usual "bytewise" endianness).  The polynomial is correct but
you are claiming the polynomial coefficients are mapped to bits in a different
order than they actually are.

- Eric

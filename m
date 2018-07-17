Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26447ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B811C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ot7fi87G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B811C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeGQEEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:04:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45971 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeGQEEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:04:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so139687pgq.12;
        Mon, 16 Jul 2018 20:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmX8mR7AsIHFNbjcc6aVCgbeKnWsHEsKANU7L0S50/8=;
        b=ot7fi87GZFUL4N2C194lfojjiSZNhLhEGCBFSsLr+eE8wSTqs/rLhAtW03x+l9qyI2
         glSaQr6T+3T+y5R+1DMJQZdjJBrWl5R639GdHUutCK9ytEsD4An4DUh2THh+0CQdpe6I
         vmsoVMO1+hxhjLXRzTxHwd5tEguuygYiqodm1LegbXt0E5vKkLOEkJkdouh3oumfnAZ/
         ZmWn/6QEDUewwzt8hCDTERcz8W4PG4wutyI36ZWkOirt1LeL6E0TTrFKT1Rqr8PTlMgb
         fIvCIl5crk2dVZjbUAtzR+cnp/K72YY1jWTcnnRtQjF6zoo9RQcn1HGTkGu9MbxP0hax
         g9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmX8mR7AsIHFNbjcc6aVCgbeKnWsHEsKANU7L0S50/8=;
        b=VRe3Nv6RJTZcGgMfBmZ3qFnCwpAANA3Nmzsv3d/xgOHxnNxV/DcvGGQ3K2qM7+njWY
         uyitwtUSrDlimdqXH5GqZexZ7bWq6m56IoDsk6m1lJ80RdUQxmNsD3KcgsA0mB572Yba
         5ItU9GNceVWt7r+SuZgCP3N30TUouqegP3isFBZzUWSB2O606cJRqDOr0rmiK9VsvtGZ
         zp4FMJIa4nYtTQZjVMp+98f2jDgOQxVFzmOZRHhbPZyrwB1G9CZVdNuLjqGzGJMZQ0Df
         tSsdHg2CaB6WQNpIazErvdeUlfaFqDaOAdGbeZEkzJYZ6W4GDM67/PBn1iSlVD5R6YOH
         PueA==
X-Gm-Message-State: AOUpUlH9dh60i26/g/8e97ZWlGZ3owx4A5dARrDhS9lrIVU8UcRolXmu
        VV79Iq1quFHeSh9cepZ7sKc=
X-Google-Smtp-Source: AAOMgpfd+LxmaDrJ6JsDbAvEpDAVIB3rE9Z3GzNpm8l9EkzLkQztRFb+zFORyxLH/sVnshASICXjFw==
X-Received: by 2002:a63:c902:: with SMTP id o2-v6mr17780657pgg.118.1531798468351;
        Mon, 16 Jul 2018 20:34:28 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id r1-v6sm103479462pfi.17.2018.07.16.20.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 20:34:27 -0700 (PDT)
Date:   Mon, 16 Jul 2018 20:34:25 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 2/4] lib: add crc64 calculation routines
Message-ID: <20180717033425.GA1728@sol.localdomain>
References: <20180716165507.23100-1-colyli@suse.de>
 <20180716165507.23100-3-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716165507.23100-3-colyli@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coly,

On Tue, Jul 17, 2018 at 12:55:05AM +0800, Coly Li wrote:
> This patch adds the re-write crc64 calculation routines for Linux kernel.
> The CRC64 polynomical arithmetic follows ECMA-182 specification, inspired
> by CRC paper of Dr. Ross N. Williams
> (see http://www.ross.net/crc/download/crc_v3.txt) and other public domain
> implementations.
> 
> All the changes work in this way,
> - When Linux kernel is built, host program lib/gen_crc64table.c will be
>   compiled to lib/gen_crc64table and executed.
> - The output of gen_crc64table execution is an array called as lookup
>   table (a.k.a POLY 0x42f0e1eba9ea369) which contain 256 64bits-long
>   numbers, this talbe is dumped into header file lib/crc64table.h.
> - Then the header file is included by lib/crc64.c for normal 64bit crc
>   calculation.
> - Function declaration of the crc64 calculation routines is placed in
>   include/linux/crc64.h
> 
[...]
> diff --git a/lib/crc64.c b/lib/crc64.c
> new file mode 100644
> index 000000000000..03f078303bd3
> --- /dev/null
> +++ b/lib/crc64.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Normal 64bit CRC calculation.
> + *
> + * This is a basic crc64 implementation following ECMA-182 specification,
> + * which can be found from,
> + * http://www.ecma-international.org/publications/standards/Ecma-182.htm
> + *
> + * Dr. Ross N. Williams has a great document to introduce the idea of CRC
> + * algorithm, here the CRC64 code is also inspired by the table-driven
> + * algorithm and detail example from this paper. This paper can be found
> + * from,
> + * http://www.ross.net/crc/download/crc_v3.txt
> + *
> + * crc64table_le[256] is the lookup table of a table-driver 64bit CRC
> + * calculation, which is generated by gen_crc64table.c in kernel build
> + * time. The polynomial of crc64 arithmetic is from ECMA-182 specification
> + * as well, which is defined as,
> + *
> + * x^64 + x^62 + x^57 + x^55 + x^54 + x^53 + x^52 + x^47 + x^46 + x^45 +
> + * x^40 + x^39 + x^38 + x^37 + x^35 + x^33 + x^32 + x^31 + x^29 + x^27 +
> + * x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
> + * x^7 + x^4 + x + 1
> + *
> + * Copyright 2018 SUSE Linux.
> + *   Author: Coly Li <colyli@suse.de>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <uapi/linux/types.h>
> +#include "crc64table.h"
> +
> +MODULE_DESCRIPTION("CRC64 calculations");
> +MODULE_LICENSE("GPL");
> +
> +__le64 crc64_le_update(__le64 crc, const void *_p, size_t len)
> +{
> +	size_t i, t;
> +
> +	const unsigned char *p = _p;
> +
> +	for (i = 0; i < len; i++) {
> +		t = ((crc >> 56) ^ (__le64)(*p++)) & 0xFF;
> +		crc = crc64table_le[t] ^ (crc << 8);
> +	}
> +
> +	return crc;
> +}
> +EXPORT_SYMBOL_GPL(crc64_le_update);
> +
> +__le64 crc64_le(const void *p, size_t len)
> +{
> +	__le64 crc = 0x0000000000000000ULL;
> +
> +	crc = crc64_le_update(crc, p, len);
> +
> +	return crc;
> +}
> +EXPORT_SYMBOL_GPL(crc64_le);
> +
> +/* For checksum calculation in drivers/md/bcache/ */
> +__le64 crc64_le_bch(const void *p, size_t len)
> +{
> +	__le64 crc = 0xFFFFFFFFFFFFFFFFULL;
> +
> +	crc = crc64_le_update(crc, p, len);
> +
> +	return (crc ^ 0xFFFFFFFFFFFFFFFFULL);
> +}
> +EXPORT_SYMBOL_GPL(crc64_le_bch);

Using __le64 here makes no sense, because that type indicates the endianness of
the *bytes*, whereas with CRC's "little endian" and "big endian" refer to the
order in which the *bits* are mapped to the polynomial coefficients.

Also as you can see for lib/crc32.c you really only need to provide a function

	u64 __pure crc64_le(u64 crc, unsigned char const *p, size_t len);

and the callers can invert at the beginning and/or end if needed.

Also your function names make it sound like inverting the bits is the exception
or not recommended, since you called the function which does the inversions
"crc32_le_bch()" so it sounds like a bcache-specific hack, while the one that
doesn't do the inversions is simply called "crc32_le()".  But actually it's
normally recommended to do CRC's with the inversions, so that leading and
trailing zeroes affect the resulting CRC.

> diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
> new file mode 100644
> index 000000000000..5f292f287498
> --- /dev/null
> +++ b/lib/gen_crc64table.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generate lookup table for the talbe-driven CRC64 calculation.
> + *
> + * gen_crc64table is executed in kernel build time and generates
> + * lib/crc64table.h. This header is included by lib/crc64.c for
> + * the table-driver CRC64 calculation.
> + *
> + * See lib/crc64.c for more information about which specification
> + * and polynomical arithmetic that gen_crc64table.c follows to
> + * generate the lookup table.
> + *
> + * Copyright 2018 SUSE Linux.
> + *   Author: Coly Li <colyli@suse.de>
> + *
> + */
> +
> +#include <inttypes.h>
> +#include <linux/swab.h>
> +#include <stdio.h>
> +#include "../usr/include/asm/byteorder.h"
> +
> +#define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL

Okay, that's actually the ECMA-182 polynomial in "big endian" form (highest
order bit is the coefficient of x^63, lowest order bit is the coefficient of
x^0), so you're actually doing a "big endian" CRC.  So everything in your patch
series that claims it's a little endian or "le" CRC is incorrect.

> +
> +#ifdef __LITTLE_ENDIAN
> +#  define cpu_to_le64(x) ((__le64)(x))
> +#else
> +#  define cpu_to_le64(x) ((__le64)__swab64(x))
> +#endif
> +
> +static int64_t crc64_table[256] = {0,};
> +
> +static void generate_crc64_table(void)
> +{
> +	uint64_t i, j, c, crc;
> +
> +	for (i = 0; i < 256; i++) {
> +		crc = 0;
> +		c = i << 56;
> +
> +		for (j = 0; j < 8; j++) {
> +			if ((crc ^ c) & 0x8000000000000000ULL)
> +				crc = (crc << 1) ^ CRC64_ECMA182_POLY;
> +			else
> +				crc <<= 1;
> +			c <<= 1;

See here, it's shifting out the most significant bit, which means it's the
coefficient of the x^63 term ("big endian" or "normal" convention), not the x^0
term ("little endian" or "reversed" convention).

Eric

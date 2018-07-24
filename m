Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110DAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44F320875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfGfn396"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44F320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbeGXFbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:31:10 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36873 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbeGXFbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:31:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so1156924plc.4;
        Mon, 23 Jul 2018 21:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6lTIw9y1GXBJmo2GmyDvhhRu707mLcJa8v3k4TNTwkM=;
        b=MfGfn396n1kDEmGZ5av/vd1862PdIMKGfulm1ffguCGZZaiZ9IEraiYgfGGXVq2kWo
         MKbU24eaat52zv6tOpYV8AfzX2edhVQEbs7KQQFWmoIma/uLtzRc/Q4rKjgI8pnJBeSR
         p3Pietsr0JgBzrMuOHemeAwExlASt4pPqzTKAcIHLuFUyy9cch4a8t45ufF2etRD/hoZ
         7AArJyzDpD4e3G5Oj/lRHtHewPhrWUb+hjtW5DiWGV5zc31nCaWXVF3bRqoGRybibSWx
         NQ/+SdW9ApljxzGLviC8k2STv+/84+PqxUhIgPEH3/NPaIMvIOFI144U7P9bwuU3+o5t
         ZzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6lTIw9y1GXBJmo2GmyDvhhRu707mLcJa8v3k4TNTwkM=;
        b=L/4G5giX0572Q+tQX3UD3X0kJUXz/FGkaTf7PgUVj7anDpn134c0qXc6B7TjoqL3ag
         BhwBFmEIAtt7qXUStp+0q0trx13rJfnzMy6umL4EFOP7aGpWNznE2CXQevnzQkkkMkkJ
         nf/zzp1a3f9obf2Fs7+jKvkKUcSK3V+JtAI3QNbUpZAFyZyWIBYSHP2Sn1iCMS2eV415
         5HDDgpLwT92f5+0jjMy3Qz05UxRkAHtBCK6qDFKn/eWyhgQk803l2NhUoC0ItIHtSpxQ
         iDzTF1oAyFXXKWdVeKv++raKYTwZ/qQ2GJ7uxuPepIHEi4XHtZX6MSViYz1/oyOUtMqd
         ggtQ==
X-Gm-Message-State: AOUpUlHvqzJ0JnMLOxGVjF+Ewmy27fijBTxIu4melRJSPQpBj9pgcPnF
        2u8MiD8mnYajXqMhI0aad34=
X-Google-Smtp-Source: AAOMgpd3PRKR/6yXVonjfsO7QuE1LIFNZLZrg1Xmpu7EIHTigUVXmzpNuBFxSjVoyMDJuFVsHLGlcQ==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11-v6mr15031912plx.243.1532406399670;
        Mon, 23 Jul 2018 21:26:39 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id u1-v6sm20753390pgk.25.2018.07.23.21.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 21:26:39 -0700 (PDT)
Date:   Mon, 23 Jul 2018 21:26:37 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Coly Li <colyli@suse.de>
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
Subject: Re: [PATCH v4 1/3] lib: add crc64 calculation routines
Message-ID: <20180724042637.GA1944@sol.localdomain>
References: <20180718165545.1622-1-colyli@suse.de>
 <20180718165545.1622-2-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718165545.1622-2-colyli@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:55:43AM +0800, Coly Li wrote:
> This patch adds the re-write crc64 calculation routines for Linux kernel.
> The CRC64 polynomical arithmetic follows ECMA-182 specification, inspired

"polynomical" => "polynomial".  Same everywhere else in the patches.

> + * crc64table[256] is the lookup table of a table-driver 64-bit CRC

"table-driver" => "table-driven"

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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include "crc64table.h"
> +
> +MODULE_DESCRIPTION("CRC64 calculations");
> +MODULE_LICENSE("GPL v2");
> +
> +/**
> + * crc64_be - Calculate bitwise big-endian ECMA-182 CRC64
> + * @crc: seed value for computation. 0 for a new CRC computing, or the
> + *	previous crc64 value if computing incrementally.

"0 or (u64)~0 for a new CRC calculation".  Both conventions are common in CRCs.
In fact the all-ones convention is generally considered better, because it
causes leading zeroes in the data to affect the checksum.

> + * @p: pointer to buffer over which CRC64 is run
> + * @len: length of buffer @p
> + */
> +u64 __pure crc64_be(u64 crc, const void *p, size_t len)
> +{
> +	size_t i, t;
> +
> +	const unsigned char *_p = p;
> +
> +	for (i = 0; i < len; i++) {
> +		t = ((crc >> 56) ^ (*_p++)) & 0xFF;
> +		crc = crc64table[t] ^ (crc << 8);
> +	}
> +
> +	return crc;
> +}
> +EXPORT_SYMBOL_GPL(crc64_be);
> diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
> new file mode 100644
> index 000000000000..8296b0c3ea30
> --- /dev/null
> +++ b/lib/gen_crc64table.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generate lookup table for the talbe-driven CRC64 calculation.

"talbe-driven" => "table-driven"

> + *
> + * gen_crc64table is executed in kernel build time and generates
> + * lib/crc64table.h. This header is included by lib/crc64.c for
> + * the table-driver CRC64 calculation.

"table-driver" => "table-driven"

> + *
> + * See lib/crc64.c for more information about which specification
> + * and polynomical arithmetic that gen_crc64table.c follows to
> + * generate the lookup table.
> + *
> + * Copyright 2018 SUSE Linux.
> + *   Author: Coly Li <colyli@suse.de>
> + */
> +#include <inttypes.h>
> +#include <stdio.h>
> +
> +#include <linux/swab.h>
> +
> +#define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL
> +
> +static int64_t crc64_table[256] = {0};

This really should be uint64_t, not int64_t.

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
> +		}
> +
> +		crc64_table[i] = crc;
> +	}
> +}
> +
> +static void print_crc64_table(void)
> +{
> +	int i;
> +
> +	printf("/* this file is generated - do not edit */\n\n");
> +	printf("#include <linux/types.h>\n");
> +	printf("#include <linux/cache.h>\n\n");
> +	printf("static const u64 ____cacheline_aligned crc64table[256] = {\n");
> +	for (i = 0; i < 256; i++) {
> +		printf("\t0x%016" PRIx64 "ULL", crc64_table[i]);
> +		if (i & 0x1)
> +			printf(",\n");
> +		else
> +			printf(", ");
> +	}
> +	printf("};\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	generate_crc64_table();
> +	print_crc64_table();
> +	return 0;
> +}
> -- 
> 2.17.1
> 

- Eric

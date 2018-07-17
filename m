Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6663BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148E3206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HStJ8CHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148E3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeGQREr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:04:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44906 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbeGQREr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:04:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so664474pgp.11;
        Tue, 17 Jul 2018 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4n0bFj6cuZbADw0VZKMH1SZ2g39tz5qHaKAil7Qnun8=;
        b=HStJ8CHuoG98OFrkJgnDAl7+FX4jDZioOOfIkHe/qEWn+p8+1oxgofPE0OUkOZk6S6
         Sawqlv/9RmCUNKmt14HV5mYm3mTNjAJHXQY4AUpTb7OxYmHmavVwsJYwfKo8TXF8IEs8
         D/aqlMk1s2CpGTe0WJZTBqD99gpphotfz7FwUpmNgVQSes9qKuGAxv9KEUDvKTXS7y12
         QVCfHclQQVgXvflcIgLHd4qDGQJLFSkQPQjV+qVBWI1sJICsQv2XeMy5ORci4qnBn94x
         Fd/4WheTpqfOeYjs+Xe373/Vrl5h2vdIfz23sssF8wNvpnoCNsRbE2DOolYCDKVB8rvA
         F70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4n0bFj6cuZbADw0VZKMH1SZ2g39tz5qHaKAil7Qnun8=;
        b=a/O7NSf8TtyfaUyPTwvE6X0HAprcx6AVNKz+eYEv6eIjWXadBCHwVI73rm+ZsbRprJ
         rU6wWuHmNUmKhyw3ZmPPyac+wiaWPX+rlkJoT/4pXcM+5LeCiD9O5cZ/uTCl3IP0Ts7Z
         xSGGHK4lbg3KNkR0JrkPLsuYaKlEUYkR2wTOd6hZtB8aQSqJRSGH5zXkdTyzEx5vVW/6
         Y/CX7pIKPLBc8lYgX0G3djOoGSmJZiswz5klYQM4ommEU12P6Bw8dXq1zvh0bKyhk+f2
         7s0dTuZ+FH8NStFtE2L1HI3/Zv6s/5SkZLsJK7zxGtBo4nx0oRdwJrXgViDBdpyjCExG
         f8MA==
X-Gm-Message-State: AOUpUlHen5fNxM/bsxFYfaLvTnbxKuXst1moeuq1KKy9S8uDyS3J1jsl
        iCGkwHQzAqX9PMXQ8vxs79I=
X-Google-Smtp-Source: AAOMgperV3rCmqmc5l35UzYKuHrYggGPgjbrfqV3NUCplCK12BiBkKF5OJLJe2AUpPCiekAs4gFnpw==
X-Received: by 2002:a63:b705:: with SMTP id t5-v6mr2284841pgf.45.1531845079048;
        Tue, 17 Jul 2018 09:31:19 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id z2-v6sm1986571pgv.12.2018.07.17.09.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 09:31:18 -0700 (PDT)
Date:   Tue, 17 Jul 2018 09:31:16 -0700
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
Subject: Re: [PATCH v3 1/3] lib: add crc64 calculation routines
Message-ID: <20180717163116.GA75957@gmail.com>
References: <20180717145525.50852-1-colyli@suse.de>
 <20180717145525.50852-2-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717145525.50852-2-colyli@suse.de>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coly,

On Tue, Jul 17, 2018 at 10:55:23PM +0800, Coly Li wrote:
> This patch adds the re-write crc64 calculation routines for Linux kernel.
> The CRC64 polynomical arithmetic follows ECMA-182 specification, inspired
> by CRC paper of Dr. Ross N. Williams
> (see http://www.ross.net/crc/download/crc_v3.txt) and other public domain
> implementations.

Please also mention who is planned to use this CRC-64 code.  Again, if it's just
one user then there's no need for this patchset yet.  If bcachefs is planned to
be another user (separate from bcache) then you need to say so.

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
> Changelog:
> v3: More fixes for review comments of v2
>     By review comments from Eric Biggers, current functions naming with
>     'le' is misleading. Remove 'le' from the crc function names, and use
>     u64 to replace __le64 in parameters and return values. 
> v2: Fix reivew comments of v1
> v1: Initial version.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Michael Lyle <mlyle@lyle.org>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Eric Biggers <ebiggers3@gmail.com>
> ---
>  include/linux/crc64.h | 13 ++++++++
>  lib/.gitignore        |  2 ++
>  lib/Kconfig           |  8 +++++
>  lib/Makefile          | 11 +++++++
>  lib/crc64.c           | 71 +++++++++++++++++++++++++++++++++++++++++++
>  lib/gen_crc64table.c  | 69 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 174 insertions(+)
>  create mode 100644 include/linux/crc64.h
>  create mode 100644 lib/crc64.c
>  create mode 100644 lib/gen_crc64table.c
> 
> diff --git a/include/linux/crc64.h b/include/linux/crc64.h
> new file mode 100644
> index 000000000000..3e87b61cd54f
> --- /dev/null
> +++ b/include/linux/crc64.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * See lib/crc64.c for the related specification and polynomical arithmetic.
> + */
> +#ifndef _LINUX_CRC64_H
> +#define _LINUX_CRC64_H
> +
> +#include <linux/types.h>
> +
> +u64 __pure crc64_update(u64 crc, const void *_p, size_t len);
> +u64 __pure crc64(const void *p, size_t len);
> +u64 __pure crc64_bch(const void *p, size_t len);
> +#endif /* _LINUX_CRC64_H */

I still think you should make the API consistent with lib/crc32.c by replacing
the three functions with just:

	u64 __pure crc64_be(u64 crc, const void *p, size_t len);

Your API maps to it as follows:

	crc64_update(crc, p, len) == crc64_be(crc, p, len)
	crc64(p, len)             == crc64_be(0, p, len)
	crc64_bch(p, len)         == ~crc64_be(~0, p, len)

The "_be" suffix clarifies that it's not using the bit-reversed convention.  We
don't want to have to rename everything when someone needs to do CRC-64 using
the other convention.  The CRC-64 in the .xz file format, for example, uses the
bit-reversed convention.

The other problem with your API (besides it being inconsistent with lib/crc32.c)
is that as soon as the caller needs to do something nontrivial, like passing the
data in multiple chunks or using different conventions for the initial and final
values, then they actually have to use only "crc64_update()" anyway, which is
confusing as it makes it sound like there should be a "crc64_init()" and
"crc64_final()" to go along with "crc64_update()".

Also, naming CRC conventions after a specific user ("bch") isn't appropriate.

Thanks,

- Eric

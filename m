Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A4520875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9tm3Xs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A4520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbeGXFs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:48:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37396 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388203AbeGXFs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:48:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so1946553pgq.4;
        Mon, 23 Jul 2018 21:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uc3uwE1fRhBcZiIMKimWjz+xdXtDv7tiIQjrtM1Js4=;
        b=k9tm3Xs0uDLzr3F6fWrX4G7XSgtB+Z3d6S3so9QsJe8ZyxA3/oFMKNeiBPsk74dUpo
         hec/Yi3sVAdVQptIuthLgc6UPokChclDA5s8uq1QTAPSTuwSdfZCyZZ4z8vm2flPVonq
         EjHCRmADA1l0ZlymId2qFN72XsGNUAFQUDcVXQHch7BP0csvfgrsrsudx8lRameuqqZR
         QIGGrH6N1Sp7Am/DcwuddixbzXA1Wzr6LXKKTK6b7l+bqjPqdOTesU3NL05tZl5WFCNo
         QvMM3y2xbq1ubjLOjUNoM68XXf7xCTFyx4+OOF7JaDEtmicIzjqzK4exa5amUglo9/qA
         CxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+uc3uwE1fRhBcZiIMKimWjz+xdXtDv7tiIQjrtM1Js4=;
        b=qKk4XKU/aQnbs/NcD1rl3rG1VTTy4q1/TD8Nto1qM6tkz0s+wWH1DNNM7dWOIVSgxj
         3z6InwrqP6a7a4hkb07fu8HEt4FdisTYElpYSTYce4X17XQ1mrPaI6/nOI5unTI3Cv9j
         D1vct9SwLDBMFAqVlnFkv+nguXvkWFcXmPkAkb5PyEpuDEAAUUk0Aa/oJzfOT/NJuMEg
         wm6rv3wVr+b8PiwPx/diT3rGC/kegJQkwlFHTmapb6hCOeKTnnYaiNmPTqJInhVI5Ap+
         eVDbkcxJAHJtwlxdFdvq84C7O0rfn4TiAnx+dudL1XlOM3AYSXEGxKZt2LU6EWetS+50
         GQgQ==
X-Gm-Message-State: AOUpUlGO8TTKaM1IIRCV/gMucvkSDSLzEgr1OD61QbgZExZCTLyZBouH
        2QxW+dM9iJ1yQjvbeVFvkUY8zS0n
X-Google-Smtp-Source: AAOMgpeHou7qi6nXlxhXglQ0Pmb08ZFUfeT/ICvov6fGtDmv77sWA1GdUbFYdq0SWjr9LMXubDxeLw==
X-Received: by 2002:a62:a3d1:: with SMTP id q78-v6mr15970587pfl.5.1532407463257;
        Mon, 23 Jul 2018 21:44:23 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id c68-v6sm25362345pfj.51.2018.07.23.21.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 21:44:22 -0700 (PDT)
Date:   Mon, 23 Jul 2018 21:44:20 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Coly Li <colyli@suse.de>
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
Subject: Re: [PATCH v4 3/3] lib/test_crc: Add test cases for crc calculation
Message-ID: <20180724044420.GB1944@sol.localdomain>
References: <20180718165545.1622-1-colyli@suse.de>
 <20180718165545.1622-4-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718165545.1622-4-colyli@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:55:45AM +0800, Coly Li wrote:
> This patch adds a kernel module to test the consistency of multiple crc
> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
> 
> The test results are printed into kernel message, which look like,
> 
> test_crc: crc64_be: FAILED (0x03d4d0d85685d9a1, expected 0x3d4d0d85685d9a1f)
> 
> kernel 0day system has framework to check kernel message, then the above
> result can be handled by 0day system. If crc calculation inconsistency
> happens, it can be detected quite soon.
> 
> lib/test_crc.c is a testing frame work for many crc consistency
> testings. For now, there is only one test caes for crc64_be().

Are you aware there's already a CRC-32 test module: CONFIG_CRC32_SELFTEST and
lib/crc32test.c?  Confusingly, your patch uses a different naming convention for
the new CRC-64 one, and puts the Kconfig option in a different place, and makes
it sound like it's a generic test for all CRC implementations rather than just
the CRC-64 one.  Please use the existing convention (i.e. add
CONFIG_CRC64_SELFTEST and lib/crc64test.c) unless you have a strong argument for
why it should be done differently.

(And I don't think it makes sense to combine all CRC tests into one module,
since you should be able to e.g. enable just CRC32 and CRC32_SELFTEST without
also pulling in a dependency on all the other CRC variants.)

> +/* Add your crc test cases here */
> +static void test_crc64_be(struct crc_test_record *rec)
> +{
> +	u64 crc;
> +
> +	crc = crc64_be(rec->initval, rec->data, sizeof(rec->data));
> +	chk_and_msg(rec->name, crc, rec->expval);
> +}
> +
> +/*
> + * Set up your crc test initial data here.
> + * Do not change the existing items, they are hard coded with
> + * pre-calculated values.
> + */
> +static struct crc_test_record test_data[] = {
> +	{ .name		= "crc64_be",
> +	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
> +			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
> +	  .initval	= 0x61C8864680B583EB,
> +	  .expval	= 0xb2c863673f4292bf,
> +	  .handler	= test_crc64_be,
> +	},
> +	{}
> +};

This is incorrect; the test is checksumming data that has a CPU-specific
endianness.  So, it will fail on big-endian systems.  The data needs to be
declared as a byte or char array instead.  See e.g. what crypto/testmgr.h does
for crypto API algorithms.

Also please mark the test data structures 'const'.

- Eric

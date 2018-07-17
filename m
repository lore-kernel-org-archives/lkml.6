Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E9AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F319B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F319B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeGQQUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:20:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:22965 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbeGQQUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:20:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 08:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="67640899"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2018 08:46:53 -0700
Message-ID: <b9e186e35d780a31077c8336315e86a8f0551523.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/3] add crc64 calculation as kernel library
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Date:   Tue, 17 Jul 2018 18:46:53 +0300
In-Reply-To: <20180717145525.50852-1-colyli@suse.de>
References: <20180717145525.50852-1-colyli@suse.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 22:55 +0800, Coly Li wrote:
> This patch set adds basic implementation of crc64 calculation as Linux
> kernel library. Since bcache already does crc64 by itself, this patch
> set also modifies bcache code to use the new crc64 library routine.
> 
> bcache uses crc64 as storage checksum, if a change of crc lib routines
> results an inconsistent result, the unmatched checksum may make bcache
> 'think' the on-disk is corrupted, such change should be avoided or
> detected as early as possible. Therefore the last patch in this series
> adds a crc test framework, to check consistency of different
> calculations.
> 

Thanks, I have commented individual patches, though I didn't see patch
3/3 and...

> Andy Shevchenko (1):
>   lib/crc64: add crc64 option to lib/Kconfig
> 
> Coly Li (3):
>   lib: add crc64 calculation routines
>   bcache: use routines from lib/crc64.c for CRC64 calculation
>   lib/test_crc: Add test cases for crc calculation

...this part looks weird.

Do you use `git format-patch --cover-letter`?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

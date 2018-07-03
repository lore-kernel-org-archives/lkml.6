Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BB8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF0B23CE3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF0B23CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934603AbeGCTEK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:04:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932698AbeGCTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:04:08 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faQao-0001Ac-8b; Tue, 03 Jul 2018 21:04:02 +0200
Date:   Tue, 3 Jul 2018 21:04:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/13] x86/sgx: architectural structures
In-Reply-To: <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1807032056460.1816@nanos.tec.linutronix.de>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com> <20180703182118.15024-6-jarkko.sakkinen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:

> This commit adds arch/x86/include/asm/sgx_arch.h that contains definitions

This is not a commit. Simply: Add .....

> for data structures used by the SGX.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Co-developed-by: Suresh Siddha <suresh.b.siddha@intel.com>

Documentaiton:

  A Co-Developed-by: states that the patch was also created by another developer
  along with the original author.  This is useful at times when multiple people
  work on a single patch.  Note, this person also needs to have a Signed-off-by:
  line in the patch as well.

Please fix all over the place.

> +
> +#define SGX_MISC_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL

L ? ULL I'd say...

> +#define SGX_ATTR_RESERVED_MASK 0xFFFFFFFFFFFFFFC9L

Ditto

> +#define SGX_SECS_RESERVED1_SIZE 24
> +#define SGX_SECS_RESERVED2_SIZE 32
> +#define SGX_SECS_RESERVED3_SIZE 96
> +#define SGX_SECS_RESERVED4_SIZE 3836
> +
> +struct sgx_secs {
> +	uint64_t size;
> +	uint64_t base;
> +	uint32_t ssaframesize;
> +	uint32_t miscselect;
> +	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
> +	uint64_t attributes;

Please make these tabular aligned for readility sake

> +	uint32_t	miscselect;
> +	uint8_t		reserved1[SGX_SECS_RESERVED1_SIZE];
> +	uint64_t	attributes;

Hmm? All over the place...

> +enum sgx_tcs_flags {
> +	SGX_TCS_DBGOPTIN	= 0x01, /* cleared on EADD */

Please do not use tail comments. Either put the comment above the define or
use kernel doc.

> +};
> +
> +#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL

See above.

> +#define SGX_SECINFO_PERMISSION_MASK	0x0000000000000007L
> +#define SGX_SECINFO_PAGE_TYPE_MASK	0x000000000000FF00L
> +#define SGX_SECINFO_RESERVED_MASK	0xFFFFFFFFFFFF00F8L

Ditto

Thanks,

	tglx

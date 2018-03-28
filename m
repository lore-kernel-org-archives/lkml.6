Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeC1Q70 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:59:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:53437 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbeC1Q7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:59:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="38892007"
Subject: Re: [PATCHv2 12/14] x86/mm: Implement page_keyid() using page_ext
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20180328165540.648-1-kirill.shutemov@linux.intel.com>
 <20180328165540.648-13-kirill.shutemov@linux.intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b4498b2b-5092-b347-e92d-6ebd375fd947@intel.com>
Date: Wed, 28 Mar 2018 09:59:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328165540.648-13-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2018 09:55 AM, Kirill A. Shutemov wrote:
> +static inline int page_keyid(struct page *page)
> +{
> +	if (!mktme_nr_keyids)
> +		return 0;
> +
> +	return lookup_page_ext(page)->keyid;
> +}

This doesn't look very optimized.  Don't we normally try to use
X86_FEATURE_* for these checks so that we get the runtime patching *and*
compile-time optimizations?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeCFO7H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:59:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:57351 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932659AbeCFO7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:59:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="23368702"
Subject: Re: [RFC, PATCH 13/22] mm, rmap: Free encrypted pages once mapcount
 drops to zero
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-14-kirill.shutemov@linux.intel.com>
 <e04536bc-77e9-84d0-3c23-1dfea8542da5@intel.com>
 <20180306082743.2epdfxv4ds7hz7py@node.shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <d1faf309-837b-d385-4d0a-c840fdab8b36@intel.com>
Date: Tue, 6 Mar 2018 06:59:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306082743.2epdfxv4ds7hz7py@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 12:27 AM, Kirill A. Shutemov wrote:
> +	anon_vma = page_anon_vma(page);
> +	if (anon_vma_encrypted(anon_vma)) {
> +		int keyid = anon_vma_keyid(anon_vma);
> +		free_encrypt_page(page, keyid, compound_order(page));
> +	}
>  }

So, just double-checking: free_encrypt_page() neither "frees and
encrypts the page"" nor "free an encrypted page"?

That seems a bit suboptimal. :)

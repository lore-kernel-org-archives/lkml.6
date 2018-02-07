Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbeBGSto (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:49:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:31908 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754048AbeBGStl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:49:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="16387235"
Subject: Re: [PATCHv2 0/5] x86: Enumerate TME and PCONFIG, add MKTME_KEY_PROG
 helper
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0f1e32ce-81a5-bfc8-d830-a97df5bbee8a@intel.com>
Date: Wed, 7 Feb 2018 10:49:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2018 04:59 AM, Kirill A. Shutemov wrote:
> The patchset does some ground work for MKTME enabling:
>   - Adds two new cpufeatures: TME and PCONFIG;
>   - Detects if BIOS enabled TME and MKTME;
>   - Enumerates what PCONFIG targets are supported;
>   - Provides helper to program encryption keys into CPU;
> 
> As part of TME enumeration we check of how many bits from physical address
> are claimed for encryption key ID. This may be critical as we or guest VM
> must not use these bits for physical address.

For this kind of stuff, I'd really appreciate if you included some
high-level descriptions.  I'd assume that a reviewer has no idea what
PCONFIG or MKTME is.

It would also be really nice to say which hardware will implement this.
Is it in particular CPUs today, for instance?

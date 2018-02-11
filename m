Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753671AbeBKTCr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 14:02:47 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53681 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeBKTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 14:02:45 -0500
X-Google-Smtp-Source: AH8x226L39WavUqru5AzgDYZN0HxzEvqlAUpd4uskHuDjPyN1Z8+dS4CITVDfsNYHqbX4EFmhiVKlQ==
Date: Sun, 11 Feb 2018 20:02:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/5] x86: Enumerate TME and PCONFIG, add MKTME_KEY_PROG
 helper
Message-ID: <20180211190241.nzulvhhzkb74t72o@gmail.com>
References: <20180209140754.17062-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209140754.17062-1-kirill.shutemov@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> Multikey Total Memory Encryption (MKTME)[1] is a technology that allows
> transparent memory encryption in upcoming Intel platforms.
>
> MKTME is built on top of TME. TME allows encryption of the entirety of
> system memory using a single key. MKTME allows to have multiple encryption
> domains, each having own key -- different memory pages can be encrypted
> with different keys.
> 
> The patchset does some ground work for MKTME enabling:
>   - Adds two new cpufeatures: TME and PCONFIG;
>   - Detects if BIOS enabled TME and MKTME;
>   - Enumerates what PCONFIG targets are supported;
>   - Provides helper to program encryption keys into CPU;
> 
> As part of TME enumeration we check out how many bits from physical address
> are claimed for encryption key ID. This may be critical as we or guest VM
> must not use these bits for physical address.

So how will the 'full' patchset look like, roughly - is there a tree or diffstat 
we could take a look at perhaps?

I'm also wondering how 'TME' compares to AMD's SME (Secure Memory Encryption) and 
SEV features. SME required a number of low level boot code changes - I'm wondering 
how much commonality there can be achieved with Intel's TME so that we don't end 
up with two sets of interfaces.

Thanks,

	Ingo

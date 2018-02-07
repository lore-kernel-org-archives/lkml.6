Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbeBGUwk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:52:40 -0500
Received: from terminus.zytor.com ([65.50.211.136]:52529 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754127AbeBGUwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:52:39 -0500
Subject: Re: [RFC 0/3] x86: Patchable constants
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: the arch/x86 maintainers <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180207145913.2703-1-kirill.shutemov@linux.intel.com>
 <CA+55aFxJO7kDNp6wRnU58Z6-sPbK1SqdzpgLBTAe54mdPjnd=g@mail.gmail.com>
 <8fea57cc-8772-f8b4-3298-91b0de126358@zytor.com>
Message-ID: <83ddad10-936f-9848-e3d1-8c6e73ab2969@zytor.com>
Date: Wed, 7 Feb 2018 12:43:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8fea57cc-8772-f8b4-3298-91b0de126358@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: the interface I'm implementing looks like this:

	[output =] const_op(data, variable);

... where variable can be any variable with a static address, although
in any sane scenario it should be __ro_after_init.  During
initialization, it kicks out to an out-of-line (.alternatives_aux)
handler which accesses the variable in normal fashion, but at
alternatives-patching time it inlines the relevant opcodes.

Some of the assembly infrastructure for this is indeed hairy, especially
when the out-of-line hander needs temp registers.

	-hpa

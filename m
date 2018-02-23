Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeBWTbD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:31:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:7544 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754631AbeBWTbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:31:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="177603051"
Subject: Re: [RFC PATCH v3 6/8] x86/pti: don't mark the user PGD with
 _PAGE_NX.
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
References: <1515612500-14505-1-git-send-email-w@1wt.eu>
 <1515612500-14505-7-git-send-email-w@1wt.eu>
 <CA+55aFxyx2-m8Rd5vBoncd2u-UOF=QQ-By7XwzWEfHtA=Lqp5A@mail.gmail.com>
 <CALCETrUH6s8=w6O67g39B45of6XBJv2CTt24Xw-darfb6KB42A@mail.gmail.com>
 <1515616106.22302.237.camel@amazon.co.uk>
 <20180223175811.GO8252@char.us.oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <c23cc663-9bbf-f5a1-7182-7995b4528403@linux.intel.com>
Date: Fri, 23 Feb 2018 11:30:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223175811.GO8252@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 09:58 AM, Konrad Rzeszutek Wilk wrote:
>> We also need to clear the RSB on vmexit, as documented. And if we
>> really want 100% support for retpoline on SKL+ instead of saying "use
>> IBRS if you're paranoid", then there are a few more cases where we need
>> to stuff it to avoid underflow (which is the same operation, but Arjan
>> insists we should differentiate the two, which is reasonable enough).
> Are these cases documented somewhere along with what approaches are taken?

Some of them are documented here: https://goo.gl/pXbvBE

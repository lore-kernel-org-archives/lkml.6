Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeBVWFW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:05:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:37697 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751502AbeBVWFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:05:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,380,1515484800";
   d="scan'208";a="19721303"
Subject: Re: [RFC][PATCH 04/10] x86/espfix: use kernel-default PTE mask
To: Andy Lutomirski <luto@kernel.org>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203658.80705136@viggo.jf.intel.com>
 <93613F56-C778-4EA0-8945-A0B8ABC1A5FD@vmware.com>
 <f90cef60-1710-1d99-61ee-4527067b115f@linux.intel.com>
 <CALCETrU_o5Mk5YTdN0_+2QGfEV5rQ7-MJC7_7dyjHhq+CdD3Uw@mail.gmail.com>
Cc: Nadav Amit <namit@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8fca2faa-1bac-2252-3719-8d393e2f2661@linux.intel.com>
Date: Thu, 22 Feb 2018 14:05:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU_o5Mk5YTdN0_+2QGfEV5rQ7-MJC7_7dyjHhq+CdD3Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 01:59 PM, Andy Lutomirski wrote:
>> I think it's good practice to just expose only the *minimal* amount of
>> data necessary.  It's easier to audit and less likely to expose things
>> accidentall.
> But espfix64 is geniunely global.  I'm confused.

I'm the confused one.

In my *first* set of patches to do this, I missed making the espfix64
area global.  This new code apparently got it right, but I assumed the
"new" global area that showed up was a mistake, thus this patch.

I'll change this patch into a commenting patch that calls out the need
for keeping _PAGE_GLOBAL.

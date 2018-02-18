Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeBRQrH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 11:47:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39490 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeBRQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 11:47:06 -0500
Subject: Re: Use of GCC plugin instead ISO C
To: Progyan Bhattacharya <bprogyan@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1518941218.12663.1.camel@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7bd655df-39a1-2098-0d1c-256c0900b7ed@infradead.org>
Date: Sun, 18 Feb 2018 08:47:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518941218.12663.1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/2018 12:06 AM, Progyan Bhattacharya wrote:
> Hi Again,
> 
> According to last time talked, you said me to avoid "-Werror=pedantic"
> flag to build the GNU specific plugins instead of Standard ISO C. I
> changed my default compiler flags and tried to rebuild. But I am still
> getting the same error messages at:
> 
> 	CC /***/Linux/tools/objtool/arch/x86/decode.o
> 
> All of them were arising due to same "-pedantic" flag being enabled.
> 1. Range expression in Case statements were not allowed.
> 2. Use of braced-group were not allowed in MACRO definition.
> 3. Pointer arithmetic with void pointer was not allowed.
> 
> I took a look on related Makefiles, but found none with "-pedantic" or
> "-Werror=pedantic" flag.

I didn't find "pedantic" in any Makefiles either.

You could try (re)building with V=1 on the "make" command line and capture
the output to see where the "pedantic" is coming from.

-- 
~Randy

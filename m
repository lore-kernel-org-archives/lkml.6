Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755853AbeEHVFE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:05:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54908 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEHVFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:05:02 -0400
Subject: Re: crosstool requirements?
To: Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1b8328d1-4e41-c4f9-c07b-87530e85eb7c@infradead.org>
 <CAK8P3a1fPK0eqfkehphXF9aeL0sbryzOyqD3rXej6YSrySSMwA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5405552-455d-6b68-d378-2ae87120019f@infradead.org>
Date: Tue, 8 May 2018 14:04:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1fPK0eqfkehphXF9aeL0sbryzOyqD3rXej6YSrySSMwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2018 07:35 PM, Arnd Bergmann wrote:
> On Sat, May 5, 2018 at 2:20 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> Hi Arnd,
>>
>> I was trying to use the x86_64 hosted openrisc/or1k gcc compiler (7.3.0-nolibc)
>> but I mostly what I get are errors like the following:
>>
>> crosstool/gcc-7.3.0-nolibc/or1k-linux/bin/../libexec/gcc/or1k-linux/7.3.0/cc1: error while loading shared libraries: libisl.so.15: cannot open shared object file: No such file or directory
>>
>>
>> I do have /usr/lib64/libisl.so.10 (not .15) installed on my system.
>> Am I just outofluck for doing this?
> 
> This has been pointed out by some others before, sorry for not having addressed
> it yet. I'll be back from travelling on May 22 and should be able to build a set
> of gcc-8.1 binaries without this problem, and also rebuild some of the older
> compilers to fix it (gcc-4.8 is already fixed, but IIRC doesn't
> support openrisc)
> 
> What happened here is that I built against the libraries that came
> with Ubuntu 16.04,
> intentionally picking a somewhat older distro in the hope that this
> would produce
> binaries that work on a wider range of systems, but I had it use the
> system libisl,
> libgmp, libmpfc, and libmpc rather than using the one provided by the
> gcc project
> for static linking.
> 
> You should be able to just install the binaries from
> https://launchpad.net/ubuntu/xenial/amd64/libisl15/0.16.1-1
> as well as any others you might need along with the toolchain (either
> using dpkg on Debian or Ubuntu, or extracting the .so file into an
> appropriate directory for others) until then.

Thanks.  That is working for me now.

-- 
~Randy

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeB1AXX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:23:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1AXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:23:22 -0500
Subject: Re: [PATCH v2 0/3] kbuild: fix host progs build with libs in non
 standard locations
To: Josh Poimboeuf <jpoimboe@redhat.com>,
        Robin Jarry <robin.jarry@6wind.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <cover.1519668832.git.robin.jarry@6wind.com>
 <20180227174518.qzw6eqmuyggcvjl6@treble>
 <20180227205231.t2wmh4e2ky2ganyo@6wind.com>
 <20180227213825.ht7a2ggjjxgnleys@treble>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <739369f0-14a9-fc87-3cbd-06ef7ab5dddc@infradead.org>
Date: Tue, 27 Feb 2018 16:23:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227213825.ht7a2ggjjxgnleys@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 01:38 PM, Josh Poimboeuf wrote:
> On Tue, Feb 27, 2018 at 09:52:31PM +0100, Robin Jarry wrote:
>> 2018-02-27, Josh Poimboeuf:
>>> In Documentation/kbuild/kbuild.txt, we have the following environment
>>> variables:
>>>
>>>   KCFLAGS
>>>   --------------------------------------------------
>>>   Additional options to the C compiler (for built-in and modules).
>>>   
>>>   CFLAGS_KERNEL
>>>   --------------------------------------------------
>>>   Additional options for $(CC) when used to compile
>>>   code that is compiled as built-in.
>>>   
>>>   CFLAGS_MODULE
>>>   --------------------------------------------------
>>>   Additional module specific options to use for $(CC).
>>>   
>>>   LDFLAGS_MODULE
>>>   --------------------------------------------------
>>>   Additional options used for $(LD) when linking modules.
>>>   
>>>   LDFLAGS_vmlinux
>>>   --------------------------------------------------
>>>   Additional options passed to final link of vmlinux.
>>>
>>> So instead of
>>>
>>>   HOST_CFLAGS
>>>   HOST_LDFLAGS
>>>
>>> maybe it would be more consistent to call them
>>>
>>>   CFLAGS_HOST
>>>   LDFLAGS_HOST
>>>
>>> ?
>>
>> I had missed this file. Indeed {C,LD}FLAGS_HOST are much less confusing!
>>
>>> Also, the new environment variables should be documented in the above
>>> file.
>>
>> Sure, I'll do that. However, I feel like I should also leave the
>> paragraph in Documentation/admin-guide/README.txt.
>>
>> What do you think?
> 
> [ Adding Jon Corbet to CC in case he has an opinion. ]
> 
> I think that paragraph in the admin guide seems a bit out of place,
> because that file only seems to cover the most common cases.
> 
> No other env variables are described in that file (and some of the
> previously existing env variables are much more likely to be used than
> these new ones anyway).
> 
> It might be a good idea to instead just add a reference to kbuild.txt,
> suggesting the user refer to that file if they want to learn more about
> what env variables can be used to customize the build.

(IMHO :)  I agree, the addition to admin-guide/README.rst (not .txt) is in
the wrong place, although it could contain a pointer to kbuild/ like Josh says.

And if you do move that text to kbuild/, please change "non standard" to
"non-standard" in 2 places.

thanks,
-- 
~Randy

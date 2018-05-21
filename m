Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeEUAtS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 20:49:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37615 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751094AbeEUAtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 20:49:14 -0400
X-ME-Proxy: <xmx:ihcCWzXiD0JZslhWby2_0hRE8hauXHrtStQ03dtClPicR5xXk8HOmQ>
X-ME-Proxy: <xmx:ihcCW7zkIxkKF85J5g1xCu7TCoClJf93hei43HDvHEVz2bgUaLPbjQ>
X-ME-Proxy: <xmx:ihcCWxOV8wDPkOLAdO4aGx-lItVl62jkXsbFPdzQ7VYUklUWGVuA8Q>
X-ME-Proxy: <xmx:ihcCW84I8BBKb9xCyk8lnrMKuN0kyZiH2RD5sZsby-TdhK_-wrsIyQ>
X-ME-Proxy: <xmx:ihcCWyO_nD1iM2SQLK6s7k7Iq81v9t8Vp3r3z9lpmVXMTBL8xDxOcw>
X-ME-Proxy: <xmx:ihcCW5Qjdn3rGJQNsobiDi4cy5g0zPawuakz3Rrkbuo1UAn8QDQCCw>
X-ME-Sender: <xms:ihcCW1AHXElQxjAN9Yu3S2vW-LCprjsLkLlQ7KuKR1acyNayxxU7Sg>
Subject: Re: mmotm 2018-05-17-16-26 uploaded (autofs)
From: Ian Kent <raven@themaw.net>
To: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20180517232639.sD6Cz%akpm@linux-foundation.org>
 <19926e1e-6dba-3b9f-fd97-d9eb88bfb7dd@infradead.org>
 <49acf718-da2e-73dc-a3bf-c41d7546576e@themaw.net>
 <9e3dfece-46a0-8ab2-2c7e-3edf956703a8@infradead.org>
 <6441e45b-6216-a20a-5b1d-6f5663d701dd@themaw.net>
 <80c2dcf5-b9a9-3d75-7f6f-d0e9c1a11fb9@themaw.net>
 <22ae3b7e-bfbd-6537-9656-9fd429255d69@infradead.org>
 <d225202d-fcba-851d-63a6-ae6a1c3ae0e7@themaw.net>
Message-ID: <11712bc6-9d45-7bb1-4e88-720ee3e312dd@themaw.net>
Date: Mon, 21 May 2018 08:49:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d225202d-fcba-851d-63a6-ae6a1c3ae0e7@themaw.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/18 08:43, Ian Kent wrote:
>>>
>>> It looks like adding:
>>> depends on AUTOFS_FS = n && AUTOFS_FS != m
>>
>> Hi.  Is there a typo on the line above?

LOL, but your point is what does the AUTOFS_FS != m do!

The answer should be nothing but ..... I'll have to play
a little more.

> 
> Don't think so.
> 
> This was straight out of:
> 
> diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
> index 53bc592a250d..2f9bafabac1b 100644
> --- a/fs/autofs4/Kconfig
> +++ b/fs/autofs4/Kconfig
> @@ -1,6 +1,7 @@
>  config AUTOFS4_FS
>         tristate "Kernel automounter version 4 support (also supports v3 and v5)"
>         default n
> +       depends on AUTOFS_FS = n && AUTOFS_FS != m
>         help
>           The automounter is a tool to automatically mount remote file systems
>           on demand. This implementation is partially kernel-based to reduce
> @@ -30,3 +31,10 @@ config AUTOFS4_FS
>           - any "alias autofs autofs4" will need to be removed.
>  
>           Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
> +
> +         NOTE: Since the modules autofs and autofs4 use the same file system
> +               type name of "autofs" only one can be built. The "depends"
> +               above will result in AUTOFS4_FS not appearing in .config for
> +               any setting of AUTOFS_FS other than n and AUTOFS4_FS will
> +               appear under the AUTOFS_FS entry otherwise which is intended
> +               to draw attention to the module rename change.
> 
> which appears to do what's needed about as well as can be done and deals
> with the AUTOFS4_FS=y && AUTOFS_FS=y case.
> 
> Ian
> 

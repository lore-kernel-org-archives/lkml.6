Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966833AbeE3A2X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 20:28:23 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:54506
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965323AbeE3A2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 20:28:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DnAACH7w1b/zXSMGcNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGDGYENbTqDd5U3AQEBAQEBBn8IIXUalTMqhE0Cgjg4FAECAQEBAQE?=
 =?us-ascii?q?BAoEIhTUBAQEDIxVBEAsNCwICJgICVwYBDAYCAQGDHgKBchykS22CHBqEPoNqg?=
 =?us-ascii?q?WMFgQmIOYEHgQ8kDIIoNYJ6hHmCVAKHI5E/CAGFbIJXhhcIh3iFDIlsiHeBczM?=
 =?us-ascii?q?aCCgIgn4fggEXEWkBAYddhVBdkAQBAQ?=
X-IPAS-Result: =?us-ascii?q?A2DnAACH7w1b/zXSMGcNTxoBAQEBAQIBAQEBCAEBAQGDGYE?=
 =?us-ascii?q?NbTqDd5U3AQEBAQEBBn8IIXUalTMqhE0Cgjg4FAECAQEBAQEBAoEIhTUBAQEDI?=
 =?us-ascii?q?xVBEAsNCwICJgICVwYBDAYCAQGDHgKBchykS22CHBqEPoNqgWMFgQmIOYEHgQ8?=
 =?us-ascii?q?kDIIoNYJ6hHmCVAKHI5E/CAGFbIJXhhcIh3iFDIlsiHeBczMaCCgIgn4fggEXE?=
 =?us-ascii?q?WkBAYddhVBdkAQBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,458,1520870400";
   d="scan'208";a="84602333"
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@lst.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
 <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
 <alpine.LNX.2.21.1805271547090.9@nippy.intranet>
 <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet>
 <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
From: Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <10880132-7686-78f6-7f9f-3fc29c3e554a@linux-m68k.org>
Date: Wed, 30 May 2018 10:28:15 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 28/05/18 20:15, Geert Uytterhoeven wrote:
> On Mon, May 28, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> On Mon, 28 May 2018, Michael Schmitz wrote:
>>> Am 27.05.2018 um 17:49 schrieb Finn Thain:
>>>> On Sun, 27 May 2018, Michael Schmitz wrote:
>>>>
>>>>> That should have fixed the warning already ...
>>>>
>>>> It's still not fixed (hence my "acked-by" for Geunter's patch).
>>>>
>>>
>>> Odd - does link order still matter even though the
>>> arch_setup_dev_archdata() function from the core platform code is
>>> declared as a weak symbol?
>>>
>>> I'll see what I can find out on elgar ...
>>>
>>
>> Any one of the numerous patches/rfcs/suggestions that I sent will avoid
>> the WARN splat.
>>
>> When I said "it's still not fixed", what I meant to say was, "it's still
>> not fixed in mainline and no proposed fix was accepted to the best of my
>> knowledge".
> 
> Indeed.
> 
> Do we have a consensus on the way forward? The merge window for
> v4.18 will open soon.

For whatever it is worth I thought Finn's patch was the best approach
(https://lkml.org/lkml/2018/5/17/333, "m68k: Set default dma mask for
platform device").

We seem to be hitting quite a few places (within m68k) that otherwise
need individual fixes. There is no immediate need to revert existing
changes that have already been applied if we use this now either
(like my FEC fix, commit f61e64310b75 "m68k: set dma and coherent
masks for platform FEC ethernets").

Regards
Greg

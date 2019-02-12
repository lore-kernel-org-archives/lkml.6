Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB68C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4356F21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfBLIE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:04:28 -0500
Received: from mail.sysgo.com ([176.9.12.79]:33946 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfBLIE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:04:28 -0500
Subject: Re: [PATCH RESEND] initramfs: cleanup incomplete rootfs
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181022134048.19693-1-david.engraf@sysgo.com>
 <20181030151805.5519-1-david.engraf@sysgo.com>
 <CAHp75VdOSC8j_1G3z-UO01_JYN20M-YMGOC2JkFDhi8njNZAvA@mail.gmail.com>
 <20190208140810.76ef6c25825a5644d9625f0a@linux-foundation.org>
 <CAHp75VdWyGv2QyuwE+4-oFJt8St2UmeuaHhveeLAFPPPuN5=tg@mail.gmail.com>
 <20190211165638.e7820ab0491bbef8a0ca960e@linux-foundation.org>
From:   David Engraf <david.engraf@sysgo.com>
Message-ID: <3443b6a3-541e-0c37-2431-d86f95d45528@sysgo.com>
Date:   Tue, 12 Feb 2019 09:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190211165638.e7820ab0491bbef8a0ca960e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.19 at 01:56, Andrew Morton wrote:
> On Sat, 9 Feb 2019 12:35:03 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> On Sat, Feb 9, 2019 at 12:08 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>>> On Fri, 8 Feb 2019 21:45:21 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>> On Tue, Oct 30, 2018 at 5:22 PM David Engraf <david.engraf@sysgo.com> wrote:
>>>>>
>>>>> Unpacking an external initrd may fail e.g. not enough memory. This leads
>>>>> to an incomplete rootfs because some files might be extracted already.
>>>>> Fixed by cleaning the rootfs so the kernel is not using an incomplete
>>>>> rootfs.
>>>>
>>>> This breaks my setup where I have U-boot provided more size of
>>>> initramfs than needed. This allows a bit of flexibility to increase or
>>>> decrease initramfs compressed image without taking care of bootloader.
>>>> The proper solution is to do this if we sure that we didn't get enough
>>>> memory, otherwise I can't consider the error fatal to clean up rootfs.
>>>
>>> OK, thanks.  Maybe David can suggest a fix - I'll queue up a revert
>>> meanwhile.
>>>
>>> I don't really understand the failure.  Why does an oversized initramfs
>>> cause unpack_to_rootfs() to fail?
>>
>> In my case I have got "Junk in compressed archive". I don't know (I
>> would check if needed) which exact condition I got  since there are
>> three places with this message.
> 
> Well that's a plain irritating screwup right there.  Could someone
> please cook up a patch to give us three distinct (and hopefully more
> informative) error messages?

Done. BTW "invalid magic at start of compressed archive" is the error we 
get with the patch.

Best regards
- David



Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85489C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214842159F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="ZQaXB9Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214842159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935395AbeF1Mb1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:31:27 -0400
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:55338 "EHLO
        elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932371AbeF1MbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1530189220; bh=NuVUqOZd5NvmBZDH7yEXiDcTvQ5r+3SC+wQ1
        6TtMXhQ=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=ZQaXB9C
        k0O4rrx4E0KVY2zsPXijXZrTvBinPRLTbZg6quTJpTEjd+u4T0D+JPBoqkNOgxUiuRx
        1WRdu0nCEblZhl7/o2aIrEn13CoFNY9Ht6k1eS79JrgAnvWZsLGZDl11DKYeQivwXsu
        KYesQ47W5pSIUdvuH3CTfM5JnQW9IS+Sn7kYsuTWnAY5sGezV4ulOzxELX6qSA2AjWI
        2hqNbr2Qr2DX6x9kEGL1qBNJdxBNHxNf6Ds5q3b4A/GYwJnToC1Ln02p8goyHi0TYOt
        qJzdVffPSIimWpM2zwSGzyNJzUsrmBsQrszijkYYDXkagw0kowZxQgMK/YE4GY5/Z+Q
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=LICP4tzpwfuA/MZoTzai1Mgm8RAKY5sdgn3CLdO8MnYeA01TCKCeEGYt3YH029pJF6gq/GlPMNRjfsh0NNAlAvh+wTuXi+HwSfuWTdpIckR0Zd0BISV33GQvQvmIJDS5a5h7r9kIXCPg1HsEhG4BpyuahQDuq/jwIE49gTHNA6zr1H0mnB4gHiRmmBgxbjx7yg6NbYn68pTqBG4JEhWrDUZvXbZioo8B989coH1cZxNVsY3n2Btcbf8R4JU9M+BQ+r5vgsLtqwSV2v4nsqD3LmQOqOBbvvCfVQG8Er0fwhLe03Zmeq/BNYJ0niHP/7re2zcI1zP2L0XblTp8ee4ucA==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fYW7E-000A9f-1b; Thu, 28 Jun 2018 08:33:36 -0400
Subject: Re: Amiga RDB partition support for disks >= 2 TB
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <a8bef8a7-7b99-bc91-87b6-f9e4e838a4b8@earthlink.net>
 <4710936.m2SbBcP6dP@merkaba> <51008870.LIDn3ZZdjm@merkaba>
From:   jdow <jdow@earthlink.net>
Message-ID: <6b25bd4b-d218-55a0-6687-b17fbf7e5c97@earthlink.net>
Date:   Thu, 28 Jun 2018 05:31:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <51008870.LIDn3ZZdjm@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711209cf7ffa7a2ea36230d23ed728364599e87a9675ac443faa4350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20180628 04:38, Martin Steigerwald wrote:
> Martin Steigerwald - 28.06.18, 13:30:
>> jdow - 28.06.18, 12:00:
>>> On 20180628 01:16, Martin Steigerwald wrote:
>> […]
>>
>>>>> That brings to the fore an interesting question. Why bother with
>>>>> RDBs
>>>>> over 2TB unless you want a disk with one single partition? This
>>>>> Win10
>>>>> monster I am using has a modest BIOS driver partition for the OS
>>>>> and
>>>>> a giant data partition. That smaller partition would easily work
>>>>> with
>>>>> any RDB/Filesystem combination since 2.0. So there are some good
>>>>> workarounds that are probably "safer" and at least as flexible as
>>>>> RDBs, one Linux has used for a very long time, too.
>>>>
>>>> Well, my use case was simple:
>>>>
>>>> I had this 2 TB disk and I choose to share it as a backup disk for
>>>> Linux *and* AmigaOS 4.x on that Sam440ep I still have next to me
>>>> desk here.
>>>
>>> EEEEEEK! The hair on my neck is standing up straight! Have you heard
>>> of SAMBA? The linux mail server firewall etc machine has an extra
>>> 4TB
>>> disk on it as a backup for the other systems, although a piddly 4TB
>>> is small when I save the entire 3G RAID system I have. It's a proof
>>> of concept so.... A full backup on a 1gig Ethernet still takes a
>>> looooong time. But backing up even an 18GB disk on an Amiga via
>>> 100Base-t isn't too bad. And disk speeds of the era being what they
>>> were it's about all you can do anyway.
>>
>> Heh, the thing worked just fine in Amiga OS 4. I got away with it
>> without an issue, until I plugged the disk to my Linux laptop and
>> wrote data onto the Linux file system. Mind you, I think in that
>> partition marked LNX\0 I even created a Linux LVM with pvcreate. Do
>> you call that insane? Well it probably is. :)
>>
>> And as an Amiga user I could just return to you: I clicked it, it did
>> not warn, so all is good :)
>>
>> But yeah, as mentioned I researched the topic before. And I think
>> there
>> has not even been an overflow within the RDB:
>>> The raw, theoretical limit on the maximum device capacity is about
>>> 2^105 bytes:
>>>
>>> 32 bit rdb_Cylinders * 32 bit rdb_Heads * 32 bit rdb_Sectors * 512
>>> bytes/sector for the HD size in struct RigidDiskBlock
>>
>> http://wiki.amigaos.net/wiki/RDB_(Amiga_Rigid_Disk_Block)
>>
>> Confirmed by:
>>
>> The .ADF (Amiga Disk File) format FAQ:
>> http://lclevy.free.fr/adflib/adf_info.html#p6
>>
>> But what do I write, you know the RDB format :)
>>
>> So just do the calculation in 96 Bit and you all are set :)
> 
> For sectors.
> 
> Or
> 
> 3*32+9 (for 512 bytes per sector) = 105 bits
> 
> for bytes.
> 
>> Now that is a reason for 128 Bit CPUs :).
>>
>> Muuhahaha.

And if you make the logical block size 65536 you need 128 bits or 10^something 
big = 2^128.
{^_-}

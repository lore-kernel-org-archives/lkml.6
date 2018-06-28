Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0F4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C3257EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="ZrDljvUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985C3257EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeF1C6A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:58:00 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:41506 "EHLO
        elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932114AbeF1C56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1530154694; bh=WaV70I98Rpozxoa/E/lptE407Ek9D5w4FHuk
        aZX3N8c=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=ZrDljvU
        P2SI36Jr/A+sKbvO5+si0Sh3A8KiXu9paJMci2YyeImrrm8SH5OCGJhXHcDZpfuZ/ey
        KN4Zr1UrBf6y/ANUwezS3f1SsfpSVCsDjrUyxbVSgOEoBw/G2Rye1NaKm+Vv7RAPJsE
        OECXqRRZJT1iHtP8kGc0gYBkmS7H2Qr0NdWbP51riRvAgpMsQAT0N0f7z53o4d3UBHo
        lNb8cyywsyavy8rIsXTrXqCQyP7oURfy1KSMI6f0AHDcQjLHim3IZ/JamCkEKHkdM34
        qTe/Ca9ITm/VS2KGpRqq5UvXeZqB8LRjlAx1pJVU3sNTfDtCcB1oF1tYbRi9WAeI9ow
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=DtMfX/Dv20NtkOwwVLr+VdLLXD0+boNzdnpn6xqdebhzZCO7C5MVhPzmLnTKkWHrKZCWDyStWcv5zRorDCc7G8ZV6oXV6extFOkWBl+wPhO/0uf3SNjI9sJ6R/X3I0UhR8OqtM/PAliAm+NWI51z8gHWFFuUP02nBPN6GBEAnThd55HWXxTjRnOadTi9/Hyl6qEZnizhyxpL8czuoAzAEf7qdvUbdH6zmptnyYC/y/sFggUFbYnvOqDQjUEQ1B5qZVNBsb9lThqyzc6UmpwrCMmiXNaMbLVTwQEP41zaSwnDBjieusQ54/dBLy8syqr5Fk5GTCfENYzxcxWVsAWrzw==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fYN8I-0008o6-Im; Wed, 27 Jun 2018 22:58:06 -0400
Subject: Re: moving affs + RDB partition support to staging?
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
 <CAOmrzkKLJiWvDwsER0ca09UJbi57Rj6PUmdxizSNPXzZLMErOA@mail.gmail.com>
 <83f7c594-b24e-69f5-03fb-3c9229d15438@earthlink.net>
 <3093795.YrKfDMMbMq@merkaba>
From:   jdow <jdow@earthlink.net>
Message-ID: <0f1f0b33-e9db-6f71-e3a2-846898b792a7@earthlink.net>
Date:   Wed, 27 Jun 2018 19:57:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3093795.YrKfDMMbMq@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711209cf7ffa7a2ea36238e4a60458f8e496b674d26ee3fc7409a350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue is what happens when one of those disks appears on a 3.1 system.
{^_^}

On 20180627 01:03, Martin Steigerwald wrote:
> Dear Joanne.
> 
> jdow - 27.06.18, 08:24:
>> You allergic to using a GPT solution? It will get away from some of
>> the evils that RDB has inherent in it because they are also features?
>> (Loading a filesystem or DriveInit code from RDBs is just asking for
>> a nearly impossible to remove malware infection.) Furthermore, any 32
>> bit system that sees an RDSK block is going to try to translate it.
>> If you add a new RDB format you are going to get bizarre and probably
>> quite destructive results from the mistake. Fail safe is a rather
>> good notion, methinks.
>>
>> Personally I figure this is all rather surreal. 2TG of junk on an
>> Amiga system seems utterly outlandish to me. You cited another
>> overflow potential. There are at least three we've identified, I
>> believe. Are you 100% sure there are no more? The specific one you
>> mention of translating RDB to Linux has a proper solution in the RDB
>> reader. It should recover such overflow errors in the RDB as it can
>> with due care and polish. It should flag any other overflow error it
>> detects within the RDBs and return an error such as to leave the disk
>> unmounted or mounted read-only if you feel like messing up a poor
>> sod's backups. The simple solution is to read each of the variables
>> with the nominal RDB size and convert it to uint64_t before
>> calculating byte indices.
>>
>> However, consider my inputs as advice from an adult who has seen the
>> Amiga Elephant so to speak. I am not trying to assert any control. Do
>> as you wish; but, I would plead with you to avoid ANY chance you can
>> for the user to make a bonehead stupid move and lose all his
>> treasured disk archives. Doing otherwise is very poor form.
> 
> I am pretty confident that larger than 2 TiB disks are fully supported
> within AmigaOS 4, as I outlined in my other mail.
> 
> So with all due respect: I used a larger than 2 TiB disk in AmigaOS 4 in
> 2012 already *just* fine. I even found I had the same questions back
> then, and researched it. Which lead to this official article back then:
> 
> http://wiki.amigaos.net/wiki/RDB
> 
> I am also pretty sure that AmigaOS still uses RDB as partitioning
> format. They support MBR. I don´t think AmigaOS 4.1 supports GPT.
> Whether to implement that of course is the decision of AmigaOS 4
> development team. I am no longer a member of it since some time.
> 
> Linux m68k should already be able to use disks in GPT format, but you
> likely won´t be able to read them in AmigaOS, unless there is some third
> party support for it meanwhile.
> 
> Thanks,
> Martin
> 
>>
>> {o.o}   Joanne "Said enough, she has" Dow
>>
>> On 20180626 18:07, Michael Schmitz wrote:
>>> Joanne,
>>>
>>> As far as I have been able to test, the change is backwards
>>> compatible (RDB partitions from an old disk 80 GB disk are still
>>> recognized OK). That"s only been done on an emulator though.
>>>
>>> Your advice about the dangers of using RDB disks that would have
>>> failed the current Linux RDB parser on legacy 32 bit systems is well
>>> taken though. Maybe Martin can clarify that for me - was the 2 TB
>>> disk in question ever used on a 32 bit Amiga system?
>>>
>>> RDB disk format is meant for legacy use only, so I think we can get
>>> away with printing a big fat warning during boot, advising the user
>>> that the oversize RDB partition(s) scanned are not compatible with
>>> legacy 32 bit AmigaOS. With the proposed fix they will work under
>>> both AmigaOS 4.1 and Linux instead of truncating the first
>>> overflowing partition at disk end and trashing valid partitions
>>> that overlap, which is what Martin was after.
>>>
>>> If that still seems too risky, we can make the default behaviour to
>>> bail out once a potential overflow is detected, and allow the user
>>> to
>>> override that through a boot parameter. I'd leave that decision up
>>> for the code review on linux-block.
>>>
>>> Two more comments: Linux uses 512 byte block sizes for the partition
>>> start and size calculations, so a change of the RDB blocksize to
>>> reduce the block counts stored in the RDB would still result in the
>>> same overflow. And amiga-fdisk is indeed utterly broken and needs
>>> updating (along with probably most legacy m68k partitioners). Adrian
>>> has advertised parted as replacement for the old tools - maybe this
>>> would make a nice test case for parted?
>>>
>>> Cheers,
>>>
>>>     Michael
>>>
>>> On Tue, Jun 26, 2018 at 9:45 PM, jdow <jdow@earthlink.net> wrote:
>>>> If it is not backwards compatible I for one would refuse to use it.
>>>> And if it still mattered that much to me I'd also generate a
>>>> reasonable alternative. Modifying RDBs nay not be even an
>>>> approximation of a good idea. You'd discover that as soon as an
>>>> RDB uint64_t disk is tasted by a uint32_t only system. If it is
>>>> for your personal use then you're entirely free to reject my
>>>> advice and are probably smart enough to keep it working for
>>>> yourself.
>>>>
>>>> GPT is probably the right way to go. Preserve the ability to read
>>>> RDBs for legacy disks only.
>>>>
>>>> {^_^}
>>>>
>>>> On 20180626 01:31, Michael Schmitz wrote:
>>>>> Joanne,
>>>>>
>>>>> I think we all agree that doing 32 bit calculations on 512-byte
>>>>> block
>>>>> addresses that overflow on disks 2 TB and larger is a bug, causing
>>>>> the issues Martin reported. Your patch addresses that by using
>>>>> the correct data type for the calculations (as do other partition
>>>>> parsers that may have to deal with large disks) and fixes
>>>>> Martin's bug, so appears to be the right thing to do.
>>>>>
>>>>> Using 64 bit data types for disks smaller than 2 TB where
>>>>> calculations don't currently overflow is not expected to cause
>>>>> new issues, other than enabling use of disk and partitions larger
>>>>> than 2 TB (which may have ramifications with filesystems on these
>>>>> partitions). So comptibility is preserved.
>>>>>
>>>>> Forcing larger block sizes might be a good strategy to avoid
>>>>> overflow
>>>>> issues in filesystems as well, but I can't see how the block size
>>>>> stored in the RDB would enforce use of the same block size in
>>>>> filesystems. We'll have to rely on the filesystem tools to get
>>>>> that right, too. Linux AFFS does allow block sizes up to 4k (VFS
>>>>> limitation) so this should allow partitions larger than 2 TB to
>>>>> work already (but I suspect Al Viro may have found a few issues
>>>>> when he looked at the AFFS code so I won't say more). Anyway
>>>>> partitioning tools and filesystems are unrelated to the Linux
>>>>> partition parser code which is all we aim to fix in this patch.
>>>>>
>>>>> If you feel strongly about unknown ramifications of any
>>>>> filesystems on partitions larger than 2 TB, say so and I'll have
>>>>> the kernel print a warning about these partitions.
>>>>>
>>>>> I'll get this patch tested on Martin's test case image as well as
>>>>> on a RDB image from a disk known to currently work under Linux
>>>>> (thanks Geert for the losetup hint). Can't do much more without
>>>>> procuring a working Amiga disk image to use with an emulator,
>>>>> sorry. The Amiga I plan to use for tests is a long way away from
>>>>> my home indeed.
>>>>>
>>>>> Cheers,
>>>>>
>>>>>        Michael
>>>>>
>>>>> Am 26.06.18 um 17:17 schrieb jdow:
>>>>>> As long as it preserves compatibility it should be OK, I suppose.
>>>>>> Personally I'd make any partitioning tool front end gently force
>>>>>> the
>>>>>> block size towards 8k as the disk size gets larger. The file
>>>>>> systems
>>>>>> may also run into 2TB issues that are not obvious. An unused
>>>>>> blocks
>>>>>> list will have to go beyond a uint32_t size, for example. But a
>>>>>> block
>>>>>> list (OFS for sure, don't remember for the newer AFS) uses a tad
>>>>>> under 1% of the disk all by itself. A block bitmap is not quite
>>>>>> so bad. {^_-}
>>>>>>
>>>>>> Just be sure you are aware of all the ramifications when you make
>>>>>> a
>>>>>> change. I remember thinking about this for awhile and then
>>>>>> determining I REALLY did not want to think about it as my brain
>>>>>> was getting tied into a gordian knot.
>>>>>>
>>>>>> {^_^}
>>>>>>
>>>>>> On 20180625 19:23, Michael Schmitz wrote:
>>>>>>> Joanne,
>>>>>>>
>>>>>>> Martin's boot log (including your patch) says:
>>>>>>>
>>>>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512)
>>>>>>> sdb1
>>>>>>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res
>>>>>>> 2 spb
>>>>>>> 4)
>>>>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
>>>>>>> Attached SCSI disk
>>>>>>>
>>>>>>> so it's indeed a case of self inflicted damage (RDSK (512) means
>>>>>>> 512
>>>>>>> byte blocks) and can be worked around by using a different block
>>>>>>> size.
>>>>>>>
>>>>>>> Your memory serves right indeed - blocksize is in 512 bytes
>>>>>>> units.
>>>>>>> I'll still submit a patch to Jens anyway as this may bite others
>>>>>>> yet.
>>>>>>>
>>>>>>> Cheers,
>>>>>>>
>>>>>>>       Michael
>>>>>>>
>>>>>>> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net>
> wrote:
>>>>>>>> BTW - anybody who uses 512 byte blocks with an Amiga file
>>>>>>>> system is
>>>>>>>> a famn
>>>>>>>> dool.
>>>>>>>>
>>>>>>>> If memory serves the RDBs think in blocks rather than bytes so
>>>>>>>> it
>>>>>>>> should
>>>>>>>> work up to 2 gigablocks whatever your block size is. 512 blocks
>>>>>>>> is
>>>>>>>> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk
>>>>>>>> in
>>>>>>>> block maps.
>>>>>>>> Go up to 4096 or 8192. The latter is 35 TB.
>>>>>>>>
>>>>>>>> {^_^}
>>>>>>>>
>>>>>>>> On 20180624 02:06, Martin Steigerwald wrote:
>>>>>>>>> Hi.
>>>>>>>>>
>>>>>>>>> Michael Schmitz - 27.04.18, 04:11:
>>>>>>>>>> test results at
>>>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>>>>>>>> indicate the RDB parser bug is fixed by the patch given
>>>>>>>>>> there, so if
>>>>>>>>>> Martin now submits the patch, all should be well?
>>>>>>>>>
>>>>>>>>> Ok, better be honest than having anyone waiting for it:
>>>>>>>>>
>>>>>>>>> I do not care enough about this, in order to motivate myself
>>>>>>>>> preparing the a patch from Joanne Dow´s fix.
>>>>>>>>>
>>>>>>>>> I am not even using my Amiga boxes anymore, not even the
>>>>>>>>> Sam440ep
>>>>>>>>> which
>>>>>>>>> I still have in my apartment.
>>>>>>>>>
>>>>>>>>> So RDB support in Linux it remains broken for disks larger 2
>>>>>>>>> TB,
>>>>>>>>> unless
>>>>>>>>> someone else does.
>>>>>>>>>
>>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> linux-m68k" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at
>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> linux-m68k" in the body of a message to
>>>>>> majordomo@vger.kernel.org
>>>>>> More majordomo info at
>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-m68k" in the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

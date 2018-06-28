Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD70E26FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="Ep9WgLvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD70E26FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeF1Gj2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:39:28 -0400
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:35188 "EHLO
        elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932136AbeF1GjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1530168071; bh=PVSpwEHTreNBauQ4k8kVvIJBZhKjz9QKDPsJ
        agzYGPI=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=Ep9WgLv
        X/s9d3IoYElr9zsOELH72FeOAWju0WmPK84zq0Q8yDTmynbWYd3muzKrg2yvOETirwH
        zCCYfMJkUPfKwT26qCmS5CDlzguCMTsMxp8z1Jofq0/THPYniMA20LmijxonzwthCuO
        5mYsA2iqcHtZxUNDMdjnLnTm8h8ThmgDTmX7EYcqnYS7HSWpYvFMKDR+BukUsFA8gQh
        /LHxwfExcJbWLBelP76hrx/xDNLDwTaZRek/mbp0F11CN3AngDyQfbXjbsjREojSKvx
        FayGqdgNSV7afKMdc63/Cs5gvaSQ8K7rt3AwejjIa8ObCwhGrXvHziuZHCeRI/pmf1A
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=cwLfwtbMHV4wj15MRDp9Lne6uTJYgNcGLUEd26Rl+DRdbQ/mvfxBYJd4c4cOdyeMjxFAvYZrIWtGeJxfvbjFf1ck4/yJ20JSwDpokiKCalFiCzolvyjsZwspeTenu+e80dlxgQhwj/t/1+edUy5NHlIp0ya0Cmf5AYJHbOgsRAy15R8nbcI+E7oAUv+kC2OEF3oMlDJQ2te+ruIaoENNa/PIfu18T1u8XNM/iLK6P5/anxBoCx7JMJ0w6r9TtJMcH8nP2/LY7soS9ELNlsLJJuk2caaLwYhby626TXfyrwNtmRRvLKjHZPWZSkyLS25rb802HksGKvdUGGevFBKsIQ==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fYQc6-0001KG-Bc; Thu, 28 Jun 2018 02:41:06 -0400
Subject: Re: moving affs + RDB partition support to staging?
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba>
 <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
 <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
 <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
 <00416cde-ddda-a9e6-f4e8-ee424b2e2a1c@gmail.com>
 <8ef4bdc6-4ed0-675e-e26d-0b6e7ab4a00e@earthlink.net>
 <CAOmrzkKLJiWvDwsER0ca09UJbi57Rj6PUmdxizSNPXzZLMErOA@mail.gmail.com>
 <83f7c594-b24e-69f5-03fb-3c9229d15438@earthlink.net>
 <c5691a23-dc03-be49-6213-ee24afe72087@gmail.com>
 <b1b9944d-c31b-1c06-555a-b9603bdb3f87@earthlink.net>
 <c552b9e3-03ff-75ef-18e1-35d39cfdaca5@gmail.com>
From:   jdow <jdow@earthlink.net>
Message-ID: <07b0cd8a-a353-ba45-07a1-d0e5bb80b83f@earthlink.net>
Date:   Wed, 27 Jun 2018 23:39:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c552b9e3-03ff-75ef-18e1-35d39cfdaca5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711209cf7ffa7a2ea3623b155e9a7ac68dd9b1a036a86675380a6350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anything done to RDBs for Linux must remain 100.000% compatible with existing 
Amiga equipment. Otherwise, what's the point of bothering to use RDBs?

Note, as an experiment I had a CrossDOS partition on a hard disk briefly. So 
some amazing nonsense is possible. I concluded that for me it was not something 
I wanted to do. Alternative techniques worked well enough.

That brings to the fore an interesting question. Why bother with RDBs over 2TB 
unless you want a disk with one single partition? This Win10 monster I am using 
has a modest BIOS driver partition for the OS and a giant data partition. That 
smaller partition would easily work with any RDB/Filesystem combination since 
2.0. So there are some good workarounds that are probably "safer" and at least 
as flexible as RDBs, one Linux has used for a very long time, too.

With that it is easy in concept to put together a dual boot system with all the 
disks and partitions readable if you play the proper games at the filesystem 
level and keep individual partitions small. The filesystem would have to take on 
some of the attributes of a device driver, though. A 281 TB disk made up of 2 TB 
partitions should be possible to create if you think it through. (Note that with 
RDBs the CHS disk description is purely an abstraction that has no relationship 
to anything inside the disk. The same tricks could exist at the filesystem level.)

As for existing tools screwing up, do you think that is an excuse to perpetuate 
the failure?

If we are speaking Linux for m68k, what does it do when confronted with which is 
described with a size larger than 32 bits? Before it had everything inside it 
that refers to positions within a file by byte index with an __int64 type of 
storage did it throw up it's hands, corrupt the disk, or what? If the m68k Linux 
is a failure perhaps it doesn't matter what you do for Linuxoids. (I'll stick 
with the x64 version in that case. And I never go back to earlier versions for 
games since I consider a good compiler is the best game around. It's better than 
a blank piece of paper for possibilities.)

As I have said, for the RDB parser fix the famndool thing. Do fix it right in 
such a manner that if somebody compiles it against a version with no 64 bit 
device code it will throw a proper overflow error and protect the user. Users 
are dumb. We like to think of ourselves as smart. Let's try to be smart about 
this where we can so fingers can't point back at us rather than the fool that 
made some other error.

And do remember, I am merely (and vociferously) advising rather than dictating. 
You don't need my approval to proceed. I may want my name noted as an early 
contributor only. Meanwhile I spit out ideas as they come to me. One or more of 
them might be good. And offering alternatives is better than simply saying "No" 
most of the time.

If people are using RDBs for TB level disks I doubt they can remember which is 
the left shoe when they are getting dressed in the morning before going out in 
the yard to beat some dead horses. Or else maybe they just want to see how far 
they can flog the m68k architecture as a mental challenge. In that case, taking 
it too seriously could hurt. Note that I am mostly ignoring m68k Linux. People 
using that are hard core. People using x86/x64 Linux aren't such hard core 
folks. And I bet most of them want to read the disks so they can copy stuff to 
Amiga Forever or WinUAE running on other architectures. So TB is not likely to 
be an issue for them, either.

{^_^}

On 20180627 22:43, Michael Schmitz wrote:
> Joanne,
> 
> Linux on m68k has supported lseek64 (or llseek) for a long time (from glibc 
> version 2.1 according to what I found). About the only area where we are limited 
> by 32 bits is the virtual memory size.
> 
> I'm not proposing to modify the RDB format definition, though an extension to 
> store 64 bit offsets separate from the 32 bit ones would be one way to make 
> certain such disks are safe to use on 3.1 and earlier versions of AmigaOS. 
> (Another one would be to modify the disk drivers on older versions to do the 
> offset calculation in 64 bit, and check for overflow just as we do here. Not 
> sure whether that's feasible. And as you so eloquently describe, we can't rely 
> on users listening.)
> 
> Either way, we need the cooperation of partitioning tool writers to ensure 
> partition information that is prone to overflows is never stored in the 32 bit, 
> classic RDB. That appears to have failed already, as Martin's experience 
> illustrates.
> 
> I'm only concerned with fixing the (dangerous) but in the Linux partition format 
> parser for RDB. Refusing to use any partitions that will cause havoc on old 
> AmigaOS versions is all I can do to try and get the users' attention.
> 
> Your warning makes me wonder whether the log message should just say 'report 
> this bug to linux-m68k@vger.kernel.org' to at least try and educate any that 
> respond about the dangers of their partitioning scheme before telling them about 
> the override option. Problem with that is, in about three years no one will 
> remember any of this ...
> 
> Cheers,
> 
>      Michael
> 
> 
> Am 28.06.2018 um 15:44 schrieb jdow:
>> Michael, as long as m68k only supports int fseek( int ) 4 GB * block
>> size is your HARD limit. Versions that support __int64 fseek64( __int64
>> ) can work with larger disks. RDBs could include RDSK and a new set of
>> other blocks that replace the last two characters with "64" and use
>> __int64 where needed in the various values. That way a clever disk
>> partitioner could give allow normal (32 bit) RDB definitions where
>> possible. Then at least SOME of the disk could be supported AND a very
>> clever filesystem that abstracts very large disks properly could give
>> access to the whole disk. (Read the RDBs first 32 bits. Then if a
>> filesystem or driveinit was loaded re-read the RDBs to see if new 64 bit
>> partitions are revealed.
>>
>> I could be wrong but I do not think RDBs could be safely modified any
>> other way to work. And, trust me as I bet this is still true, you will
>> need a SERIOUSLY good bomb shelter on the Moon if you change RDBs.
>> Suppose Joe Amigoid uses it, and then Joe Amigoid loads Amigados 2.4
>> because he wants to run a game that crashes on anything newer. Then Joe
>> got far enough something writes to the disk and data is corrupted. Note
>> further that Amigoids do NOT, repeat NOT, listen to facts in such cases.
>> Hell, some of them never listened to facts about an incident at Jerry
>> Pournelle's place when a 1.1 DPaint session with Kelly Freas hung and we
>> lost a delightful drawing. Jerry reported it. Amigoids screamed. I tried
>> to tell them I was there, it was my machine, and 1.1 was, indeed, crap.
>>
>> {o.o}
>>
>> On 20180627 02:00, Michael Schmitz wrote:
>>> Joanne,
>>>
>>> I'm not at all allergic to avoiding RDB at all cost for new disks. If
>>> AmigaOS 4.1 supports more recent partition formats, all the better.
>>> This is all about supporting use of legacy RDB disks on Linux (though
>>> 2 TB does stretch the definition of 'legacy' a little). My interest in
>>> this is to ensure we can continue to use RDB format disks on m68k
>>> Amiga computers which have no other way to boot Linux from disk.
>>>
>>> Not proposing to change the RDB format at all, either. Just trying to
>>> make sure we translate RDB info into Linux 512-byte block offset and
>>> size numbers correctly. The kernel won't modify the RDB at all
>>> (intentionally, that is - with the correct choice of partition sizes,
>>> Martin might well have wiped out his RDB with the current version of
>>> the parser).
>>>
>>> The choice of refusing to mount a disk (or mounting read-only) rests
>>> with the VFS drivers alone - AFFS in that case. Not touching any of
>>> that. At partition scan time, we only have the option of making the
>>> partition available (with a warning printed), or refusing to make it
>>> available to the kernel. Once it's made available, all bets are off.
>>>
>>>  From what Martin writes, his test case RDB was valid and worked as
>>> expected on 32 bit AmigaOS (4.1). Apparently, that version has the
>>> necessary extensions to handle the large offsets resulting from 2 TB
>>> disks. Not sure what safeguards are in place when connecting such a
>>> disk to older versions of AmigaOS, but that is a different matter
>>> entirely.
>>>
>>> The overflows in partition offset and size are the only ones I can see
>>> in the partition parser - there is no other overflow I've identified.
>>> I just stated that in order to place a partition towards the end of a
>>> 2 TB disk, the offset calculation will overflow regardless of what
>>> combination of rdb->rdb_BlockBytes and sector addresses stored in the
>>> RDB (in units of 512 byte blocks) we use:
>>>
>>>          blksize = be32_to_cpu( rdb->rdb_BlockBytes ) / 512;
>>>
>>>
>>>                  nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
>>>                              be32_to_cpu(pb->pb_Environment[9])) *
>>>                             be32_to_cpu(pb->pb_Environment[3]) *
>>>                             be32_to_cpu(pb->pb_Environment[5]) *
>>>                             blksize;
>>>                  if (!nr_sects)
>>>                          continue;
>>>                  start_sect = be32_to_cpu(pb->pb_Environment[9]) *
>>>                               be32_to_cpu(pb->pb_Environment[3]) *
>>>                               be32_to_cpu(pb->pb_Environment[5]) *
>>>                               blksize;
>>>
>>> But in the interest of avoiding any accidental use of a RDB partition
>>> where calculations currently overflow, I'll make the default behaviour
>>> to bail out (instead of using wrong offset or size as we currently
>>> do). Given the 'eat_my_RDB_disk=1' boot option, the user may proceed
>>> at their own risk (though I still can't see what harm should result
>>> from now translating a well formed v4.1 2 TB disk RDB correctly for
>>> the first time).
>>>
>>> Whether or not Linux correctly handles AFFS filesystems larger than 1
>>> TB is a matter for VFS experts. Bailing out on nr_sects overflowing
>>> ought to prevent accidental use of AFFS filesystems on RDB disks which
>>> I suppose is the majority of use cases.
>>>
>>> Bugs in partitioning tools on Linux are entirely out of scope - the
>>> partitioning tools bypass the partition structure discovered by the
>>> kernel, and work straight on the raw device. No protecting against that.
>>>
>>> If you can point out a way to cause data loss with these precautions,
>>> for a disk 2 TB or larger that was partitioned and used on a recent
>>> version or AmigaOS supporting such large disks, I'd consider omitting
>>> the 'eat_my_RDB_disk' boot option, and just bail out as the only safe
>>> option.
>>>
>>> Cheers,
>>>
>>>      Michael
>>>
>>>
>>> Am 27.06.2018 um 18:24 schrieb jdow:
>>>> You allergic to using a GPT solution? It will get away from some of the
>>>> evils that RDB has inherent in it because they are also features?
>>>> (Loading a filesystem or DriveInit code from RDBs is just asking for a
>>>> nearly impossible to remove malware infection.) Furthermore, any 32 bit
>>>> system that sees an RDSK block is going to try to translate it. If you
>>>> add a new RDB format you are going to get bizarre and probably quite
>>>> destructive results from the mistake. Fail safe is a rather good notion,
>>>> methinks.
>>>>
>>>> Personally I figure this is all rather surreal. 2TG of junk on an Amiga
>>>> system seems utterly outlandish to me. You cited another overflow
>>>> potential. There are at least three we've identified, I believe. Are you
>>>> 100% sure there are no more? The specific one you mention of translating
>>>> RDB to Linux has a proper solution in the RDB reader. It should recover
>>>> such overflow errors in the RDB as it can with due care and polish. It
>>>> should flag any other overflow error it detects within the RDBs and
>>>> return an error such as to leave the disk unmounted or mounted read-only
>>>> if you feel like messing up a poor sod's backups. The simple solution is
>>>> to read each of the variables with the nominal RDB size and convert it
>>>> to uint64_t before calculating byte indices.
>>>>
>>>> However, consider my inputs as advice from an adult who has seen the
>>>> Amiga Elephant so to speak. I am not trying to assert any control. Do as
>>>> you wish; but, I would plead with you to avoid ANY chance you can for
>>>> the user to make a bonehead stupid move and lose all his treasured disk
>>>> archives. Doing otherwise is very poor form.
>>>>
>>>> {o.o}   Joanne "Said enough, she has" Dow
>>>>
>>>> On 20180626 18:07, Michael Schmitz wrote:
>>>>> Joanne,
>>>>>
>>>>> As far as I have been able to test, the change is backwards compatible
>>>>> (RDB partitions from an old disk 80 GB disk are still recognized OK).
>>>>> That"s only been done on an emulator though.
>>>>>
>>>>> Your advice about the dangers of using RDB disks that would have
>>>>> failed the current Linux RDB parser on legacy 32 bit systems is well
>>>>> taken though. Maybe Martin can clarify that for me - was the 2 TB disk
>>>>> in question ever used on a 32 bit Amiga system?
>>>>>
>>>>> RDB disk format is meant for legacy use only, so I think we can get
>>>>> away with printing a big fat warning during boot, advising the user
>>>>> that the oversize RDB partition(s) scanned are not compatible with
>>>>> legacy 32 bit AmigaOS. With the proposed fix they will work under both
>>>>> AmigaOS 4.1 and Linux instead of truncating the first overflowing
>>>>> partition at disk end and trashing valid partitions that overlap,
>>>>> which is what Martin was after.
>>>>>
>>>>> If that still seems too risky, we can make the default behaviour to
>>>>> bail out once a potential overflow is detected, and allow the user to
>>>>> override that through a boot parameter. I'd leave that decision up for
>>>>> the code review on linux-block.
>>>>>
>>>>> Two more comments: Linux uses 512 byte block sizes for the partition
>>>>> start and size calculations, so a change of the RDB blocksize to
>>>>> reduce the block counts stored in the RDB would still result in the
>>>>> same overflow. And amiga-fdisk is indeed utterly broken and needs
>>>>> updating (along with probably most legacy m68k partitioners). Adrian
>>>>> has advertised parted as replacement for the old tools - maybe this
>>>>> would make a nice test case for parted?
>>>>>
>>>>> Cheers,
>>>>>
>>>>>    Michael
>>>>>
>>>>>
>>>>>
>>>>> On Tue, Jun 26, 2018 at 9:45 PM, jdow <jdow@earthlink.net> wrote:
>>>>>> If it is not backwards compatible I for one would refuse to use it.
>>>>>> And if
>>>>>> it still mattered that much to me I'd also generate a reasonable
>>>>>> alternative. Modifying RDBs nay not be even an approximation of a
>>>>>> good idea.
>>>>>> You'd discover that as soon as an RDB uint64_t disk is tasted by a
>>>>>> uint32_t
>>>>>> only system. If it is for your personal use then you're entirely
>>>>>> free to
>>>>>> reject my advice and are probably smart enough to keep it working for
>>>>>> yourself.
>>>>>>
>>>>>> GPT is probably the right way to go. Preserve the ability to read
>>>>>> RDBs for
>>>>>> legacy disks only.
>>>>>>
>>>>>> {^_^}
>>>>>>
>>>>>>
>>>>>> On 20180626 01:31, Michael Schmitz wrote:
>>>>>>>
>>>>>>> Joanne,
>>>>>>>
>>>>>>> I think we all agree that doing 32 bit calculations on 512-byte block
>>>>>>> addresses that overflow on disks 2 TB and larger is a bug, causing
>>>>>>> the
>>>>>>> issues Martin reported. Your patch addresses that by using the
>>>>>>> correct
>>>>>>> data type for the calculations (as do other partition parsers that
>>>>>>> may
>>>>>>> have to deal with large disks) and fixes Martin's bug, so appears
>>>>>>> to be
>>>>>>> the right thing to do.
>>>>>>>
>>>>>>> Using 64 bit data types for disks smaller than 2 TB where
>>>>>>> calculations
>>>>>>> don't currently overflow is not expected to cause new issues, other
>>>>>>> than
>>>>>>> enabling use of disk and partitions larger than 2 TB (which may have
>>>>>>> ramifications with filesystems on these partitions). So
>>>>>>> comptibility is
>>>>>>> preserved.
>>>>>>>
>>>>>>> Forcing larger block sizes might be a good strategy to avoid overflow
>>>>>>> issues in filesystems as well, but I can't see how the block size
>>>>>>> stored
>>>>>>> in the RDB would enforce use of the same block size in filesystems.
>>>>>>> We'll have to rely on the filesystem tools to get that right, too.
>>>>>>> Linux
>>>>>>> AFFS does allow block sizes up to 4k (VFS limitation) so this should
>>>>>>> allow partitions larger than 2 TB to work already (but I suspect Al
>>>>>>> Viro
>>>>>>> may have found a few issues when he looked at the AFFS code so I
>>>>>>> won't
>>>>>>> say more). Anyway partitioning tools and filesystems are unrelated to
>>>>>>> the Linux partition parser code which is all we aim to fix in this
>>>>>>> patch.
>>>>>>>
>>>>>>> If you feel strongly about unknown ramifications of any
>>>>>>> filesystems on
>>>>>>> partitions larger than 2 TB, say so and I'll have the kernel print a
>>>>>>> warning about these partitions.
>>>>>>>
>>>>>>> I'll get this patch tested on Martin's test case image as well as
>>>>>>> on a
>>>>>>> RDB image from a disk known to currently work under Linux (thanks
>>>>>>> Geert
>>>>>>> for the losetup hint). Can't do much more without procuring a working
>>>>>>> Amiga disk image to use with an emulator, sorry. The Amiga I plan to
>>>>>>> use
>>>>>>> for tests is a long way away from my home indeed.
>>>>>>>
>>>>>>> Cheers,
>>>>>>>
>>>>>>>       Michael
>>>>>>>
>>>>>>> Am 26.06.18 um 17:17 schrieb jdow:
>>>>>>>>
>>>>>>>> As long as it preserves compatibility it should be OK, I suppose.
>>>>>>>> Personally I'd make any partitioning tool front end gently force the
>>>>>>>> block size towards 8k as the disk size gets larger. The file systems
>>>>>>>> may also run into 2TB issues that are not obvious. An unused blocks
>>>>>>>> list will have to go beyond a uint32_t size, for example. But a
>>>>>>>> block
>>>>>>>> list (OFS for sure, don't remember for the newer AFS) uses a tad
>>>>>>>> under
>>>>>>>> 1% of the disk all by itself. A block bitmap is not quite so bad.
>>>>>>>> {^_-}
>>>>>>>>
>>>>>>>> Just be sure you are aware of all the ramifications when you make a
>>>>>>>> change. I remember thinking about this for awhile and then
>>>>>>>> determining
>>>>>>>> I REALLY did not want to think about it as my brain was getting tied
>>>>>>>> into a gordian knot.
>>>>>>>>
>>>>>>>> {^_^}
>>>>>>>>
>>>>>>>> On 20180625 19:23, Michael Schmitz wrote:
>>>>>>>>>
>>>>>>>>> Joanne,
>>>>>>>>>
>>>>>>>>> Martin's boot log (including your patch) says:
>>>>>>>>>
>>>>>>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512)
>>>>>>>>> sdb1
>>>>>>>>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res
>>>>>>>>> 2 spb
>>>>>>>>> 4)
>>>>>>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
>>>>>>>>> Attached SCSI disk
>>>>>>>>>
>>>>>>>>> so it's indeed a case of self inflicted damage (RDSK (512) means
>>>>>>>>> 512
>>>>>>>>> byte blocks) and can be worked around by using a different block
>>>>>>>>> size.
>>>>>>>>>
>>>>>>>>> Your memory serves right indeed - blocksize is in 512 bytes units.
>>>>>>>>> I'll still submit a patch to Jens anyway as this may bite others
>>>>>>>>> yet.
>>>>>>>>>
>>>>>>>>> Cheers,
>>>>>>>>>
>>>>>>>>>      Michael
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
>>>>>>>>>>
>>>>>>>>>> BTW - anybody who uses 512 byte blocks with an Amiga file
>>>>>>>>>> system is
>>>>>>>>>> a famn
>>>>>>>>>> dool.
>>>>>>>>>>
>>>>>>>>>> If memory serves the RDBs think in blocks rather than bytes so it
>>>>>>>>>> should
>>>>>>>>>> work up to 2 gigablocks whatever your block size is. 512 blocks is
>>>>>>>>>> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk in
>>>>>>>>>> block maps.
>>>>>>>>>> Go up to 4096 or 8192. The latter is 35 TB.
>>>>>>>>>>
>>>>>>>>>> {^_^}
>>>>>>>>>> On 20180624 02:06, Martin Steigerwald wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi.
>>>>>>>>>>>
>>>>>>>>>>> Michael Schmitz - 27.04.18, 04:11:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> test results at
>>>>>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>>>>>>>>>> indicate the RDB parser bug is fixed by the patch given there,
>>>>>>>>>>>> so if
>>>>>>>>>>>> Martin now submits the patch, all should be well?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Ok, better be honest than having anyone waiting for it:
>>>>>>>>>>>
>>>>>>>>>>> I do not care enough about this, in order to motivate myself
>>>>>>>>>>> preparing
>>>>>>>>>>> the a patch from Joanne Dow´s fix.
>>>>>>>>>>>
>>>>>>>>>>> I am not even using my Amiga boxes anymore, not even the Sam440ep
>>>>>>>>>>> which
>>>>>>>>>>> I still have in my apartment.
>>>>>>>>>>>
>>>>>>>>>>> So RDB support in Linux it remains broken for disks larger 2 TB,
>>>>>>>>>>> unless
>>>>>>>>>>> someone else does.
>>>>>>>>>>>
>>>>>>>>>>> Thanks.
>>>>>>>>>>>
>>>>>>>>>> -- 
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>> linux-m68k" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>
>>>>>>>>>
>>>>>>>> -- 
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> linux-m68k" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>>>
>>>>>> -- 
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> linux-m68k" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>
> 

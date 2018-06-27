Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC729C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6897B261C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1lAVMQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6897B261C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeF0BHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:07:46 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33312 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeF0BHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:07:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so174894pfi.0;
        Tue, 26 Jun 2018 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oXrrdGnEJJTGrO0U1Kq83TXcWJOLiLLhAkZwSpepZws=;
        b=Q1lAVMQowiMthFgTJLMvPO7wEOlX1edR0MXRE3DAvX00wjnW56sOCWgS+n/knUpZQh
         bTajh3CPFxkZW1FYRaHoBBF5CtyZAlaBrtNY6oZai1+HbT2YRi+sMJYFAfVCoTLpJ4Wb
         QLSup7inRElnnG7JSY3cpgxTtLpe/lqQ9PCron+SR0yMRMy1xVo8uBaNTuePploHC8m8
         oQ0xAzsY2U4rLu4csJ79At0s0AxQjS1XaRRRuaKjCVBf05tcaq3mqTtg5J3pTr6HZR8p
         xhuO6Fbk+5eNuKWHLEK0kwcKNrfUmU+NlQnTeX1vnJXkp7cAE2dZdjSpIUh9rAHowNQq
         H5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oXrrdGnEJJTGrO0U1Kq83TXcWJOLiLLhAkZwSpepZws=;
        b=Kq5yl+2EHbQVwyA9tJknO27MU58cKTJJU1U5lkDHMg7gMZCUXZMD93wtT/bJwGdBVd
         4PEkfSC/rSunTsj2qgN87YP8hhupxi6dLe9/tqxAtiObxGClonCIi0BqC2GTsbiw6FEC
         1Y8f6OrLGqs7nUD/Dyf13PEyW/g7XFeyt37sIPxZrQ1N0MLLrAGCWEd4ecI4bUWJ68bo
         PYaORJvqYqeaPJ8UJHpzuNuKe0CEOGLAxkH+Fr0im/vIqi5hONzrcrE4rt/dXwJzGaEO
         kxgPLZGvgpu5kjg0v/1DIs3Tk8z7jmf2hjU+3YL4Fk98uAbR+sJAmxYZM3fxV1gLLwvT
         5EXg==
X-Gm-Message-State: APt69E1aA8U+qrT0ByqMrpEhxtYT+P7N4vSn3/ls76aO+/c6yLan9tAm
        ImQTo/uAbSNYrPD7CswYln58vVL3r9D9axXoSc4KcQ==
X-Google-Smtp-Source: ADUXVKIzFadbuHU4gxvgdqsVkw4IIPNLw+Q0JFLB/S0ePQdxn12SO/4V42ayGJ2xZU65UTKInz4it/Q+IMbfR1Z6Ewc=
X-Received: by 2002:a65:52c3:: with SMTP id z3-v6mr3310433pgp.69.1530061663167;
 Tue, 26 Jun 2018 18:07:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2a89:0:0:0:0 with HTTP; Tue, 26 Jun 2018 18:07:42
 -0700 (PDT)
In-Reply-To: <8ef4bdc6-4ed0-675e-e26d-0b6e7ab4a00e@earthlink.net>
References: <20180425154602.GA8546@bombadil.infradead.org> <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba> <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
 <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
 <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net> <00416cde-ddda-a9e6-f4e8-ee424b2e2a1c@gmail.com>
 <8ef4bdc6-4ed0-675e-e26d-0b6e7ab4a00e@earthlink.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Date:   Wed, 27 Jun 2018 13:07:42 +1200
Message-ID: <CAOmrzkKLJiWvDwsER0ca09UJbi57Rj6PUmdxizSNPXzZLMErOA@mail.gmail.com>
Subject: Re: moving affs + RDB partition support to staging?
To:     jdow <jdow@earthlink.net>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joanne,

As far as I have been able to test, the change is backwards compatible
(RDB partitions from an old disk 80 GB disk are still recognized OK).
That"s only been done on an emulator though.

Your advice about the dangers of using RDB disks that would have
failed the current Linux RDB parser on legacy 32 bit systems is well
taken though. Maybe Martin can clarify that for me - was the 2 TB disk
in question ever used on a 32 bit Amiga system?

RDB disk format is meant for legacy use only, so I think we can get
away with printing a big fat warning during boot, advising the user
that the oversize RDB partition(s) scanned are not compatible with
legacy 32 bit AmigaOS. With the proposed fix they will work under both
AmigaOS 4.1 and Linux instead of truncating the first overflowing
partition at disk end and trashing valid partitions that overlap,
which is what Martin was after.

If that still seems too risky, we can make the default behaviour to
bail out once a potential overflow is detected, and allow the user to
override that through a boot parameter. I'd leave that decision up for
the code review on linux-block.

Two more comments: Linux uses 512 byte block sizes for the partition
start and size calculations, so a change of the RDB blocksize to
reduce the block counts stored in the RDB would still result in the
same overflow. And amiga-fdisk is indeed utterly broken and needs
updating (along with probably most legacy m68k partitioners). Adrian
has advertised parted as replacement for the old tools - maybe this
would make a nice test case for parted?

Cheers,

  Michael



On Tue, Jun 26, 2018 at 9:45 PM, jdow <jdow@earthlink.net> wrote:
> If it is not backwards compatible I for one would refuse to use it. And i=
f
> it still mattered that much to me I'd also generate a reasonable
> alternative. Modifying RDBs nay not be even an approximation of a good id=
ea.
> You'd discover that as soon as an RDB uint64_t disk is tasted by a uint32=
_t
> only system. If it is for your personal use then you're entirely free to
> reject my advice and are probably smart enough to keep it working for
> yourself.
>
> GPT is probably the right way to go. Preserve the ability to read RDBs fo=
r
> legacy disks only.
>
> {^_^}
>
>
> On 20180626 01:31, Michael Schmitz wrote:
>>
>> Joanne,
>>
>> I think we all agree that doing 32 bit calculations on 512-byte block
>> addresses that overflow on disks 2 TB and larger is a bug, causing the
>> issues Martin reported. Your patch addresses that by using the correct
>> data type for the calculations (as do other partition parsers that may
>> have to deal with large disks) and fixes Martin's bug, so appears to be
>> the right thing to do.
>>
>> Using 64 bit data types for disks smaller than 2 TB where calculations
>> don't currently overflow is not expected to cause new issues, other than
>> enabling use of disk and partitions larger than 2 TB (which may have
>> ramifications with filesystems on these partitions). So comptibility is
>> preserved.
>>
>> Forcing larger block sizes might be a good strategy to avoid overflow
>> issues in filesystems as well, but I can't see how the block size stored
>> in the RDB would enforce use of the same block size in filesystems.
>> We'll have to rely on the filesystem tools to get that right, too. Linux
>> AFFS does allow block sizes up to 4k (VFS limitation) so this should
>> allow partitions larger than 2 TB to work already (but I suspect Al Viro
>> may have found a few issues when he looked at the AFFS code so I won't
>> say more). Anyway partitioning tools and filesystems are unrelated to
>> the Linux partition parser code which is all we aim to fix in this patch=
.
>>
>> If you feel strongly about unknown ramifications of any filesystems on
>> partitions larger than 2 TB, say so and I'll have the kernel print a
>> warning about these partitions.
>>
>> I'll get this patch tested on Martin's test case image as well as on a
>> RDB image from a disk known to currently work under Linux (thanks Geert
>> for the losetup hint). Can't do much more without procuring a working
>> Amiga disk image to use with an emulator, sorry. The Amiga I plan to use
>> for tests is a long way away from my home indeed.
>>
>> Cheers,
>>
>>      Michael
>>
>> Am 26.06.18 um 17:17 schrieb jdow:
>>>
>>> As long as it preserves compatibility it should be OK, I suppose.
>>> Personally I'd make any partitioning tool front end gently force the
>>> block size towards 8k as the disk size gets larger. The file systems
>>> may also run into 2TB issues that are not obvious. An unused blocks
>>> list will have to go beyond a uint32_t size, for example. But a block
>>> list (OFS for sure, don't remember for the newer AFS) uses a tad under
>>> 1% of the disk all by itself. A block bitmap is not quite so bad. {^_-}
>>>
>>> Just be sure you are aware of all the ramifications when you make a
>>> change. I remember thinking about this for awhile and then determining
>>> I REALLY did not want to think about it as my brain was getting tied
>>> into a gordian knot.
>>>
>>> {^_^}
>>>
>>> On 20180625 19:23, Michael Schmitz wrote:
>>>>
>>>> Joanne,
>>>>
>>>> Martin's boot log (including your patch) says:
>>>>
>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
>>>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2 spb
>>>> 4)
>>>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
>>>> Attached SCSI disk
>>>>
>>>> so it's indeed a case of self inflicted damage (RDSK (512) means 512
>>>> byte blocks) and can be worked around by using a different block size.
>>>>
>>>> Your memory serves right indeed - blocksize is in 512 bytes units.
>>>> I'll still submit a patch to Jens anyway as this may bite others yet.
>>>>
>>>> Cheers,
>>>>
>>>>     Michael
>>>>
>>>>
>>>> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
>>>>>
>>>>> BTW - anybody who uses 512 byte blocks with an Amiga file system is
>>>>> a famn
>>>>> dool.
>>>>>
>>>>> If memory serves the RDBs think in blocks rather than bytes so it
>>>>> should
>>>>> work up to 2 gigablocks whatever your block size is. 512 blocks is
>>>>> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk in
>>>>> block maps.
>>>>> Go up to 4096 or 8192. The latter is 35 TB.
>>>>>
>>>>> {^_^}
>>>>> On 20180624 02:06, Martin Steigerwald wrote:
>>>>>>
>>>>>>
>>>>>> Hi.
>>>>>>
>>>>>> Michael Schmitz - 27.04.18, 04:11:
>>>>>>>
>>>>>>>
>>>>>>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=3D43511
>>>>>>> indicate the RDB parser bug is fixed by the patch given there, so i=
f
>>>>>>> Martin now submits the patch, all should be well?
>>>>>>
>>>>>>
>>>>>>
>>>>>> Ok, better be honest than having anyone waiting for it:
>>>>>>
>>>>>> I do not care enough about this, in order to motivate myself prepari=
ng
>>>>>> the a patch from Joanne Dow=C2=B4s fix.
>>>>>>
>>>>>> I am not even using my Amiga boxes anymore, not even the Sam440ep
>>>>>> which
>>>>>> I still have in my apartment.
>>>>>>
>>>>>> So RDB support in Linux it remains broken for disks larger 2 TB,
>>>>>> unless
>>>>>> someone else does.
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-m68k" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-m68k" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

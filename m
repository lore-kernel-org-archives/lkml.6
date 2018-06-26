Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC072C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F8F26826
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="FJE6RHha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F8F26826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933723AbeFZJqx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:46:53 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:35074 "EHLO
        elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752606AbeFZJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1530006600; bh=yge4cx/cWjq4umpAhwc50cAo/LauqVDqk02r
        BNX51yw=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=FJE6RHh
        ahmDvNnJHcfv4Qyiht8sPlT8eEVlVU1012rpnCW6oMd9pqovNltl2sJbA3NPW0n8vr5
        wt3VIhB+5A3DZQYDrTN8GfKhEqKNC0O2CsrxLJQ+IAIRV4TYYQUYH7gHF3W5hBo0JBF
        N7L75uBfEXzqLnFc256uBz2DtSV9ikX0FlohVXaJfUXMk3No7e2tGh9s84LvpOyRMBo
        57qUOtZQE+CtSG6ZUb4FjzN60ZfuJk5/h9opSV8nXp9VopjqAIS5+VAFVCQi/fqP4IQ
        mkDGl9KSx8nprnA0OJjpleUzAq88rcTnUNWCqMyDPZayvqFzy6psICcSPAR39xGP8gg
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=R2ud/KAqaqzMc0xl19dpR3w10f42BXmwDANNyHxsRAPmkd4KRyrEHGPbqQb3oKqSdnkBZJlqn5ch9nT+uj743v1OaaBufvAiX3cFiFDe0mth0AzyOQVy1znDgHB9WRsdeqjeQvC7r75LbpKUWJCdw7qPNIRzIBLqrNExCqcew9EqxzlPEbOhJ2i65Y/1Q7svOGwpeXIXBYgw4p5EQ36zsLyrAwctPWKcF/dMyhj73Ru3AxBz4LHQhhqmwXQhCTu8LwwWypAdFVNzWiZVAy3rPGSbgyTvRreDiOv5WiNak1a3z9nLum1LEYCY6EfVRbkjoYMZrzlL0J7CfJTv2n3tDw==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fXkbk-000GrU-9a; Tue, 26 Jun 2018 05:49:56 -0400
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
 <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
 <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
 <1954225.EY2fU3p6yy@merkaba>
From:   jdow <jdow@earthlink.net>
Message-ID: <3030f647-1744-8cd6-4ce8-f619aa064a2f@earthlink.net>
Date:   Tue, 26 Jun 2018 02:46:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1954225.EY2fU3p6yy@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120e34ac1e402a3b8c1bd41581886a29d77a6100a05dea77183350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Get everybody)
Speak to the high level driver folks about that. The low level stuff is 
basically dumb. It tells you what it finds. It tells the rest of the OS (the 
file systems) what it found. The amiga-makefs (or whatever it is called) needs 
to grow some added intelligence just as HDToolBox needs to grow more 
intelligence. The step from RDB uint32_t to RDB uint64_t probably needs a great 
deal of thought. Personally I'd be tempted to adopt GUID based partitioning 
system. It has already considered this stuff.

{^_^}

On 20180626 01:12, Martin Steigerwald wrote:
> Joanne.
> 
> jdow - 26.06.18, 07:17:
>> As long as it preserves compatibility it should be OK, I suppose.
>> Personally I'd make any partitioning tool front end gently force the
>> block size towards 8k as the disk size gets larger. The file systems
>> may also run into 2TB issues that are not obvious. An unused blocks
>> list will have to go beyond a uint32_t size, for example. But a block
>> list (OFS for sure, don't remember for the newer AFS) uses a tad
>> under 1% of the disk all by itself. A block bitmap is not quite so
>> bad. {^_-}
>>
>> Just be sure you are aware of all the ramifications when you make a
>> change. I remember thinking about this for awhile and then
>> determining I REALLY did not want to think about it as my brain was
>> getting tied into a gordian knot.
> 
> Heh… :)
> 
> Well, all I can say it that it just worked on AmigaOS 4. I did not see
> any data corruption in any of the filesystems. Well as far as I have
> been able to check. There has been no repair tool for JXFS I think. But
> as I migrated the data on it to SFS, I was able to copy everything.
> 
> Famous last words.
> 
> Well especially the disk size was detected properly and there was no
> overflow like on Linux. So I´d say rather have on error less than one
> error more.
> 
> Of course, it could also be an option to outright *refuse* to detect
> such disks with a big fat warning in kernel log that it may unsafe. But
> overflowing and thus on writes overwriting existing data is not safe.
> 
> I do think it is safe enough, but what I do know about the internals
> about RDB (more than the average user certainly, but not as much as you
> or some other AmigaOS developer who digged  deeper into that).
> 
> So in case you´d rather see Linux to refuse to handle disks like that,
> that would also be fine with me. Just do not handle them in the broken
> way that they are handled in Linux now. I.e. do not deliberately corrupt
> things as in "Its dangerous, so let´s overwrite data straight away, so
> the user gets it." :)
> 
> Anyway, in my opinion RDB still just so much more advanced than MBR and
> in some parts even on par with the much later GPT. With some limitations
> it is a quite brilliant partition format, if you ask me.
> 
>> {^_^}
>>
>> On 20180625 19:23, Michael Schmitz wrote:
>>> Joanne,
>>>
>>> Martin's boot log (including your patch) says:
>>>
>>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
>>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2
>>> spb
>>> 4)
>>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
>>> Attached SCSI disk
>>>
>>> so it's indeed a case of self inflicted damage (RDSK (512) means 512
>>> byte blocks) and can be worked around by using a different block
>>> size.
>>>
>>> Your memory serves right indeed - blocksize is in 512 bytes units.
>>> I'll still submit a patch to Jens anyway as this may bite others
>>> yet.
>>>
>>> Cheers,
>>>
>>>     Michael
>>>
>>> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
>>>> BTW - anybody who uses 512 byte blocks with an Amiga file system is
>>>> a famn dool.
>>>>
>>>> If memory serves the RDBs think in blocks rather than bytes so it
>>>> should work up to 2 gigablocks whatever your block size is. 512
>>>> blocks is 2199023255552 bytes. But that wastes just a WHOLE LOT of
>>>> disk in block maps. Go up to 4096 or 8192. The latter is 35 TB.
>>>>
>>>> {^_^}
>>>>
>>>> On 20180624 02:06, Martin Steigerwald wrote:
>>>>> Hi.
>>>>>
>>>>> Michael Schmitz - 27.04.18, 04:11:
>>>>>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>>>> indicate the RDB parser bug is fixed by the patch given there, so
>>>>>> if
>>>>>> Martin now submits the patch, all should be well?
>>>>>
>>>>> Ok, better be honest than having anyone waiting for it:
>>>>>
>>>>> I do not care enough about this, in order to motivate myself
>>>>> preparing the a patch from Joanne Dow´s fix.
>>>>>
>>>>> I am not even using my Amiga boxes anymore, not even the Sam440ep
>>>>> which I still have in my apartment.
>>>>>
>>>>> So RDB support in Linux it remains broken for disks larger 2 TB,
>>>>> unless someone else does.
>>>>>
>>>>> Thanks.
> […]
> 

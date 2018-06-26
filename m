Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683B2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1541F2651E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="ZjR63X23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1541F2651E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeFZFRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:17:19 -0400
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:52320 "EHLO
        elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751014AbeFZFRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=earthlink.net;
        s=dk12062016; t=1529990250; bh=azfJpdiWFauDJihyPI5BBGrluh8NMyMHta3F
        55Ug0XI=; h=Received:Subject:To:Cc:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=ZjR63X2
        3oU1ok6bF798kvJMESbc3XZ0faAU5GCLfZZF3IdRKUNeP/3eBHBT8Mp3pwoDcDfFbf9
        qyyG6z0/1p0SLe4PGzEjeQPpO95VHJRZoGXo3PDYy2FG/OfUeh3HeU3cxuiQD/tr3bv
        tLdfFl9e83jIECsslgGzrDRqFJXAYVUirZ+3xUYz8bPXBE7nYhz2h2ZvTrw+nYLNvhV
        poC0z9WkmmX2u0wRepZ1Fa8ik2TPvXXKyDgWevyTCEEL4lgh4JcCrDYOiKYpgKmZBrK
        2GqE6KtaMwKZ12O4bDGWbVP4WNei383Fc17eUQCWhk9+4Nn+a6FD0jgTPRjbKsUHiHQ
        ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=earthlink.net;
  b=NAi0QCOdkLcfQws7jLMTJcxEaI99B3e+9jIwhWnbnyXXitDu3QMhUyWzMe+ygT4JqwCwzFY7PMion9mgrQRqW42oSwWApIQN86h9R1TRotqLNtLcM3J/Z1LduyOjskXWi8QyhVZQJu3kQpB0iA2jKWs0dw5z20YdMVkEe2b7btSqzRnR77NEyHLgPxM5z2yBIajyn+R5avNBVOBOIdLAnQNaxcXEBpZVluDXx05aGhsBUCz5IcRwBrTavgVEhP3gt/zvhWA/WXYgcTHzqQJcrduJ54dphyUcuXTbiPrHEPb8luP3FfHYZrVXIFLeng8HPTGOPAV6Qlx7enhb0kv/0Q==;
  h=Received:Subject:To:Cc:References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.183.100.61] (helo=[192.168.37.199])
        by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <jdow@earthlink.net>)
        id 1fXgM2-000A1x-VM; Tue, 26 Jun 2018 01:17:27 -0400
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
From:   jdow <jdow@earthlink.net>
Message-ID: <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
Date:   Mon, 25 Jun 2018 22:17:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120dffac9ef49ac61154fceb338c4e57b978284c0d70cdf2f37350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.183.100.61
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as it preserves compatibility it should be OK, I suppose. Personally I'd 
make any partitioning tool front end gently force the block size towards 8k as 
the disk size gets larger. The file systems may also run into 2TB issues that 
are not obvious. An unused blocks list will have to go beyond a uint32_t size, 
for example. But a block list (OFS for sure, don't remember for the newer AFS) 
uses a tad under 1% of the disk all by itself. A block bitmap is not quite so 
bad. {^_-}

Just be sure you are aware of all the ramifications when you make a change. I 
remember thinking about this for awhile and then determining I REALLY did not 
want to think about it as my brain was getting tied into a gordian knot.

{^_^}

On 20180625 19:23, Michael Schmitz wrote:
> Joanne,
> 
> Martin's boot log (including your patch) says:
> 
> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2 spb
> 4)
> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
> Attached SCSI disk
> 
> so it's indeed a case of self inflicted damage (RDSK (512) means 512
> byte blocks) and can be worked around by using a different block size.
> 
> Your memory serves right indeed - blocksize is in 512 bytes units.
> I'll still submit a patch to Jens anyway as this may bite others yet.
> 
> Cheers,
> 
>    Michael
> 
> 
> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
>> BTW - anybody who uses 512 byte blocks with an Amiga file system is a famn
>> dool.
>>
>> If memory serves the RDBs think in blocks rather than bytes so it should
>> work up to 2 gigablocks whatever your block size is. 512 blocks is
>> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk in block maps.
>> Go up to 4096 or 8192. The latter is 35 TB.
>>
>> {^_^}
>> On 20180624 02:06, Martin Steigerwald wrote:
>>>
>>> Hi.
>>>
>>> Michael Schmitz - 27.04.18, 04:11:
>>>>
>>>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>> indicate the RDB parser bug is fixed by the patch given there, so if
>>>> Martin now submits the patch, all should be well?
>>>
>>>
>>> Ok, better be honest than having anyone waiting for it:
>>>
>>> I do not care enough about this, in order to motivate myself preparing
>>> the a patch from Joanne Dow´s fix.
>>>
>>> I am not even using my Amiga boxes anymore, not even the Sam440ep which
>>> I still have in my apartment.
>>>
>>> So RDB support in Linux it remains broken for disks larger 2 TB, unless
>>> someone else does.
>>>
>>> Thanks.
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

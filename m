Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CACC266E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECU1AhZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CACC266E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeFZIbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:31:39 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44575 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeFZIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:31:36 -0400
Received: by mail-io0-f193.google.com with SMTP id g7-v6so15139824ioh.11;
        Tue, 26 Jun 2018 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=F19DCH2t1FauUiRbiWiZ8MF4FWkO1sE1hx3P6E8wEbA=;
        b=ECU1AhZwm+s8u3amqJB9op873/WKf4BAfZkbz9si8JVAGOBqNziKxl1xVQFRb3CvDa
         fSr8+M1jo8jYXCWov4vM0CkVW6jE2TTyfwCe2LVYvTd5ZdjrxyG+b6iDGHQy+z2UGT6I
         YuWfK8+HyRCaxeHIswVgs5Uq1rWhCst4dTC1UHx8XIizjY2cJQP9YU+nHgM5pW9oHUtf
         /lmPHmPcrwSm8rzNMeblF/+VmvR1sKtNAuZ7Sz1yVvLdsK+HcHMDaHIRNRLVqVJMkO8m
         9tDuop1a913BJmbkrKvAXAqlFoORue7y4zycYbf7+8SNdDyxs8iUc9rP5bWIL7JLXAAx
         hcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=F19DCH2t1FauUiRbiWiZ8MF4FWkO1sE1hx3P6E8wEbA=;
        b=fJP9GKd9OfXsqdXqTrwKxLfnahkjuxfliy2q4FiIpb43EWxg2+7VaEaUT5Juf95dxR
         vBCV4YXb5YCUTviRirrTBLCdV5xE8E4DU9ikUP3pj6Ojf3Ex1clsJjHwrA9JWiYma414
         oZqTpAppZC1KmpLSUR0ZXPmGNrBy3tOqYiVNJ+C3qDojfdEOQZbywKaKBIdrjYCQ+MSk
         vTmqTErThXo7iSHHkyvLNA2nAAfHajAg4l0fjds63cGXJyOHcT62UOVIhMmQ7pDQvnTB
         Zh9tNpyQP9cOEng496N/DPjNa44kg6rIvQHXxJrcczT7mCTFAaFlyOF4i11fpvDLN+SD
         PmVw==
X-Gm-Message-State: APt69E3lBdDRPAiE46rDVKT0AXSykcIA8YTBjt6RVe3DiqkFSzgxfqF/
        BWg98kig/H5gO2lygWAaRKQ=
X-Google-Smtp-Source: AAOMgpchW9flsrGOjghXOQTVpvSIcHxohECC1aQ8FrVg92PO1RpBlyB8iJTm7Zx32rkactFWLAa/Xw==
X-Received: by 2002:a6b:f812:: with SMTP id o18-v6mr397592ioh.235.1530001895354;
        Tue, 26 Jun 2018 01:31:35 -0700 (PDT)
Received: from Schmitz-MBP.telecom (222-154-41-72-adsl.bb.spark.co.nz. [222.154.41.72])
        by smtp.googlemail.com with ESMTPSA id e63-v6sm465825ioa.85.2018.06.26.01.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:31:34 -0700 (PDT)
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
References: <20180425154602.GA8546@bombadil.infradead.org>
 <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
 <CAOmrzkKunsjZzwpj9gtovKwXVkj1kTt81ea1zmB7BCDtZz409g@mail.gmail.com>
 <1910962.ItDVNtUG5Q@merkaba>
 <c76b4e4d-7e8e-13ac-81e4-9132f4235eb8@earthlink.net>
 <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com>
 <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <00416cde-ddda-a9e6-f4e8-ee424b2e2a1c@gmail.com>
Date:   Tue, 26 Jun 2018 20:31:23 +1200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joanne,

I think we all agree that doing 32 bit calculations on 512-byte block
addresses that overflow on disks 2 TB and larger is a bug, causing the
issues Martin reported. Your patch addresses that by using the correct
data type for the calculations (as do other partition parsers that may
have to deal with large disks) and fixes Martin's bug, so appears to be
the right thing to do.

Using 64 bit data types for disks smaller than 2 TB where calculations
don't currently overflow is not expected to cause new issues, other than
enabling use of disk and partitions larger than 2 TB (which may have
ramifications with filesystems on these partitions). So comptibility is
preserved. 

Forcing larger block sizes might be a good strategy to avoid overflow
issues in filesystems as well, but I can't see how the block size stored
in the RDB would enforce use of the same block size in filesystems.
We'll have to rely on the filesystem tools to get that right, too. Linux
AFFS does allow block sizes up to 4k (VFS limitation) so this should
allow partitions larger than 2 TB to work already (but I suspect Al Viro
may have found a few issues when he looked at the AFFS code so I won't
say more). Anyway partitioning tools and filesystems are unrelated to
the Linux partition parser code which is all we aim to fix in this patch.

If you feel strongly about unknown ramifications of any filesystems on
partitions larger than 2 TB, say so and I'll have the kernel print a
warning about these partitions.

I'll get this patch tested on Martin's test case image as well as on a
RDB image from a disk known to currently work under Linux (thanks Geert
for the losetup hint). Can't do much more without procuring a working
Amiga disk image to use with an emulator, sorry. The Amiga I plan to use
for tests is a long way away from my home indeed.

Cheers,

    Michael

Am 26.06.18 um 17:17 schrieb jdow:
> As long as it preserves compatibility it should be OK, I suppose.
> Personally I'd make any partitioning tool front end gently force the
> block size towards 8k as the disk size gets larger. The file systems
> may also run into 2TB issues that are not obvious. An unused blocks
> list will have to go beyond a uint32_t size, for example. But a block
> list (OFS for sure, don't remember for the newer AFS) uses a tad under
> 1% of the disk all by itself. A block bitmap is not quite so bad. {^_-}
>
> Just be sure you are aware of all the ramifications when you make a
> change. I remember thinking about this for awhile and then determining
> I REALLY did not want to think about it as my brain was getting tied
> into a gordian knot.
>
> {^_^}
>
> On 20180625 19:23, Michael Schmitz wrote:
>> Joanne,
>>
>> Martin's boot log (including your patch) says:
>>
>> Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
>> (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2 spb
>> 4)
>> Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
>> Attached SCSI disk
>>
>> so it's indeed a case of self inflicted damage (RDSK (512) means 512
>> byte blocks) and can be worked around by using a different block size.
>>
>> Your memory serves right indeed - blocksize is in 512 bytes units.
>> I'll still submit a patch to Jens anyway as this may bite others yet.
>>
>> Cheers,
>>
>>    Michael
>>
>>
>> On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
>>> BTW - anybody who uses 512 byte blocks with an Amiga file system is
>>> a famn
>>> dool.
>>>
>>> If memory serves the RDBs think in blocks rather than bytes so it
>>> should
>>> work up to 2 gigablocks whatever your block size is. 512 blocks is
>>> 2199023255552 bytes. But that wastes just a WHOLE LOT of disk in
>>> block maps.
>>> Go up to 4096 or 8192. The latter is 35 TB.
>>>
>>> {^_^}
>>> On 20180624 02:06, Martin Steigerwald wrote:
>>>>
>>>> Hi.
>>>>
>>>> Michael Schmitz - 27.04.18, 04:11:
>>>>>
>>>>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
>>>>> indicate the RDB parser bug is fixed by the patch given there, so if
>>>>> Martin now submits the patch, all should be well?
>>>>
>>>>
>>>> Ok, better be honest than having anyone waiting for it:
>>>>
>>>> I do not care enough about this, in order to motivate myself preparing
>>>> the a patch from Joanne Dow´s fix.
>>>>
>>>> I am not even using my Amiga boxes anymore, not even the Sam440ep
>>>> which
>>>> I still have in my apartment.
>>>>
>>>> So RDB support in Linux it remains broken for disks larger 2 TB,
>>>> unless
>>>> someone else does.
>>>>
>>>> Thanks.
>>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-m68k" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D934ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EE520823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EE520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKAJEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:04:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36100 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKAJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:04:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so16004055wmf.1;
        Wed, 31 Oct 2018 17:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=b1V8oEaWXihiKN7yHSA2kgIfscY0N1InxXnbrmnHvZg=;
        b=BNp/EB3jKzDtXprw8g6GDBFNRnlRLaYJLdwidK07Dv1PO+8m/m+yVfPB3UW+L6Kw3q
         NDzt5LzMwOoBtDZ81dBPiQ5s/LEUVA3SjSRQkrAKE9o5SBZg+GGvtANNlaFXbbSMHXuH
         ea/Pn1Rn0zVOnaAjIVgLpbCPzQkX8NLVcrK5H6cLWCzKtT5wwxge0lev6KvJ+N9MWZXk
         WnQPZppXvWPiq8qtSTW3XI4Q8OzrVJiExKbk6GgcQrpHXeKSRtcfOUIs2eV9SjiQNEjH
         1w77UMtMWiHynyxwF9NFJJHavxLMUjnTWUHyE5EYqArQvcaAC5ipkkYufUr0K/eFfOLl
         wMJA==
X-Gm-Message-State: AGRZ1gLzOOxi282dB7BlZKnM4Kr/9piKBxfgjt4/oESaAiW8rgtiz3Ch
        2fzz+TloDtGk78e3v0E+tpGp+0VM
X-Google-Smtp-Source: AJdET5e1lkEdNnxUBomq7VGWE3TTgnAFniNO58Cg0ubrmOLaqflABwa6VEEGR1JGApiJorHeicNAWg==
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr3806569wmg.110.1541030625018;
        Wed, 31 Oct 2018 17:03:45 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id i204-v6sm34733528wmd.28.2018.10.31.17.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:03:44 -0700 (PDT)
Subject: Re: remove exofs and the T10 OSD code V2
To:     dgilbert@interlog.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, martin.petersen@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20181027082019.20838-1-hch@lst.de>
 <f9423180-e0fc-efba-e759-dfa4725953ad@kernel.dk>
 <20181030074542.GB24697@lst.de>
 <ea317f79-37bb-1149-fc43-fb07f46c15e9@electrozaur.com>
 <57a73f2b-29be-6301-2f4b-df582b7d23ff@interlog.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <a711a25d-e866-aabe-95c8-53bcd212a173@electrozaur.com>
Date:   Thu, 1 Nov 2018 02:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <57a73f2b-29be-6301-2f4b-df582b7d23ff@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/18 23:10, Douglas Gilbert wrote:
> On 2018-10-31 4:57 p.m., Boaz Harrosh wrote:
>> On 30/10/18 09:45, Christoph Hellwig wrote:
>>> On Mon, Oct 29, 2018 at 02:42:12PM -0600, Jens Axboe wrote:
>>>> LGTM, for both:
>>>
>>> I also have this one on top as requested by Martin.  The core block
>>> bidi support is unfortunately also used by bsg-lib, although it is
>>> not anywhere near as invasive.  But that is another argument for
>>> looking into moving bsg-lib away from using block queues..
>>>
>>
>> BUT this patch is very very wrong.
>>
>> Totally apart from T10-OSD and its use in the field. Support for scsi BIDI
>> commands is not exclusive to T10-OSD at all. Even the simple scsi-array
>> command-set has BIDI operations defined. for example the write-return-xor
>> and so on.
>>
>> Also some private administrative CDBs of some vendor devices uses SCSI-BIDI.
>> So this patch just broke some drivers. (User-mode apps use bsg pass through)
>>
>> Also you might (try hard and) remove all usage of scsi-bidi as an initiator
>> from the Linux Kernel. But what about target mode. As a target we have supported
>> on the wire bidi protocols like write-return-xor and others for a long time.
>> Are you willing to silently break all these setups in the field on the next update?
>> Are you so sure these are never used?
>>
>> PLEASE, I beg of you guys. Do not remove SCSI-BIDI. It is a cry of generations.
>>
>> And I think by the rules of Linus, as far as target mode. You are not allowed
>> to break users in this way.
> 
> Hi,
> I'm in the process of rebuilding the sg driver with the following goals:
> 
>    - undo 20 years of road wear, some of which is caused by literally
>      hundreds of "laparoscopic" patches that gradually ruin a driver,
>      at least from the maintainer's viewpoint. Comments that once made
>      sense become cryptic or just nonsense; naming schemes that
>      obliterate variable names to the extent that a random name
>      generator would be easier to follow; and just plain broken code.
>      For example, why sort out the existing locking at a particular
>      level when you can add a new lock in a completely non-orthogonal
>      way? [Yes, I looking at you, google.] Anyway, my first cut at this
>      is out there (on the linux-scsi list, see: "[PATCH v3 0/8] sg:
>      major cleanup, remove max_queue limit"). Not much new there,
>      unless you look very closely
> 
>    - the next step is to add to the sg driver async SCSI command
>      capability based on the sg_io_v4 structure previously only used
>      by the bsg driver and now removed from bsg. The main advantage
>      of the sg_io_v4 structure over previous pass-through interface
>      attempts is the support of SCSI bidi commands
> 
>    - as part of this effort introduce two new ioctls: SG_IOSUBMIT and
>      SG_IORECEIVE to replace the write()/read() technique currently
>      in use (since Linux 1.0 in 1992). The write()/read() technique
>      seems to be responsible for various security folks losing clumps
>      of their hair. One advantage of ioctls, as Alan Cox pointed out,
>      is the ability to write to and read back from the kernel in a way
>      that is naturally synchronized. [Actually, those security folks
>      shouldn't look too closely at sg_read() in that respect.]
> 
> In discussions with several folks who are on the T10 committee, I
> wondered why there was no READ GATHERED command (there has been a
> WRITE SCATTERED for 2 years). The answer was lack of interest ***,
> plus the difficultly of implementation. You see, READ GATHERED needs
> to send a scatter gather list to the device and get the corresponding
> data back (as a linear array). And that requires either:
>    a) bidi commands (scatter gather list in the data-out, corresponding
>       "read" data in the data-in), or
>    b) loooong SCSI commands, up to around 256 bytes long in which the
>       sgat list is the latter part of that command
> 
> And the T10 folks say neither of those options is well supported or
> is expensive. 

It is supported in Linux scsi/osd driver is a proof of that. And expensive
it is not. I have demonstrated the ability to saturate a 10G link over
a raid of devices from a single writer. In OSD everything is bidi.

> I'm guessing they are referring to Linux and Windows.
> I haven't argued much beyond that point, but it looks like a bit of
> a chicken and egg situation.
> 
> 
> Don't know too much about the T10 OSD stuff. But I can see that it
> uses both long SCSI commands and a lot of bidi. IMO it seems to be
> 10 or 20 years before its time. Maybe ibm/redhat need to
> (re-)discover it for it to catch on.
> 
> 
> Plus there are proprietary SCSI bidi commands out there. People contact
> me and ask me how to issue them with sg3_utils package. Easy, I tell them,
> just use sg_raw with a bsg device. Typically, in my experience, "no news
> is good news" after suggestions like that. When I give bad advice, I
> usually hear back relatively quickly. Anyone who wants SCSI bidi _async_
> support is currently out of luck.
> 

Thank you Doug


> Enough already
> Doug Gilbert
> 
> 
> *** example: loading all or most kernel modules in a few READ SCATTERED
>      commands might speed up boot time ...
> 


Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD6BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96BB2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HASyTaoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96BB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJDQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:49:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40737 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeJDQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:49:28 -0400
Received: by mail-io1-f67.google.com with SMTP id w16-v6so7385253iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8TAxZbVYs1zX4PjOJM4uLgJ+grVxUWuimmSLQuy5a7E=;
        b=HASyTaozmJP+TpCszUn6zE++nKddEcIiqeM7mQ3wS7U/BJGDC7cv6YsU2Si/DraRSi
         zUhGCELcMZ1gldzqD0VZhHCfwV4DvFWF1AzPNt9Npvh/LPbZwDIoq60AP8f2uc1jlpl7
         KfglaDONAZdkpU3Wd/pi6+lVDIj3aaGvC0t0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8TAxZbVYs1zX4PjOJM4uLgJ+grVxUWuimmSLQuy5a7E=;
        b=rJIAWzaGyAuLdYV3ZUB3NaEjN6alm3DPYIKZU0nJzfe4cr/bT2JngJVRXsj3IvQIkg
         63TF4ldFQneaxvqc1WZbzP+DhlXIHP2Cu/aTyYKLVz5xEFVV0vapLRxpW5vwJthJepfz
         0ceL5jVGnACnOzHvUQIglmoyXgAKZPMMu3nZPfDhREww87vjiSjMuNdPS0lF+vjELuHh
         qtIQyeFQMf+nNxQtp5WwxixYbidFtjRC/WfC0VTmvpoVL+pRbcETtzpQNLZcDUp2HCH7
         KH/Fs6jpEwxFAFOqKXTNhvnMc7iWQ5B30+/fNaWehF9omLBYydh98f58NkUm+54yV5ab
         MSCQ==
X-Gm-Message-State: ABuFfogXvZmKX8xiXypVLEmm6mq6oqUTFUX+xzbxQ+eL4EM+XJvwy8gl
        cZJRXrq/HDp0JwkSVE/u9jZ2RYMpFbf90KJI05YCIA==
X-Google-Smtp-Source: ACcGV62zhM54knkK0Yq6K3qCQ6D+WD1q2Z2iCxR7zFH8UzVULQ62O47BO46nVNFNFRldJVRyRNjY9BwvQjlHSdp2iEY=
X-Received: by 2002:a6b:9cc8:: with SMTP id f191-v6mr4065346ioe.266.1538647017669;
 Thu, 04 Oct 2018 02:56:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 02:56:17 -0700 (PDT)
In-Reply-To: <CAHhmqcRbz+UsgDsHzJzKDWqZ_JMNp1UYq3M2rAf1vqfmO+wRyg@mail.gmail.com>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com> <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
 <1E24731C-13E1-41CC-A96A-ABDAA6175849@linaro.org> <CAHhmqcRbz+UsgDsHzJzKDWqZ_JMNp1UYq3M2rAf1vqfmO+wRyg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Oct 2018 11:56:17 +0200
Message-ID: <CAPDyKFqJMJkmumxS3vET6kvjnGGMrHaDpUT20LDAgzygbFmZHw@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     Bryan Gurney <bgurney@redhat.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Damien.LeMoal@wdc.com, Artem Bityutskiy <dedekind1@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, aherrmann@suse.com, mgorman@suse.com,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 October 2018 at 19:34, Bryan Gurney <bgurney@redhat.com> wrote:
> On Wed, Oct 3, 2018 at 11:53 AM, Paolo Valente <paolo.valente@linaro.org> wrote:
>>
>>
>>> Il giorno 03 ott 2018, alle ore 10:28, Linus Walleij <linus.walleij@linaro.org> ha scritto:
>>>
>>> On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>>>
>>>> There is another class of outliers: host-managed SMR disks (SATA and SCSI,
>>>> definitely single hw queue). For these, using mq-deadline is mandatory in many
>>>> cases in order to guarantee sequential write command delivery to the device
>>>> driver. Having the default changed to bfq, which as far as I know is not SMR
>>>> friendly (can sequential writes within a single zone be reordered ?) is asking
>>>> for troubles (unaligned write errors showing up).
>>>
>>> Ah, that is interesting.
>>>
>>> Which device driver files are we talking about here, specifically?
>>> I'd like to take a look.
>>>
>>> I guess what you say is not that you are looking for the deadline
>>> scheduling per se (as in deadline scheduling is nice), what you want is
>>> the zone locking semantics in that scheduler, is that right?
>>>
>>> I.e. this business:
>>> blk_queue_is_zoned(q)
>>> blk_req_zone_write_lock(rq);
>>> blk_req_zone_write_unlock(rq);
>>> and mq-deadline solves this with a spinlock.
>>>
>>> I will augment the patch to enforce mq-deadline
>>> if blk_queue_is_zoned(q) is true, as it is clear that
>>> any device with that characteristic must use mq-deadline.
>>>
>>> Paoly might be interested in looking into whether BFQ could
>>> also handle zoned devices in the future, I have no idea of how
>>> hard that would be.
>>>
>>
>> Absolutely, as I already wrote in my reply to Damien.
>>
>> In the meantime, Linus, augmenting your patch as you propose seems
>> a clean and effective solution to me.
>>
>> Thanks,
>> Paolo
>>
>>> The zoned business seems a bit fragile. Should it even be
>>> allowed to select any other scheduler than deadline on these
>>> devices? Presenting all compiled in schedulers in
>>> /sysblock/device/queue/scheduler sounds like just giving
>>> sysadmins too much rope.
>>>
>>> Yours,
>>> Linus Walleij
>>
>
> Right now, users of host-managed SMR drives should be using "deadline"
> or "mq-deadline", to avoid out-of-order writes in sequential-only
> zones.
>
> I'm running into a situation right now on a test system (Fedora 28,
> 4.18.7 kernel) where I copied test data onto an F2FS filesystem, but I
> accidentally forgot to add my "udev rule" file:
>
> # cat /etc/udev/rules.d/99-zoned-block-devices.rules
> ACTION=="add|change", KERNEL=="sd[a-z]",
> ATTRS{queue/zoned}=="host-managed", ATTR{queue/scheduler}="deadline"
>
> ...and now, I see these messages when that specific SMR drive is mounted:
>
> kernel: F2FS-fs (sdc): IO Block Size:        4 KB
> kernel: F2FS-fs (sdc): Found nat_bits in checkpoint
> kernel: F2FS-fs (sdc): Mounted with checkpoint version = 212216ab
> kernel: mpt3sas_cm0: log_info(0x31080000): originator(PL), code(0x08),
> sub_code(0x0000)
> kernel: mpt3sas_cm0: log_info(0x31080000): originator(PL), code(0x08),
> sub_code(0x0000)
> kernel: scsi_io_completion: 20 callbacks suppressed
> kernel: sd 7:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE
> kernel: sd 7:0:0:0: [sdb] tag#0 Sense Key : Aborted Command [current]
> kernel: sd 7:0:0:0: [sdb] tag#0 Add. Sense: No additional sense information
> kernel: sd 7:0:0:0: [sdb] tag#0 CDB: Write(16) 8a 00 00 00 00 00 3d d4
> ec 99 00 00 00 80 00 00
>
> I was also running into problems with creating new directories on this
> F2FS filesystem.  However, "fsck.f2fs" reports no problems.  So at
> this point, I created a new F2FS filesystem on a second SMR drive, and
> am currently copying the data from the "bad" F2FS filesystem to the
> "good" one.
>
> I wouldn't call zoned block devices "fragile"; they simply have I/O
> rules that didn't previously exist: all writes to sequential-only
> zones must be sequential.  And one of the things that schedulers do is
> reorder writes.  After 4.16, sd stopped being the "gatekeeper" of
> ensuring sequential writes, but the only "zoned-aware" schedulers were
> deadline and mq-deadline.  Since my test system defaulted to "cfq", I
> ran into problems.
>
> So I welcome any changes that make it impossible for the user to
> "accidentally use the wrong scheduler".

I fully agree.

>
> At least this time, I didn't "brick" my test system's BIOS, like I did
> back in May of this year [1].

It sounds to me that the kernel isn't doing its job. In particular,
the kernel have the information, as to be able to select the proper
I/O scheduler (the block layer could just check
BLK_ZONE_TYPE_SEQWRITE_REQ/ZBC_ZONE_TYPE_SEQWRITE_REQ). Instead it
relies on userspace to do the right thing, it can't be right.

Kind regards
Uffe

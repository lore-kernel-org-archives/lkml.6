Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E2D2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu8gNVfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E2D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJCWl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:41:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34731 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbeJCWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:41:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so6722813wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGd85nOuYerT55AxFzZUXNAAK6duCOFyRC4cb8TBE2o=;
        b=Nu8gNVfwiacV/OVh6zh2skiV2k76a8YZSYKnLPcRvIccyR+q/96av2Nd7eXWEqbDYt
         9q40tFZ2fth+j7bA8bm7G9ja25y846HvKoI8HbETHWJWhEUArg0DXaS+aQmrYQ4i8XHv
         pSLRLVI3klkcNP7bmBf8IIRjKC11gR0C+UpWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGd85nOuYerT55AxFzZUXNAAK6duCOFyRC4cb8TBE2o=;
        b=NikRS/6nj8m/M7cIobuz4LTo3YJkr9jD/7mMEfYZQqYS411MrBzoxBAKWxcxWP2QAs
         /oKHpF1/VtCV3yrjz5falXpSqQjYPylUbmxH1bQYlfGcZLW4J8TgxK5q/iiIFgFw93+b
         c3UxbB8HMIQv9Bmqkkg9UzqvgUMdo8I79FDn3oZyY6FazwYdMJtyy+26GhXkWhseIKzu
         m1udw4CTVLKAbenAIjoQ6EW8y+uwYYG3nCS2HL23cieikYUzfatK066aqN4sJM4aWh7+
         NjAGSv5eqLET3ONtbnGF3jO+iOfknWZpvO2GWJHrHDLOtoW+Jzo3vOKCX2YkrwjsFaYh
         FVXQ==
X-Gm-Message-State: ABuFfoiw9Dv/wupZucNsLKO1c6Y4PSkzBfurvf0CQVbM9qfFfJB4P6kg
        wYyEWGRAkOSPwkLfRks5hkAv8Q==
X-Google-Smtp-Source: ACcGV63F/jJ3loqz5JnvxaMmQ7z/Kt9k8nYt1OAAuqCJB3MR16yTqgiXjtsR+NjQF7NWcInBuHH4zw==
X-Received: by 2002:adf:9a38:: with SMTP id z53-v6mr1847992wrb.75.1538581979966;
        Wed, 03 Oct 2018 08:52:59 -0700 (PDT)
Received: from [192.168.43.112] ([31.157.182.99])
        by smtp.gmail.com with ESMTPSA id w11-v6sm2368521wrn.65.2018.10.03.08.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:52:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
Date:   Wed, 3 Oct 2018 17:52:57 +0200
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>,
        "aherrmann@suse.com" <aherrmann@suse.com>,
        "mgorman@suse.com" <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44614924-FF19-4C99-B04F-93C032B74395@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 03 ott 2018, alle ore 09:42, Damien Le Moal =
<damien.lemoal@wdc.com> ha scritto:
>=20
> On 2018/10/03 16:18, Linus Walleij wrote:
>> On Wed, Oct 3, 2018 at 9:05 AM Artem Bityutskiy <dedekind1@gmail.com> =
wrote:
>>> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
>>>> So, I do understand your need for conservativeness, but, after so =
much
>>>> evidence on single-queue devices, and so many years! :), what's the
>>>> point in keeping Linux worse for virtually everybody, by default?
>>>=20
>>> Sounds like what we just need a mechanism for the device (ubi block =
in
>>> this case) to select the I/O scheduler. I doubt enhancing the =
default
>>> scheduler selection logic in 'elevator.c' is the right answer. Just
>>> give the driver authority to override the defaults.
>>=20
>> This might be true in the wider sense (like for what scheduler to
>> select for an NVME device with N channels) but $SUBJECT is just
>> trying to select BFQ (if available) for devices with one and only one
>> hardware queue.
>>=20
>> That is AFAICT the only reasonable choice for anything with just
>> one hardware queue as things stand right now.
>>=20
>> I have a slight reservation for the weird outliers like loopdev, =
which
>> has "one hardware queue" (.nr_hw_queues =3D=3D 1) though this
>> makes no sense at all. So I would like to know what people think
>> about that. Maybe we should have .nr_queues and .nr_hw_queues
>> where the former is the number of logical queues and the latter
>> the actual number of hardware queues.
>=20
> There is another class of outliers: host-managed SMR disks (SATA and =
SCSI,
> definitely single hw queue). For these, using mq-deadline is mandatory =
in many
> cases in order to guarantee sequential write command delivery to the =
device
> driver. Having the default changed to bfq, which as far as I know is =
not SMR
> friendly (can sequential writes within a single zone be reordered ?) =
is asking
> for troubles (unaligned write errors showing up).
>=20

Hi Damien,
actually I have followed threads on SMR device, and have already looked
into this.  I'm sorry for not having mentioned it in my first reply.

My plan is to simply port this feature from mq-deadline to bfq.  It
should be really straightforward, especially after the testing you did
through mq-deadline.  Even if I'm missing some less trivial hidden
issue, I guess it won't be impossible to address.

If it may be useful for the outcome of this thread, I'm willing to
raise the priority of this change to bfq.

> A while back, we already had this discussion with Jens and Christoph =
on the list
> to allow device drivers to set a sensible default I/O scheduler for =
devices with
> "special needs" (e.g. host-managed SMR). At the time, the conclusion =
was that
> udev (or something alike in userland) is better suited to set a =
correct scheduler.
>=20
> Of note also is that host-managed like sequential zone devices are =
also likely
> to show up soon with the work being done in the NVMe standard on the =
new "Zoned
> namespace" feature proposal. These devices will also require a =
scheduler like
> mq-deadline guaranteeing per-zone in-order delivery of sequential =
write
> requests. Looking only at the number of queues of the device is not =
enough to
> choose the best (most reasonnable/appropriate) scheduler.
>=20

Until bfq simply handles SMR devices too.

Thanks,
Paolo

> --=20
> Damien Le Moal
> Western Digital Research


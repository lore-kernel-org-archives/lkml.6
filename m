Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C51BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E258820875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bntNnNAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E258820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeJEQZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:25:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44988 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeJEQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:25:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so12785506wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 02:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rDCcyN9BQqaci5BS2MACKe5qUHXubvViTJ56L651cNk=;
        b=bntNnNANPdkSXkr6kNRYbVuoR+0EM9tfC2fBYAqEJEokw/wsI6CeUZrs0uSjQtLpRY
         oEVng7n6B06n90JYmw3OpGc8IV2fZRBEBy70v5iIeZfrGTDUs2964yA/Zert9LUdG04O
         eLbui8ej5n6QysYYZZBum68RqTbHKdCs1KCdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rDCcyN9BQqaci5BS2MACKe5qUHXubvViTJ56L651cNk=;
        b=EArwdoEkp0i/0rXdbCabQXGe3pf0fpZxgo8kkBw1OdCsTYRZtEklbTfM1uqZNsA/PT
         DuEr4pB6CyVg9svDZ9LoxWVjjyAWwX1+crU1wWD1O++D/YootkLhLNXttRPgw3k4AZrS
         zeFrB7tFglGh6Vxr5LoQ5gunqTw+wKAt6/775LXQPkqyT2DYcxzxwfopytPr8ktV6SXr
         C1T1X41rDFuQv8xnqn3SKllREoyt7JhXbNd5smsfqnOTlLXLQvp4nuRHwQt8NM779tz8
         i9DyMSZUj3Gi7DSrMtVQZVYfG8kkpVIV7y4SiJ3Fk+RCgN2T7l4uwV1Ilydva55Lgx2D
         v+dA==
X-Gm-Message-State: ABuFfogTPwOFQ0Nkllx8S6RWNcZyFCdblfjHp2QLwxqv8aDdLnBwsm5k
        pPqNV2cuMNMmvR31VXHH4Dq10A==
X-Google-Smtp-Source: ACcGV62B2AD/QA1zdXlF+2IjTSdo83369EPUgKjmBDYm4SwL6Lr0jp13NX9Bnxobf9PHSybykE3SXg==
X-Received: by 2002:adf:edc2:: with SMTP id v2-v6mr7105050wro.208.1538731683304;
        Fri, 05 Oct 2018 02:28:03 -0700 (PDT)
Received: from wifi-122_dhcprange-127.wifi.unimo.it ([155.185.122.127])
        by smtp.gmail.com with ESMTPSA id b193-v6sm1274372wmg.44.2018.10.05.02.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 02:28:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538692972.8223.7.camel@acm.org>
Date:   Fri, 5 Oct 2018 11:28:07 +0200
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A76F98D4-4D3E-4DFA-BF24-C64AD8BF8169@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 05 ott 2018, alle ore 00:42, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Thu, 2018-10-04 at 22:39 +0200, Paolo Valente wrote:
>> No, kernel build is, for evident reasons, one of the workloads I =
cared
>> most about.  Actually, I tried to focus on all my main
>> kernel-development tasks, such as also git checkout, git merge, git
>> grep, ...
>>=20
>> According to my test results, with BFQ these tasks are at least as
>> fast as, or, in most system configurations, much faster than with the
>> other schedulers.  Of course, at the same time the system also =
remains
>> responsive with BFQ.
>>=20
>> You can repeat these tests using one of my first scripts in the S
>> suite: kern_dev_tasks_vs_rw.sh (usually, the older the tests, the =
more
>> hypertrophied the names I gave :) ).
>>=20
>> I stopped sharing also my kernel-build results years ago, because I
>> went on obtaining the same, identical good results for years, and I'm
>> aware that I tend to show and say too much stuff.
>=20
> On my test setup building the kernel is slightly slower when using the =
BFQ
> scheduler compared to using scheduler "none" (kernel 4.18.12, NVMe =
SSD,
> single CPU with 6 cores, hyperthreading disabled). I am aware that the
> proposal at the start of this thread was to make BFQ the default for =
devices
> with a single hardware queue and not for devices like NVMe SSDs that =
support
> multiple hardware queues.
>=20

I miss your point: as you yourself note, the proposal is limited to
single-queue devices, exactly because BFQ is not ready for
multiple-queue devices yet.

> What I think is missing is measurement results for BFQ on a system =
with
> multiple CPU sockets and against a fast storage medium.

It is not missing.  As I happened to report in previous threads, we
made a script to measure that too [1], using fio and null block.

I have reported the results we obtained, for three classes of
processors, in the in-kernel BFQ documentation [2].

In particular, BFQ reached 400KIOPS with the fastest CPU mentioned in
that document (Intel i7-4850HQ).

So, since the speed of that single-socket commodity CPU is most likely
lower than the total speed of a multi-socket system, we have that, on
such a system and with BFQ, you should be conservatively ok with
single-queue devices in the range 300-500 KIOPS.

[1] https://github.com/Algodev-github/IOSpeed
[2] https://www.kernel.org/doc/Documentation/block/bfq-iosched.txt

> =20

> Eliminating
> the host lock from the SCSI core yielded a significant performance
> improvement for such storage devices. Since the BFQ scheduler locks =
and
> unlocks bfqd->lock for every dispatch operation it is very likely that =
BFQ
> will slow down I/O for fast storage devices, even if their driver only
> creates a single hardware queue.
>=20

One of the main motivations behind NVMe, and blk-mq itself, is that it
is hard to reach the above IOPS, and more, with a single I/O queue as
bottleneck.

So, I wouldn't expect that systems
- equipped with single-queue drives reaching more than 500 KIOPS
- using SATA or some other non-NVMe as protocol
- so fast to push these drives to their maximum speeds
constitute more than a negligible percentage of devices.

So, by sticking to mq-deadline, we would sacrifice 99% of systems, to
make sure, basically, that those very few systems on steroids reach
maximum throughput with random I/O (while however still suffering from
responsiveness problems).  I think it makes much more sense to have as
default what is best for 99% of the single-queue systems, with those
super systems properly reconfigured by their users.  For sure, other
defaults are to be changed too, to get the most out of those systems.

Thanks,
Paolo


> Bart.


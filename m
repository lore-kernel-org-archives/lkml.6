Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F43C65BA7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADCF20652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKn+S5so"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADCF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJCNQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:16:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33243 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeJCNQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:16:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so6391382wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dOenQctWUQs8r5V17gMkUwrIeBqIxwj89sTfNHHymNM=;
        b=XKn+S5soOEDKGoRW4Io99NoI7mp2OAcmSQ5VsEbxlfd9c7rVNUhnGyJ4wEdk14ImIP
         M3U2oQ8AKaW6pzyIPTzJoIUr0q7A1Yh9vJzYWShP9eTvlHV/aHTksl3jSZto12x89BBN
         f+kC0b8B54usvlfLrwJ517kbJ3pXodoQYPlTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dOenQctWUQs8r5V17gMkUwrIeBqIxwj89sTfNHHymNM=;
        b=X1nNCSSywS4E21Es55CCZHQtbeYDGj444tJ4KJlrLKV08wMeji0dZW0RFk6g2WgBWM
         DQD2ANwW8OlrQGBHVXwO+LHPTKwvTDbja8oUz4OsWTaS1T9ZMKGw5sXgspifAocNUSnJ
         LQ+LXeMALAad2HSsRSmpe2ECe8xSelTmfM2DXHMOOZdJKqIndNz/17mPdeG8Fd0yqJYG
         dSY9I2B3vRMZr/0yawVIIqljuHJD8dRbkjMhC7UNRRRbu3rjO3zkjuJD1mSatGP4pdKb
         cGltSFHVg+6fPIoneg6B63e0Vc+23PzMQ57VILHIcMXQVKRyqI+ah57rnEVTn7gtXaln
         XKPg==
X-Gm-Message-State: ABuFfoiVfKNuyzIUqCpFaJG+/jet34p5lqiG//mrIadncTt/zZ8RN9Ns
        A1F4mJTIRQeMaF9bZ2PsgcW+0g==
X-Google-Smtp-Source: ACcGV63CEHbPZsRhEvGDN9+dNsQPUNAb6pqwIIcb3WOqRpGF/m/6GSKSV8+kt/abL0aYdT50AtLPzA==
X-Received: by 2002:a1c:1507:: with SMTP id 7-v6mr320930wmv.6.1538548153132;
        Tue, 02 Oct 2018 23:29:13 -0700 (PDT)
Received: from [192.168.0.100] (146-241-17-39.dyn.eolo.it. [146.241.17.39])
        by smtp.gmail.com with ESMTPSA id w4-v6sm595323wra.83.2018.10.02.23.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 23:29:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
Date:   Wed, 3 Oct 2018 08:29:10 +0200
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 02 ott 2018, alle ore 16:31, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 10/2/18 6:43 AM, Linus Walleij wrote:
>> This sets BFQ as the default scheduler for single queue
>> block devices (nr_hw_queues =3D=3D 1) if it is available. This
>> affects notably MMC/SD-cards but notably also UBI and
>> the loopback device.
>>=20
>> I have been running it for a while without any negative
>> effects on my pet systems and I want some wider testing
>> so let's throw it out there and see what people say.
>> Admittedly my use cases are limited.
>>=20
>> I talked to Pavel a bit back and it turns out he has a
>> usecase for BFQ as well and I bet he also would like it
>> as default scheduler for that system (Pavel tell us more,
>> I don't remember what it was!)
>>=20
>> Intuitively I could understand that maybe we want to
>> leave the loop device (possibly others? nbd? rbd?) as
>> "none", as it is probably relying on a scheduler on the
>> device below it, so I'm open to passing in a scheduler hint
>> from the respective subsystem in say struct blk_mq_tag_set.
>> However that makes for a bit of syntactic dissonance
>> with the struct member ".nr_hw_queues" (I wonder how
>> the loop device can have 1 "hardware queue"?) so
>> maybe we should in that case also rename that struct
>> member to ".nr_queues" fair and square before we start
>> making adjustments for treating queues differently whether
>> they are in hardware or actually not.
>=20
> I think this should just be done with udev rules, and I'd
> prefer if the distros would lead the way on this, as they
> are the ones that will most likely see the most bug reports
> on a change like this.
>=20

Hi Jens,
I see your point, but I doubt this is the way to go, because of the
following flaws.

As also Linus Torvalds complained [1], people feel lost among
I/O-scheduler options.  Actual differences across I/O schedulers are
basically obscure to non experts.  In this respect, Linux-kernel
'users' are way more than a few top-level distros that can afford a
strong performance team, and that, basing on the input of such a team,
might venture light-heartedly to change a critical component like an
I/O scheduler.  Plus, as Linus Walleij pointed out, some users simply
are not distros that use udev.

So, probably 99% of Linux-kernel users will just stick to the default
I/O scheduler, mq-deadline, assuming that the algorithm by which that
scheduler was chosen was not "pick the scheduler with the longest
name", but "pick the best scheduler for most cases".  The problem is
that, for single-queue devices with a speed below 400/500 KIOPS, the
default scheduler is apparently incomparably worse than bfq in terms
of responsiveness and latency for time-sensitive applications [2], and
in terms of throughput reached while controlling I/O [3].  And, in all
other tests ran so far, by any entity or group I'm aware of, bfq
results basically on par with or better than mq-deadline.

So, I do understand your need for conservativeness, but, after so much
evidence on single-queue devices, and so many years! :), what's the
point in keeping Linux worse for virtually everybody, by default?

Thanks,
Paolo

[1] https://lkml.org/lkml/2017/2/21/791
[2] http://algo.ing.unimo.it/people/paolo/disk_sched/results.php
[3] https://lwn.net/Articles/763603/



> --=20
> Jens Axboe


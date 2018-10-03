Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2075EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB96A20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D39vBri6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB96A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJDALp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:11:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33029 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeJDALp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:11:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so7050964wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LyqJ4anEYMwD0L3rYcfWiYxAf+l80CRBoz4rcy3lb2M=;
        b=D39vBri65+fA+sORnB0Yo+uzfShXCQfAts16yWMAMHHm/KxsKrViGbisQZfnNjrI7r
         +QSH3S9JVEv26yS5uSZ8Hq6lgPg64b0i6KglQwvrfLv90FT7pJ3jT40amhKdmajjqveC
         +GiWDy2Kqk7cjzchQSlaUr94jyVPm+3SrmZTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LyqJ4anEYMwD0L3rYcfWiYxAf+l80CRBoz4rcy3lb2M=;
        b=RnZfLj05CTxbqp84CDmNfWhRrModGNVTWJHooGCBYxVxKORkS4EX2xpbEDeQARv20f
         3fDGd/rAkgTAM4CmY52gbyLpAHyGh3JILzf/hg/OubjAXOSAV7oe6cPcZ9e54An/E0zX
         K3nCkjkz17LczIxeJ6G/qNpnizLu2AzLaytpnOnTG81rtEWDDod9yKFFqYDMhJcz9YhC
         x7Lvg3b2tUmU6O6zwYtEBUreS3zJdKNWyW70RuYYKw654hSQWMsROMDcnkgzhc9iPV+x
         MPvYr1OigJ1NhtNXRbqQDFkEUn2PAb5HEr0MKyhmKKFMA7W3aQ3oGAuwDfbHinbXGm0E
         0yOQ==
X-Gm-Message-State: ABuFfoj4Am8y7+IXxBrHiRXkcfqys1hFmgOsluCapX8lD8zi7lWMGkF7
        JF+RrBlr0OAyXqTo5wSYEQ5Z5Q==
X-Google-Smtp-Source: ACcGV60MPQ43IC41XmNQMfvhSq9uHgjELZ3odS6psD3B13NpclsdI6ZC8tgxEothMBq2Cwr2XQnwFg==
X-Received: by 2002:adf:9f0f:: with SMTP id l15-v6mr2090426wrf.206.1538587344749;
        Wed, 03 Oct 2018 10:22:24 -0700 (PDT)
Received: from [192.168.0.100] (146-241-40-124.dyn.eolo.it. [146.241.40.124])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2230546wme.40.2018.10.03.10.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:22:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
Date:   Wed, 3 Oct 2018 19:22:20 +0200
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <11FFD0AF-4A08-4565-B4BE-FF80EA5BB5E6@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org>
 <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
To:     'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 03 ott 2018, alle ore 18:02, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 03 ott 2018, alle ore 17:54, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>>=20
>> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
>>> [1] https://lkml.org/lkml/2017/2/21/791
>>> [2] http://algo.ing.unimo.it/people/paolo/disk_sched/results.php
>>> [3] https://lwn.net/Articles/763603/
>>=20
>> =46rom [2]: "BFQ loses about 18% with only random readers, because =
the number
>> of IOPS becomes so high that the execution time and parallel =
efficiency of
>> the schedulers becomes relevant." Since the number of I/O patterns =
for which
>> results are available on [2] is limited and since the number of =
devices for
>> which test results are available on [2] is limited (e.g. RAID is =
missing),
>> there might be other cases in which configuring BFQ as the default =
would
>> introduce a regression.
>>=20
>=20
> =46rom [3]: none with throttling loses 80% of the throughput when used
> to control I/O. On any drive. And this is really only one example =
among a ton.
>=20

I forgot to add that the same 80% loss happens with mq-deadline plus
throttling, sorry.  In addition, mq-deadline suffers from much more
than a 18% loss of throughput, w.r.t. bfq, exactly in the same figure
you cited, if there are random writes too.

> In addition, the test you mention, designed by me, was meant exactly
> to find and show the worst breaking point of BFQ.  If your main
> workload of interest is really made only of tens of parallel thread
> doing only sync random I/O, and you care only about throughput,
> without any concern for your system becoming so unresponsive to be
> unusable during the test, then, yes, mq-deadline is a better option
> for you.
>=20

Some more detail on this.  The fact that bfq reaches a lower
throughput than none in this test is actually still puzzling me,
because the process rate of I/O with bfq is one order of magnitude
higher than the IOPS of this device.  So, I still don't understand
why, with bfq, the queue of the device does not get as full as with
none, and thus why the throughput with bfq is not the same as with
none.

To further test this issue, I replaced sync I/O with async I/O (with a
very high depth).  And, nonsensically (for me), throughput dropped
with both bfq and none!  I already meant to to report this issue,
after investigating it more.  Anyway, this is a different story w.r.t.
this thread.

Thanks,
Paolo


> So, are you really sure the balance is in favor of mq-deadline?
>=20
> Thanks,
> Paolo
>=20
>> I agree with Jens that it's best to leave it to the Linux =
distributors to
>> select a default I/O scheduler.
>>=20
>> Bart.
>=20
> --=20
> You received this message because you are subscribed to the Google =
Groups "bfq-iosched" group.
> To unsubscribe from this group and stop receiving emails from it, send =
an email to bfq-iosched+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.


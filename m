Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B210C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38462084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHX0eeAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38462084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJFXua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:50:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34561 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeJFXua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:50:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id z4-v6so16500683wrb.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=orT95nIgXX54+qqMVs94e8m3zgxG4mYOAV47Gi1q2vE=;
        b=OHX0eeApzGJ0f4I0jWwt4OBkxgscv3jsulRCCGbvfbEreLda85nUEFJ88T+GwZj18b
         PNMfNXSaBgDMh6rEmKNVO+hFfnX4so6HRqZrOQ5m+1bwcBkK3culrnTZz787OKwda7xJ
         +5eYnmDixIhubYpB+zoOzd3XPqJWrttyhSeGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=orT95nIgXX54+qqMVs94e8m3zgxG4mYOAV47Gi1q2vE=;
        b=RzpsMmq8VMbSZ8jh/Kxa3wRKKpt4LE1V08Y/oSfEnE3CseRSXv5ibqfx1B6u0Ik6yM
         l05+/4Xd6RPbNNL2vzU8qm641Z3Px14xyGpRswnCdc3F7bLh3ForvmrZ6+E4+j+EMCIj
         0lBezmuCUOPhFF4fg0aliZ6iCzvsMX4/ZC2ju60w6JMpEQsE7W9c0wWE1nwLHq31xS5O
         tLDZNmtk3LsiKphv20m4rGyc2UIQedB8ozQ8w5exZuShbHnHnDA+mp7CUSNClyv4jrXm
         bwh1i9dqLivWqBaqgXRdbydhMMA8z41H9I4nj2snMPpLQM8zYq4I4DWuY+PwyQtqnlpL
         ZSIg==
X-Gm-Message-State: ABuFfog/UsgRLX04tHqWC/hnkOO+CWHQQYcFXm5dLKmaX5FhrENwF9GS
        D5+X3DDv3lGerDAMuTMLl81lyw==
X-Google-Smtp-Source: ACcGV62mgQFO8UahMXZ4PeGhMZWHF1P0k2jziBqgpw1uKVT9uCrch59h1Ey+ZWve9Mhou4mmtiBNbA==
X-Received: by 2002:adf:fe83:: with SMTP id l3-v6mr11900045wrr.322.1538844385392;
        Sat, 06 Oct 2018 09:46:25 -0700 (PDT)
Received: from [192.168.0.103] (146-241-62-14.dyn.eolo.it. [146.241.62.14])
        by smtp.gmail.com with ESMTPSA id y138-v6sm4290514wmd.2.2018.10.06.09.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 09:46:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <bb934140-ef97-05b3-2bfc-d82be4766578@acm.org>
Date:   Sat, 6 Oct 2018 18:46:22 +0200
Cc:     Jan Kara <jack@suse.cz>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6305E683-5078-4DA1-A168-D4E5D9BFA80F@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org> <20181005091626.GA9686@quack2.suse.cz>
 <20bfa679-3131-e0af-f69d-2fbec32fbced@acm.org>
 <A6518C7A-C7DF-48A6-A57A-F4B4162DC16E@linaro.org>
 <bb934140-ef97-05b3-2bfc-d82be4766578@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 06 ott 2018, alle ore 18:20, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On 10/5/18 11:46 PM, Paolo Valente wrote:
>>> Il giorno 06 ott 2018, alle ore 05:12, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>>> On 10/5/18 2:16 AM, Jan Kara wrote:
>>>> On Thu 04-10-18 15:42:52, Bart Van Assche wrote:
>>>>> What I think is missing is measurement results for BFQ on a system =
with
>>>>> multiple CPU sockets and against a fast storage medium. =
Eliminating
>>>>> the host lock from the SCSI core yielded a significant performance
>>>>> improvement for such storage devices. Since the BFQ scheduler =
locks and
>>>>> unlocks bfqd->lock for every dispatch operation it is very likely =
that BFQ
>>>>> will slow down I/O for fast storage devices, even if their driver =
only
>>>>> creates a single hardware queue.
>>>> Well, I'm not sure why that is missing. I don't think anyone =
proposed to
>>>> default to BFQ for such setup? Neither was anyone claiming that BFQ =
is
>>>> better in such situation... The proposal has been: Default to BFQ =
for slow
>>>> storage, leave it to deadline-mq otherwise.
>>>=20
>>> How do you define slow storage? The proposal at the start of this =
thread
>>> was to make BFQ the default for all block devices that create a =
single
>>> hardware queue. That includes all SATA storage since scsi-mq only =
creates
>>> a single hardware queue when using the SATA protocol. The proposal =
to make >> BFQ the default for systems with a single hard disk probably =
makes sense
>>> but I am not sure that making BFQ the default for systems equipped =
with
>>> one or more (SATA) SSDs is also a good idea. Especially for =
multi-socket
>>> systems since BFQ reintroduces a queue-wide lock.
>> No, BFQ has no queue-wide lock.  The very first change made to BFQ =
for
>> porting it to blk-mq was to remove the queue lock.  Guided by Jens, I
>> replaced that lock with the exact, same scheduler lock used in
>> mq-deadline.
>=20
> It's easy to see that both mq-deadline and BFQ define a queue-wide =
lock. For mq-deadline its deadline_data.lock. For BFQ it's =
bfq_data.lock. That last lock serializes all bfq_dispatch_request() =
calls and hence reduces concurrency while processing I/O requests. =46rom =
bfq_dispatch_request():
>=20
> static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
> {
> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
> 	[ ... ]
> 	spin_lock_irq(&bfqd->lock);
> 	[ ... ]
> }
>=20
> I think the above makes it very clear that bfqd->lock is queue-wide.
>=20
> It is easy to understand why both I/O schedulers need a queue-wide =
lock: the only way to avoid race conditions when considering all pending =
I/O requests for scheduling decisions is to use a lock that covers all =
pending requests and hence that is queue-wide.
>=20

Absolutely true.  Queue lock is evidently a very general concept, and
a lock on a scheduler is, in the end, a lock on its internal queue(s).
But the queue lock removed by blk-mq is not that small per-scheduler
lock, but the big, single-request-queue lock.  The effects of the
latter are probably almost one order of magnitude higher than those of
a scheduler lock, even with a non-trivial scheduler like BFQ.

As a simple concrete proof of this fact, consider the numbers that I
already gave you, and that you can re-obtain in five minutes: on a
laptop, BFQ may support up to 400KIOPS.  Probably, even just with noop
as I/O scheduler, the same PC cannot process so many IOPS with legacy
blk (because of the single-request-queue lock).

To sum up, in your argument you mixed two different locks.

Anyway, you are going very deep in this issue.  This takes you very
close to what I'm currently working on (still in a design phase):
increasing the parallel efficiency of BFQ, mainly by reducing the
duration of the pieces of BFQ executed under its scheduler lock.

But the goal of such a non-trivial improvement is to go from the
current 400 KIOPS to more than one million of IOPS.  This is an
improvement that will most likely provide no benefits for probably 99%
of the systems with single-queue devices.  Those systems simply do no go
beyond 300 KIOPS.

So, I'm trying to first devote my limited single-person bandwidth
(sorry, I didn't resist the temptation to joke on this growing
discussion on single-something issues :) ) to improvements that make
BFQ better within its current hardware scope.

Thanks,
Paolo

> Bart.


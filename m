Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC01EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59AA20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2SdoDqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59AA20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeJEDeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:34:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36937 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeJEDeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:34:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so586354wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P2SzKngWQmTMeesDAsT186A/MDilvXbaxeJYoWc4fkU=;
        b=Z2SdoDqvK8QxWTqP+KfQ29zhUCFsyashc6WPJBoudEivDbSJVPbwBYKCtKpGzNzuNk
         vgVDQmBLULbww4q17Jo0C7VIhmv3Usmv8y5ZTAEn57nvbIXuuE6HJlGHfzcMVBL/DorE
         wuVfMKMAUChf7ue3mA+rIpySyI/X5XUpCa4kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=P2SzKngWQmTMeesDAsT186A/MDilvXbaxeJYoWc4fkU=;
        b=SRsBO0SwyseWW0X1m3qNzvoNucnhEjar9nve386Jh6nr6aUjbAaGUuzVtbAKjguhj4
         tn6haUwtAyLKr9UWorqblRcMmGnspv2O9ykLX90CRO+4vX/X87HaG3CqeCZ7RrPro/YG
         C3/1UkiaIFtwUQvmrdG7MUtieDjovtr37Mn7FZeqATb7m8ozrlWo4e1LbA1Q2MCuhxzK
         EBWtz3/cA06x+/QUrs9TdoNMnMl3MNyQt+JW0oyDQFmwZQR7lv22a+XGBYQZYHtBqicH
         vG6X9tsZaFd7XohtJq99xv5exmJEk5QMfSvJIyPk6PP8JIrsxKWmDmf2KPn/k58gd78u
         6kEQ==
X-Gm-Message-State: ABuFfoh/tpcSTIR8U+xw0ns61f9xdDvfeWaEzVXR6NYoETEa33pIfSOw
        h/xXhcmoM1JrkteWUH5i00gwBg==
X-Google-Smtp-Source: ACcGV602v6+/4N1X2jxglUp8M4284OQAtJQfxYTbVhNaOBCtd8Az461hiqVXbjOgEPWmVQJ82Mwhfg==
X-Received: by 2002:a5d:41d0:: with SMTP id e16-v6mr6527020wrq.8.1538685562876;
        Thu, 04 Oct 2018 13:39:22 -0700 (PDT)
Received: from [192.168.0.100] (146-241-9-213.dyn.eolo.it. [146.241.9.213])
        by smtp.gmail.com with ESMTPSA id x8-v6sm603753wrd.54.2018.10.04.13.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 13:39:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538683746.230807.9.camel@acm.org>
Date:   Thu, 4 Oct 2018 22:39:20 +0200
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
Message-Id: <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 04 ott 2018, alle ore 22:09, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Thu, 2018-10-04 at 20:25 +0100, Alan Cox wrote:
>>> I agree with Jens that it's best to leave it to the Linux =
distributors to
>>> select a default I/O scheduler.
>>=20
>> That assumes such a thing exists. The kernel knows what devices it is
>> dealing with. The kernel 'default' ought to be 'whatever is usually =
best
>> for this device'. A distro cannot just pick a correct single default
>> because NVME and USB sticks are both normal and rather different in =
needs.
>=20
> Which I/O scheduler works best also depends which workload the user =
will run.
> BFQ has significant advantages for interactive workloads like video =
replay
> with concurrent background I/O but probably slows down kernel builds.

No, kernel build is, for evident reasons, one of the workloads I cared
most about.  Actually, I tried to focus on all my main
kernel-development tasks, such as also git checkout, git merge, git
grep, ...

According to my test results, with BFQ these tasks are at least as
fast as, or, in most system configurations, much faster than with the
other schedulers.  Of course, at the same time the system also remains
responsive with BFQ.

You can repeat these tests using one of my first scripts in the S
suite: kern_dev_tasks_vs_rw.sh (usually, the older the tests, the more
hypertrophied the names I gave :) ).

I stopped sharing also my kernel-build results years ago, because I
went on obtaining the same, identical good results for years, and I'm
aware that I tend to show and say too much stuff.

Thanks,
Paolo

> That's
> why I'm not sure whether the kernel should select the default I/O =
scheduler.
>=20
> Bart.


Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E87C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B002089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+lVVJ3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B002089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJCWvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:51:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54778 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:51:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so6266062wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wb6w6HFYiyU7K2nshj692sKb++MyK4v1CGwWJnmPTZM=;
        b=N+lVVJ3U1alRuMdtl4En2sv73m4CiU4XSl0iQe7nshVNztJRvJZyTMzApoJ2ESGELm
         iAjkz4xMtfLnDTFm1mG4M4oiiywDOPZw6rcdw5f/o4m2fepS7dpbLVdb33s4z6yPQ2lA
         0oLjdIWLp0vz6J+buqf6HhQV2PJXT/E3QQ6xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wb6w6HFYiyU7K2nshj692sKb++MyK4v1CGwWJnmPTZM=;
        b=KRFVhPN0p0MZvpONhhtTBjaYgBIt3nxPgRjyIW22NQrG1VFGukHbAzvVYiHM6lX5dX
         PKXdG9u00LuFv3UAvVzyBf/G6/u0GU6qZgAeylajN9a4kUI5tFRIkEDz9jKPbkhnlccQ
         cxkhMoHap7clUDF3AGoIw/OiasirAag5M6Vbc78ac9je2MP5AdzSn9TLM90nZ2+0DH0w
         nlBZJl4gzibFA9+8uwToKlAfH9rtCCk64cOcQhsKln3zmBjlASb3zoN+16gHWFb4lDBD
         /4kLWOZknDkcX+CVnUVUM4qikivXBJOhIqTlawKinezxVLVUCMWJB4/nwKeAC8O54dmv
         yceg==
X-Gm-Message-State: ABuFfoiciQiubfRF99lgw5ST+/TQXdZbIrudW5qeUkNZ7NeiKcn1LOWE
        BKdL6YYmQn8bdlP2rvgCyFsXaQ==
X-Google-Smtp-Source: ACcGV616z3mUKVnWtt8SU4Ef4lGI9RXITusvJNniAVO5nn2YYVJZVS5Y0SmYdkkSeqVwsRvX4yQs1g==
X-Received: by 2002:a1c:2081:: with SMTP id g123-v6mr1938210wmg.144.1538582559498;
        Wed, 03 Oct 2018 09:02:39 -0700 (PDT)
Received: from [192.168.43.112] ([31.157.182.99])
        by smtp.gmail.com with ESMTPSA id g3-v6sm1889023wrw.81.2018.10.03.09.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 09:02:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538582091.205649.20.camel@acm.org>
Date:   Wed, 3 Oct 2018 18:02:36 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
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
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 03 ott 2018, alle ore 17:54, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
>> [1] https://lkml.org/lkml/2017/2/21/791
>> [2] http://algo.ing.unimo.it/people/paolo/disk_sched/results.php
>> [3] https://lwn.net/Articles/763603/
>=20
> =46rom [2]: "BFQ loses about 18% with only random readers, because the =
number
> of IOPS becomes so high that the execution time and parallel =
efficiency of
> the schedulers becomes relevant." Since the number of I/O patterns for =
which
> results are available on [2] is limited and since the number of =
devices for
> which test results are available on [2] is limited (e.g. RAID is =
missing),
> there might be other cases in which configuring BFQ as the default =
would
> introduce a regression.
>=20

=46rom [3]: none with throttling loses 80% of the throughput when used
to control I/O. On any drive. And this is really only one example among =
a ton.

In addition, the test you mention, designed by me, was meant exactly
to find and show the worst breaking point of BFQ.  If your main
workload of interest is really made only of tens of parallel thread
doing only sync random I/O, and you care only about throughput,
without any concern for your system becoming so unresponsive to be
unusable during the test, then, yes, mq-deadline is a better option
for you.

So, are you really sure the balance is in favor of mq-deadline?

Thanks,
Paolo

> I agree with Jens that it's best to leave it to the Linux distributors =
to
> select a default I/O scheduler.
>=20
> Bart.


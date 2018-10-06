Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0703C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637C72086D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzV2iqsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637C72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeJFNst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:48:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45130 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeJFNss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:48:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so15535845wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C6Kx+7jZkW+F6mP2kuTI1AOyF5VbXamlYnFlsvHR0MA=;
        b=VzV2iqsjxOM6liTmB3OsLEr5P4AvCsaQivvBN9GROM3qY3/A3QfewS5m5DpWXTb78R
         yI+bdUF4bt4zXfifC7ZribvpCz/euv/Cwg02ymEV0dzS++yuw03p7Li/Lswc9l1JsJYv
         fqXnCxJjUuvToplMJhaUPNHB+cW4ERZd8bov0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C6Kx+7jZkW+F6mP2kuTI1AOyF5VbXamlYnFlsvHR0MA=;
        b=uMf7TbQowDXswt7r/lQUydyBeaDWuWm4Rw8II/GAX76t8c76N4TM2n7eXe9GSZaZDn
         cpc4IsbMxox8F7Ccf9W+dVPHv3Nt4ZdOw23DwUB/X5FJeEF58jT0RYreImArsi4lYtkJ
         irZNnZOs01Xls0t5bEZBFwfeBOpVDp+OVlvmybi4oh+lGLfNmrRe/4FzCxUdaH//uzQ1
         SQAPpaLNE0ZYQW+VaFC68FwYrToguH2ishQXqOOd94KZpPViETWJSylY12tPrA/beogo
         HD/1h1GR/q04bbKFb/aT1phb3dwNHzHSKPPt6B6Eh5VsyhxCsgmdRD5AsWVVcgVjHxiJ
         9GcA==
X-Gm-Message-State: ABuFfoiCYCxkwbuzQNGH9TbXHccF2lVrnG1+MYsAw5kNMiwASDgrKa86
        1XXd1oIR6lILLFoysgmCaE0onQ==
X-Google-Smtp-Source: ACcGV60n4xh1UBoH27Bi9nbtfE2pL35Z3Ohxp7WVzKzzU+hct7PFo7oyot1CMTR0aSkc6rEQAKKRhg==
X-Received: by 2002:adf:8022:: with SMTP id 31-v6mr11017155wrk.16.1538808398881;
        Fri, 05 Oct 2018 23:46:38 -0700 (PDT)
Received: from [192.168.0.103] (146-241-62-14.dyn.eolo.it. [146.241.62.14])
        by smtp.gmail.com with ESMTPSA id y7-v6sm4010781wmy.27.2018.10.05.23.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 23:46:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20bfa679-3131-e0af-f69d-2fbec32fbced@acm.org>
Date:   Sat, 6 Oct 2018 08:46:36 +0200
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
Message-Id: <A6518C7A-C7DF-48A6-A57A-F4B4162DC16E@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org> <20181005091626.GA9686@quack2.suse.cz>
 <20bfa679-3131-e0af-f69d-2fbec32fbced@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 06 ott 2018, alle ore 05:12, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On 10/5/18 2:16 AM, Jan Kara wrote:
>> On Thu 04-10-18 15:42:52, Bart Van Assche wrote:
>>> What I think is missing is measurement results for BFQ on a system =
with
>>> multiple CPU sockets and against a fast storage medium. Eliminating
>>> the host lock from the SCSI core yielded a significant performance
>>> improvement for such storage devices. Since the BFQ scheduler locks =
and
>>> unlocks bfqd->lock for every dispatch operation it is very likely =
that BFQ
>>> will slow down I/O for fast storage devices, even if their driver =
only
>>> creates a single hardware queue.
>> Well, I'm not sure why that is missing. I don't think anyone proposed =
to
>> default to BFQ for such setup? Neither was anyone claiming that BFQ =
is
>> better in such situation... The proposal has been: Default to BFQ for =
slow
>> storage, leave it to deadline-mq otherwise.
>=20
> Hi Jan,
>=20
> How do you define slow storage? The proposal at the start of this =
thread was to make BFQ the default for all block devices that create a =
single hardware queue. That includes all SATA storage since scsi-mq only =
creates a single hardware queue when using the SATA protocol. The =
proposal to make BFQ the default for systems with a single hard disk =
probably makes sense but I am not sure that making BFQ the default for =
systems equipped with one or more (SATA) SSDs is also a good idea. =
Especially for multi-socket systems since BFQ reintroduces a queue-wide =
lock.

No, BFQ has no queue-wide lock.  The very first change made to BFQ for
porting it to blk-mq was to remove the queue lock.  Guided by Jens, I
replaced that lock with the exact, same scheduler lock used in
mq-deadline.

Thanks,
Paolo

> As you know no queue-wide locking happens during I/O in the scsi-mq =
core nor in the blk-mq core.
>=20
> Bart.


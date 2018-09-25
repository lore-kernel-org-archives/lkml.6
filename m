Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C44AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232B920676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWFG05+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232B920676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeIYXrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:47:22 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:43397 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeIYXrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:47:21 -0400
Received: by mail-lj1-f180.google.com with SMTP id m84-v6so22535829lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sFNa0RKknb3EhVwoTAZBuDYutQeHurLMgzS3amojaJg=;
        b=IWFG05+McrAlKQjmNwVR57a9eErlDe3jbJmV1Ojv70Pwhgub7inr08osJLhIjR+Q+E
         OVwT9q1GL90T57YcQRXJz4n8w+FO5I77s0BSOVUJp8o6d3y2BAXmZGWMVKrsdEd8igO6
         2qv7ghFnCOOQ13IXpwpBgweoYDQsTMuQkznDBeirOpwsRIhX3AV7NWM/aGPbvzrpfb7E
         IIxHpODNDqq6pcrsL9KYOq2Uioa6tXfHDtIhTtLFqfKEdMHm/qxNtM7tYu0m2ajEQKBI
         rePWk7VdRP2Y8gFtfWt5aGLXXgjOlAnv/o8ozrfHUkkzRNMPi1rDrVU5EsRwEP7mtYlJ
         R3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sFNa0RKknb3EhVwoTAZBuDYutQeHurLMgzS3amojaJg=;
        b=fh1LSWe02VDSDOgTy6KeM3iAtN39SOrLtpR7i7QFks1pKgEboSEA4V+PU32uY/qIjo
         WqUUPxLg6tWiDA0c059Q7QtqoDeRhYcjLQmqBI1aSmcbjWiqUDqy54FeYVzDlRxGCGEt
         JB29ZGL/i2D9keYfSU+l69fHtEzWYE7ymORXUUNytbg4BIJEPSDt2RKOEnez0Akb9mP3
         FIbU8Tr2VwwRLenNUg7/fltZukUAqvKXCwQSoVMhFIS8HQqUmO1wpoZ9I/m8ZVOuxfmy
         ZUjb8yRB9zuMOYQ0uMl0IFysjBA+xF813COJ4bB5DGnfR2jUKBdmDBVscyx466BwfPiQ
         8R2A==
X-Gm-Message-State: ABuFfoitr9/6l/gFU9g+waz0Ji59Z2Z/2iwRd2GkHuyjSXVd1Ny/d1S1
        5VtCtYvWXwZolMb0iv4cuGlPS7n1Kg42oro9Suo=
X-Google-Smtp-Source: ACcGV60St7ARs9EAlVzSb2OKTVyKAiGfvKRhy55lANewjGYLBvm0UOZXBA9QjVCGSZJhMH9+B9R8VIVUDASFPmZcPIY=
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr1794820ljh.111.1537897126498;
 Tue, 25 Sep 2018 10:38:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:278e:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 10:38:45
 -0700 (PDT)
In-Reply-To: <20180925154101.e13613306da9c0e7408771b6@christoph-conrads.name>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <20180925112832.GA10951@amd>
 <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
 <20180925131344.GB7479@thyrsus.com> <20180925154101.e13613306da9c0e7408771b6@christoph-conrads.name>
From:   "\\0xDynamite" <dreamingforward@gmail.com>
Date:   Tue, 25 Sep 2018 12:38:45 -0500
Message-ID: <CAMjeLr8AvR8G2eFyR4zFqLsHmgw069xWTobW+pwVX4152eRoag@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Christoph Conrads <contact@christoph-conrads.name>
Cc:     esr@thyrsus.com, Pavel Machek <pavel@ucw.cz>,
        Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> And there is no level on which this is anything but bad.
>
> In this context, I want to mention the tweet by the CoC author from
> August 29, 2018 [1]:
>
>> All software is political.
>
> This tweet was posted as a response to your article "Non-discrimination
> is a core value of open source" stating that politics should be kept
> separate from work (in an open source community):

Is this at all consequential to Lessig's (Harvard Law professor) book
"Code is Law"?

There are two separate issues:  1) the political revancy of F/OSS and
2) the politics of CoCs.

It's like the Matrix:

Through one door, the community can either choose to stay political
neutered and let RMS (and company) handle all of the politics OR it
can see itself as revolutionary (because of its insistence on freedom)
and stay political, and see just how the rabbit hole goes.

Which should it be?

Mark

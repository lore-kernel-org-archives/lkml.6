Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72103ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368D720862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="k+NqPamH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368D720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeKESg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:36:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42196 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKESg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:36:56 -0500
Received: by mail-ua1-f67.google.com with SMTP id d21so2897324uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 01:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=133c4zJ21diu451h842v49iTXh/EfnsZJH98AgJ8ieY=;
        b=k+NqPamHHxY/ENDUAP0Hej3AghG9EFLv57p6CEDe1HwZx7G33HcOIa8LAxoOKTTT+O
         y9Jnrl9n1ld2qTOTXFdL7WXDuiZXxUOjym3rB4fnfmkua+GmtnRrInU5Y2RdErCAQTue
         UE0uY5hkTAkWgdXxA/dFHW8fcGiVlTDM41zRLApaFyR6LWUhw4FWwhTMhvuibcP725EI
         WGvB5svlgWvEGQit7g2r0ZQ3Cl/m6upMSkfXm+ODuDD30b7x5SyXysnXAw/3vslciw68
         5YQkyuYivprYQBraUg7wZEo27CDqdKuPhu24oJigrVE6sLlStlrOgcK2m4S/hDAIPchQ
         r/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=133c4zJ21diu451h842v49iTXh/EfnsZJH98AgJ8ieY=;
        b=ATDj+L6Zv3mu+9HyS98iVO1lUrKoroXJWRtHhf8ip0TM+2JXc7TqHZKC4bzidy20EL
         6f/mUtBStBi3SnTATxi0fYwSsoNRIPBr/jcYL6cOR/w4vXJrD9TVVFmif7hiF5Z0K9oQ
         9FF9ElmdSsLR9xPX+NSjjyTFKJ7BEyVwQsKdDnQteUMGMWWERbwMF+FV8/60AHVC8NWX
         V0X0RSIc2ky7zr69S9mWky3XtYTq6SQ8S+yAtmltfdX5+VW1HF6dmaZEa89eMVWS7UIc
         CFWqN0609dYNV5ErRieF6IXwDrfHJo8EpHK4Y95Ude32MGMEXln9pP+VEjpnsBmHIOix
         hIXA==
X-Gm-Message-State: AGRZ1gL4PlxXfqC2nRgiRaUu3kFiEHXqkLQxjME43dhqKJ3iRPmwp3pT
        7jVDlI/l9sVE+uVQ2IKanRLhb5pQARLzgYH6pQjOddCOC9w=
X-Google-Smtp-Source: AJdET5e/T28uiWlPWBC64B5SWE1ppm535DACX4EsfASCm6oQPmhASv03J9n00NWE37BuzX71fzrx7IQADfcH2GqHhuM=
X-Received: by 2002:ab0:7488:: with SMTP id n8mr9860013uap.115.1541409491311;
 Mon, 05 Nov 2018 01:18:11 -0800 (PST)
MIME-Version: 1.0
References: <1541325924-14777-1-git-send-email-gilad@benyossef.com> <2578248.XAorIH2ink@tauon.chronox.de>
In-Reply-To: <2578248.XAorIH2ink@tauon.chronox.de>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 5 Nov 2018 11:18:00 +0200
Message-ID: <CAOtvUMeRth4zrTZbEy6Co=+CR4==5oSDbaf760Yh4fj8UAf8bQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: mark cts(cbc(aes)) as FIPS allowed
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Ofir Drang <Ofir.Drang@arm.com>,
        Yael Chemla <Yael.Chemla@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Mon, Nov 5, 2018 at 10:50 AM Stephan Mueller <smueller@chronox.de> wrote=
:
>
> Am Sonntag, 4. November 2018, 11:05:24 CET schrieb Gilad Ben-Yossef:
>
> Hi Gilad,
>
> > As per Sp800-38A addendum from Oct 2010[1], cts(cbc(aes)) is
> > allowed as a FIPS mode algorithm. Mark it as such.
> >
> > [1] https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
>
> There are several types of CTS approaches. Only three of those are listed=
 in
> the SP800-38A addendum. The source code only refers to some RFCs.
>
> Did you check whether the CTS implementation matches one or more of the t=
ypes
> listed in the addendum? If yes, may I suggest to add a small statement in=
 the
> code noting this fact?

Yes, AFAIK the software implements CBC-CS3 as described in the document.
You have a very good point about this not document anywhere. I will
send a patch.

While we're at it, does someone find it useful if I implemented the
other two modes?
They are part of the standard as well, although I am not sure that in
itself is sufficient cause.


Gilad

--
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!

Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCC3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E49208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1fxvshl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dJfQQTSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E49208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeGKF4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:56:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33533 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeGKF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:56:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15-v6so92991qtp.0;
        Tue, 10 Jul 2018 22:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bg70zOPN85RSOJJ22svua//djKxZtm0rA4v2piI/oLc=;
        b=i1fxvshltVgcL3l5FLv6Z9ROCoGHlyEoMF0aE5nD4/hvCl0+VSsd8U09STzjMBvYdW
         Z9HlpGgtmZj7BSV1rOUHHRF7UAVSoAA0NcE29KRm0SASUFfHW8mqNOHUjajTbwQzkQmE
         9pOLQ2Fudf9O5F4Ld62bw0GU/YikKvrF39K+lee07NKS1CkHXGuSI2WM1xKBf25r2GRQ
         metn3hma88I7lTnn0IXge09Mx9AfKmju9yD88rSbxqxs/WyOHcNr3CMS1RGD8Ay82TqX
         3dUObe6LJBNykCY1j8ighHjeyhJ7BZXyyBeaDcFjY4qb4qkSKj75ixfU4juQdVOM7pvn
         ttOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bg70zOPN85RSOJJ22svua//djKxZtm0rA4v2piI/oLc=;
        b=dJfQQTSDP5rouBXWkU6yTmIh4gsB8YLsi4I2CHr/xbR3ukbzJMgD/wqP2b7eURcrp5
         0Ra/KxSy+SXDKUqrulyFUlrPPk7/5we2fqO9GuN2s7j2/q9y7Gp0viXISKgKYkqolxdf
         IIzs895crNycFLT1ZCkgymUk33xpaRXm58fbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bg70zOPN85RSOJJ22svua//djKxZtm0rA4v2piI/oLc=;
        b=QoBYOfTNJG4+skn431X/tnhFCNhAqBNFMpcBzFaolNXWa6Q/JEaDPCwVv5DG++/i+c
         sTENnLiab4184PgJF5quvutj1HFeHROOcxDJS3puhpwmQKsvxy+raRANpfY89va9K0FP
         OUiYESKb8XzWTIR87mN66oX/9h7s1QNhQZtTgDWHq5joBCdFFicYS03XoFNg4TqxS3uv
         k0+YjZGf+V/b3fCT16QI67L0+B/dBBmSOGUIuuXfU7/0oIIb+JJFBkwOqOUv4v9kEyOY
         NQHjnQ/6/C4czS6a/gmPVYeY9ATefmGoWf9KPAaPR+4BQS1UaeF4r3APs8+8BvU0vXqN
         PHsg==
X-Gm-Message-State: APt69E3ZssxTpNBDXRgZ7BXfmrRbl1pl4sK55pq2C5K0qIX1XVObCAZg
        nCICaE5s8rTQKuUi6oL2xKBRIlR0IGZZvk4G/bc=
X-Google-Smtp-Source: AAOMgpcMC8zpNtFraTZl+Y/s9KMf2hBVCIMaId5JgX5aq03yOJpcd7UYGesbP+6JCXAAL9/vyh7A1t4BcukrEgwe664=
X-Received: by 2002:ac8:322:: with SMTP id q34-v6mr26507868qtg.342.1531288452580;
 Tue, 10 Jul 2018 22:54:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 22:53:52
 -0700 (PDT)
In-Reply-To: <153089970720.143105.7005759760140367907@swboyd.mtv.corp.google.com>
References: <20180628231540.26633-1-joel@jms.id.au> <153089970720.143105.7005759760140367907@swboyd.mtv.corp.google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Jul 2018 15:53:52 +1000
X-Google-Sender-Auth: ZTS0Rh9h3EA52hEKuEP5vKEDX50
Message-ID: <CACPK8XfxKhT_ywpo3vqXSEaSPGdM+uhkgpn1R+EP9Z3spxAzXg@mail.gmail.com>
Subject: Re: [PATCH] clk: aspeed: Support HPLL strapping on ast2400
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 7 July 2018 at 03:55, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Joel Stanley (2018-06-28 16:15:40)
>> The HPLL can be configured through a register (SCU24), however some
>> platforms chose to configure it through the strapping settings and do
>> not use the register. This was not noticed as the logic for bit 18 in
>> SCU24 was confused: set means programmed, but the driver read it as set
>> means strapped.
>>
>> This gives us the correct HPLL value on Palmetto systems, from which
>> most of the peripheral clocks are generated.
>>
>> Fixes: 5eda5d79e4be ("clk: Add clock driver for ASPEED BMC SoCs")
>> Cc: stable@vger.kernel.org # v4.15
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>
> Do you want this merged for -rc5? It sounds like on some systems this is
> a problem, but I don't know if these systems are supposed to work yet or
> not, so priority of this fix is not easy for me to understand.
>

Sure, some more background:

We did not notice this until we attempted to use the clock for the mtd
driver. However, this clock is used for the kernel clocksource, so eg.
sleep 1 takes two seconds to complete. This affects all of the systems
I have access to.

I suggest we merge for4.18, and keep the cc: stable so it can be
backported to the stable trees.

Cheers,

Joel

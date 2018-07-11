Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5966C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537B0208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5FFbMd7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dszUf3Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537B0208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeGKEbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 00:31:45 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40367 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeGKEbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 00:31:45 -0400
Received: by mail-qk0-f193.google.com with SMTP id c126-v6so4063291qkd.7;
        Tue, 10 Jul 2018 21:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tU5FGVgVHOsfWqz+QA6/CQq6zpaqrvqeY88rwfI89Sw=;
        b=U5FFbMd7eiUP7SzFoxAdS7D/79z50YEDE2lpLHG3BYHOEJlNKNPRF7mCWHCnNUNt3w
         COEAsTmK5ORArUeerXHFmgQkspr9qdEPPqvJaTfHVcSVYVAk8Tk0Ip8Ne2Zqlbc9yUo8
         OedePoh0vDGR7cP/pfYmQJ7jfn80bjZ15Pg0kkJAzv73QZk7cM4wzJqf2YpETpkcXgfE
         GECjfStVlTYeCSsNeEuqXzpS2utbq62n2vX6iCHDMAnr9MpPGoULnHosR7+TMIab5DQm
         FplV2LTeKp9hllrpHzKXa8Q5C+jNedstuSgeNYON8j9jqkVKhA9pB9qjjHGkZBHNbN4o
         M2XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tU5FGVgVHOsfWqz+QA6/CQq6zpaqrvqeY88rwfI89Sw=;
        b=dszUf3Bs8lie7HyZW0PlA7/7I6W5ZqPCNMzeKDEqtJAcfNARi0xin6R4/fb7q0b/uW
         o+3IQW13sFkguTKsgaXZLacRfTNm8u2aOdg8qybrI4Ywq/dCm8FMa51uGAf2gk68nZ2i
         +JFTrBCumzIdBqWJmerhROSuhmWk6/SwPmQDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tU5FGVgVHOsfWqz+QA6/CQq6zpaqrvqeY88rwfI89Sw=;
        b=aM4SGWJ6NS3QXas6786pV/gM0EUKnWD5fgGN1nT/OjFnIFXp+bMvvqdSK5KrtvX/v4
         mxxbtthKn2fZl3UqYBbKh8QQrJVVEM5rymgwYlPEvAoIfGNJOJjxa1xH1DbdYtLbjP4b
         /gw0VaSZITwTF4WiYvebMrPIhVZFV/wyJ0LCfzA0FdxbrsGOmS5PTBIhmcsIO1edGxGD
         xfwvrZ9NP29Jmd7xjihQiImfVbbB/p9lDNcMrQgTCLlcpSPJRQMl4+4qA3/JAyGZCJB8
         DRWuJmM+PLaDrBLAoPzyDPw6gU+4rEYXDBqIaA3BTeu1jPTPeEe+gU34S8IqsGihxLIn
         NpHw==
X-Gm-Message-State: AOUpUlELGQQgWItV888zx8NMHr6q1qGciGawFD5Qxyqlt7nnGETvKQIi
        umkknZ/lgdkLSQ/qNKq0Q39msrk8amydp23FwjY=
X-Google-Smtp-Source: AAOMgpc5uZGxHg1ftzQfikt5Ksusk0pT/FT7HcM6qIByUdtKUcG7zoEmh0FE8a0+DaH3V7k6ZKJq/x8uCoLHMdaQdLo=
X-Received: by 2002:a37:3a8a:: with SMTP id h132-v6mr9893420qka.352.1531283363743;
 Tue, 10 Jul 2018 21:29:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 21:29:03
 -0700 (PDT)
In-Reply-To: <479b3c82-ffe7-9e6a-569c-64fcb1b43d32@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato> <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato> <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
 <20180710193944.34phe4zafzvwjm5v@ninjato> <479b3c82-ffe7-9e6a-569c-64fcb1b43d32@linux.vnet.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Jul 2018 14:29:03 +1000
X-Google-Sender-Auth: lD4BodnTOKr35wsBDlI0ll4CipM
Message-ID: <CACPK8Xf7mCuksfgH4jfxcgbT2h0-WH236=pWchzbucrrVsLF3A@mail.gmail.com>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 July 2018 at 06:59, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>
>
> On 07/10/2018 02:39 PM, Wolfram Sang wrote:
>>>
>>> Sorry, what do you mean "show up as"? Yes, we could first shift all our
>>> addresses in user-space before passing them to the driver, so that the
>>> msg->addr field is exactly what the hardware expects already... This
>>> would
>>> be non-trivial for our users considering all our documentation represents
>>> the addresses as the top 7 bits of a byte :(
>>
>> Ah, now I understand the whole situation! Good that I asked. But I have
>> bad news for you:
>>
>> msg->addr is 7 bit and LSB aligned. No way around that. This is how
>> Linux I2C worked since the beginning. You have to adapt to it.
>>
>> I know what you mean. Most doumentation I get has the addresses in 8
>> bit, i.e. 7 bit address shifted + RW bit. But sorry again, the Linux
>> representation is different and all drivers have to adhere to that.
>>
>> An EEPROM ist at 0x50 in Linux. There is no write addr 0xa0 and read
>> addr 0xa1.
>
>
> OK, I understand! Will test and resend with conforming addressing. Thanks
> for all the feedback!

Nice one Wolfram. I wondered why the standard tools didn't work, but
hadn't gotten around to working out what was going on.

Thanks for taking a close look.

Cheers,

Joel

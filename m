Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6947BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8442082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFmClu70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8442082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJCVBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:01:38 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54321 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeJCVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:01:38 -0400
Received: by mail-it1-f196.google.com with SMTP id l191-v6so8476837ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gUt+V0Mrgz8s1Bj4B17hOns+qiTyqu9O9PSCicQOjns=;
        b=MFmClu70iy+UlSkuRHbUk6fUusU13KPcpBd033IeojW0jCUdenyMejWluqYx2/92fM
         oTAIOGGOsxPwtgOAwKyVy+rM5WOBvtCkLYtoGg7PVHnAXZp9ItxmyQj9dC9IiGVKfIgx
         DcHAdQsbLx+Bp3YZHKt7r+z8UoV7CQurErXjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gUt+V0Mrgz8s1Bj4B17hOns+qiTyqu9O9PSCicQOjns=;
        b=NQJX5xODct36zEf6O2ApNAQwU9O9IzYnPyzm/O+7JWqx2XAbvx+AfjH2Wka/rkjlxS
         W/QIDUXOIf/CYe92IpJxxgZaKovCPJKCoonG7edCrswgXJv8i5467g9VzetrNPQgDZL6
         x1ceE4PcofwbUpVHCXUj91Xx6LtjNr78TcPa79o5xPNqjfQ6PNZbe/ra/XITfRfODqoR
         Ih5N2TZzgEtnJ74Y3ZXApquLdKtUlM4/XxnwEhDo3EY65A3duQpwdahienNCzAAnl3Ai
         Dj0ZOS/o7oKdzq+uCnMExmnC7Bu+Q+igUiS9CSv+J1qGB0TB5UL5IPb8SHu4gKWTs02l
         ShDQ==
X-Gm-Message-State: ABuFfogJLkxDZ2YewmJ/aEIEmJgJ5KQm44iYkHSQZ1kQ1/qzbpQI72CN
        sMbozrp27801xosEBCuKmODcIndtXkwuYI1cpYNg2g==
X-Google-Smtp-Source: ACcGV61rIeEoWw68Gor1RK2rrEPEtJU5QyCSdkt+ncwgvPQdd5N0etUUnhoJvpzIXQvRodCYbGIrgt5XOg8r9XMJ3vk=
X-Received: by 2002:a24:e48e:: with SMTP id o136-v6mr1378663ith.58.1538575983159;
 Wed, 03 Oct 2018 07:13:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Wed, 3 Oct 2018 07:13:02 -0700 (PDT)
In-Reply-To: <CAHmME9rWkLT=92QVhbYZd1oee5wYtVRnYu0BGHkGn3bXjN-OxQ@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <CAKv+Gu-oCH4D_otvMk+R_6z_p73Le90PkdQUUPnT6q0kWVL4Jw@mail.gmail.com> <CAHmME9rWkLT=92QVhbYZd1oee5wYtVRnYu0BGHkGn3bXjN-OxQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 3 Oct 2018 16:13:02 +0200
Message-ID: <CAKv+Gu9dOLbiBYKp9HG+GSPML0OJ-UuXnGsJO_re2S75ZF_qNA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 October 2018 at 16:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Ard,
>
> On Wed, Oct 3, 2018 at 1:15 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > +config WIREGUARD
>> > +       tristate "WireGuard secure network tunnel"
>> > +       depends on NET && INET
>>
>> I think you need to add IPV6 here
>
> Nope. Like much of the net tree, WireGuard can function on ipv6-less
> kernels. If you do find something in WireGuard isn't working in a
> v6-less configuration, I consider that to be a bug that needs fixing.
>

OK. I hit a build error yesterday, and setting CONFIG_IPV6 fixed it.
Let me see if I can reproduce.

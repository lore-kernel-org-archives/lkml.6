Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92253C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4309020652
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LF+uVkkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4309020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeI2O17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:27:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44725 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeI2O17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:27:59 -0400
Received: by mail-io1-f67.google.com with SMTP id x26-v6so215154iog.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DRaZS4eF6RSaprt+zJohSn8BqjVokhOefaKC+9qMPe4=;
        b=LF+uVkkAePhoLuSpCDpeCTE9sXmzi+TSgulyRGAaSIt+drb/rF+oJaZU95d5t+ztdt
         BfA3LeXFecso2RhkIC2tBqJYc9X97rQr+zIEVw/pJCneX8C6X15C+gWDgA5bHgqRhj3o
         Y0k8vFv43/wTvJQ34/zhjgPg1TDgO1gNkx0dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DRaZS4eF6RSaprt+zJohSn8BqjVokhOefaKC+9qMPe4=;
        b=HlM4Uw5FBwW26JZXl7MkSa9Q4KIt2Jg+lPGQPQYM3Ft+6WMn74hLLDzrFuF/SnmSCa
         5uIrxNQ/aGO4CqntEwwpmbv6dHpeO5rgiItPygLF6t6kOw6TYaUS5MoSVVfJ0J3hK4dO
         BF2gU957ahgwDBGgyTUR2FmEI+M/CY2hqxdVbyaaJ7UdXHdTb8Um+umKUSer1fWnHwqg
         8vl8p6JfJOlwuLIZkto1b2yGH9exMugxRuVb0mGzmtwTiTimEPIwKTZ1nGXBLczmg7Vi
         7+OL/Ul9ZHSIyw840BD+fcK4ZPgkh4zkGhCJNNg2lwDDsvkbaA28WMZoaGtwYH5wwPGV
         P8QQ==
X-Gm-Message-State: ABuFfohOQ0JcpBbB9v3D9bOyeiDZTHJDaFlfSXeGi8aZCux0ID35zkE0
        QUHtdo2KUp3kSt7jVWakm1dJGIL3bFCIyboR8xG+XA==
X-Google-Smtp-Source: ACcGV631nbPshzyFrZHLacKeRLZe08JlXuYFM594nMboRhN3AeiIMHPZR9avgjgElbhzshdeIfRK/36HfulM4W8TONA=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr1312349iof.173.1538208030401;
 Sat, 29 Sep 2018 01:00:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Sat, 29 Sep 2018 01:00:29
 -0700 (PDT)
In-Reply-To: <20180929075601.GA11115@zn.tnic>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-5-Jason@zx2c4.com>
 <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
 <CAHmME9rc5zgN4HhBy0_oq+EbEXdS8nePzA7qW39nocx_y4ay1Q@mail.gmail.com> <20180929075601.GA11115@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 29 Sep 2018 10:00:29 +0200
Message-ID: <CAKv+Gu_jawg7R1n0qz75=H16J+WNx4aRhEsAt2WMNUkPAhD2og@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 September 2018 at 09:56, Borislav Petkov <bp@alien8.de> wrote:
> On Sat, Sep 29, 2018 at 04:01:53AM +0200, Jason A. Donenfeld wrote:
>> I was wondering about the ordering of these, actually. I've seen s-o-b
>> on top and s-o-b on bottom of the cc list in lots of commits and
>> haven't yet divined the One True Position.
>
> Documentation/process/submitting-patches.rst
>
> section 12, first sentence.
>
> The SOB chain needs to clearly express the path of the patch from
> author(s) to the upstream kernel.
>

Note that this is the author of the *patch* not necessarily the author
of the code.

Anyone is free to submit patches adding code authored by others as
long as the author has made it available under a suitable license, and
this is actually the whole point of the S-o-B: you are stating to the
next guy that the code included in your patch was made available to
you under a compatible license.

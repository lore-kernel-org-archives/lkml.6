Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556CB216FE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="yS25NlU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556CB216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHEJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:09:07 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58105 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbeHHEJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:09:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0fc011b3;
        Wed, 8 Aug 2018 01:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=2cJ40CHJ6Gve
        Xzdt2xoz0HuCdtI=; b=yS25NlU60x9/o4xbPCLVaNkv/3kClomsJE2o24MTOrNh
        ghMadQPvO2SVK6mSQGctWgcsB1bd/3D1pWH4MLNY1Y3Mru98OztK1NGxhaShRG8J
        M21DWgOpzZqZq27CZ+xtV0oQaYYenJvN1BItcB7+P9quep1vjEtdr6uHqpxSFyda
        ubFXKWTfRpJVlzxpXR55KCRm5ra2Q0k/iSADgXUyYKhMAJqev8FMezfETURwd25k
        +PYpPDNYaeLtSalcaYbSf5R90yG6daPwqkvW8wq8FQpjlovMktamUH3e3AKW+52m
        xNyyBRsy/S/BDMTXQenzEXEe0XvFKr+xCsuiktPTLQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c976745b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 8 Aug 2018 01:39:35 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id s198-v6so1025301oih.11;
        Tue, 07 Aug 2018 18:51:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlHurYDayuTyELjtmoezKWZy9jOAJ3SBCDDqa8KpC42yxi05z12b
        YKM8BKw3+hjXfPmcYLmJKa7Fm3N815MGvjFQ92s=
X-Google-Smtp-Source: AA+uWPwJvl4pfbiR8GKZJZHEodXfgqaSi0+CSIaA6cCm1Sv5rYg5cRE06NNme2rJd+uHnW1yUuTc0bO62fx2fL/ynM0=
X-Received: by 2002:aca:ceca:: with SMTP id e193-v6mr845795oig.37.1533693110940;
 Tue, 07 Aug 2018 18:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
 <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
 <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
 <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
 <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com> <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net>
In-Reply-To: <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Aug 2018 18:51:39 -0700
X-Gmail-Original-Message-ID: <CAHmME9rG8VFfuuCy=rCVmxb1CdneYGv1d4xmsyqSPooBozoOJw@mail.gmail.com>
Message-ID: <CAHmME9rG8VFfuuCy=rCVmxb1CdneYGv1d4xmsyqSPooBozoOJw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "Daniel J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 6:49 PM Andy Lutomirski <luto@amacapital.net> wrote:
> I really wish we had a way to see that we use asm-generic=E2=80=99s copy =
of a header in all cases except where an arch opts out.

It's really not that hard to do -- symlink asm-generic to a target
called "asm" inside an otherwise empty directory, and add that
otherwise empty directory to the -I paths just after arch/include.
Since it's searched second, it's only used if the first fails. Maybe
I'm missing something though, as this seems a bit too obvious. Perhaps
a project for another day.

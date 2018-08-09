Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5651BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003F92238C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9cIvveq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003F92238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeHIUes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbeHIUes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:34:48 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416B622392
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 18:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533838128;
        bh=RY8h3SEJtJ5V5EmZT2evf9V1gaQuoSgH9/wCmrsVti8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=L9cIvveqq5o+JLLInNmKPv15p1XnSpG7KfDzzHPjej8swBjceHCgAxABkmUk/AwYk
         HAyFyPSMls2xPdU2JOylQ+qS5ipUir21PjEBBepLlxMX3pHboBert2XUZAF76EyrYx
         ZAKmUS8pgxOLBKVpW+UzzVDK28xaU7r4jgfz97d0=
Received: by mail-wr1-f42.google.com with SMTP id v14-v6so5923023wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:08:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlEeJk865DpjLmEPaaVDjPNo5ybRjuHj2I3Ec1YPFa3FxijFevJp
        HBpbxkLK8iyuwbkL6EeeO7RmaTkNT55zqFZsT3YVvw==
X-Google-Smtp-Source: AA+uWPxgS7JedxMMLwOBmv47Xx+u+rTu39f5nMfARfc/ZKByGeWdJkgKzeiHDFJwpGa39kP7GMtIHTtsf1JbmZx+zNA=
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr2091676wrd.67.1533838126721;
 Thu, 09 Aug 2018 11:08:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 11:08:25 -0700 (PDT)
In-Reply-To: <CAHmME9rG8VFfuuCy=rCVmxb1CdneYGv1d4xmsyqSPooBozoOJw@mail.gmail.com>
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
 <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
 <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com>
 <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
 <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
 <A44CAA94-415C-476C-9523-2D19F28EDC6D@amacapital.net> <CAHmME9rG8VFfuuCy=rCVmxb1CdneYGv1d4xmsyqSPooBozoOJw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 9 Aug 2018 11:08:25 -0700
X-Gmail-Original-Message-ID: <CALCETrUgOk7veQavAWayY7vQUY0fJkwGsYxNhLxK-v3F-BEmsg@mail.gmail.com>
Message-ID: <CALCETrUgOk7veQavAWayY7vQUY0fJkwGsYxNhLxK-v3F-BEmsg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Eric Biggers <ebiggers3@gmail.com>,
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

On Tue, Aug 7, 2018 at 6:51 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, Aug 7, 2018 at 6:49 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>> I really wish we had a way to see that we use asm-generic=E2=80=99s copy=
 of a header in all cases except where an arch opts out.
>
> It's really not that hard to do -- symlink asm-generic to a target
> called "asm" inside an otherwise empty directory, and add that
> otherwise empty directory to the -I paths just after arch/include.
> Since it's searched second, it's only used if the first fails. Maybe
> I'm missing something though, as this seems a bit too obvious. Perhaps
> a project for another day.

The problem here (I think) is that it's preferable for stray files in
the kernel tree to have no effect and, with this scheme, stray files
in arch/*/include/asm could affect the build.  So something explicit
has an advantage.  I just think there should be way to say "this
asm-generic file should affect all arches unless they generic-n or
override-generic-y it or whatever".

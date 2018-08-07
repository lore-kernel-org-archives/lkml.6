Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D449C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060BF215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GcnPT18S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060BF215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeHHCFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:05:21 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45823 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeHHCFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:05:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ee5aae85;
        Tue, 7 Aug 2018 23:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=aezAgJsqthuIhL+8RCoJYQhHICo=; b=GcnPT1
        8SWRda172bkfVU+cwsRpIYm1QGTF6Zbwj/6HyzdaEyGAppSy1YCEuFCGmPgvaULF
        qqT1+Xxfc8sPjiCAY/mtPb3qyQaevEGaevGHqIJ2IjT92Yf8EI+m5UPWg+Qd7bKC
        61BZWmRPrYyZAweyzOaE76ae5Sm/J1F+OC8SWtSr3MP0+hv1xEiv7GKR/NO5b+Uk
        XAwvnSHtjSY+nBA4heCMjKIdPMreztderWsnB2wstw0GBZ/5Oaty0mJJuYb9ZRLi
        d9uRZ2qx0zEyXl3sc6tbQ613FpWXPRLLWTN5AOJEldFihuMPLZPljxUHCINbJy/X
        IK2mmyPeG+YVqzOw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e2d0feca (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 7 Aug 2018 23:36:13 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id 13-v6so755782ois.1;
        Tue, 07 Aug 2018 16:48:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlHLeOwLcrcc7yQtmTCvXPjDUMITn1HCR6CwlK3zrcDS6M/Ghjlg
        nzJPhig4EBdwY6KAmOENKWDe7q8bhmTeq14mv+k=
X-Google-Smtp-Source: AA+uWPwNN1ZI1G3uetybf9b38kiVGuQhYJ1vIlxRYAOdUgtPCHDtN024WaH+KIgcHW5dzx/ZnRhMzxoskQSTC6isdBw=
X-Received: by 2002:aca:fc94:: with SMTP id a142-v6mr516795oii.29.1533685708643;
 Tue, 07 Aug 2018 16:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180801072246.GA15677@sol.localdomain> <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
 <CAHmME9oThR-dE3gTW0UyqAGZO80qu19ktG4YTb4iL6CNpzNNaw@mail.gmail.com>
 <CALCETrVziUpAU4nTaZ=t5ct=1jsWswWOy7KDNxXGPD1L=tMTGQ@mail.gmail.com>
 <CAHmME9pt3PxKQmc8E-arA-W0p2tp9z_oJ-uXQwis3qD=Zvpnsg@mail.gmail.com>
 <CAHmME9rA_nb9Le4VQhtcqCfNSuHpFjZVOV6=vE12FydJD9CmAQ@mail.gmail.com> <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
In-Reply-To: <CALCETrWo-vCt_bHMBPAEHEr3P4=AJq-95Bf=00aAEAcE839wLw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Aug 2018 16:48:17 -0700
X-Gmail-Original-Message-ID: <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
Message-ID: <CAHmME9qPay3O7Yh-R66EDhon4dJz1cuy69dWUxf3Xkt8seqLZA@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

On Tue, Aug 7, 2018 at 12:43 PM Andy Lutomirski <luto@amacapital.net> wrote:
> For "zinc: add simd helper", I think it should be in include/linux,
> and include/linux/simd.h should (immediately or maybe in the future)
> include <asm/simd.h> to pick up arch-specific stuff.  And the patch
> should get sent to linux-arch@vger.kernel.org.

I guess you saw my prompt about that in the previous commit message?
Based on your encouragement, I implemented it:
https://git.zx2c4.com/linux-dev/commit/?h=simd This is _far_ more
invasive than I wanted to be, as I don't want this patch submission to
grow unwieldy and never be merged, but I guess we can roll with this
for now...

> In your blake2s_arch() implementation, you're not passing in a
> simd_context_t.  Is that still a work in progress?  I thought the plan
> was to pass it in rather than doing the check in the _arch()
> functions.

I'm inclined to do the explicit context passing only when a function
is likely to be used in that kind of environment, and adjust as
needed. Long term, anyway, that API will be removed once the x86 guys
figure out lazy FPU restoration and the amortization doesn't add
anything.

Jason

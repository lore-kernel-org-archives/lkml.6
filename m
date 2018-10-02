Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9158C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA22064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HtKBmVTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACA22064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJBTGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:06:06 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52861 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJBTGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:06:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e2594ee1;
        Tue, 2 Oct 2018 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Bh4YY1mg4ng0HTuhCbrID9uFjwg=; b=HtKBmV
        TWNVwCHZW37h7ih/c6LItH93yu9nwqDqOmkeATOaLgzfpSYJjKbp1qzFrs1UV9c4
        zflHo8jI5/PiB3NbZ8S8JI2EyIgYvEfaREP/bw95EOGeWG6E38v/yIxwiGww3Jnn
        cyfKSbx1uIIzOnwTTQTyjIFPNPKUDIvIm4lvTf252jD3Zp50dpQv65hHum9RdKPR
        9whw71HGvSK++e7tfT4C7rz/9Q3KB0z9c2WyFJp/JeqMwg0KMI3/YmpfM8pnFHW5
        rarl2Nkkbze+j2dyG2AgCRrK/f/y4/n21Uzxv5f8lLTPNzjTUXQyJJULLn7+XiNh
        +HHjWe/XZhT4Yurw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 540a9f7c (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 12:22:57 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 36-v6so1618943oth.11;
        Tue, 02 Oct 2018 05:22:59 -0700 (PDT)
X-Gm-Message-State: ABuFfog8Q1gTQFyLH7lGyiuGpF5L4fwOOPJyF+hJ+/caTVYeEDeK+as2
        zBUDF7mKtAauvK8xy+1P/vvN7qYIL3UF9MVwakU=
X-Google-Smtp-Source: ACcGV62LID//N72R+PNPL0nuot7fCF516ANJX8Qe3XmyaXYaDpzGGMNVNk0PS6OCI5pS0sF7i4hgRKTurwzj/LSMKHI=
X-Received: by 2002:a9d:1d47:: with SMTP id m65mr4470983otm.199.1538482979006;
 Tue, 02 Oct 2018 05:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au> <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
 <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 14:22:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9r6-DHLwePQGBGcnPUZuZgZ2GtSUX9arsWzLqhKxd=uDA@mail.gmail.com>
Message-ID: <CAHmME9r6-DHLwePQGBGcnPUZuZgZ2GtSUX9arsWzLqhKxd=uDA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 8:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Also, I still think the name Zinc (zinc is not crypto/) is needlessly
> divisive and condescending, and unsaying it (in v2 and up) doesn't
> really work on the Internet (especially since you are still repeating
> it in your conference talk.)
> Jason, you seem to hate the existing crypto framework with passion,
> and the name reflects that.

It's not divisive or condescending. I don't hate the existing
framework with a passion -- this is patently false. The name even with
its original acronym doesn't imply anything essentially negative. I
see that you've repeatedly misinterpreted it this way -- which is why
I removed that from v2 for the avoidance of doubt --  but that doesn't
change the fact that its proper interpretation is not a condescending
or divisive one.

Look, people love to bikeshed about names. I'm sure you'll be able to
CC-in a large crew of people who have opinions in one way or another,
and this thread could begin to have many voices on that front or on
multiple fronts. There are real benefits of sticking with the name
I've given to the library I've spent enormous amounts of time writing.
And so I'm going to stick with Zinc, since that's why our library is
called. Sorry. We can talk about this at Plumbers in Vancouver if you
want, but I think you're not going to get very far with a mailing list
naming bikeshed.

Meanwhile, I'm working around the clock to integrate your very useful
technical suggestions, so please keep them coming if you still have
technical nits you'd like to be in v7 of this patchset.

Jason

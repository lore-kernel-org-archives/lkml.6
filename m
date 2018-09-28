Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32361C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF74206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xgavg60F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF74206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeI1WWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:22:00 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57323 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1WV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:21:56 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id bf490735;
        Fri, 28 Sep 2018 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=1DitDICRPEmh7Ip8skDQYNhi95Y=; b=Xgavg6
        0FVSg+Mpt01gPViaIf/QmfTZcX/NczQDfAuAqJ7r+0rvMmB++vwgIgcmp6ZYM0nE
        votGeUgKTUGDUgRV4MLQMcfTNmkDwNlH+kFy5L6jSHZFzP8x1VLkwo1TMCRsTYPt
        dEZQqwAWMv3m4AyaG9u6fxEFeSv/Tf5GsRkJgUobFs/YyNMJQ6hAAe7+b3tKJdVK
        9S7n8bEBag115WPVJfINtjaSApd29sdUx7WImKB4aODrhj9IFKFHalyqu7Z2pV0v
        EfY2qcv2iIzYSpwplg5ZztLpSiQcvrD4oecLG7LwvEfLgdP+SFnGVZ6hnyOHTX8w
        RAyqrtGwwkTCHYVg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c3239139 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 28 Sep 2018 15:38:42 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id k64-v6so5799400oia.13;
        Fri, 28 Sep 2018 08:57:30 -0700 (PDT)
X-Gm-Message-State: ABuFfog4mW7cSFDfghEjmpWwUpXKoRcQKkR+I/YI9ZYcwlS+FH37qW9D
        GAebYo3xjDBVQxr1awVhr2/zkq2wHP/MMVspf48=
X-Google-Smtp-Source: ACcGV63VftJilTMuoTaXYQvSFGDgrXNhmvNs8SAGEUn746N5ArI8uAwWWZpXJuWBLMyUYrdiZMsShRdoApbCDsthS0U=
X-Received: by 2002:aca:ac4:: with SMTP id k65-v6mr6244287oiy.265.1538150250034;
 Fri, 28 Sep 2018 08:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-6-Jason@zx2c4.com>
 <CAKv+Gu8-EwxFhQSUPxjEvTA5ZPz34RieMokM6CUqwURDr74jtg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8-EwxFhQSUPxjEvTA5ZPz34RieMokM6CUqwURDr74jtg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 17:57:18 +0200
X-Gmail-Original-Message-ID: <CAHmME9r3CuEkkxTEp0mDpPoYUR_CVqa8TVMB8ZTwBxLh9fQSTQ@mail.gmail.com>
Message-ID: <CAHmME9r3CuEkkxTEp0mDpPoYUR_CVqa8TVMB8ZTwBxLh9fQSTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/23] zinc: import Andy Polyakov's ChaCha20
 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Sep 28, 2018 at 5:49 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> As I mentioned before, I'd prefer this to be based on the original .pl
> but if I am the only one objecting to this, I guess I can live with
> it.

We're working on that, actually. It's not obvious when it'll be ready
to ship -- perhaps after the initial merge, but perhaps way sooner --
but that is something we're trying to do for arm/arm64/mips64.

Jason

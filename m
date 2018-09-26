Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E30C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D635B20676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HZ12qrRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D635B20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeIZVy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:54:58 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34397 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeIZVy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:54:58 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fdb5d68e;
        Wed, 26 Sep 2018 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=8ku/SQCo7hUyowLSvnmZzRmoXZM=; b=HZ12qr
        RheZH+l5emiWjtdLK7hsd9vDhYDI7WdRl+0G9+A44TX/lfJM1jtwRHrUKE6InJJz
        5QTH2tZma2D9D35dGv/1mjtND39eHOTV8DayxxctOSDcQBOgcDL+JhcSmMiYhhfl
        thhJ9To18dHFHxI56UZY8rUokYzEr3TRyqjBXwZ4Wb5wMwLB0PhA2bpss5IiYliJ
        l8mkfDX3G8WykCGn+TXVmzrCg99J+ZohqKyrwWvKg2TPlKRxVj/9pE3VXL+JUyuw
        a+xRqlI8BKn0j1xfYDmBWRa4L7knAAz2GbSwFxNR9tCNuVIKpRPXku0zRbp+2Ob1
        vDG/7i8aB6sgE2vw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 40a1378a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 15:22:51 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id c18-v6so11295232otm.3;
        Wed, 26 Sep 2018 08:41:25 -0700 (PDT)
X-Gm-Message-State: ABuFfoha2eHJeLfHR5ZYKxIQoi/QEFMOUxSt8KS9Ll7OIyMgJEoFRq/o
        6oBUQCI1Yl/sJUgPZ2NWW44E8N5G8+cbn9HQIPA=
X-Google-Smtp-Source: ACcGV61iTol3ioYPoEZ7kbnjUe4+KtSiky7cn63lQ7WeoVhZ5kduapgSAvBOQfKqqSowUYR4OOx7/hJcCaxmxgK4oJQ=
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr4744192otl.209.1537976483889;
 Wed, 26 Sep 2018 08:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com> <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 17:41:12 +0200
X-Gmail-Original-Message-ID: <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
Message-ID: <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 4:02 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> I don't think it makes sense to keep
> it simple now and add the complexity later (and the same concern
> applies to async support btw).

Ugh, no. I don't want to add needless complexity, period. Zinc is
synchronous, not asynchronous. It provides software implementations.
That's what it does. While many of your reviews have been useful, many
of your comments indicate some desire to change and mold the purpose
and focus of Zinc away from Zinc's intents. Stop that. It's not going
to become a bloated mess of "things Ard wanted and quipped about on
LKML." Things like these only serve to filibuster the patchset
indefinitely. But maybe that's what you'd like all along? Hard to
tell, honestly. So, no, sorry, Zinc isn't gaining an async interface
right now.

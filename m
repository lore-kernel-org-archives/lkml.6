Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440EAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08032152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="rkAPjUpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08032152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeI0AA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:00:56 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56295 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeI0AA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:00:56 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2554726e;
        Wed, 26 Sep 2018 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=0TihzqTR2QyPxwCOyTfvX2QStDo=; b=rkAPjU
        pkCwQ9eRzwhVSzlkEi2pQbX4MZQs7teePC/pFBb8czk9hzOyLIgwHHsmQhFzULA3
        04OrYc7xjayXcswg9U2HrdLdPV45UZYMnvMmuWcefbgMLBqxXnvFE24ugOYQRVRT
        1UtZ+HhVAQ0qu3rN8Rp5EJs9ZXSzRaA15IXEZUXZYpUHMmfXxp6Tpi/Id1tXqT/L
        I7L1NDXI29iO2ruw4AJUp8SGRcarm5wdisRRaDFgy6X7RM9iuujvglfb/eGJBOeq
        lVIViJL57mdp7iqxdlncuz5vU0QAOf/2e6W3mJaYJlW6lcCA9408XUdqpdqVVuPz
        1QfSOHopfVTppUWA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a7405f44 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 17:28:15 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id e18-v6so29039407oti.8;
        Wed, 26 Sep 2018 10:46:49 -0700 (PDT)
X-Gm-Message-State: ABuFfogR81vYZRWphaBQYd61SgXdhX5gl+VVYUZZx3VQIwgRKlNpEChY
        d44i5HShdfZMmP5h14NfQyUlah97OPNjeiTNYyg=
X-Google-Smtp-Source: ACcGV63dRQ1AnG/VjZb5DVwcZ1Swny5y2kKwmFAIoy1TYIQDOMZT/jf8TJ13KwUF75LNXqWEAXUi5+Wzp8RVvJaWL8E=
X-Received: by 2002:a9d:56bb:: with SMTP id o56-v6mr4688597oth.393.1537984008102;
 Wed, 26 Sep 2018 10:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com> <20180926173720.GA248906@gmail.com>
In-Reply-To: <20180926173720.GA248906@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 19:46:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9ou-4JvvuRntwUf-BCQpnsHP4d+T0V8_XPSQ8jQ4G2Rpg@mail.gmail.com>
Message-ID: <CAHmME9ou-4JvvuRntwUf-BCQpnsHP4d+T0V8_XPSQ8jQ4G2Rpg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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

On Wed, Sep 26, 2018 at 7:37 PM Eric Biggers <ebiggers@kernel.org> wrote:
> Can you please stop accusing Ard of "filibustering" your patchset?  Spending too
> long in non-preemptible code is a real problem even on non-RT systems.
> syzkaller has been reporting bugs where the kernel spins too long without any
> preemption points, both in crypto-related code and elsewhere in the kernel.  So
> we've had to add explicit preemption points to address those, as otherwise users
> can lock up all CPUs for tens of seconds.  The issue being discussed here is
> basically the same except here preemption is being explicitly disabled via
> kernel_neon_begin(), so it becomes a problem even on non-CONFIG_PREEMPT kernels.

The async distraction (re:filibustering) and the preempt concern are
two totally different things. I've already posted some code elsewhere
in this thread that addresses the preempt issue that looked good to
Ard. This will be part of v7.

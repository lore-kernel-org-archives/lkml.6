Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D48C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A1E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A1E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeILC24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:28:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42468 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILC24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:28:56 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzqBz-0006H6-Dm; Tue, 11 Sep 2018 23:27:27 +0200
Date:   Tue, 11 Sep 2018 23:27:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Samuel Neves <sneves@dei.uc.pt>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>, mingo@redhat.com,
        X86 ML <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 05/17] zinc: ChaCha20 x86_64 implementation
In-Reply-To: <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809112322060.1427@nanos.tec.linutronix.de>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-6-Jason@zx2c4.com> <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de> <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com> <alpine.DEB.2.21.1809111106420.5110@nanos.tec.linutronix.de>
 <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Jason A. Donenfeld wrote:

> Hey Thomas,
> 
> On Tue, Sep 11, 2018 at 3:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > This is covered on the 02/17 commit message, whose relevant paragraph follows:
> > Well, being only cc'ed on only half of the patches does not really help.
> 
> Sorry about that. I'm happy to Cc you on the whole series for next
> round if you want. Just let me know. In the meantime:

Na, all good. I'm fine with the answer and reviewing that ASM maze is way
over my limited crypto knowledge anyway. I definitely would enjoy
refreshing the math behind it, but that surely would be way outside of your
envisioned time frame for getting this merged :)

Thanks,

	tglx

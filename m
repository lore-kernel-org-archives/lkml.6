Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B81C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EAF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EAF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeISLuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:50:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59636 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbeISLuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:50:10 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2Vk5-0002vu-7G; Wed, 19 Sep 2018 08:13:41 +0200
Date:   Wed, 19 Sep 2018 08:13:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>, mingo@redhat.com,
        X86 ML <x86@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 04/20] zinc: ChaCha20 x86_64 implementation
In-Reply-To: <CAHmME9oARODJsrDbcNK7A22KrTRJP945hj9+oCJtQM6OjGF4Ag@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809190802160.1468@nanos.tec.linutronix.de>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-5-Jason@zx2c4.com> <alpine.DEB.2.21.1809190017050.1468@nanos.tec.linutronix.de> <CAHmME9oARODJsrDbcNK7A22KrTRJP945hj9+oCJtQM6OjGF4Ag@mail.gmail.com>
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

Jason,

On Wed, 19 Sep 2018, Jason A. Donenfeld wrote:
> On Wed, Sep 19, 2018 at 12:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > > +++ b/lib/zinc/chacha20/chacha20-x86_64-glue.h
> > > @@ -0,0 +1,100 @@
> > > +/* SPDX-License-Identifier: MIT
> >
> > Please put that into a separate one liner comment. Also this should be
> > 'GPL-2.0[+] or MIT' I think.
> 
> I had that originally, but changed it to just MIT, since MIT is a
> subset of GPL-2.0. And looking at tree repo, it appears this is what
> others do too.

Subset? Not really. Both MIT and BSD3-Clause are GPL2.0 compatible
licenses. And if your intention is to have those files MIT/BSD only, yes
then the single license identifier is the right thing. If you want it dual
licensed then it should be expressed there clearly.

Thanks,

	tglx



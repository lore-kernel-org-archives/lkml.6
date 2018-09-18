Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4310CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A0220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A0220C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeISEEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:04:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59040 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISEEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:04:40 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2OVD-0005Lz-AN; Wed, 19 Sep 2018 00:29:51 +0200
Date:   Wed, 19 Sep 2018 00:29:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [PATCH net-next v5 04/20] zinc: ChaCha20 x86_64 implementation
In-Reply-To: <20180918161646.19105-5-Jason@zx2c4.com>
Message-ID: <alpine.DEB.2.21.1809190017050.1468@nanos.tec.linutronix.de>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-5-Jason@zx2c4.com>
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

On Tue, 18 Sep 2018, Jason A. Donenfeld wrote:

> This provides SSSE3, AVX-2, AVX-512F, and AVX-512VL implementations for
> ChaCha20. The AVX-512F implementation is disabled on Skylake, due to
> throttling, and the VL ymm implementation is used instead. These come
> from Andy Polyakov's implementation, with the following modifications
> from Samuel Neves:
...
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Samuel Neves <sneves@dei.uc.pt>

I'm a bit confused by this SOB chain. So above you write that it's from
Andy Polakovs implementation and Samuel did the changes. But here it seems
you are the main author. If Samuel just did some modifications then you
want to use the Co-developed-by tag along with his SOB.

Also I'd recommend to add a Originally-by or Based-on-code-from: Andy
Polyakov tag. Both are not formal tags but widely in use for attributions.

> +++ b/lib/zinc/chacha20/chacha20-x86_64-glue.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: MIT

Please put that into a separate one liner comment. Also this should be
'GPL-2.0[+] or MIT' I think.

> +++ b/lib/zinc/chacha20/chacha20-x86_64.S
> @@ -0,0 +1,2632 @@
> +/* SPDX-License-Identifier: BSD-3-Clause

See above. That applies to all the others as well.

Thanks,

	tglx

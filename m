Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B5420865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B5420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeIKNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:21:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeIKNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:21:19 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzdwh-00012x-5N; Tue, 11 Sep 2018 10:22:51 +0200
Date:   Tue, 11 Sep 2018 10:22:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Andy Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/17] zinc: ChaCha20 x86_64 implementation
In-Reply-To: <20180911010838.8818-6-Jason@zx2c4.com>
Message-ID: <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-6-Jason@zx2c4.com>
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

On Mon, 10 Sep 2018, Jason A. Donenfeld wrote:
>  lib/zinc/Makefile                        |    4 +
>  lib/zinc/chacha20/chacha20-x86_64-glue.h |  102 +
>  lib/zinc/chacha20/chacha20-x86_64.S      | 2632 ++++++++++++++++++++++

Just a stupid question. What's the rationale of putting that into lib/zinc
instead of having it in arch/x86/crypto?

Thanks,

	tglx

Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6BDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6797B269D9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="C5hYovHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6797B269D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934776AbeFZLdR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:33:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:18252 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933780AbeFZLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530012794;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=CmIPr7WXozYFTcxtERJdZPZ1TWtF8DBHqScYjQutFA0=;
        b=C5hYovHFmiEOeJaY7cfbwNwrLLAl5ZqldzmuyKDURPpJQU3OkrQ59Xc3Ep6cOBYCpK
        Afe7JhdCTmuZo8VDRtkmqnVrgvTcCEr+cApq5MrUWdJUuVxzFrjSV6TXk8h20GxWlSbw
        hmfHVx52GClR9p6Ilc4XlM5tjOd56JEe/RayKJQbahenz1c4MmOmHmIStmBrIKfIuHK3
        XgPQhmW0ZXl52SEfZ8EswWgk8pCVImHydbSxrX130RYgLpFkjJcs0N1AA2qLjfzKhK8T
        exYJvTrli90Yd071c5tzTPi3V+fKN46r0pyGHBjGiz1rLvlw7RWFdMyH9+XE/2ac50yU
        /WLQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW4DNhHoQE+naq/TxnB4G17At7qqy34JoXPVwp4IB4BhOW7BTvQpCg=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.10 AUTH)
        with ESMTPSA id j06b90u5QBXCnrh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 26 Jun 2018 13:33:12 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cryptomgr_test / drbg_ctr: BUG: sleeping function called from invalid context
Date:   Tue, 26 Jun 2018 13:33:12 +0200
Message-ID: <2482919.MrXjzQZjmy@tauon.chronox.de>
In-Reply-To: <CAMuHMdXfn6YuG9imLKd5nEdxhT4gWu-V8bn1LRt+M3bESaUAkA@mail.gmail.com>
References: <CAMuHMdW_4gvQYhCxcXR+sa6dhwAshyJnhXhc36=VC=hWKB-7Jw@mail.gmail.com> <14009987.cibGRJrWdm@positron.chronox.de> <CAMuHMdXfn6YuG9imLKd5nEdxhT4gWu-V8bn1LRt+M3bESaUAkA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 26. Juni 2018, 12:33:48 CEST schrieb Geert Uytterhoeven:

Hi Geert,

> Issue is gone. I assume due to commit 6e88f01206edab0e ("crypto:
> arm64/aes-blk - fix and move skcipher_walk_done out of kernel_neon_begin,
> _end").

Thanks a lot for the hint.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert



Ciao
Stephan



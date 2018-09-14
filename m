Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7182ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612B720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oHse3Byw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612B720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeINPHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:07:10 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:49325 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeINPHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:07:09 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id af004bce;
        Fri, 14 Sep 2018 09:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=hLPb86mdSs2C6nm1+BH4PS8NEwg=; b=oHse3B
        ywWnDW6cILtHtSKHFuD/lq27acPgZwjgWJI6ld/BDMtOecbQg5BXifUp1/MhThgC
        FHav2O3RIhTrR/gNL3SCOBLlUTs8+L410jGKkG2eXirzo+cVO7168QEhak/AMx00
        kIxWOXUHJMlDM11Wa4PbCaW2Xjdk/aa6nlSuhnNGAzxulUYGzOBDBMVDBnoGga+N
        cktx8XUwtgR+Nee+/SkDE6EYmtlOtrpIKzVcM99iovj7L3i8AhmEbEY2M7KD3Ff4
        IwGRIZiFOin+IuC4xdODXJyiYHZV52CJvcK/FytL0eQ/H1hQpcnSg++R0hR7pBZG
        YuwtB34/eNXjBtSg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 96c77ec5 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 14 Sep 2018 09:36:21 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id t68-v6so12230516oie.12;
        Fri, 14 Sep 2018 02:53:22 -0700 (PDT)
X-Gm-Message-State: APzg51AtAERJX7kkQpaRPAbphXSXcv3bWYSVFGGZ4GgfL0TqezzZVSUQ
        0ItK5cWEL1RyX50MSbKfUUBZZu5U8ofyRRkbTtk=
X-Google-Smtp-Source: ANB0VdbnYsaf+dJk+X2VMuE3XszMMhgmr+LZaEQh4pk47PqGTrWrcnmk2XNVrJDM/RsP0Nh4BIKLWpGfIuU2Oc7GZtc=
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr9183899oix.74.1536918802116;
 Fri, 14 Sep 2018 02:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
 <CAKv+Gu8z1r7F_wbR6-e0Vbryqby7djDy2OR6JJURCsTo6ZMa2g@mail.gmail.com>
 <CAHmME9pcODNc2m26DH1cQY6R+grxYW5dvFpNDpz_GiugM3qufw@mail.gmail.com>
 <CAKv+Gu9GVbSETjp01tANMwJgA6O9aexhnH+47836KjZg+71q2A@mail.gmail.com>
 <CAHmME9qjTyYpm_PsQ5_oZSfZBGa29zME1XHVak9F4Ued-qm67g@mail.gmail.com> <CAKv+Gu8zULznCmgz++LNNTwfTifaz5L92h=vvWb4yh5fHh-huQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8zULznCmgz++LNNTwfTifaz5L92h=vvWb4yh5fHh-huQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Sep 2018 11:53:10 +0200
X-Gmail-Original-Message-ID: <CAHmME9qmDEk-aPYH2CA+q0G7rYfUt6W_WijAgusPVYe48OzwdQ@mail.gmail.com>
Message-ID: <CAHmME9qmDEk-aPYH2CA+q0G7rYfUt6W_WijAgusPVYe48OzwdQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 8:15 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> OK, so given random.c's future dependency on Zinc (for ChaCha20), and
> the fact that Zinc is one monolithic piece of code, all versions of
> all algorithms will always be statically linked into the kernel
> proper. I'm not sure that is acceptable.

v4 already addresses that issue, actually. I'll post it shortly.

> BTW you haven't answered my question yet about what happens when the
> WireGuard protocol version changes: will we need a flag day and switch
> all deployments over at the same time?

No, that won't be necessary, necessarily. Peers are individually
versioned and the protocol is fairly flexible in this regard.

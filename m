Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C391C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406C32083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXayxo/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406C32083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeJCEVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:21:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34502 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJCEVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:21:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so6257155wmf.1;
        Tue, 02 Oct 2018 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdy6ejh+GgH3+h9Ihbs4fwCFeP/wwKdr/NLPyZRpSYU=;
        b=cXayxo/Gs5OhoMtmlMvBAkfat9xZCWS5lzVMy3npTtxOx9PJ92SDcfKeJixJBNG0Tw
         qBK49CLPHt5tLL6jxAFbnqFPb9O4wHKPWvi4iDQV/HL+cl48dcAeykLQhlCpoxO85DJ6
         0erloILlVjk42zDL4f+WASoLaOGqNTlH0mBDKYwYOf20C1xdMKDl4yK0LjKFHIM8UeQ5
         yI7KQaovOVgamRNKnLq2Z44NcHDnILnbkRxIsZ0SsQsWEiKgGUZa0d0YBcpMAItdK5W4
         JAoPGWaU0H+XwrP3vSQExBVQCtuEnp9R9x1t+yFAGbRaqw0PXAVLlI/tuR6MijCInNSL
         sN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdy6ejh+GgH3+h9Ihbs4fwCFeP/wwKdr/NLPyZRpSYU=;
        b=IGlrFAuzEg70C1c9wX797WvVvm55gAeNOFa6KDKe8vWkl6cv14ffowZFu13CYU+h4J
         JcMVJDXf5n6bilXmso0/KqNS9fT195DmGrFBj21ulv2D2cxtHWCmwaGJTHAKImwEn1ce
         jKAHHKQL7jNGx47MaTmXd5w2bPkipH//f6+h//dWIpkBH14/qjSMk2LrAAVkEsPV7V3R
         4wigBlS3BUl/X2GblZmPjV7UcEDyUjHdPypHu2Tz4mVr03eqCubBzFQzs3jnPxd3nKQX
         YeMk3QYCXugAvq2dIx5rJsKHANFehkv7Kspy0EWSleCBrAMHGhDRzXDNV6xljEHrsafC
         C3Dg==
X-Gm-Message-State: ABuFfoh2JFxNKZEafkLvOmxxMEvXiWBhz5o8UPVYhXfl/GaryJeoWxq7
        dlwXkt71LSIT2iMC4pHgJ6Zc+4ODEeBL16+x9Ps=
X-Google-Smtp-Source: ACcGV61XFz9nECOoWTSRq+5v5A5fpqhN2gWUgps2zNjjJwq0EnB9rGkh2gdQrPhtQzvdoBL1xvGhaCR9i3mM5ZClWUo=
X-Received: by 2002:a1c:3745:: with SMTP id e66-v6mr2918409wma.142.1538516146911;
 Tue, 02 Oct 2018 14:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 2 Oct 2018 23:35:35 +0200
Message-ID: <CAFLxGvwUP6+tfOr0NrM6vFs6NGepDz+MKPNnQWA+gO2k2mdPqw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>, sneves@dei.uc.pt,
        Andy Lutomirski <luto@kernel.org>,
        jeanphilippe.aumasson@gmail.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard,

On Tue, Oct 2, 2018 at 7:06 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> I guess qhasm means generated code, right?

Yes.
Please see: http://cr.yp.to/qhasm.html

It generates code from a q-file (the "template").
Actually it is a rather powerful tool, but as you noticed, sometimes
the code is not perfect.

-- 
Thanks,
//richard

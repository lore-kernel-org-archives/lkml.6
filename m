Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A30C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2163D214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IOMxCuLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2163D214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeISHRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:17:21 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35637 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISHRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:17:20 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 89f17502;
        Wed, 19 Sep 2018 01:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=roU98NU/fqkKhou3AKEgPNOhq+c=; b=IOMxCu
        Lg7ydYc+7qb+CeBZpqjlw/x81Pqd8sIsbn6401jrKEuFJQo227BVMrLQoLFpw+Dl
        /G4F5fOc05BCufJABiJUvZ5yeQNlahwoOACS4ip6vbgizgZ5BiCK5E+FLTksd5xV
        P08UeGAnWKwHnyO5C8ZBWSqGlXFbt4/NXnG6z/KGLGQe+DD7NBS8fq47XPBN9ERm
        6iI7HC5VLJ7AdjIC/OIVZ+CrCmEhB0kfMmoE/JyZ5iAf/E9VgDCG0aiiWVoECz/g
        Sc/Q4lfMIqTuTJ0AaudrJ9KVYMax7ogfgBMoi2jbWOIBBlIDBaN1xjnMwptdz59A
        7j2oxpkWltZekQGA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1f662f47 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 01:24:19 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id y207-v6so3599669oie.13;
        Tue, 18 Sep 2018 18:41:56 -0700 (PDT)
X-Gm-Message-State: APzg51DPtU/5YeLXDmrSdz6OcRKSO3oBCP810pCOlUAc6mHJVcheO/A/
        abfuMwWQ4tLrOEIw3j/8ui1XTnRi0N4Wq3FAqXQ=
X-Google-Smtp-Source: ANB0VdaHasFLnhPg5Hv4Kr117peMsxnDj9RhZmPc0IY/NIgPVYxYrflbRbzV7RfcA4RtZS0vuPOswGwIJCHhgbEJcy8=
X-Received: by 2002:aca:ce02:: with SMTP id e2-v6mr256860oig.225.1537321315969;
 Tue, 18 Sep 2018 18:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-8-Jason@zx2c4.com>
 <20180919005054.GC74746@gmail.com> <CAHmME9rab92gc68tGX384eGR71q+7JtovpxBLSYrYNHA7L5zFw@mail.gmail.com>
In-Reply-To: <CAHmME9rab92gc68tGX384eGR71q+7JtovpxBLSYrYNHA7L5zFw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 03:41:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9rzRMHMWFUSGPsVDP573cdrVCYN36WuAet-aSsir0DFMQ@mail.gmail.com>
Message-ID: <CAHmME9rzRMHMWFUSGPsVDP573cdrVCYN36WuAet-aSsir0DFMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/20] zinc: Poly1305 generic C
 implementations and selftest
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 3:39 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> > > +     const size_t num = ctx->num % POLY1305_BLOCK_SIZE;
> > 0 <= ctx->num < POLY1305_BLOCK_SIZE, so no need to mod by POLY1305_BLOCK_SIZE.
> > > +     size_t num = ctx->num % POLY1305_BLOCK_SIZE;
> > Same here.
>
> I know, but I was having a hard time convincing gcc-8 of that
> invariant, and it was warning me. Perhaps this is something they
> fixed, though, between 8.1 and 8.2 though. I'll check back and adjust
> accordingly.

This was changed here:
https://git.zx2c4.com/WireGuard/commit/?id=37f114a73ba37219b00a66f0a51219a696599745

I can't reproduce with 8.2 anymore, so perhaps I should remove it now.
Unless you'd like to avoid a warning on old compilers. Since there's
no difference in speed, probably we should avoid the 8.1 warning and
leave it be?

Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3334B21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="tGOz65fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3334B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbeIYUhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:37:06 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:50119 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeIYUhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:37:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 37ffba5e;
        Tue, 25 Sep 2018 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=NCVPFU0OKZR6+lQOWlHO+YHQWqc=; b=tGOz65
        fGZ6zzNbtEgHSha4P9AHFFt4GJ2piabHlB7b0I1O/uurObzCIIPI3N6IYDcqv31z
        qRBeC+7j+iUXPsHibpOlnyKCMzhR6USTSIvqg2hauJ+hLWDroFyqYN3nuaExbRQS
        6W1sg+Rd3RSt6xrMp/T3PgW7VQ5vxuCqHm4FAXtCHTQ0DBC+SL6G5c5vPT+r0l9b
        J1lGWVPgf7n0R0ZRLp5xxpCWj2wWJg6136JX+pk+4X0nk/ffc30tm5z+lY6qsjGq
        Lukr2kHuFzXlf6p4puerrORTSDBNgIlvOJRiNum2qCUXVTdp6LPTWM5LEacwkUD9
        B+8q21qdEvxdYDlQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1527c5d5 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 25 Sep 2018 14:10:51 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id m23-v6so7010139otf.0;
        Tue, 25 Sep 2018 07:29:17 -0700 (PDT)
X-Gm-Message-State: ABuFfojkVnzuyXxHzuRgY53Ho2lSPwPxC87MZDaKnr8gAqufjc8aohHT
        rcrd3biHbyiJE3J4dVIUihk1ZzDqF44GFxcFaCM=
X-Google-Smtp-Source: ACcGV61P5d05a9rqhGBBftsDd3SKO/KNI6wg3xkOuCSxqibN1CWY2JVK8tMzGw3bUMa+OdV++RhRMeHhZz+c8ME80QY=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr877221oth.250.1537885755203;
 Tue, 25 Sep 2018 07:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
 <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
 <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
 <CAK8P3a2VL16mtyq0HjNOXuSp8YJXik4J9Z_aPzksmTAbFB+=_g@mail.gmail.com> <CAK8P3a3j0eqAPc-Vkp7YFxT56R2-LrqL_EcULQFam5Bm93gPyw@mail.gmail.com>
In-Reply-To: <CAK8P3a3j0eqAPc-Vkp7YFxT56R2-LrqL_EcULQFam5Bm93gPyw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 25 Sep 2018 16:29:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9ofMSsLBJnGjt3VdErnFOQnGTFh8HMmduxRYC1EYyQkkQ@mail.gmail.com>
Message-ID: <CAHmME9ofMSsLBJnGjt3VdErnFOQnGTFh8HMmduxRYC1EYyQkkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hey Arnd,

On Tue, Sep 25, 2018 at 9:18 AM Arnd Bergmann <arnd@arndb.de> wrote:
> I think I misread your earlier sentence and thought you had said the
> exact opposite.
>
> For confirmation, I've downloaded your git tree and built it with my
> collection of compilers (gcc-4.6 through 8.1) and tried building it
> in various configurations. Nothing alarming stood out, the only
> thing that I think would might warrant some investigation is this one:
>
> lib/zinc/curve25519/curve25519-hacl64.h: In function 'curve25519_generic':
> lib/zinc/curve25519/curve25519-hacl64.h:785:1: warning: the frame size
> of 1536 bytes is larger than 500 bytes [-Wframe-larger-than=]
>
> Without KASAN, this takes 832 bytes, which is still more than it should
> use from a look at the source code.
>
> I first suspected some misoptimization around the get/put_unaligned_le64()
> calls, but playing around with it some more led me to this patch:

Excellent detective work. Thanks for spotting that before I had a time
to respond here. I'll also send that same fix to the HACL* team at
INRIA, so they can add it as a heuristic.

Jason

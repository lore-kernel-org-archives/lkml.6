Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1BAECDFC1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9434D20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="yerT4ZOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9434D20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeIMU4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:56:11 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52699 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeIMU4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:56:10 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f0c530a2;
        Thu, 13 Sep 2018 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=RdZUR/tpm7SsDg97avDsa3jlRlc=; b=yerT4Z
        OIDq4Wez5inXEbSALNOoYljD6YskWi/V0asl2jocOOhfn8X89tfetxNV6wbmvMsT
        rEANuQtlJPB+XEXr4lCdYcWABToisb1+0nTp9qwp6tLrh4zncctZpMDpQ43yTYXS
        VqGxnoA6Smbp6hTAJvQRP6rXai0nlWmniXjQfVaYyuq3bPWlYKkl0T85WxmapO4O
        UDIJtONMxsi/O/z4smaMVw+uzCueatmFkwlELMWjFOZ7pw0Zg7alYV3b6snEj2G6
        Bkjy0zjWbQpYvQEHARYOuTGgEo1m6SE/Eq9fWEZ38oSmEgremfTziGC+Zzl7UHfO
        scEC02Hil1wNXIBA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b1d7cf17 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 15:29:06 +0000 (UTC)
Received: by mail-oi0-f46.google.com with SMTP id k12-v6so9864966oiw.8;
        Thu, 13 Sep 2018 08:46:02 -0700 (PDT)
X-Gm-Message-State: APzg51BaK2rtJJXcLgVYyqWiD88RFAOxyT6PjSAvu31xJOHrwVt/Iej3
        Hsk6ez0HWZA+8Tf/xgGGRSE/5m7y5YWpKOufmLc=
X-Google-Smtp-Source: ANB0Vdbj2OOyj3GDwoqGqoeIhTmxPT3apJaRt0VeNflJuzByTArm9MyfId3MlixLnvYTFZuQNThLzGAwewWCMdnd2ks=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr6560415oig.189.1536853561789;
 Thu, 13 Sep 2018 08:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CAHmME9oYAEwFQAriVRm5zZKCo0Sh1=t5YheNZ+MtKQLQPoMWeg@mail.gmail.com> <CAKv+Gu9VamLBv5Ji5AtvugUrAYQYaotLFZZGA=Rt18JUDEaAMQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9VamLBv5Ji5AtvugUrAYQYaotLFZZGA=Rt18JUDEaAMQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 17:45:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9rfCc-Hp08AzeWT8M19Nivs3DY=DnmEQ9pT-qxf+vKiXw@mail.gmail.com>
Message-ID: <CAHmME9rfCc-Hp08AzeWT8M19Nivs3DY=DnmEQ9pT-qxf+vKiXw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:04 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> > The code still benefits from the review that's gone into OpenSSL. It's
> > not modified in ways that would affect the cryptographic operations
> > being done. It's modified to be suitable for kernel space.
>
> So could we please at least have those changes as a separate patch then?

I'll experiment with a couple ways of trying to communicate with
precision what's been changed from OpenSSL for the next round of
patches.

> > That's interesting. I'll bring this up with AndyP. FWIW, if you think
> > you have a real and compelling claim here, I'd be much more likely to
> > accept a different ChaCha20 implementation than I would be to accept a
> > different Poly1305 implementation. (It's a *lot* harder to screw up
> > ChaCha20 than it is to screw up Poly1305.)
>
> The question is really whether we want different implementations in
> the crypto API and in zinc.

Per earlier in this discussion, I've already authored patches that
replaces the crypto API's implementations with simple calls to Zinc,
so that code isn't duplicated. These will be in v4 and you can comment
on the approach then.

> You are completely missing my point. I am not particularly invested in
> the crypto API, and I share the concerns about its usability. That is
> why I want to make sure that your solution actually results in a net
> improvement for everybody, not just for WireGuard, in a maintainable
> way.

Right, likewise. I've put quite a bit of effort into separating Zinc
into Zinc and not into something part of WireGuard. The motivation for
doing so is a decent amount of call sites all around the kernel that
I'd like to gradually fix up.

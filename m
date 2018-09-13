Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED21F81825
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92AA2150B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dz0dfmW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92AA2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeIMVJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:09:03 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41499 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbeIMVJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:09:03 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 889d88f3;
        Thu, 13 Sep 2018 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=aXk07+9/W0BukxIV5LWvqzdUWVI=; b=dz0dfm
        W0HPZzGP2MDdvcN0IkLLCqqVjXqG/fC4zKW6oB9ilih9QLOILcYvbq+BUv0o7w7q
        oeXR/mq7KBqDobh69V8aOABYRu2PJ9oUp9TtHsZCr4Z1cEsvxAwdUx4rphgE/iBW
        5/1B6xOTXvil/4D988JbZCePLDD/k9OoTNNUfTWVjf1D0vyYJr/3BAxlv7Ki1vYk
        6xrlTGhK4A0IP15n9d7po4cZKLvNh7pfX0eo85OhD/Vj5a4ylUmLn5PG5PLaVNPz
        mDV1hTlfWZA85QMuXUvSheBrF/1BJ+2DWPrQtJkAtiHqNTTWW+DOyYDSWt1ajTCB
        n8vTzhxmLOPqa8iA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1aca9017 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 15:41:56 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id c190-v6so9917376oig.6;
        Thu, 13 Sep 2018 08:58:52 -0700 (PDT)
X-Gm-Message-State: APzg51ArwNtnEKrZYLtvbXJCSk9bsGbSvOxvNsuBbOnQFxHqUJo3JZ0u
        9BFHGBOv6X8z5yyEZNiLfXEDzNayJAFMQxfXylU=
X-Google-Smtp-Source: ANB0VdbF/23N83mIGiqA8FgV62nY4HysFJlEkl9SzxIFLNxTnZi0aup6+wY2Zb1cOFb7loULp15+XP/BFSzkiX1CAMo=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr6589668oig.189.1536854331807;
 Thu, 13 Sep 2018 08:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
 <CAKv+Gu8z1r7F_wbR6-e0Vbryqby7djDy2OR6JJURCsTo6ZMa2g@mail.gmail.com>
 <CAHmME9pcODNc2m26DH1cQY6R+grxYW5dvFpNDpz_GiugM3qufw@mail.gmail.com> <CAKv+Gu9GVbSETjp01tANMwJgA6O9aexhnH+47836KjZg+71q2A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9GVbSETjp01tANMwJgA6O9aexhnH+47836KjZg+71q2A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 17:58:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9qjTyYpm_PsQ5_oZSfZBGa29zME1XHVak9F4Ued-qm67g@mail.gmail.com>
Message-ID: <CAHmME9qjTyYpm_PsQ5_oZSfZBGa29zME1XHVak9F4Ued-qm67g@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 5:43 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> I'd prefer it if all the accelerated software implementations live in
> the same place. But I do strongly prefer arch code to live in
> arch/$arch

Zinc follows the scheme of the raid6 code, as well as of most other
crypto libraries: code is grouped by cipher, making it easy for people
to work with and understand differing implementations. It also allows
us to trivially link these together at compile time rather than at
link time, which makes cipher selection much more efficient. It's
really much more maintainable this way.

> I think AES-GCM is a useful example here. I really like the SIMD token
> abstraction a lot, but I would like to understand how this would work
> in Zinc if you have
> a) a generic implementation
> b) perhaps an arch specific scalar implementation
> c) a pure NEON implementation
> d) an implementation using AES instructions but not the PMULL instructions
> e) an implementation that uses AES and PMULL instructions.

The same way that Zinc currently chooses between the five different
implementations for, say, x86_64 ChaCha20:

- Generic C scalar
- SSSE3
- AVX2
- AVX512F
- AVX512VL

We make a decision based on CPU capabilities, SIMD context, and input
length, and then choose the right function.

> You know what? If you're up for it, let's not wait until Plumbers, but
> instead, let's collaborate off list to get this into shape.

Sure, sounds good.

Jason

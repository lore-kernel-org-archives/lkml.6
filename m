Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A9C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFBD20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iZoqaMlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFBD20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIMTmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:42:44 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57871 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbeIMTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:42:43 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ac105b55;
        Thu, 13 Sep 2018 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=XXKZu8toV4Aj+3/lJQV/N+D4cvM=; b=iZoqaM
        lZcKTKXBr1jJtuOgRmxnf8Kff3NKoB+2IysRhlTBQlzpmMES90sHjtAEUStqLPn6
        B1di0dKVBNjpETp6rbK/QkYRallXbup+n3HuSqfrN1HWpbguIKASEWBQfGHEuP6i
        rTj9Qm0NYcDe7ytCyspbPQ+ql6P6Uh11FWmEQL69AAcgDh0zTORxyiUsY6Knaw1a
        ghrlIVLzshcJIxX07TtNLIYqF81Pkc5wi10WdYLkzBz1MqkKu0F9aLCC5/aRlbx4
        Uf+G7XwfSY+9mc2NFWo/5GlZyxUxAX+tEo9FNO7ftbcwXw9zAAuT0lmZwQ6L9hmb
        r0/7xcIpKIV3JQ8A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 04d2c871 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 14:15:58 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id 8-v6so9684228oip.0;
        Thu, 13 Sep 2018 07:32:53 -0700 (PDT)
X-Gm-Message-State: APzg51BgJa+YytAKbG62K22PI3FnnyFPlVoP1h8ZLhWJ9UZTpZz6D0yy
        gkWB0CxCmBHpdWy6nFKirCW7CIiBp/Gh0RnI6ec=
X-Google-Smtp-Source: ANB0VdYStq1bsvFJ0cl+uWRAcKzEh65rjiVfZjjGXqf/zq6J9ljL7zyXayuWgusXqG75UPKQW+ykErwE1lc7Gf/6DVE=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr6694662oiy.191.1536849172639;
 Thu, 13 Sep 2018 07:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com> <CAKv+Gu8z1r7F_wbR6-e0Vbryqby7djDy2OR6JJURCsTo6ZMa2g@mail.gmail.com>
In-Reply-To: <CAKv+Gu8z1r7F_wbR6-e0Vbryqby7djDy2OR6JJURCsTo6ZMa2g@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 16:32:41 +0200
X-Gmail-Original-Message-ID: <CAHmME9pcODNc2m26DH1cQY6R+grxYW5dvFpNDpz_GiugM3qufw@mail.gmail.com>
Message-ID: <CAHmME9pcODNc2m26DH1cQY6R+grxYW5dvFpNDpz_GiugM3qufw@mail.gmail.com>
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

On Thu, Sep 13, 2018 at 7:41 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> But one of the supposed selling points of this crypto library is that
> it gives engineers who are frightened of crypto in general and the
> crypto API in particular simple and easy to use crypto primitives
> rather than having to jump through the crypto API's hoops.

The goal is for engineers who want to specifically use algorithm X
from within the kernel in a non-dynamic way to be able to then use
algorithm X with a simple function call. The goal is not to open it up
to people who have no idea what they're doing; for that a NaCL-like
library with functions like "crypto_box_open" or something would fit
the bill; but that's also not what we're trying to do here. Please
don't confuse the design goals. The rest of your email is therefore a
bit of a straw man; cut the rhetoric out.

> A crypto library whose only encryption algorithm is a stream cipher
> does *not* deliver on that promise, since it is only suitable for
> cases where IVs are guaranteed not to be reused.

False. We also offer XChaCha20Poly1305, which takes a massive nonce,
suitable for random generation.

If there became a useful case for AES-PMAC-SIV or even AES-GCM or
something to that extent, then Zinc would add that as required. But
we're not going to start adding random ciphers unless they're needed.

> You yourself were
> bitten by the clunkiness of the crypto API when attempting to use the
> SHA26 code, right? So shouldn't we move that into this crypto library
> as well?

As stated in the initial commit, and in numerous other emails
stretching back a year, yes, sha256 and other things in lib/ are going
to be put into Zinc following the initial merge of Zinc. These changes
will happen incrementally, like everything else that happens in the
kernel. Sha256, in particular, is probably the first thing I'll port
post-merge.

> I think it is reasonable for WireGuard to standardize on
> ChaCha20/Poly1305 only, although I have my concerns about the flag day
> that will be required if this 'one true cipher' ever does turn out to
> be compromised (either that, or we will have to go back in time and
> add some kind of protocol versioning to existing deployments of
> WireGuard)

Those concerns are not valid and have already been addressed (to you,
I believe) on this mailing list and elsewhere. WireGuard is versioned,
hence there's no need to "add" versioning, and it is prepared to roll
out new cryptography in a subsequent version should there be any
issues. In other words, your concern is based on a misunderstanding of
the protocol. If you have issues, however, with the design decisions
of WireGuard, something that's been heavily discussed with members of
the linux kernel community, networking community, cryptography
community, and so forth, for the last 3 years, I invite you to bring
them up on <wireguard@lists.zx2c4.com>.

> And frankly, if the code were as good as the prose, we wouldn't be
> having this discussion.

Please cut out this rhetoric. That's an obviously unprovable
statement, but it probably isn't true anyway. I wish you'd stick to
technical concerns only, rather than what appears to be a desire to
derail this by any means necessary.

> Zinc adds its own clunky ways to mix arch and
> generic code, involving GCC -include command line arguments and
> #ifdefs everywhere. My review comments on this were completely ignored
> by Jason.

No, they were not ignored. v2 cleaned up the #ifdefs. v4 has already
cleaned up the makefile stuff and will be even cleaner. Good things
await, don't worry.

Jason

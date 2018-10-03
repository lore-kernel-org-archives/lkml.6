Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A272C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EF820644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="us9fJJKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EF820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJCVeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:34:10 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36539 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCVeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:34:09 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7fe01622;
        Wed, 3 Oct 2018 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=0nRDfVaPf93KM3eloS2uJCINnpo=; b=us9fJJ
        KwBi5/3xGu/EQ1v9K4ykA0ccw9h1Q3y5cdAqeBMuUBTV2U8FAGmuyON8T28H6Q6t
        FXO9lxbPwjibVxNwM+NBMJS7XOl4Ba7GZdnJBcXrmkQO29i1sbe/wGFKhvSybOYP
        8R1FDHcgWo6nTqIOzwFqGbN9k1pMDy5wPsZDjO/YG6SVJouA9ggf7POuvmduREyh
        zxcu1qqjJQs3VMh7C4cppaM+UfBYkfqwhPOcN4Wbq85yeoKOLnEuZH8vplNTj2Bt
        Py1kptlMPRvefVCU72pAdRQ+yKJBGrMMCTdHCO+93kp9OuCEvbvgfuMYKPofP0+J
        2s+TFpaYr7z++hJg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e7e395e4 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 3 Oct 2018 14:45:15 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id w81-v6so4706061oiw.9;
        Wed, 03 Oct 2018 07:45:26 -0700 (PDT)
X-Gm-Message-State: ABuFfoilH/76Fj3Ep1q19hjp8LONk57PQiwpMautrGFfw9axR1ulqqql
        EnQtW838QE7v3nNB20DkpSXUNmIfTg2GV7mNo/w=
X-Google-Smtp-Source: ACcGV60adoaqbRqG2R4W0G6yvBjwVg+hqTtu9tuwCfo6vNvRP9U2ALkRND9Q7Nk4POfVFaSesEFVyXRkvGQed/UHJ0A=
X-Received: by 2002:aca:2c5:: with SMTP id 188-v6mr819681oic.192.1538577924937;
 Wed, 03 Oct 2018 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-12-Jason@zx2c4.com>
 <20181003061236.GB745@sol.localdomain> <CAKv+Gu8-HoAEyYiPYqMOMy9MGduFLQik2YxdJziqxN_cUs0nCA@mail.gmail.com>
 <CAHmME9oAa+Ezqy639_wSKsUDW4vgSrkbJUVd1O8Jcbo3CN4WKg@mail.gmail.com>
In-Reply-To: <CAHmME9oAa+Ezqy639_wSKsUDW4vgSrkbJUVd1O8Jcbo3CN4WKg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 3 Oct 2018 16:45:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9o1vc+-K39t-ruR4hYPY971XjLaiDqJ26wgoFha3tyRyg@mail.gmail.com>
Message-ID: <CAHmME9o1vc+-K39t-ruR4hYPY971XjLaiDqJ26wgoFha3tyRyg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/23] zinc: import Andy Polyakov's Poly1305
 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andy Polyakov <appro@openssl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 4:08 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> for all of the other places, and so I the comment in the dev tree a

The missing word between "I" and "the" is "extirpated".

Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B16C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1A021A13
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Jmj/IzHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1A021A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbeHGC1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:27:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45557 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730724AbeHGC1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:27:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c93d7750;
        Tue, 7 Aug 2018 00:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=HvV/wEjw7xfAAG8g2r0V9uXpqEk=; b=Jmj/Iz
        HYGA6Q7VhsrXe4k6k2CjfUD7coD5HHdC777zT0LntA5i+vn9hG6fh3zDJosAG1hT
        HmxzBMEIAXZed0XwcdUWe/iEKerV7lFsdtxKxAe8MIf9KVjw4+yCxmX8k7Ij30wr
        bRA6k6sEZ2XJDcQ9EEVaG0dEHrfAlw71g6bH9Hjr+KKPomREHjUWLebn0kHvjVzn
        GxRjfZaiVsfSojUe3V/Tw5CBN5noRz5PVhK+OBclK7uh3SXpUZCIYlFXSIrSiBe5
        kg0lV5rxpL1+IZUJ+c9EbCIol0XgoWOzBn+hQlemFOTujXokxxXJYSBmMj7edzCW
        hhsE3s/PakCbLLjw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 575bf09f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 7 Aug 2018 00:03:37 +0000 (UTC)
Received: by mail-oi0-f47.google.com with SMTP id 8-v6so25492768oip.0;
        Mon, 06 Aug 2018 17:15:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlHoDbaXqyafnZ4nKPC21aVjuxUFC+rD5IVN1dcSsOa5Sis4qUWc
        F221YyIgMfhJIonlblGGF9nOCCAZZ9KmRLy4Wfo=
X-Google-Smtp-Source: AAOMgpdwOCBLG0wg4nnyaATCLVjvLqe8362DAjK0xNMIQnxLgbTjOiZTClGWUbFxTFtxlgj2+q3llZge0/tP0mNlFaM=
X-Received: by 2002:aca:f189:: with SMTP id p131-v6mr15994955oih.14.1533600944770;
 Mon, 06 Aug 2018 17:15:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:a025:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 17:15:43 -0700 (PDT)
In-Reply-To: <CA+_SqcD+KpQ_X6iXUCpQh0N6pWzBorstBJDx7eBqcybY4Dvy8Q@mail.gmail.com>
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806223300.113891-4-ebiggers@kernel.org>
 <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com> <CA+_SqcD+KpQ_X6iXUCpQh0N6pWzBorstBJDx7eBqcybY4Dvy8Q@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 6 Aug 2018 20:15:43 -0400
X-Gmail-Original-Message-ID: <CAHmME9o6XQ+16d4b8+BiQViSiOOApi-J_ML2UOOBpTN8hV3iVA@mail.gmail.com>
Message-ID: <CAHmME9o6XQ+16d4b8+BiQViSiOOApi-J_ML2UOOBpTN8hV3iVA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] crypto: chacha20-generic - refactor to allow
 varying number of rounds
To:     Paul Crowley <paulcrowley@google.com>
Cc:     ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        samuel.c.p.neves@gmail.com, tomer.ashur@esat.kuleuven.be,
        Eric Biggers <ebiggers@google.com>, djb@cr.yp.to
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 8/6/18, Paul Crowley <paulcrowley@google.com> wrote:
> Salsa20 was one of the earlier ARX proposals, and set a very
> conservative number of rounds as befits our state of knowledge at the
> time. Since then we've learned a lot more about cryptanalysis of such
> offerings, and I think we can be comfortable with fewer rounds. The
> best attack on ChaCha breaks 7 rounds, and that attack requires 2^248
> operations. Every round of ChaCha makes attacks vastly harder.

I'm well aware of that, which is why I mentioned that ChaCha12
_probably_ has an adequate security. My primary concerns are a bit
different actually from where you're going - that it breaks from
what's becoming a pretty widely accepted "norm" and, more importantly,
that it increases implementation complexity. These aren't really
drastic concerns, but I am in earnest wondering the type of hardware
analysis you did to determine that you really do need the 12-speedup.
What's the practical landscape out there look like? What disk speeds
were too low for which specific kind of Android usage on which
particular hardware? Did you hit the bottlenecks when paging for code
or when filling up caches when writing asynchronously? And for how
much longer do you foresee underpowered hardware like that being a not
insignificant part of the market? I'm especially curious to know
because ostensibly at Google you have all sorts metrics regarding that
kind of thing.

Jason

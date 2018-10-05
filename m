Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8CFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EE22084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f6JeRTDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EE22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeJEUMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:12:50 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:49423 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbeJEUMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:12:49 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e3265ff3;
        Fri, 5 Oct 2018 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ECunFzCWLWJhIxlpg2RgA2TRgr8=; b=f6JeRT
        DQZni7mxB2PNVoV5fYTsxQmmOZQ7dsaqtQMLTHuoTILqHfdJlOjjV+ODprcliwQz
        KzsIRUC1RtA9U/fUT2Doo/4undjMJL1E1B48/axCTCt25bXAkQDCuT6yU2TNfqdJ
        2IecAqtqZ/YTjN6ewFkkc1sK8moGHOnkZ8N1d2MRz6zdJAK8+hqm5jprirIsKGNN
        9le0spc5onw3eop1ZqXzyVpeiqxK0hlHiEZZq15Kqf9f9+O8V/IX2uFaOgAW6qJq
        uux2SL6vH1TZB1UyPWQN5Ri2uMdM/QdLb8EYKURSEBea9ux+LJCoWdxUdyXtWMkJ
        V9GZVDLMkQQlQTtg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db984af7 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 5 Oct 2018 13:13:41 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id i12-v6so12688922otl.1;
        Fri, 05 Oct 2018 06:14:06 -0700 (PDT)
X-Gm-Message-State: ABuFfoiWl5O2gZbuYXb1KvmNp9aO/rU46YIz4b9FUURefI/2JwbO/IEY
        YAPCOLT2cWWGZehA8pgfGz2Jq0eu471x0t98MnI=
X-Google-Smtp-Source: ACcGV62g1cXPYSKGppeDtszc//KO5DhrJIJHskrimdKWqvNhNvGspdstMDCb/1Slvz/ImslA0rox3346sYIRW1r1/jc=
X-Received: by 2002:a9d:1d47:: with SMTP id m65mr6930413otm.199.1538745245184;
 Fri, 05 Oct 2018 06:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au> <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
 <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
 <CAHmME9r6-DHLwePQGBGcnPUZuZgZ2GtSUX9arsWzLqhKxd=uDA@mail.gmail.com> <20181003064951.GC745@sol.localdomain>
In-Reply-To: <20181003064951.GC745@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 5 Oct 2018 15:13:54 +0200
X-Gmail-Original-Message-ID: <CAHmME9ogY=v2Le85+_=-m++RwAzwiUmKyNzx6N2y9Ht-J7xBcQ@mail.gmail.com>
Message-ID: <CAHmME9ogY=v2Le85+_=-m++RwAzwiUmKyNzx6N2y9Ht-J7xBcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Oct 3, 2018 at 8:49 AM Eric Biggers <ebiggers@kernel.org> wrote:
> It's not really about the name, though.  It's actually about the whole way of
> thinking about the submission.  Is it a new special library with its own things
> going on, or is it just some crypto helper functions?  It's really just the
> latter, but you've been presenting it as the former

No, it really is its own thing with important differences from the
present crypto api. Zinc's focus is on simplicity and clarity. To the
extent that we're at all tangled with the current crypto api, the goal
is to untangle as much as possible. It intends to be a small and
lightweight set of routines, whose relationships are obvious, and with
this direct and to the point organization, as well as work with the larger
cryptography community and with academia to invite collaboration. With
this comes a different way of maintaining it, with higher standards
and a preference for different implementations than the current
situation. With Zinc, you have an obvious series of C function calls
composing the whole thing, without complicated indirection. It's
something that could be trivially lifted out into a userspace library,
and used broadly, for example -- something I'll probably do at some
point. That's a bit of a design change to the current crypto api, and
sprinkling some direct function calls within the current crypto api's
complicated enterprise situation would only kick the can further down
the road, as much complexity would still remain. The goal is to move
away from behemoth enterprise APIs, and large and complex codebases to
a simple and direct way of doing things. This desire to untangle, to
start from a simpler base, and to generally do things differently
means it will go into lib/zinc/ and include/zinc/ and have different
maintainers.

Jason

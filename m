Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F64C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FDB20891
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="syU059gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FDB20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeILCaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:30:04 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41959 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbeILCaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:30:03 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 812ea928;
        Tue, 11 Sep 2018 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=D4xiGxYwdhH1fOaYfXmSkBxnFLk=; b=syU059
        gx4LvIYSTk8LTcedOc4e5D+RepCRzAX3NEY3TECVYAUqx4xRMcnyjsiK3JyDQK6Y
        ukbUQgZ1THOx1T5oGzw9vVxWpEnrkT9ys/Z/pKiEsAIwLThYlL7j4v3kxll8dtwY
        aN8uxhorjFlv0j8A1+872z/Y+AFbCNQOQ/pLczBKpfYrK9LdEyR8URYdp2Wd5V64
        OcDaoSET3PtgDIgE1QskVE8XR1N69xnJ+4Elvj+Y1vv8bQ/BUcbzk4diXI4Hj8Ui
        MZwg2mSDkxpYpzbFzAfhs1E0YYmoe6Zpbf4bmnMTTgqnEg9++Py04apQoKLc7KIi
        PyPVRj9/mRtBQuzQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c84887e1 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 21:12:06 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id 13-v6so50261187ois.1;
        Tue, 11 Sep 2018 14:28:49 -0700 (PDT)
X-Gm-Message-State: APzg51CUffYjCHMpMeVtURbfuvWvrkA5iANLdCtF+u2uKeBg3Xcu7OCc
        9dwdkwDkzo6/wiwI9Sd2dyGl/PR3Az8oP29/MIg=
X-Google-Smtp-Source: ANB0VdYvEl8ly6+iQbMJBINccic1iwmiou/STp5VF9SWmMZvEWTydPByi/aVoZGL0jnmpX3sbhWGEhZheFI5sC7PKNk=
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr29210530oix.74.1536701328189;
 Tue, 11 Sep 2018 14:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-6-Jason@zx2c4.com>
 <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de>
 <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com>
 <alpine.DEB.2.21.1809111106420.5110@nanos.tec.linutronix.de>
 <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com> <alpine.DEB.2.21.1809112322060.1427@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809112322060.1427@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 15:28:35 -0600
X-Gmail-Original-Message-ID: <CAHmME9rr=OtFTmNWPdSY2OtRkSvCPpkq_HuS3LO1dL4n96rzOQ@mail.gmail.com>
Message-ID: <CAHmME9rr=OtFTmNWPdSY2OtRkSvCPpkq_HuS3LO1dL4n96rzOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/17] zinc: ChaCha20 x86_64 implementation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Samuel Neves <sneves@dei.uc.pt>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>, mingo@redhat.com,
        X86 ML <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 3:27 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Na, all good. I'm fine with the answer and reviewing that ASM maze is way
> over my limited crypto knowledge anyway. I definitely would enjoy
> refreshing the math behind it, but that surely would be way outside of your
> envisioned time frame for getting this merged :)

Well, if you're at LPC, we can nerd out a bit on some crypto math if
you want. :-P

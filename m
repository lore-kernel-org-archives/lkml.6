Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1524C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A68E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HiEFnl7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A68E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeILDFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:05:52 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39207 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbeILDFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:05:52 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2af1e8f3;
        Tue, 11 Sep 2018 21:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=AkMPCVJA96zi8qJ8peyIlh1gxwY=; b=HiEFnl
        7L7wjY54txrfi3ceW6f5zR0VV9ErccLhala82e6KjFbyNYee0Bbvniu2nA3YClhb
        M44JIgM3FCoIuk8DEmY6b2QYJdcity40rmrjHnAI2HHewp40Q2Uc+DLG4Tlxk6jk
        P/p9EfUdPZwosmjQpukwoqldqBpOnEU0JdpKAOj27d06CTLmzrpWdzZRWoDgB59r
        H/ATst05fgF0S3iKTBsvSb58VCDeXaiuaH0NYJCu3kxlYNjJ2qKD94JAi2gyJ+PL
        WTQaAjjsUbQL8UplbZ9Hr/Nsuqk/PgkYHSb2Vn45ZBnChjnNBeNOzNwY0HPgOYs3
        c79RvomvWI8E5FSA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 31bf2c53 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 21:47:47 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id y207-v6so50245712oie.13;
        Tue, 11 Sep 2018 15:04:29 -0700 (PDT)
X-Gm-Message-State: APzg51Aru5HgGSxEQHZ7x7n62kC1dcA64Kp2ZEsxlCmxa7cumX73j01T
        EnjtSOnV94ZctwYUKC1MrLlxby1hq1rT15I7wBk=
X-Google-Smtp-Source: ANB0VdYrnlBS+bQOSPEGcRQrSjR/V/b4+t5jnAkwZWIfctYkvIju6KZI47dX/lac+A9YKVnPz9S0PReYckYdnxI0bYw=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr27663868oif.71.1536703468794;
 Tue, 11 Sep 2018 15:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-6-Jason@zx2c4.com>
 <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de>
 <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com>
 <alpine.DEB.2.21.1809111106420.5110@nanos.tec.linutronix.de>
 <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com> <20180911214837.GB81235@gmail.com>
In-Reply-To: <20180911214837.GB81235@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 16:04:16 -0600
X-Gmail-Original-Message-ID: <CAHmME9r_Lw_nQAF9-dsWtJ3-Jx3pspsp0M2KUztRVfrgJYVMZA@mail.gmail.com>
Message-ID: <CAHmME9r_Lw_nQAF9-dsWtJ3-Jx3pspsp0M2KUztRVfrgJYVMZA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/17] zinc: ChaCha20 x86_64 implementation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>,
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

On Tue, Sep 11, 2018 at 3:48 PM Eric Biggers <ebiggers@kernel.org> wrote:
> Please Cc linux-crypto on the whole patch series, including the cover letter.

Ack.

Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E3C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006AA20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GNhBmBf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006AA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeILCNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:13:40 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41085 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbeILCNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:13:40 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c6cb15cf;
        Tue, 11 Sep 2018 20:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Se4r2kLBdb3AZX5Tk9Hf1enxpaE=; b=GNhBmB
        f8l3Esjk29t0O1yTCPyJ288tdaKJ2pjKqOanzdrhZEncWBPvjOyIKiWrJnsFgVrX
        xa09kd4eJGdHfCrh1x4+sMXWUEJAAO+36eRQtO2kzsExRJqb0Q272y1qLf6mWiFt
        fM/yuXonIOP5Ucl7PB1QIQFjs86fv1bXx8X41KfWI8aLesst82cplo8IIcQO7X5I
        5SEbWm+Jj53rwV0LrT+wlEeuDmHFkfzhOdwROnsAr8kkwED9sZ1YMiDtd3gtpEpn
        KRnqw01PnWE3WzGJuHvtz2gZO9FNij1jJ84rCVk3V53xl2iApuOBMaQSOGGfSDO4
        zuWCtfcBJlM9GKtQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e083fb95 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 20:55:46 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id y207-v6so49999357oie.13;
        Tue, 11 Sep 2018 14:12:28 -0700 (PDT)
X-Gm-Message-State: APzg51AxH8ehrtXPr9Je40Lgw61/DLh24PZPCfmiqY76XKAkG8foOvXQ
        HwTGZ3PjcFSaUVX+gMQ9G6T7a8wjES2yJjL+bEM=
X-Google-Smtp-Source: ANB0VdYXX821PUoRiCCSZ3mJ6zdjc3a19h4eov+GjDt/HFrfDtsTThYpw7BSB0kJie4dZtLOmWER+q8SONg5CLXprK4=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr27792136oig.189.1536700347708;
 Tue, 11 Sep 2018 14:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-6-Jason@zx2c4.com>
 <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de>
 <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com> <alpine.DEB.2.21.1809111106420.5110@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809111106420.5110@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 15:12:14 -0600
X-Gmail-Original-Message-ID: <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com>
Message-ID: <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com>
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

Hey Thomas,

On Tue, Sep 11, 2018 at 3:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > This is covered on the 02/17 commit message, whose relevant paragraph follows:
> Well, being only cc'ed on only half of the patches does not really help.

Sorry about that. I'm happy to Cc you on the whole series for next
round if you want. Just let me know. In the meantime:

https://patchwork.ozlabs.org/project/netdev/list/?series=65056
https://lore.kernel.org/lkml/20180911010838.8818-1-Jason@zx2c4.com/T/

Regards,
Jason

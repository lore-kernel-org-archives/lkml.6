Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4320521566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KFcoWr5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4320521566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeI0X0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:26:19 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44257 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeI0X0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:26:19 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ebcf9317;
        Thu, 27 Sep 2018 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=ShRe34BhklmL
        O1KHTDlei/vS7iU=; b=KFcoWr5z/Np+2GfXx+6XGkU21g/hNCabSLI1bEC+lU/2
        2yU7NAkNZHlr6xKKRkt2GDSXvAWeWT+P3EBA8KGkODR6KlnkMD1sQpHWLxdDwyCt
        kMpYgJnd6Zd/PWxslxL6HlB9c4JmHOB136xDHe/FIfjVSI1z+OzrSmGZg4R6nNpt
        e095iX/Nd0aM9UYzPdVWLXYXguZJR48VSd3dtMws3iF0YxivDia94YfTWswTQJKO
        /f5tsucJZyc8JPAIxik5FQtJ0aXGe8OMT6Q132qZtl0VyVRg8HHiAal8B3BX2u4m
        0uKStlv3pNL7YWNgZiCf9zW+8MM0wUrNOIcfIjOOfA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d195dd04 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 27 Sep 2018 16:48:22 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id j68-v6so2809332oib.7;
        Thu, 27 Sep 2018 10:07:03 -0700 (PDT)
X-Gm-Message-State: ABuFfohyMuiJx7J2ARpCYIRyvMME83zr+pPtPv5E/QTuUYtHfqAWxE0C
        1cRm9N4kzGHUfJSBWiAPI94p5TC+ezW2snlmkJc=
X-Google-Smtp-Source: ACcGV62SfiuMBvv1beXiJlJkIpUYTAuMtML6v7KHRM8VTMRTvncoyH3daK+nZsq7PNjiNzi7avPYKq9Oh4pik3QNvgM=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr3480575oig.225.1538068022255;
 Thu, 27 Sep 2018 10:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
 <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
 <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
 <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
 <CAHmME9qNn5aRgtbV3bAsz3xW1A49a7RMMkOzGruBUPzLVUxVNg@mail.gmail.com>
 <CAHmME9rN3-7Mj5JQqt2EFPauG9vjkN5pQn3tPiJY4fPiwksaDA@mail.gmail.com>
 <CAHmME9pBRu4hC5=Ef62R_nWOi3jTegxvxNrR8qDM+VfO=2t8Tg@mail.gmail.com> <BB2CD8D5-E7FF-4D25-8C83-F64960253248@amacapital.net>
In-Reply-To: <BB2CD8D5-E7FF-4D25-8C83-F64960253248@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 27 Sep 2018 19:06:50 +0200
X-Gmail-Original-Message-ID: <CAHmME9oXBin5NyVTKfV2efSzztW4Snno+sZoWJr-ieDLNVgVGQ@mail.gmail.com>
Message-ID: <CAHmME9oXBin5NyVTKfV2efSzztW4Snno+sZoWJr-ieDLNVgVGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 6:27 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> I would add another consideration: if you can get better latency with neg=
ligible overhead (0.1%? 0.05%), then that might make sense too. For example=
, it seems plausible that checking need_resched() every few blocks adds bas=
ically no overhead, and the SIMD helpers could do this themselves or perhap=
s only ever do a block at a time.
>
> need_resched() costs a cacheline access, but it=E2=80=99s usually a hot c=
acheline, and the actual check is just whether a certain bit in memory is s=
et.

Yes you're right, I do plan to check quite often, rather than seldom,
for this reason. I've been toying with the idea of instead processing
65k (maximum size of a UDP packet) at a time before checking
need_resched(), but armed with the 20=C2=B5s figure, this isn't remotely
possible on most hardware. So I'll stick with the original
conservative plan of checking very often, and not making things
different from the aspects worked out by the present crypto API in
this regard.

Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38835C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E788021529
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fRAZ76kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E788021529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeIZWMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:12:44 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58721 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeIZWMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:12:44 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 06e56684;
        Wed, 26 Sep 2018 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=lshxYNCqFNlJpm47xTM+hyy1bEM=; b=fRAZ76
        kcchxTBrumLxo43s7Ox4jn5G7oRcQv/hMnLWnwplRKo8BNJ43IrVaAzmufLUjW9C
        /5nblbAP5mEtWgR/6RO2qWKkcwotSysogJm/F/4760W1YWrh1od2G6uia4s9RuUC
        DLQfbjlQ2RLdEDWCtXmGrU0Wbq542jEZIy4kgvlxK8p135m4213b9qabc7n5ZKKY
        cbMcjfBD7SeHuIaOpP6GX8zkndGK8kNZWnk86lhez8drFtQyGtnoAqoyAR9ThSoa
        H+4iG9WAPBG/hBfL51eLz24bFBfIxERC8MGVIaiuwxzHj1xSA2aDR/Uls02nxZ57
        P4E9oeymfgpo0Fcw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 65788f5d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 15:40:32 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id v198-v6so4825371oif.9;
        Wed, 26 Sep 2018 08:59:05 -0700 (PDT)
X-Gm-Message-State: ABuFfogrIER0h96sfuxr6+2n0p4z17YUOXN4QNTYTaSQhRFpDBqG9CiI
        x6gMwbqjBzb2rL7AVBlmKLo62SHDNSujbwgPDXQ=
X-Google-Smtp-Source: ACcGV61KQwfqPH9mMxrwXqZ/cYTC9CSKI078O9KVJYN93kQHECGbZJuReoj/wlskK/MzN3YLrd7//x5HxfygVIHV12s=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr958452oig.295.1537977544891;
 Wed, 26 Sep 2018 08:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
 <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
 <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com> <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-WDt8f9qVjLDRPHL7THS0BjtKHThw2RMfHbWBT8Hs8aQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 17:58:53 +0200
X-Gmail-Original-Message-ID: <CAHmME9q9QcCEZfTykJdS5Qcvv97Ve4PEFhFKYWKFyQXgn8+m9g@mail.gmail.com>
Message-ID: <CAHmME9q9QcCEZfTykJdS5Qcvv97Ve4PEFhFKYWKFyQXgn8+m9g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Sep 26, 2018 at 5:52 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Nice one :-)
>
> This works for me (but perhaps add a comment as well)

Sure. Just a prototype; it'll be clean for v7.

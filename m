Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95751C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A3F20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NV3ZF9sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A3F20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeKUCse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:48:34 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:45703 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbeKUCsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:48:33 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 438d852e;
        Tue, 20 Nov 2018 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=euFlACP5z0hFCwbRb9B+FEUe/+s=; b=NV3ZF9
        sk2oud19Wiwwh5Z3Sh+o9+N1jXFm9a+fcYU+m0zkEnYNHXZE+CdB7F83JwtybPxo
        d6Fl/qKH4q2e7R8EZNH8y3yu49TK6iF/KFwUI0tutGysVxbAdbYsZA5mUMLhhAWN
        lMiejz35FG9ECdp1Ka63i8vD+IUwtDaU8PMywuain3JMIhW2griQX32+l3RojLUM
        3lNjeKvFU27tYCEVop/6dYGrvNZLMOmqyCbDdft0agzWaXzH38CFJLJpNHfOQC/k
        9Zg6hN/DnAPJm41KGRjWXF1JYtkaC4zHTQ6I4p743oNQkLDwSbIG95HOwIxcUQTH
        pEpevcZUyCpM0vSA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0c96e3d5 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 20 Nov 2018 16:12:29 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id p82-v6so1936345oih.11;
        Tue, 20 Nov 2018 08:18:36 -0800 (PST)
X-Gm-Message-State: AA+aEWZYmH3arnYUAzJiZXjDzkZxysw20FeRs6aszrwDDOlTZdOeRmio
        HTkl4ceZ96eZmtvtcRu3FbZ2GMcZorB2mKmy/mA=
X-Google-Smtp-Source: AJdET5f89Ec9WDXthH/5vAoxfzAdMIAEVCRTELzByONegk0EVO7Sx9lUq1KSI098o/3dUjvyyWaISYTTtwiNxlXvFl8=
X-Received: by 2002:aca:3f87:: with SMTP id m129-v6mr1357137oia.228.1542730716096;
 Tue, 20 Nov 2018 08:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20181105232526.173947-1-ebiggers@kernel.org> <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com> <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com> <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au> <20181120060217.t4nccaqpwnxkl4tx@gondor.apana.org.au>
In-Reply-To: <20181120060217.t4nccaqpwnxkl4tx@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 20 Nov 2018 17:18:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9qOFA2hEe-8hb3CxEPsLbwNm8oev4SO5WBDhA+pxqadGA@mail.gmail.com>
Message-ID: <CAHmME9qOFA2hEe-8hb3CxEPsLbwNm8oev4SO5WBDhA+pxqadGA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Exporting existing crypto API code through zinc
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, Nov 20, 2018 at 7:02 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Here is an updated version demonstrating how we could access the
> accelerated versions of chacha20.  It also includes a final patch
> to deposit the new zinc version of x86-64 chacha20 into
> arch/x86/crypto where it can be used by both the crypto API as well
> as zinc.

N'ack. As I mentioned in the last email, this really isn't okay, and
mostly defeats the purpose of Zinc in the first place, adding
complexity in a discombobulated half-baked way. Your proposal seems to
be the worst of all worlds. Having talked to lots of people about the
design of Zinc at this point to very positive reception, I'm going to
move forward with submitting v9, once I rebase with the required
changes for Eric's latest merge.

Jason

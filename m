Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-47279-1523248167-2-6829610266166434200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523248167; b=tEW8hew7T1txpYJDbypT3DQR1MpdYVK5sFemwa6cOtuvcd1bZ8
    1ONzR/J5BtbpS+STmVQBGK8laR+MFzh6CbHuq5d8pius/KyY4VFVY72y39ZhL8aQ
    jB4hKBIsllm5u2Ago8udbYTU7Knvqr8V8J2OcDvcbix4ifQMg5qBxGG0MY7Sr78c
    XUZHYe14shNSlYIlXr50Zsiz4Aw2R/BYDasqr0taiGkEFk6pNadE3M9yqXQUZbnF
    yPuntA6a7a2qh8ASRV+yoDEu/J7naSLOQPjxJPs00cckKEmr69w8UL2LKqHY6BWX
    2nSw51D76dQTCQ/XwgSiLGlC7OrM0qzr3GRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523248167;
    bh=/uxIOqup0DRHPs3U8D8R1T0XHQn98sezi+MKtWdcQAA=; b=Hwd9uQMjNqeg
    5Ly78cjoS1FZrCZ5nTCTF1GLEQYXbTHqKIm8USl3jrHdu9PjzrE7gVxjK9X/gONG
    K7NUmxnAwc9NVZiu9LWBkzk7Sw/M5FHT1PQSlIJZPoHSdc8Gf/Em4Lj4zTmyU0v9
    CkKz0yqv/qB9PUm7B7q3aDEl1sRX79Us0vY+fGZT1XI/l0lN7NdAbUU6DjCQayuG
    ybf5j6E6O8zTmoPm32Oo+AAOTBy2/hHzitFJAwRHTtU8An6VY9zRg51SkxOm9ETn
    08aEyPHsj4GPGM/tInBYS6h3fujz/Ad/zbr9yS2i2UoR2xkQpyaweE64wg20XI+C
    DYIN63I2WQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pGYlN/Yp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kfYOe+wc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pGYlN/Yp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kfYOe+wc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM9ZO9XVVpR3WkgwtKwHPvCDHMLo1tO+fLq+bKQhUHxiYajKMhexqFqLAATF0w+nqRJyQeQkndBqU3rAH97z9fJ26OH64eB0TNMjr/wD5oCNspS99bBE
    18ydvKFVVZSTVUI9DhxVzn8pffxLX+W4g6iHfabU3UxcxQFB0Rqb87iioXxQHEK0L3vLIZZjT7CkITMRp17JJb+1n4a830hmq32gG9Tv28FvPUOOBVBliqQy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=mXOwmpu4K-kA:10 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8
    a=VTSXT1xijG1yDSQ_B9EA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeDIE3Z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:29:25 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:35669 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeDIE3X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 00:29:23 -0400
X-Google-Smtp-Source: AIpwx4/6SXfGclo4jm6Icfh0OqrTV01FIbN/V3ONdcbUlt8cDNB1VNod3s5StzN0kD5/XWgTzaCkPg==
Date: Mon, 9 Apr 2018 14:29:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "user-mode-linux-devel@lists.sourceforge.net"
        <user-mode-linux-devel@lists.sourceforge.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH AUTOSEL for 3.18 059/101] x86/um: thin archives build
 fix
Message-ID: <20180409142911.34fe1065@roar.ozlabs.ibm.com>
In-Reply-To: <20180409004042.164920-9-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
        <20180409004042.164920-9-alexander.levin@microsoft.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 9 Apr 2018 00:41:22 +0000
Sasha Levin <Alexander.Levin@microsoft.com> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> 
> [ Upstream commit 827880ec260ba048f95fe646b96a205c394fa0f0 ]
> 
> The linker does not like vdso-syms.lds in input archive files.
> Make it an extra-y instead.

I wouldn't say these should be needed on kernels without thin
archives build.

It shouldn't hurt, but no point risking stable breakage.

Thanks,
Nick

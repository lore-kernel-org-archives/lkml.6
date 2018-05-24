Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602388-1527149848-2-4132902794821811254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527149847; b=JNXx3mC9/TfFUceFsXMIPfHs+3/nWYE7ly4PGheM3bK6BSdCOc
    aGBJ5lJBqKL+3Ifmqm3/ANhXM1D+YUgov7GygtMlFCifglOP4a/yVXAFSiqXmEhr
    LwZ1BJ4g8HDOJS+DiJle2CpWqy0G48dWe4sGEcFsO+sdj5Fyx3WwzOpuSKt2xJ3A
    eKWC7F75edFct+T3PswbUhhQXVyuKHAa8rnfWEbZLhhVbyqehrBxKocSyWxSW0wJ
    AcoRlQrjHe3XGwcX3ojOsp3Zjyb3KN5qN+XpS4em+S84w0cgUNvr29rRsDwVZfHM
    JlOIoDLstDuiwNV3mTmdoPWwuwzq8U9NIKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527149847; bh=0K74eODW2qGHwFSVKx6Slu9e3ky60NZCZd2hdDr/W+
    g=; b=hMb2IRSoc1mSsf396FfwKX2j+kIrBMarGT846uwadmWJtP6zSscr7QdCSx
    Xm3LQG2ubblisRWS/RMFm45kk9+73lrSv5lFBpqvHUgbeylZ5cOL5H7IJbQD/ijD
    YsgGAaYxAoo7/II71rGmmySXwTRN103/ltWOsRONb7ivRnEP94JFKMYfarUji0Xd
    dvAMAowdXJDMXn8T932V7wWlRRhEFWILvvVRmQh7yJNa2BolkwGtCIyN9ms2Xy94
    y3xNcSeeyeAEk3Xt7eRzJJhruZtrXOf8InCsy8Gmm60sRRB8YO1x9Yf5Hrj7wc5V
    //1ZdjQB9t6YSHr1Nnz8sze7WAnA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=DCv4AQpd x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=jU30ml3g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=DCv4AQpd x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=jU30ml3g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK/Mfboc+icpZA2Znus6FFWwpakH4ZInWHBlpgbhjYOT8xeJClQY3zGkvtyx4wztlyC0teOmD4rMAwdKO1hguH+PnUSBIjJDLoeITaWTiHcmU3DZ7Rqw
    dohN7VFcTuOjlxh7aJs3xM24hGZxqdqFvAa1C5I5ORThhUwC5QkZl1/UHw+lVBO4MGL86nYavBetiXh3AplCIp834YkO0bhHNxILnMuhMLJlXtAMTUKojDZT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=k7pf5ufzz2rQo4Ujl-sA:9
    a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=OBjm3rFKGHvpk9ecZwUJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964875AbeEXIRK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 04:17:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54274 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964864AbeEXIRI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 04:17:08 -0400
X-Google-Smtp-Source: AB8JxZrNgZZSBSAQfsAViMhIY7ZdyVdT6oRzy8SH7ozQFqgUDBBjoea9IQEwLTdFyMVDz9cAu0OoVKi5V118wn89YP4=
MIME-Version: 1.0
In-Reply-To: <20180523084405.14410-1-gregory.clement@bootlin.com>
References: <20180523084405.14410-1-gregory.clement@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 10:17:06 +0200
Message-ID: <CACRpkdak2q56BpjrvpGF_FzN=ZTbZ+71r425rFAe=b-kRQDqwA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: armada-37xx: Fix spurious irq management
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        Hua Jing <jinghua@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Terry Zhou <bjzhou@marvell.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:44 AM, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> From: Terry Zhou <bjzhou@marvell.com>
>
> Until now, if we found spurious irq in irq_handler, we only updated the
> status in register but not the status in the code. Due to this the system
> will got stuck dues to the infinite loop
>
> [gregory.clement@bootlin.com: update comment and add fix and stable tags]
> Fixes: 30ac0d3b0702 ("pinctrl: armada-37xx: Add edge both type gpio irq support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Terry Zhou <bjzhou@marvell.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Patch applied.

Yours,
Linus Walleij

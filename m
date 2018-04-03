Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1679646-1522766857-2-512378529126821938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522766856; b=L8fYE0oKm+7fkt9omQ35MfI5V2VpzXlBZ+FUO1CEadQtwfBS3h
    Ps03aI+46d7M/RUWBPTBaxfMOfY4cEdPE+ZYjoODtp1UmER2AWKAxLQ0CssXUVjf
    NAdDLlz5LPWeAvTIB7qRzuqL2uUqpU30DSSP+/Ni3F7cLyw2xe89ChRTvYxWpc2h
    TShYBr92vUv0ZoJxg6GR4S/D7hgxvxpazuhv4TuH4TnXgBaiEudntSDBWbFbMDE2
    3PVpXrFnNPcwtwQoI4cBRB42pBJwD6w+lTbNN5xHt9wjGAkRxLeLgYV2d8IQWf+0
    lzzohs846eH8Vcr3EDr0n3bUSO/A2WM8YZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522766856; bh=mCLoqjJf7ECpB3zYM4CFVDYTHTxdbzZvUPygQ6SI8Q
    g=; b=P7HKg5gRI3/QWM68z9VpVWZAmoY2ARyxgW+LqLbd1c4nN+ejbMJnhKPNZI
    8NDJ3xqDCt+Naloh1DRWdxMBBIoxdRgfi4z5JWEVjaubh/tIdbI9liK0XJdoz1JD
    USzbTo27oQw/swlHD2O1Y3dZpaBEwhSS5U78lmQpsW7eQD8moosu1FkWTukk99Qj
    hk+Ez+P0qdJ0NmdcsaJABQwsdTV2D38nEmpCwFEYVema3znelGBd43kBoxmBUD+c
    nYfX41jF4HD2uoz7CKP2cLqpfcKR2dFkK6UUqg+L4AcwFxIABeiHCOb4o7hzZUVY
    yjeBv9IPFea42nIIooWa8K4zUfjw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uQNFySJ7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T1oZ1SoQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uQNFySJ7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T1oZ1SoQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHjqZluD2csMAD+vjy8sbLIiUOHA6O40uvh7MV66WNwiVG/KsNXoodCczbOmTnv+Cnj6HZeyRUdMFum8e/Mh1uAI6/71PiaoyW8qO/zHuy0AY94MPj4U
    p733SWhRwzOwcSMWJmrpJZdAaA3X8uQ4oS0FJw5E7tl9P/aXyd8rxd90psoX5vTqwoqZe1KsfeIoU99Ujj/DuPmuXt/dldRL+q2IVVeswrGsLXTeRLR/ihKR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=6zb38KopAAAA:8 a=R3wYQoVIoFRURugnPIcA:9 a=QEXdDO2ut3YA:10 a=mDT8kg4rI6sA:10
    a=sLgWHmCJlhLUVLMAeJB5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeDCOre (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 10:47:34 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:38115 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeDCOrd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 10:47:33 -0400
X-Google-Smtp-Source: AIpwx49HbXOgPdXB/xJIRuboYVTEu6qaUvUtyGeY7e8DCjOpdaGXvM/rrJveHQyybf0Nmlc9dgpnwiX0geEC4sjMWxk=
MIME-Version: 1.0
In-Reply-To: <5abfca32.5d57620a.a2eca.898b@mx.google.com>
References: <5abfca32.5d57620a.a2eca.898b@mx.google.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 3 Apr 2018 16:47:31 +0200
X-Google-Sender-Auth: ud8Jy8c3ET2f3NjFckzmWcNWoAE
Message-ID: <CAK8P3a1-VqB8mbixuHdsZbfCbGBpVppO4KX4VuZ5AJCHbYooAA@mail.gmail.com>
Subject: Re: stable-rc build: 4 warnings 0 failures (stable-rc/v4.15.15)
To: "Olof's autobuilder" <build@lixom.net>,
        "4.15.y" <stable@vger.kernel.org>
Cc: Olof Johansson <olof@lixom.net>,
        Kernel Build Reports Mailman List
        <kernel-build-reports@lists.linaro.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 31, 2018 at 7:49 PM, Olof's autobuilder <build@lixom.net> wrote:

> Warnings:
>
>         arm64.allmodconfig:
> WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o

This needs a backport of

59fba0869aca ("phy: qcom-ufs: add MODULE_LICENSE tag")

       Arnd

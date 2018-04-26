Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2415778-1524739335-2-11901591866281739791
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='no',
  MailFrom='org'
X-Spam-charsets: from='utf-8', to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524739334; b=Zdm6EhJxqQKoVGFmKFU0ZoILM9xBxrqKoDnr2uQvoS7WHBbCCh
    NadSwW5zsGdV9Hd2KKz72oM4QiFEr5RxWGykH9LmaxU9ky4/yGA/FU8UYeTFTVoI
    UpDIlrCQ9SFBdvQMBZHHCnj6gqmzAvbglb00YLbmMyG2hb5r+r979UQRo0qQ2jgO
    Sw0sMOk4rAeLoZySZEXUAHtTWoawsDqOYCkdL2NwgY4nyzTz74lNuaFpmgMGs/LR
    rukilr8jHy8l6O+TsFfb8XSfAl2aamnYMz/jpOBBwzBAPWFG3m1p7MdHUt2J7CMN
    5jIaz10Ua/rvetHO8uZ3/ZciniMYxA0UE2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524739334;
    bh=GJ3dJhWfK1f7ezoyzIjYSSMHtL6WQoVTg8T2Gh9QXME=; b=sEDN5q/d3YzT
    RTr+WpjaJnV6paCvJUxaFAej0JnTXz/MdXEd+HaBKTRuZNRjUUozz1PXCQ0M1MW1
    oL8bglVhSpdTl0J0ZcD15RUCYqOS6oT1qYTymOXn+05r/aks297wod0wvcuEAc4Q
    BVWCMgJPbPnq/BKgI9b2dJqZCXVS8P91bVAm96Ax/o7ZzohaVhFvVSNNgpU+e7yq
    bzjKzOc2uXObbRTyYe3IMXTlSG2pFAbK8+BLwvEKEipYi73oVd812XyTNRH5bX12
    NO+rFFmQ4L1XU6Z35KfptkooHeEUnLRS61HQNyxqkC/yeVwyuxW9fsLsQtKDsDz5
    Xt80f3xkBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=bcynYhve x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=bcynYhve x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCnqbGrdAUKhfHCoWpAsSM7zx7JqQaI5bj63v7lCVBuBI+G9IopOgbltFqJhlhzy4UM/tUhVX7kfV8kZpiJ1L2wmUjAjct7FB+ZX+J0BXq89NbSog862
    DV7vcn02XQlQAafrNCN4FtY8XI82l9EP7TIAwb8g9Oy8DIuyS0GDFHyWj1U0JdAIC7Me1qMDQpkQkFTv3Y4mOBkmGP+DBawlqSgJnqxWedCmFX2wKQetVQUb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=dZ7Af3Q_AAAA:8 a=u_7SsVUpsgqSU9Wu1e8A:9 a=QEXdDO2ut3YA:10
    a=dMJi6bbOtLoA:10 a=xnyMoErWsJe9py2mg6Iw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755318AbeDZKmM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 06:42:12 -0400
Received: from canardo.mork.no ([148.122.252.1]:33883 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754630AbeDZKmK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 06:42:10 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: =?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
Organization: m
References: <20180426063013.453-1-sz.lin@moxa.com>
Date: Thu, 26 Apr 2018 12:41:56 +0200
In-Reply-To: <20180426063013.453-1-sz.lin@moxa.com> ("SZ Lin
 =?utf-8?B?KOael+S4iuaZuikiJ3M=?=
        message of "Thu, 26 Apr 2018 14:30:13 +0800")
Message-ID: <87vace5jwr.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA)" <sz.lin@moxa.com> writes:

> This patch adds support for PID 0x90b2 of ublox R410M.

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>

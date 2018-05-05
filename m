Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1470203-1525504840-2-12100357137804128292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525504839; b=ay5vzejCiHoJr2mrmPkZvGOigI2SYn8mjcthjA8OX5elMImnFB
    +WRNmJIvM7HVsjkkQWMChtK9CBCH5Jl4roxT4RkmPNvewf/Ci7gx6gCjs3ERRpte
    Qxm2hvL0Nolh+mLtYlUwwzSYDWEcue96aD0htexeQvjxB4usm2zzrpQl6L0zB007
    S4iaMhVcBBRpLqjFnv2sH2aZelaqWflGqE3yIfoZzele1+uRAjGmOaxQ455kbJlh
    PVROWM2BhRgZ1HmdRhUxKAaqyng8T7ZMDT4rkPr4ktXtBnEKdGKTlCJooyfq20GE
    lgenJdE+AOZAiGuRPQZ0i81ZjKpdlE+oKQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1525504839; bh=vTAR
    4rd+VbdOhqBr/UXnjiGfKuL0BuE/WNKx4gTDtHo=; b=NXhNqcuxWx8fRZixQ2s0
    O7K1ihlDF46kwINyJ3te5fP3+FLFXzTZ3AKDOVtiP+4t16d9zzve+s9Q72uTXMR9
    4miBIWNFi/m0hEVqZk0H1zVqCqfVqF+oKtPa6u817yy6IFWNfb0GQwj1ZagYSFEv
    9X1EVQMBaajpLyEiq8pIgyn7ytHiu6TGaMzUbxckjEZ4GZ1B1SKjXWvSpjNmeOfX
    Xh3zitl/ww2lKiNCdPWBJRY/E3oL46BgZ+6MR+zBmLU0F+lHIYcb8M+tFt4gQIDR
    NFspYlmeDcJqG8MvsivPL5me3n/+kDd71netQ3iR3KlDvFh8w5zcAwPauFKLVBsm
    jQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=ofMtNqa2 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Pd1aEoLS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=ofMtNqa2 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Pd1aEoLS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCO1n/y8L9IBnHJnfhioFZNkVJF72tK+XQioApO6hbatCe6+VvaPJiXMZgphn0oUsnO6hcTdHXAL26We5MFV+bZQrdiFYWHt4sUl6yjnVHBnG4pUuj+y
    YV4HJnuWv27riV5dxjyTNiKS7rUy6VbyjARf7vsZP6ZKrvG7hBGLEaKKD1lb0zRXTp0JUlkz2c+vtoHquKglQlkQJswwwdkc0LjjSod5YU1jazRrSve0oF8Q
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=AJ7UbYC7JNMA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=QSSnCv9aFBVFueqTE3wA:9
    a=QEXdDO2ut3YA:10 a=Qn6xTRysOZEA:10 a=FoiGvTp0eMAA:10 a=pRQRx_yQ9a0A:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbeEEHUh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 5 May 2018 03:20:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38630 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeEEHUg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 5 May 2018 03:20:36 -0400
X-Google-Smtp-Source: AB8JxZrYJwwEUYhvmER02VsSH3pE53AHWwKM6xb1oxLckX/TSvWtZm+M44kpBguvgXIzoRETgMLIOXvXfCsbMvWTVr4=
MIME-Version: 1.0
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Sat, 5 May 2018 09:20:35 +0200
Message-ID: <CAFGhKbxsNyZqpwJER9RXtpW1FsoNYMHg2nXDLHr9wQXUuMr=+g@mail.gmail.com>
Subject: EOL for the 3.2 kernel?
To: Ben Hutchings <ben@decadent.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

will there be an announcement that Linux 3.2 is EOL or will there be
another release which announces it as the last release of this stable
series? The kernel release page
https://www.kernel.org/category/releases.html lists it as EOL for this
month.

Charlemagne

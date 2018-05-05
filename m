Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1924002-1525531540-2-16470436308385103780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525531540; b=GwzJYeVTGmhT5N2/jgl1u8FUUz5RZ3L//aYOnKpoY+mRSSi1Vz
    0yYhr/5BJL+QGuGTSRZGXhk2ZK63WiUgT6LFl9VxswexI/CPFMt0QE1d/zP0cGN6
    rLeXHXby+SaeXTrm9aoyBamiJRzsHlsjqG+rBI0QfCgYb0CDQ1mYYzmMIKYWk9bS
    D0yYj74xmrx1kB9SUWonin4lu/pRyg39mxUOPshaEqlmvbfdvHHuB7xC5b72mezK
    0QDaJhW80EaiKnoWp+3gf5PO+e3yi5BhGzC08lGdvAiH6NBn/0Hk315O8jg3VOx7
    Iam4XGtcSfMt2HbH/rVU0dlPySoUbD4LKPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1525531540; bh=jYS47xnjR0JN
    Z4QtzBEuroedtO1F6UD3oYXByajos2Y=; b=U7Bgsj8f60stauCtivjYoN0yPx+D
    iC7gWP8EWzfq48GW8Dnd7XXYNRZ9ZoO8t6aN1JLmqxRfX/Rm285TRpgMtMQ+lara
    ZUoLSUzVtsbHGfDpr29endx66E/b1+mxcZlmELmfAfUu758KcWNVjftx6ri3209f
    ZLH9kzENHze+xJlSoR/p75wHcUYTAfGaNGLrfuIdn4LwGvQ4ZeH5g6ZvbPIKtUaC
    ToMZCjOGdLHkOZr+YwLxXFnWiSl+NEd0o33rDRRSBIhhl635iAsJWCqlbWdYbuiL
    LFzydFvx2Lii0DAwmivv41ZDcNcUivG0YLKWX0Nk0CmoNvSAd0fnTne4OQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=decadent.org.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=decadent.org.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO6gcoI/golaRVdN6NwnQOnSON5EliTSH2Oqh8l9j9Li3Rn3fbB4KiXA7x/oZvE8esBh8Gw81CVtIlA+PkX/0JyMpzVjkhBMQwxX3EFt4yglN2NWDQEp
    I7ZFkaebU/MiBF/pnbJmYzmaa/XGSUuXp/y/rmXyTAJEm4tY1uacQ2apFNWWEWx2FgxhaJK2LQSgab4LFXT0crm86jS3S1czy6XpwS5gQB8JcpfDVF2b5Qow
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=n5lKZTBSTmxQdFr_EUEA:9 a=QEXdDO2ut3YA:10
    a=Qn6xTRysOZEA:10 a=FoiGvTp0eMAA:10 a=pRQRx_yQ9a0A:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeEEOpf convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sat, 5 May 2018 10:45:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52427 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751183AbeEEOp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 5 May 2018 10:45:27 -0400
Date: Sat, 05 May 2018 15:45:16 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFGhKbxsNyZqpwJER9RXtpW1FsoNYMHg2nXDLHr9wQXUuMr=+g@mail.gmail.com>
References: <CAFGhKbxsNyZqpwJER9RXtpW1FsoNYMHg2nXDLHr9wQXUuMr=+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: EOL for the 3.2 kernel?
To: Charlemagne Lasse <charlemagnelasse@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
From: Ben Hutchings <ben@decadent.org.uk>
Message-ID: <4BE24D5A-C212-419C-AF82-B60DEEB4E0AB@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.120.74
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5 May 2018 08:20:35 BST, Charlemagne Lasse <charlemagnelasse@gmail.com> wrote:
>Hi,
>
>will there be an announcement that Linux 3.2 is EOL or will there be
>another release which announces it as the last release of this stable
>series? The kernel release page
>https://www.kernel.org/category/releases.html lists it as EOL for this
>month.

I intend to make at least one more release. I will say in the release announcement when it's the last one.

Ben.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

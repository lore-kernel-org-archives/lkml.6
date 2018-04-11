Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2881586-1523466394-2-2957687113828677278
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523466393; b=RH2sFU5jbccHUlNQRo6aTgDBCzRkt7TjQKZQXM9C3js9BWSAwZ
    zykUHAY0VYCSsQOohzMmBJzwUOXJcKs2PvKTWJKx09imex5atbax/eOxIAJX2A+7
    5rRsW4upJdyu9SeC2nmNZCaOTWJ8G4KI3kv73vZDoYE/uzvF/x6/QxhTPl+L9TdD
    4+t73dduHKat49BgLox1BX0L5VKLXEhf7R7X50bpurDpCH5ouXHh6JpMKFD+JbLA
    5s2vzF2Agg/Nrdnz2qJAM10HJmArpu3HQlSSIBgY8VxxH1XE71fgFwX1Zf8MHu9J
    qTT78+T26KMuMP65YNb9ox+RguQCLL+r20vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523466393; bh=KcSuApuMFI3rv995PtuXYfwmWVx08HiQfHBGo9p6SP
    8=; b=YoLLGz1khon7ZnIvda9Ao+i/ZeAhptGOcJIKqJV4ilo6m+vc07Wci16V5I
    rO+FUJrv7xAL04G7IbzhVAjXpsnVAYpi4Sj3t0lBHtl8fPsuVaoZ5Yi0xO2c3I/c
    amOD7a/O6Di3x61PpZqobyrUGOZ9UeqEV7UYiYu1aqekyXX82msDBSOzh+FxlzCY
    DoFpkorjf9NLMCvbCHkN/A/XbeGUSNPIHv2N+7J9vj97a5mkmvAtKUNH7A9H7y40
    QHs1ZFzWct4p03qLFsTyrS+O/YXxaXIinyWc6WccvfVhvchE3zR2R9VcOx7IAgM2
    GzGK2unSTKX9e2phKtBoGR7svVNg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=FbcBHRSV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KQocedWr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=FbcBHRSV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KQocedWr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTS0ExlQnfbdzaZQXGGUi7i+H1j0WqbdeAId1U602qhbgc9UzkThOCtWDP6icpDD6PywmR9wSlR2H+j55GhLp5GzIh/bLnz3+8Ca4N70p6WyPfr29Jx
    SkySE7qxIDPjop7mWO1YxQC3m5mb1fnU+R2vxcx4o4WR33eHeRaEqROurJO1/MKPcF3b44xMA59vaLWYE/X71ocWqKKaWDdskHwfVoftqixQZCI6Z1X+kYKs
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=h4fXbT4-m2PDPQcL7v8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeDKRGT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:06:19 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36797 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeDKRGS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 13:06:18 -0400
X-Google-Smtp-Source: AIpwx48FyqHD7OTjENhbStPA9DLWwPH+ra00KBRzSpNAsXaEF3r9qkkM06vMgT1vtpbzx4AH9uw4/LIGBDWDVyce098=
MIME-Version: 1.0
In-Reply-To: <152346389240.4030.11187964053014260180.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346389240.4030.11187964053014260180.stgit@warthog.procyon.org.uk>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Apr 2018 19:05:56 +0200
Message-ID: <CAG48ez2TN_fLgyiOZn5aTpKp9UTbJShO4iM=jHo3SJ7s6CW4Xg@mail.gmail.com>
Subject: Re: [PATCH 02/24] Add a SysRq option to lift kernel lockdown
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 6:24 PM, David Howells <dhowells@redhat.com> wrote:
> From: Kyle McMartin <kyle@redhat.com>
>
> Make an option to provide a sysrq key that will lift the kernel lockdown,
> thereby allowing the running kernel image to be accessed and modified.
>
> On x86 this is triggered with SysRq+x, but this key may not be available on
> all arches, so it is set by setting LOCKDOWN_LIFT_KEY in asm/setup.h.
> Since this macro must be defined in an arch to be able to use this facility
> for that arch, the Kconfig option is restricted to arches that support it.

In the current form, this is probably incompatible with USB/IP (which
Debian seems to be shipping as a module by default), right? And
perhaps also with dummy_hcd (if I understand correctly what it's
doing)?

Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1407584-1522887740-2-12694088948291808531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522887738; b=j5rhBMDxlxzq5nunSrmhu44g9Q5VxemF4wgBtXkng6IfOSK/mX
    XHavH2ypNjKaPWRYOczTG1KTMhXjM1zUs3jUM5pXCMAlm+oDeid5b0/oFAtM+k+O
    ZKQI93s5PioSK5uDgczCwyXBPtaXByeyUFXFbrxIOICSoYvO0kioEg3eIVBg5pKR
    RuWGR/4lcaExwxHO5cgjnVo//fDGTRkxErMrfUBUSQUjXuKVqYAdtzyLMhzwUUiw
    8lt2SazIZ+VMG75S+ZzRC/dBkE2Y+eKsPxNHlpqik9uSw+go0Rvy8rdsUgLYaV9M
    /UWuc3rjRMpLxNKnQUIglL82JFZEstM1sKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522887738; bh=EbRoydCmeZKkOH9tGmlWSoOjmdxbWZLsva0uuzTtfH
    g=; b=St9GLR9nJR1BHfQ0fnLRiAqUtt0FL/JdJLKv/ukhswn3+RRABpeSrq/A7H
    Z0ya/BOMXsIEXYGsjSBPHzq1wK0obsuXOFhIIuiJjQGKbTf5SySa45cU5S6sciXY
    VtVDW4UqCN7jzINMYQBLxT2MOA7i/F91mpWRjwQvrsGhzjRbFsUY4VUgKWQpIKyz
    lr35BSJATcYDpH1XxnoTPmgvb+vsIablXGfB7KNE7BvIymdV2ccvI2ECyJn52TSp
    QSNrYKD9s768eReLIFxkwWf0UrHtidojImfhO8Mo99Sq/e1wiGg2OOSUdqJSzzJ/
    rcAz2RNeHAbRAiNE48vNx+fE+Vxg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=mwuTlaog x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lvuWIfD+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=mwuTlaog x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lvuWIfD+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM4eigoeyC+0MO0MCEGVQIPgTtm2jw4VsBu+11J4S0RmB4fZM2Trm7O1r/mOMF4apItq6unJPgtsuhIJUZigiDn5uOMtCL3A4rYrIET4uFDOtZEDeKcb
    Jo3afXf0HktCOxPD0ZW/IX+2M4mnw4Z9lonHVF3Ztl3kxAEhpUgLMPYgk2D1a/SV9Nl9LIxi7xTOGKNkEHFc2rjoiuGmnaY95MOXaSH05FP77h1hn46cDwlL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8 a=a1mhgciwaYOnot9GbAAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeDEAWP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 20:22:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33443 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbeDEAWO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 20:22:14 -0400
X-Google-Smtp-Source: AIpwx49JKzuNdAQLkq40+HuHH0+0BGWUy4C4uNlmbnfPSqjzbiFoFFRrhWC2dufckr8JSFiH9oAgypQVOpEVGFqSxkw=
MIME-Version: 1.0
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
 <1119.1522858644@warthog.procyon.org.uk> <alpine.LRH.2.21.1804050918330.21060@namei.org>
In-Reply-To: <alpine.LRH.2.21.1804050918330.21060@namei.org>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 05 Apr 2018 00:22:02 +0000
Message-ID: <CACdnJusC7pvGhaRZBHAQqxc8MLHBeFUdZAddUO5DG2kFZMktMA@mail.gmail.com>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure boot)
To: jmorris@namei.org
Cc: David Howells <dhowells@redhat.com>, luto@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 4:25 PM James Morris <jmorris@namei.org> wrote:
> It's surely reasonable to allow an already secure-booted system to be
> debugged without needing to be rebooted.

alt-sysrq-x from a physical console will do that.

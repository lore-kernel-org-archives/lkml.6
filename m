Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2109832-1521045522-2-8743871000563987604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521045521; b=YIhfsgkH6EHdDox9HpBlV9rWc4mjlBhstI0vKZhd/MT+Fz6
    HF7YdvgH+HhJbIrquwzm+UUIjfyF5gIsQGKl6t3CFDhQcPmmwXPqMz34rFCZeqsK
    dJjYDc6A5nue1J1995Bedvc1cRuN1bpmb1C+mEbPZ7sb8pYUSzSzisQNIw6ZZ6XR
    qarCnXPCicg6ox4thUL/zMyPMCjbHPb1cAtOfa3JEQ1EeT2/h4n8OTV7pF28a6HH
    feaJdq+bx8azARsfmuuX8p8uGMBH55pbX2uMeXIdrJH8k1bwjWIyiUlhbVyHAr8F
    EsvJodS+jCN7ZaJMBeGZ0QAP1twOh14vRPncYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521045521; bh=d4XLf3T3m9AM8XtEA1YSXlr5eIpN+JjBMOn8nc
    V3AYA=; b=vjNmONh7Obmpkwqk9jXvvCZ9GIfOUn+P5uA8G/BVS3ba/UcGCygDx8
    T43TM0hOSbmDXBOnZgqaC9Hg+L9NZaSHtz+8ray/i7+UxO0CfEN0G7nMeU+p0+rI
    /AC7amMGk9LwMX79wwZaGc88HD5GFlBA06zRwo5/lMAN/hmmKAqksmi98HNfPFoG
    1dGUrXeyflJRawkDpuIAOSY9/9k5My+fiQ03hFHC8RWnD/rIvAN0FCCTqyfC2IzE
    FAZLj6tQ+/48/rC2KlUNOU+B9kTWxau+3mOqsI7FLPbzg/06uvDwv9kYjs9/UaKJ
    fkVRKxHDSIuFgX2fNcYQDm0Q4krwQT/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vJCwJQHi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XH5OxZRl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vJCwJQHi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XH5OxZRl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeCNQik (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 12:38:40 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41544 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCNQij (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 12:38:39 -0400
X-Google-Smtp-Source: AG47ELstNV6XI7qnV8DqC1E+hPDR4rjWTxina/HjBkmQZjaSHCy0m/4ktXB+fVbfsP40hUFpNwDp6T5JO7czmQ+Tst4=
MIME-Version: 1.0
In-Reply-To: <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com> <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 18:38:38 +0200
Message-ID: <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Aaron Durbin <adurbin@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 6:29 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Wed, Mar 14, 2018 at 4:54 AM Ricardo Ribalda Delgado <
> ricardo.ribalda@gmail.com> wrote:
>> On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org>
> wrote:

> In fact, the recommended way is to have firmware specify an ACPI SPCR table
> with OEMID="AMDCZ " (see https://patchwork.kernel.org/patch/10281307/) to
> configure proper access and address.

Hmm... I was thinking it's already there. And thus, this is just a
quirk for *existing* firmware that doesn't correctly configured
hardware.
(Yes, I'm aware about one nuance in SPCR specification I'm trying to
address via official ways)

>  With an SPCR table in place,  the
> kernel command line just becomes "earlycon", with no parameters.

SPCR *provides* an address of UART (required by specification).

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-940803-1522873160-3-6317368634420515045
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
    1522873160; b=OlfFicAcnL77HbYHS9LubzFWC+g1xrCBdPpH/WQQc1irmyM51w
    gwsZQNGt4IBLDUUa5dEQH3g/PxFOsncNISBqGZjO2Ew4Ht5Cl+A9gokj6/ZBOJRC
    YeFNr+tyBTK7FCUoV0wxK7KcBZPZ6FAYSjIJ0MrhCKCm59k0ZXLUwSB93NbZO2Co
    0mVGsd8RO9Wolnv7N0gdW2eSKXHrgGEI2ymaAvlhyvHgNsCKtIOp+woVc6qpRFZf
    moOIERkh4zIBE1tGj6x6ejGTN/NlBVM6R3Y+K8DRo0O/JPu6Pzso8eTkyvb0wFBC
    8LfWvP1k0YJoSRHRcOpV6LP2QvlPZNsMOjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522873160; bh=XukYlKFXQ7Ehlk0699AcCneqI9nnKi1P0ytvA/RfSJ
    w=; b=h+Pll2EIFdL1yH7MdnqQOcv+KG7R6dzWSUWsIQvyjL7vJ2Ir6bfgCfDUJc
    48CkVhtCBJmic1fGK1az/UDrE3Eu7Gtef6BezT0qEFpoQA7lsj5i+nFPsZV4KK4X
    gTcCdzEC9EH7CduQNcy3yhocrRIpa9UY23HrC22DgGQg1N+mKJTQvjoaKgeSNt86
    t94D5jpQgCtl64F3W5l5x3wb9uN8DB4vhebTm0jFxxs6uv6CnfATUUbg6ZLaPnlO
    1lz1FejCluB8sHy7K4/n0nQv6nwH9RPkWpXWXV38U1uL5MTxVYMKdp7wD1JFDQWo
    4tDS8dYCPmC+W1xSR8KUvfNi1mzQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=TYmo0aLa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HNkPVnDH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=TYmo0aLa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HNkPVnDH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFl2BvrSMEIwMoh0xunlIDfE6gJrAlNrY8t0oj9B2pvfTO0J/U6bj5rrcDJ+VGlCnAWKAzwiZqcRRpsDn1v0CFq9LEKH8rgf+HyjoaW0JNZscuc8CTnP
    /0xtd5mSJ6WpKxZvlRdiylHbCOIV0Mgdstss1eA28Iu1vVJr0Qzr3CzGOfVktmOtRTOyheN9VcCIDHoZZariEneH4DLR17qW/f1WFxzUIxGKwo3NToNkspsZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=9LHV0vVXN8Gm0gs0bnAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeDDUTS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 16:19:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56135 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbeDDUSv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 16:18:51 -0400
X-Google-Smtp-Source: AIpwx482fswXskf9khPepFgWOkb7XpiC26dfhdQIexso/LK5hVeEPA/L0+Da4Z93fOsMXJ390ooWQKrRTxRnjweNJB4=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <CACdnJuutJeeaaB2kwma0MMd9uDDbKavoHEk4koDLe1M6gYZWXQ@mail.gmail.com>
 <CALCETrVR_EcbKv5-4AR6Zm02XHhJQQGNDeO8FGkMbYozmuDTJw@mail.gmail.com>
 <20180404184255.exdrtpqnxlqme7tl@redhat.com> <alpine.DEB.2.21.1804042148480.1492@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1804042148480.1492@nanos.tec.linutronix.de>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 20:18:38 +0000
Message-ID: <CACdnJuunSCaOHKuwDXkzV8N8V-EeaoBhfg+EkL9VPvX7Dkycdg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: tglx@linutronix.de
Cc: pjones@redhat.com, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Wed, Apr 4, 2018 at 1:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Now where the disagreement lies is the way how the uid/ring0 aspect is
tied
> to secure boot, which makes it impossible to be useful independent of
> Secure Boot.

It doesn't - you can pass a command line parameter that enables it, or your
bootloader can set the bootparams flag. I don't see a fundamental problem
with offering the opportunity to change it at runtime, other than that some
stuff that was previously initialised may have to be torn down. The reason
for having the UEFI boot stub *optionally* check the secure boot state
itself and make a policy decision (rather than having the signed bootloader
do so) is because the kernel can be launched directly by the firmware.

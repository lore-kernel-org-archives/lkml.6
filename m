Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-587055-1519318160-2-581230608804059445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519318157; b=vEC4k+goZ213I/QVLnsXnqKXpmLl80e7Cx05np5umMthJFM
    S4RqNtBKt/BjrcP65mlyN6K2eP0nBOZWOif+qPkknImdgdYUWKgPqnz0HWKURdSs
    kreOSqn63rYLctXC4h+cbj1nnpkwy3LVHY6kNRfxCjI4zUQEhbzmv49h3LM+9aDx
    zLF4o5X2JVbnzYrJb3ySvf6e2R8v8/ajFNqH6yKsvOln1q3QEIvUO5Rc4la4NHOH
    0690W/hx/KbYoIpHKZkiI2J8Wf3mJLtlyqxQ9kTF5nVuPoLV6RVfVJCoSYGiei2+
    kZwDibbn09huKMomCNODCh1zYz0R5WlJnMbczkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519318157; bh=WREFzS1NmUOTUBTM4evLtEk8ny+tWbuz8yeIXB
    pFIDg=; b=h9QHsjNNIAR5jqUb9gcfJXJsMWasszhHAVBz+W7i84lDc/yggTc90I
    J37SsLIddLVOuxURUKxWleiKLGFkLasVNOGe0Ob0NPPMo/12fIc8LMKSPBq3iCo7
    boMGxyizyFodehBK+dgQPetx+rSisDvuLMzpYZBp/Q2bsm/pUdxImDTK+zzR9g3D
    XdycpQzJfTyPt/OR9VOAMCzG0yP12fLAUPvEBRXcQzDnp70ZEBp5I72pB9jS/37+
    nTdKQyyv8fEu0rAjfpNYG+Ju8X0RHBv6jZZqS4SlkaNdQW5iwA+/+M24gKJawzTx
    LM8Q7ClBkjKfEQ0OkFsOK40pIuuY1lTA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=efIV2L47 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i1CSlRyG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=efIV2L47 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i1CSlRyG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933281AbeBVQtQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:49:16 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40830 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933219AbeBVQtP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 11:49:15 -0500
X-Google-Smtp-Source: AH8x224KSlpzGqRhrQAr7Ym3zwnKH8ut4YZJbxk0vItSsgiECDhF6iiUI2eVK4GjtTv59ulAN2BbYxUVBaMQ0e7HMSU=
MIME-Version: 1.0
In-Reply-To: <20180222133043.GC23008@lunn.ch>
References: <20180221121856.3241260-1-arnd@arndb.de> <20180222133043.GC23008@lunn.ch>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:49:14 +0100
X-Google-Sender-Auth: cGiB_rCjsehNM3yiqosCEnF_N30
Message-ID: <CAK8P3a1tkeyLN1qg1yFMXbBgRvsT3xELrdbFbMd1EmOW5tGmQg@mail.gmail.com>
Subject: Re: [PATCH] ARM: orion: fix orion_ge00_switch_board_info initialization
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 2:30 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Feb 21, 2018 at 01:18:49PM +0100, Arnd Bergmann wrote:
>> A section type mismatch warning shows up when building with LTO,
>> since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
>> const itself:
>>
>> include/linux/of.h: In function 'spear_setup_of_timer':
>> arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
>>  static const struct of_device_id timer_of_match[] __initconst = {
>>                                   ^
>> arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
>>  static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
>>                                 ^
>>
>> As pointed out by Andrew Lunn, it should in fact be 'const' but not
>> '__initconst' because the string is never copied but may be accessed
>> after the init sections are freed. To fix that, I get rid of the
>> extra symbol and rewrite the initialization in a simpler way that
>> assigns both the bus_id and modalias statically.
>>
>> I spotted another theoretical bug in the same place, where d->netdev[i]
>> may be an out of bounds access, this can be fixed by moving the device
>> assignment into the loop.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks, applied into fixes branch with your Reviewed-by tag now.

        Arnd

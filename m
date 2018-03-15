Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4072363-1521107833-2-111866308526161641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  SUSPICIOUS_RECIPS 2.51, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521107833; b=ngbyRv2re/6WRJZs0ZfzBp1v6Of0OIEsrd6scBHvUV11xj/
    AgOgI+mYO/KbhkA98jVbiNqSMCZ3L65x+2Cg4d2X0pR9HArZJHeozZI+qhmlZnHN
    TofvQBWCRWRu4b75sNRUz5v+ULe4pYDMTzy3wp70ReygUQAJD92bGrzgsiZOXxSW
    /lFGF97NkuYngBuZzxA2xgDDr+HL0lNu6YTaI8qPS78RafboGlKjF5d/I/MjO19x
    ht+LYgKR1hEU5HFrboNe6uR85qxoBznaRQECSnhAijhHbyqh+KicEdeT0pK6dF/d
    4CMIKmxsAYFA0/xORf8pLFMpuXfCWVKs0kfg1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521107833; bh=P/V53y+6m76GkHKweUjhIXnH5ZhI2+4ga3gY8S
    j/TWI=; b=N4IaovLU9GYDdPkXBgQTjFx5M3ZyysNYu/bhxKcNhYbzDVo2cYE/l/
    T1y12cm2LV7j2dEHQ8s0BI7Fy19y4l7AfD+aWRtSXaEJlDGv1fcS4Iz0XrjaOVDQ
    82B9iiY1ppKnmRNxCkoyNXWMDphLLSpnrLhKAExTNpEFmSdedUMaKwnF/N+4tGz5
    B/51tYQWG4fmUkL/oHrSRokSMEGAYphwKJdeQ0OszDaanj7bT/R0NYPVicGHAAcp
    zbJYULgqrBSCPZ1kDvro5k3XrhD6BvnAucvAo41Zue+vmhZpSTUcLOjw0puVcLWV
    auYRuCuUxe2PEyU/RuyvLFWrPVZnPi+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J/biB/E+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GfeTDuja;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J/biB/E+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GfeTDuja;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCOJ5A (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 05:57:00 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39262 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeCOJ4v (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 05:56:51 -0400
X-Google-Smtp-Source: AG47ELswYjAhiXg34Sb9tuRXoGn63tbMLVg8B5NYNvABxn25n8f3RUHd9c+29rzSwT5/1ttPND6moobWZ1l1mWZbaVU=
MIME-Version: 1.0
In-Reply-To: <2929.1521106970@warthog.procyon.org.uk>
References: <20180314143529.1456168-1-arnd@arndb.de> <2929.1521106970@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 10:56:48 +0100
X-Google-Sender-Auth: X_UtdCeig7hSjC-Q8-nfY85dSAI
Message-ID: <CAK8P3a10hBz7QYk5v5MfhVMPOwFnWYTn95WZp1HtHrd7-GQpRg@mail.gmail.com>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
To: David Howells <dhowells@redhat.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>, linux-usb@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 10:42 AM, David Howells <dhowells@redhat.com> wrote:
> Do we have anything left that still implements NOMMU?

Yes, plenty. I was wondering the same thing, but it seems that the architectures
we remove are almost completely representative of what we support overall,
except that they are all not licensed to 3rd parties, unlike many of the ones we
keep.

I've made an overview of the remaining architectures for my own reference[1].
The remaining NOMMU architectures are:

- arch/arm has ARMv7-M (Cortex-M microcontroller), which is actually
gaining traction
- arch/sh has an open-source J2 core that was added not that long ago,
it seems to
  be the only SH compatible core that anyone is working on.
- arch/microblaze supports both MMU/NOMMU modes (most use an MMU)
- arch/m68k supports several NOMMU targets, both the coldfire SoCs and the
  classic processors
- c6x has no MMU

       Arnd

[1] https://docs.google.com/spreadsheets/d/1QxMvW5jpVG2jb4RM9CQQl27-wVpNYOa-_3K2RVKifb0

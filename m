Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4072363-1521107335-2-13456062727678577677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521107335; b=ubY1Pw+uEE8wG6ChDRch0o8L4TvVNJhQx4HtCCM4khRwqZ0
    RfqgEaa9+4QZ0AsTuGCls4nxvL1UPpOvckj+dsT6QztyeJMYOCiK3FRSvtExBBuN
    QeZjI14YSuSB5THeAnQ/aeFhlJJ0WiSfU6UJKcqOTnXp76XyLfsUgn7reRte/Lrw
    KKab6KyIVWsy/b4XQqOSYUy0oajPjErq4ss2kgrF16WHDyasJtJRmMGIPYhu31hz
    fWuHhbQFww29Yw+0r7x4YNgAkwVUVvstB7khF6JVht5x+cU2Et9fVRdW2trEZn4E
    nK41yUGLkH3jhRiH7aeGl0RNPOeqU8u3Csf/DBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521107335; bh=iPuqB5ZhaTklPSdYNzR9N0VzpTnTVAfckGu8LW
    v390w=; b=bXSUuNtFDPv9LFRaLYp6SR8zVio+HD3tAl80TvG6UvBJkv0RkegT46
    z2fJOQGCHXi67MFm53CSfrs4JGlqebVTxXIPZI8bdhVzvzUsW5hpQyegcOwx6ZmN
    L4EN1jO5SvQBx2rFDWe6SVqFW4TdJB5UohQsfh1WztEefe9OE0kio3jFCnCe689D
    Xd6vWWlxo70IboXZkq/xjVbC7g9sfL9LGjH2UEWLbV3FRzPKSA6lwLkKAmhNPBPR
    eYPlBRI9nQXVAQtL+w4fqeSslTQyXEmhHabQYPKUkduNtuoPpSI5u2c/PeyCz9rf
    7/ui1EVTul88Vx6UgzzNvi5rFG/zAwkA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F/O7PeLd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PONKmPbS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=F/O7PeLd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PONKmPbS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCOJsp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 05:48:45 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43330 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeCOJsh (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 05:48:37 -0400
X-Google-Smtp-Source: AG47ELv+hkVRhj+NMNBXRSc35dUOaBjhslYXYvHRFsKoGslcM1rZAR4szPmPstC4LhAsN3DtR4FNCeAYGbasA/zDn/8=
MIME-Version: 1.0
In-Reply-To: <2929.1521106970@warthog.procyon.org.uk>
References: <20180314143529.1456168-1-arnd@arndb.de> <2929.1521106970@warthog.procyon.org.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Mar 2018 10:48:35 +0100
X-Google-Sender-Auth: wfkVA4yjUUZDS8md0ats96AbnyQ
Message-ID: <CAMuHMdXcxuzCOnFCNm4NXDv-wfYJDO5GQpB_ECu7j=2BjMhNpA@mail.gmail.com>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi David,

On Thu, Mar 15, 2018 at 10:42 AM, David Howells <dhowells@redhat.com> wrote:
> Do we have anything left that still implements NOMMU?

Sure: arm, c6x, m68k, microblaze, and  sh.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2970050-1519654473-5-10187150807869986961
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
    t=1519654473; b=LuQM9MI7RRvNhXCYCqc3GykkJYG2Xjtci9SWP79JY39uehv
    c0uPEPppbnXfFgj1EgG20D67cZXMfUVpUQ2+FQ7V4hZZI/3tBZPb7DVS193YHACy
    xV7+pv2zTnaraZ5EVa0/83IJCoxewjm71u9ayrzltoUVLT/f7Yy2Vt6xaMrYULgo
    MLy2vQlDr84QDoRLWgOBggmKeoQGE2GVrFNGGI4vUkpwiNls5COAhfolaIgNYp7W
    VnHtgZczxuTPQSI5YS6kN+ZMkJVtcmtLoVkRHYzFc/j4GedH2XMFgK/FiOhGwND3
    1gKt/gJsbHLXnJZwOLnzSyOz4Morscfa3QFns9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519654473; bh=bK3/r1601mTdru1jOUQtcoZMebAchfcjWwrovL
    rJrzk=; b=hkG1n3qGrfvW//Gc9CjTL5LzkivjnOtHVnq1HxVEm8bOADYcciB099
    l8BNPTPw/FmyfM23A4D6MmVdICQ8dRfX0aDx8c22aBsqmKzYkr64KaqWzJjKZcZ6
    ceZ8rTh7GP3KARqBHm7ET7ZqqGV722QerQsGYjxz+Jjl2LV87s3mS+MT8px20qW7
    +LFAkO4MrZ2l+T1Vu/xgAq9EWrsVSE5BAOdqzCfO1Xpb4Ljr6ArcQqlkMxyXGDwl
    d9TGBJcIzTsIciEdLTSboH8jgluvnwYl8RBl1mBxLAH7tMDQttS3T1Ok2dTGuLSG
    JRsAa2pevQNxkXSkCCZoD74E4cJzTkQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aXY0nrY8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZMpITxdh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aXY0nrY8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZMpITxdh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeBZOMy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 09:12:54 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46967 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbeBZOLD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 09:11:03 -0500
X-Google-Smtp-Source: AG47ELujoBl6erBEHclzvumNE+6CLHktmF9kZV8VRVKGYykxjKRYeew3dZNt5WAtyFH9FGV4YFz6U5ELAGE7niSUEIY=
MIME-Version: 1.0
In-Reply-To: <20180226032227.14615-3-jerry.hoemann@hpe.com>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com> <20180226032227.14615-3-jerry.hoemann@hpe.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Feb 2018 15:11:01 +0100
X-Google-Sender-Auth: tQbWS-F_QJM5lqPBdMmxSq3bmX0
Message-ID: <CAK8P3a1A5d52g-3Wgs1xP3P=dT6K0RVjmamfqAi9vE5TT=mo3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] watchdog/hpwdt: Remove legacy NMI sourcing.
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Ingo Molnar <mingo@kernel.org>, marcus.folkesson@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 4:22 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> Gen8 and prior Proliant systems supported the "CRU" interface
> to firmware.  This interfaces allows linux to "call back" into firmware
> to source the cause of an NMI.  This feature isn't fully utilized
> as the actual source of the NMI isn't printed, the driver only
> indicates that the source couldn't be determined when the call
> fails.
>
> With the advent of Gen9, iCRU replaces the CRU. The call back
> feature is no longer available in firmware.  To be compatible and
> not attempt to call back into firmware on system not supporting CRU,
> the SMBIOS table is consulted to determine if it is safe to
> make the call back or not.
>
> This results in about half of the driver code being devoted
> to either making CRU calls or determing if it is safe to make
> CRU calls.  As noted, the driver isn't really using the results of
> the CRU calls.
>
> Furthermore, as a consequence of the Spectre security issue, the
> BIOS/EFI calls are being wrapped into Spectre-disabling section.
> Removing the call back in hpwdt_pretimeout assists in this effort.
>
> As the CRU sourcing of the NMI isn't required for handling the
> NMI and there are security concerns with making the call back, remove
> the legacy (pre Gen9) NMI sourcing and the DMI code to determine if
> the system had the CRU interface.
>
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

This avoids a warning in mainline kernels, so that's great:

drivers/watchdog/hpwdt.o: warning: objtool: .text+0x24: indirect call
found in RETPOLINE build

I wonder what we do about stable kernels. Are both this patch and the patch
that added the objtool warning message candidates for backports to
stable kernels?

       Arnd

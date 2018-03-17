Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937799-1521271960-3-15877025261107409378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521271959; b=oiwXvdhZqrVjz2gyJB/dmP8dGv4uT3h+XJT0BD/GaXvmxSy
    C2KQm3YPL6AKqnpWeFhPkXr//ulro+mU/1aBLGEPK9YOFazK17CXHSIrmG1AmwF5
    kHDw6WwAJ4RTsVn83fR6nwuiWHtFfbowTh8VWF9K8NWlWMbGNYi+DpQaXmV9SdEe
    2lMatak92312KTDW9bSOeCAbnizIZL6f2+B27z0sL6cUp6EvlP5yksUtVZH8fNbc
    41Ip23RD1j69arnz2CVptDf17b5z5HOAspWrtNcv0uoXbWzPQOcWd42Fu9jqKt3R
    HGHZyxzlXgOwVzvjhfc3aMOmi0N53RfNaC/615Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521271959; bh=0Wekq0QGJVKwxicuL4Udt55F8+
    lOMfwAZxM1Yg9lZCA=; b=FUT0u0/AKtQdNUPY/EIeJQNXRGOjjYUCUk5KtpyUMo
    D01KZV2k2XyyNkVQvmhu8toMsQBPtlKJ1qxIefUxHtMjqtgkP6hsNvGe/KGZM7e8
    FajWVlSTwawyNxXHkwoos1bXAPpyX/Xe+jeMVoZP73yPBthncAd4TgJGt34lLTTI
    7olKpb8NMFEX3OtqQe5kJD1xhIbsZf5gwS+TnkuI/Ces2B7RtTA6ICw7Eje8SkUt
    ftlnykvspUM0RYEITNjyJddUkZqXPfnbrqevnd9EtyqQ7cIyJfa6mbFxqDQmxEEF
    EGk3o63jI52hlgkQAbXDZRM3PftSNiGEzfAMc4pmDZ8g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N91ZNGi4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Bq8ebQmV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N91ZNGi4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Bq8ebQmV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeCQHch (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 03:32:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51128 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeCQHcg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 03:32:36 -0400
X-Google-Smtp-Source: AG47ELuh9FJsHfD2/lV14ujJeUjk6ipftkV2xUYg7hn/aFnC0+PI9rc0VmCaf1DCfVldnB4e8f4uqQ==
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz,
        jacek.anaszewski@gmail.com
Subject: [PATCH 4.9 0/2] Clear LED_BLINK_SW flag in led_blink_set()
Date: Sat, 17 Mar 2018 08:31:00 +0100
Message-Id: <1521271862-4599-1-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The fix for brightness setting when setting delay_off=0 introduces
a regression and has truncated commit message. Revert that patch
and apply the one-line change required to fix the original issue
in the way appropriate for the 4.9 code base.

Thanks,
Jacek Anaszewski

Jacek Anaszewski (2):
  Revert "led: core: Fix brightness setting when setting delay_off=0"
  led: core: Clear LED_BLINK_SW flag in led_blink_set()

 drivers/leds/led-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.1.4

Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-247771-1521118491-2-5192183491561707891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  SUSPICIOUS_RECIPS 2.51, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521118491; b=Rmb1p500Xr6+0TW8ziKlE3R6CMq/Mk6cztjTXORcMRK8v1T
    6W7nF7omvSNvtYTQ1fflw2xH+JyshcBEmpB3Mi8nmeVM4t94kWUuqVQ2QJfKF7fa
    IVsoFrI4XKNu+TqVzeZ59BM67NmF8wZPy+eBl6iMUksoUW1b/EcYWDGEzQ6OKv3i
    ZZPjaO5wH39gCdaP5zznTpI8+vPauQ7Ic4rERFf1XJt5v1hyMqi43t/TMNvolUZo
    uDLrxu4u+GyQ4jtHRVUJ49MkTtjVaJOqPQpheZLVMAVu8TIami1noSkpcVSJEb0x
    sK/LaKESuVzM1i90uNsAiMU1Z7yGYZUyfegxcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1521118491; bh=WTl3P1YM5chOXuxT/c3JgzDaNJ
    rYRlUg7qrzYL+Zcwo=; b=vKjcF75XEdxR7fXn/F2hBLzY2ISo9Xx/TS7F+Cg+O5
    GnaAqfn7YjiEgRN5GbcevPaCQ5q0d2kv/MOu49GZmzrPedfIlRYSHTCOHn8T6iqt
    bEW9iNIPnXp+0075KdFXQPBzce+Pid3/jVWbFWWUqpnfkt5W7JihEN3ls921F25+
    MIXBc43Dbo0e9do5X+c2cqv7v/+6OqQRQTtTnDZxbABhSsdlWb0hECJJlvCEdrqX
    3Y5JnJsIYxuGuafdae9kAxsbWESI8b7DrKFEe/t3qfxvGcJazCUbyLPuoZjKfMMh
    i2Lr2QZR91764QiT3BcC2BeGG611vpRBYi+z+ZL/UQvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=AmXiEev2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=AmXiEev2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=AmXiEev2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=AmXiEev2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeCOMyU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 08:54:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38962 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeCOMyQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 08:54:16 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.3 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,SUSPICIOUS_RECIPS,T_DKIM_INVALID autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC74A600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 11/16] treewide: simplify Kconfig dependencies for removed archs
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
Date: Thu, 15 Mar 2018 14:54:07 +0200
In-Reply-To: <20180314144614.1632190-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 14 Mar 2018 15:43:46 +0100")
Message-ID: <873711zehc.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> A lot of Kconfig symbols have architecture specific dependencies.
> In those cases that depend on architectures we have already removed,
> they can be omitted.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

>  drivers/net/wireless/cisco/Kconfig   |  2 +-

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo

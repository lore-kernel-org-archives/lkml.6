Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1457237-1521024863-5-9347693065534068876
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
    t=1521024863; b=nUnbc2ZRd4hiKlfcli/olui0eRss5cGz+7JB/xK3KwsW/YZ
    r0Ohp59MxwhQ2oFxmytvXaQbj/u3FbfM16XbFB8KYkS3tGZuQ6aNx2fUfWwcUCJ2
    MXSRTiO0GVmFphd0BzwgSsQaWfkPrHv7Jl/0Wz3YIlfaA2LvG8Eplji6PYfHvELt
    LrV+E6M9IrVZpRAtcmOVSVewSxbWj49VYWdDUkw1c14jAcVapiumJAKdm96/EEk9
    rNLfUv/WVVbK/A7brLE7SdtpfiflY1tdyQNf023QvOdjmDwxLZr27U66kPRRR+MA
    hlZMp2dE1tRT4z1XNUDpiDqVoLBNAAMZxYJdgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521024863; bh=XllBdtBCvPjiSM9UbnMKo6zu9sm3Nl8avcgWzJ
    tdP2c=; b=cE3aaqKr9KvWtpvDBNTbxh1UYA3cCKqFTe2nuNrnQM4MvYBRJ0+LCd
    b7JC6+wlD2Qm7AToV7NL7r9aDMrKkF3dKnFjCK/dPjwLZx61BDKYHdvgtDBRuScY
    SLQhFCpicnBNrHbh08JuSnpOBdeSL8McaQZHzFUHXL+UdflxSr482cqAnosw38c5
    jdLpWlJ94a/9a5uMEmQCgTn1825rwT2rVwBn9ZVqObDl7kStSYHXjzeN5J7zIyBS
    Jv2VNDwryS/xa/9H1xdtAB0YWyXYB068EaZ4jxjJDhE0300A94Fr//pvZsuOLKJ3
    lPtwMkrvm80CgeLoeeVSKVTUasj8polQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LBjOekwX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NwNiNwBD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LBjOekwX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NwNiNwBD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750931AbeCNKyI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 06:54:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43032 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeCNKyF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 06:54:05 -0400
X-Google-Smtp-Source: AG47ELsSZC8z5pjBUBtS0TIpwa7Zqjd+hwRJtcJqkMZqCpnn5wBqdktfSOpWuGxMYPTueV8tfcuoFFuLLpO58k9l9Xo=
MIME-Version: 1.0
In-Reply-To: <20180314003655.12141-2-djkurtz@chromium.org>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 14 Mar 2018 11:53:43 +0100
Message-ID: <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel


On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
> input clock.
>
> Allow these platforms to set up this clock by specifying a kernel command
> line like:
> earlycon=amdcz,mmio32,0xfedc6000,115200


If the port and the mode (mmio32) is always fixed, couldn't we just
add those two into
early_amdcz_setup?


Thanks!

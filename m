Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-255570-1520465427-2-14409220577277648774
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520465426; b=TOYo2sJK4E1jPH+ofdvYWBMzh640sJWYV1kyuRYXJrZbdDE
    R+Im3P3g25cOHVHytY4oyUpmpD04035alVSJimbqD1pc9NEsi/k/emZhRx4LrfMQ
    NoZNFdl6xbVPNONsA1P/pGWhV+alRNx8R2zgCejYXJ16ez4Jwlm9On3FbnXzLjvh
    dt0MKk8/O9MPtD8tm/m4fbYVViBgVRoAQGCdBl8yuMn7fAxPpz902XU3z/BWZl94
    JWC6+4ej9zFEnMFFYBAKBH2/+Cnk6T39KO5kDPc4LfM9kUgVqA9jMdx7WJRNVWnX
    o1MYmas6+QHxUEbB8kLpKp1SHAKKMTM5cZXdokg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520465426; bh=D0POCinOWRsQQfAk0prVvrPzwMvW8wwMLDYSAL
    Sn+iE=; b=F9F/hyC7ZtewTqhkFmZgPb4SOGiJr2NTs/3yUF4zVl0kOlS3nR+Cd/
    c0YfZCbjeNjdiO5zbYtxqi9DU6v2J4VpLqC7RFfbuySf3LFnksSxqMdP9HHqZq7K
    JKvG9Ki3GvAfzY7arGJJipJT8/1QvPpMz1Ona2iJ6DZoiuZkV4YjGwcHUHpopkdI
    M2ieHyBeE+06S2jYeeK93dIOHlio5ESlGV769gNVa1Y6a1OYuSbRS0b2s/ElCkCt
    1I9sFERj5xW2z7dKEOsnLzNWpLc9EP7RSweA7hR6n6GSSDKSZ60tTfZQ6tY6ciVP
    wboo8rZo2bWT+Q3UPlmAxCXTUsi7WIGg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ResTCU+Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZwVsdIyt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=ResTCU+Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZwVsdIyt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934149AbeCGXaZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 18:30:25 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39551 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGXaY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 18:30:24 -0500
X-Google-Smtp-Source: AG47ELuTQdEeMEakjGeJm9h38RssXw0JbQWZLwXD8QoG+UoMWkUVUY7KJYn6J4cSZvmH5gMtWHRKyKzeCrwztPrwXkM=
MIME-Version: 1.0
References: <20180301184335.248378-1-djkurtz@chromium.org>
In-Reply-To: <20180301184335.248378-1-djkurtz@chromium.org>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Wed, 07 Mar 2018 23:30:11 +0000
Message-ID: <CAGS+omCr2YUcAmv9068kR1s4LOqCGij_ps3+9tQ92whVWvGBxg@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        marc.zyngier@arm.com, frederic@kernel.org, dwmw@amazon.co.uk,
        tom.saeger@oracle.com, zohar@linux.vnet.ibm.com,
        alexander.levin@verizon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 11:43 AM Daniel Kurtz <djkurtz@chromium.org> wrote:

> Currently when an earlycon is registered, the uartclk is assumed to be
> BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
> options, then 8250_early's init_port will program the UART clock divider
> registers based on this assumed uartclk.

> However, not all uarts have a UART clock of 1843200.  For example, the
> 8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
> cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
> on such a device will result in incorrect divider values and a wrong UART
> clock.

> Fix this by extending the earlycon options parameter to allow
specification
> of a uartclk, like so:

>   earlycon=uart,mmio32,0xfedc6000,115200,48000000

> If none is specified, fall-back to prior behavior - 1843200.

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

This general approach is facing resistance, so trying another more targeted
approach to work around the "BASE_BAUD=115200" assumption in arch/x86:

https://patchwork.kernel.org/patch/10265587/

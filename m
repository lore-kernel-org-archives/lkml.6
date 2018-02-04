Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2332106-1517708826-5-6178516572146862403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517708826; b=CxAMmMPRoMi1N5lPSiItE6U+YYJMDv+uT2jX5Met62sE1GV
    RPwo8S9jupk24iQo3SQ5CbrFWVI9BkxbLZnsGHnCaM8OV3mIL+78l4gBl7jVV85I
    QDoACSgEi/dv4jZBH0zNul0s/RVMhTPkFC8g5EkvwsG6PClGRjMfw1TxCHHvuIJh
    /96v/uPWRhk0NQXWCDB0zKIlLaZjVJnZHZQp23Re563KgZXP2jJgx5PTYW6DZDHe
    6wkzfrJqsAQiDkD9cQaNzSbJ8n8mXJ6dFo6zg7DaiECCM0fQEX+DY05nxbyHjPbX
    vOxcqhvBjAuWhUZz/lJTVCgOeCNU39V/zUM7xGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517708826; bh=FByVgZt
    tahWw6X7G438p/Lc0y+lNx1WNN3JQJJczvGs=; b=UKXhPl2NT/IWjxdy8e6vzxQ
    M3zxfrL+ZRaOfBbKLx2y8/Fekza41bkxgbFPjFB9brdXm8NlC0/YN1Jelw0KlQA3
    yNTf+Z6nkQAgo11L7M2m2RbmK65BLX20SYAsRv/sN0CQ1YCxXDMymlrO70S+fZoK
    dlAR5+foJoGj1XpyulMDQwj5rIZKMVwS5P2v74vI9mORSvFFjIHvTor+fBHPkB/u
    wSzFbTTGzv0Cugod+uBbz7QB6HlPfLTjlopgzTyK/BMoLVRRqREeFQ2zkw3Ux7NG
    13SZonPJgfMaTPOz47TqrTOlRN0qd2m8sqOdOJtG+B82Ccj6SW+MsJtOgEWg33Q=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CIKvcwsP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sfHaEU4p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CIKvcwsP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sfHaEU4p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeBDBq6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 20:46:58 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37988 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbeBDBq5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 3 Feb 2018 20:46:57 -0500
X-Google-Smtp-Source: AH8x227uNjh/A6JgekERhtcQMB4lhhuycp0gLRo3EbHkbIcxzQ5L7Mb95cAPRHbvzJV/joQuuY6KaQ==
X-Google-Original-Sender: <johan@kernel.org>
Date: Sun, 4 Feb 2018 12:46:06 +1100
From: Johan Hovold <johan@kernel.org>
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH 3/5] USB: serial: f81232: enable remote wakeup via RX/RI
 pin
Message-ID: <20180204014606.GB28684@localhost>
References: <1516607927-8887-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1516607927-8887-3-git-send-email-hpeter+linux_kernel@gmail.com>
 <20180130035747.GB3434@localhost>
 <e89b06fc-2daa-dae6-34d5-3eedb5b244b8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e89b06fc-2daa-dae6-34d5-3eedb5b244b8@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 11:13:01AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi Johan,
> 
> Johan Hovold 於 2018/1/30 上午 11:57 寫道:
> > On Mon, Jan 22, 2018 at 03:58:45PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> >> The F81232 can do remote wakeup via RX/RI pin with pulse.
> >> This patch will use device_set_wakeup_enable to enable this
> >> feature.
> > 
> > This is a policy decision that should be made by user space by setting
> > the power/wakeup attribute, and not something that something that
> > drivers should enable directly themselves.
> > 
> > Perhaps you really wanted to use device_set_wakeup_capable()? But then
> > you also need to honour the current setting in suspend() as well.
> > 
> > How have you tested this feature?
> > 
> 
> Our USB-To-Serial support RI/ RX remote wakeup by Modem, Fax or
> other peripherals and we had tested it by following procedure with
> device_set_wakeup_enable() enabled:
>      1. Using pm-suspend to S3
>      2. Trigger a pulse to RI/RX to wake up system.
> 
> In our test, we can do remote wakeup only with
> device_set_wakeup_enable() enabled.

Yeah, but you need to enable it though sysfs. Not every device should be
able to wake the system up. That's a decision left for user space.

> Should we add device_set_wakeup_capable() & device_set_wakeup_enable()
> like following link??
> https://elixir.free-electrons.com/linux/latest/source/drivers/media/rc/mceusb.c#L1476

No, your driver should not call device_set_wakeup_enable() itself. Just
set the wakeup capable flag in probe. And if you can disable the wake up
feature, this needs to be done at suspend depending on what user space
has requested.

Johan

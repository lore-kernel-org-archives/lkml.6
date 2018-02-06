Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1871329-1517942865-2-8024040931433779208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517942864; b=RLaR8m/K83zlpU9hU7H058RSljMSKVXq/2HzgyiX4XDmdmh
    aFTu+5E0c1MVT5iS9LVuNbMEooEoTc96TroWQA4P9fwcQwJlhsbTd7qz9SR4uCuk
    XXI8ja0NHOPSlnjxWD+k5zq7lvJ21noBK1Oo+AvLfPApcemWSKWpvNHNG0m1iauK
    KLtnYBP/HqrSz8XQ+I/DVvhOEfhGf4uDmymCeZ1JCc7PkkmlYcm30w2KSOjf5/Ke
    mV1FCb36pEBKB41qCkNA14nefxOi3ADjSVgy9WgkvDXstJjpEbW/gh3il38UfNwX
    Rp5/80QX/5cFVsV7qZwSliaI06plkXr1qc2Xvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517942864; bh=4zpmrPtsjlCPdfrEzITdF2d2g0
    WE3JJyZu3Ebvncobc=; b=kpmaUBOCUaC9kpFARzneJ3ay7/g6tL/dafxoML4kJe
    L88vSvLoR93sKzqfKMRxG5F70Mf5/ICS5OQLZUYnt7k/Ba9OGxmnGC4GGJNzZs/j
    Zr18ANjNVF0g2eDBx4m3ES3jefW5fsaPc9AFKjB5o4HEzZHzTl4Biih42hxMOvE9
    0E+63YC3ifQH8QEkX/uRYRyctOerQ1vcucCux8bige0mo/wxyZOVRcUfWFJZnT06
    3D21YSfluWt2oTNGyX1kM1j33PBkzuh7Yw3ZOz0b8O6GdTGn8abXpI1p5OwPmAH9
    0X8erAlzLC0Olp3qzah2hTQhXdEeDvWbWRSMmvbh8Q9Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeBFSrb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 13:47:31 -0500
Received: from muru.com ([72.249.23.125]:56182 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbeBFSr3 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 6 Feb 2018 13:47:29 -0500
Date: Tue, 6 Feb 2018 10:47:25 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, linux-omap@vger.kernel.org
Subject: Re: [PATCH] usb: musb: fix enumeration after resume
Message-ID: <20180206184725.GD21573@atomide.com>
References: <20180127083403.928-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127083403.928-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Andreas Kemnade <andreas@kemnade.info> [180127 08:34]:
> On dm3730 there are enumeration problems after resume.
> Investigation led to the cause that the MUSB_POWER_SOFTCONN
> bit is not set. If it was set before suspend (because it
> was enabled via musb_pullup()), it is set in
> musb_restore_context() so the pullup is enabled. But then
> musb_start() is called which overwrites MUSB_POWER and
> therefore disables MUSB_POWER_SOFTCONN, so no pullup is
> enabled and the device is not enumerated.

I just gave this patch a quick try and things seem to behave
for me from PM point of view:

Tested-by: Tony Lindgren <tony@atomide.com>

Unrelated to this patch, I also noticed that we now somehow
higher idle power consumption initially when musb modules are
loaded. It used to idle after that but now to get things to
idle I had to plug and unplug a USB device once to the musb
port.

Regards,

Tony

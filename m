Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1246032-1519727917-2-17956448595676694283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519727916; b=W0/Sy7vdJJPWKv/GgEb6WoYApAoVsJA2M19eYRxkemG7wvA
    oiKfvPUe7xRIXnZ2+Xov/eUh5t6CxCQn5NpWjZxlTvunT9Qxzcu904xr7kIq0/K/
    W/XNA0buBljTRsaP181/QQ48eGRTl+y0HE8VUoP3pmEQdBFNvwtrwHwnpqrpye6x
    cT9PxFqPyalcGt9HpL8CT3UKTeU0e8XlK9ujuM/Yi7kU04GaY/rZvv4ZUKTKYxIu
    PVJN/Gw8qNHhpaX05yDqQXADMsJQCbDj87Nnr8L3JZdGk+FZXFJzdQasINHUKpto
    pLpuD1Kbiugtq0v4T+8UJfp2SGq51d6o5evvcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519727916; bh=2NLa6lL6CYsGq5h4bFF7yKERsycx6blY+GnXtbvQoRU=; b=q
    gv6NDoe4V0LgVagrcbzS2DEJBNSqZ1kBndPgVMQVdbHkpTU3xwuyXsHrgDPhGpW2
    Rt6IbRHPwKsX2MbEuvwYr3bHoIUFT0zNqtXjZ6n5aLpiNQ7LuobSsC2NB0v4MgyG
    7QAcgKOOX4KU/Q7WqtzIezVJ05aYIyJ8xSa1U/gzAHwfHukmRs9JuYiRAqxXzfTn
    6598eGcPOO1AfHgcuqU8uOM7+xy3lQcVfNvqlx5jaKWrYoghAROKdKboaJ6IokI/
    0aFQcHgNT/pW8nMy6dMeYVhH8fgjl4JnWimDdo7HwSVCAldGLCPeLlUZCmPm8jfr
    w4lEpZrXYDUh+HVeifSkA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeB0KiK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 05:38:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:40586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752689AbeB0KiJ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 05:38:09 -0500
Message-ID: <1519727870.18525.4.camel@suse.com>
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
From: Oliver Neukum <oneukum@suse.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        'LinuxSamsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
Date: Tue, 27 Feb 2018 11:37:50 +0100
In-Reply-To: <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
         <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, den 27.02.2018, 08:26 +0100 schrieb Marek Szyprowski:

Hi,

> I've noticed that USBnet/ASIX AX88772B USB driver produces deplock kernel
> warning ("inconsistent lock state") on Chromebook2 Peach-PIT board. No

Is that 32 bit?

> special activity is needed to reproduce this issue, it happens almost
> on every boot. ASIX USB ethernet is connected to XHCI USB host controller
> on that board. Is it a known issue? Frankly I have no idea where to look

No, it is not known.

> to fix it. The same adapter connected to EHCI ports on other boards based
> on the same SoC works fine without any warnings.

Odd.

> And the log with mentioned warning:
> 
> [   17.768040] ================================
> [   17.772239] WARNING: inconsistent lock state
> [   17.776511] 4.16.0-rc3-next-20180227-00007-g876c53a7493c #453 Not tainted
> [   17.783329] --------------------------------
> [   17.787580] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [   17.793607] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [   17.798751]  (&syncp->seq#5){?.-.}, at: [<9b22e5f0>] 
> asix_rx_fixup_internal+0x188/0x288

Looks like this triggers (in usbnet):

        u64_stats_update_begin(&stats64->syncp);
        stats64->rx_packets++;
        stats64->rx_bytes += skb->len;
        u64_stats_update_end(&stats64->syncp);

That I considered to be called under lock.
Could you comment this out for testing?

	Regards
		Oliver


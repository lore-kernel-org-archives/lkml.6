Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2472844-1525765224-2-17437819885369678685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525765223; b=kMtQq1c4CT+XUPIxfQqVE/x5wpV9dVxEZu+twdDy622ZRb8DsG
    d686P4iKRFtuVaukZjxlupGXBzhurRFQlCnGU5rULN65Q3g+T3y/TT+tkXdTf9lt
    nK6eN1MNQ4H7MNT5H+oiSvsOk6ljJK6xQBjwRRCzC8BKYQdO72ve/dsjEyhdW/2z
    Xoj6dXzt83r4eQRJiIej16QYHvGt3keaIPQJUWxwA0KJR5os/KFq9/Nx75y/mpW3
    gD4bWpY01atRP8AiI8bnf4/kWM8HKET6o/MCNKGiwOcFEq64XcoIEcHGkB1O4wAY
    Ns1UBcxnwsnmFsuvCknHD4HZmgnKSS0its0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525765223; bh=J1N10XI2hZVTlwrzzRj3tQFwuraa+U
    HT73+TaThI4JI=; b=nwbVfZ6u4Y1jovwTEWoqckMIfrs62XFfNBjZgoSSldX2JO
    Jy3M0hfrxEKEwvdO0NF2M+/WxrP+SXKWGOOfrDWXrHTy53A9l/CqOxtxWdgvv7Ss
    /P5Xz1VDyCNOWYKuv+XM4Ue++ebD+wiZtCeRQ2sFlEN+X558DlDVPB5hHR9gOHwj
    0qoNKfPU8wPSxSwkpjlROpl/WxDC+M65EWeKVbNI3nezu5X4o10jGGYXVYegA7dU
    AQ9MlwHzZhgH0TzUlvVFyHp7Wp4FN03+3QcycA8TEFN7m6OIci8pIRd99NiuYBJ7
    bcQIRpqX6dihwLAQRS7RtYhsuzgdkeICyEZF0U7w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH//hMaBeW4xYtSShFfdtuCDfhYo5H2Dj6Va+hq9hKoYgawant/naxCYBtRTKbwda9b3sc4ZmVozgwM8k9zet3NncsAcX6ZRDHxJhOEYDFGHiPecBAxO
    /sJhK5AJp/3hqeoFlivo3Gz0y5PsGUth4DfiQu8NcXjdigKoyvhfliekzxXx5zh2Ji9NmPbvy7c4V6dJ/Zymn828Iq1XT535kzmjfn5G5Epya1s/BomgMaxQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Vo1_7zB31NEXSM3qNTQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeEHHkU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 03:40:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54965 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbeEHHkU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 03:40:20 -0400
Date: Tue, 8 May 2018 09:40:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-rt-users@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, gregkh@linuxfoundation.org,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Message-ID: <20180508074013.w3lzbwzrym76li2e@linutronix.de>
References: <20180504163041.28726-1-wagi@monom.org>
 <20180507125146.75crpaj2scav7mql@linutronix.de>
 <d37e074d-5e8c-84e8-5833-7ff595e6348c@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d37e074d-5e8c-84e8-5833-7ff595e6348c@monom.org>
User-Agent: NeoMutt/20180323
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-08 09:18:44 [+0200], Daniel Wagner wrote:
> Hi Sebastian,
Hi,

> Should 'echo t > /proc/sysrq' trigger the splat? At least I was so naive
> that think it would be enough.

No, this is a different interface. The thing is you send the BREAK
command and then, the next character (within a timeout) that comes over
the UART is the MAGIC request. While that character is being received
the sysrq request is answered and output is written to the console which
is probably the UART and so you can't acquire the lock again.

So you can't acquire the lock. I added a try_lock once to at least try
to acquire the lock because this may race against a printk() from
another CPU. But then someone complained about a failed try_lock on UP
(this can't happen on UP unless in a scenario like this where the lock
is already acquired) so this change to the 8250 was reverted.

So the whole situation of the console interface is not perfect and this
is the duct tape we have. It would good to have the same duct tape in
all drivers or come up with a different interface to cover corner cases
:)

To reproduce the sysrq code path: You need to the UART as a console and
send a BREAK (CTRL-A F in minicom) followed by `t' to match your
example.

> Thanks,
> Daniel

Sebastian

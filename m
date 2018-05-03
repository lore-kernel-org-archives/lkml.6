Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525372463-2-11710737476210381596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525372462; b=lrSh2kJWCDyghn5x3HQz+FeRBCVULv78UCPOV2HPVLnHzx3eLD
    D7Fpg+t137GzDjCpvCkgxN0N+Wi3pNveg47dH1Mj7+ZnopKdnLDlO7WX5BEXLx25
    BIfkWfTTbWc0LbvXKllfpcO4lhGLSUtZbharebUecGOwqqZZRhi3+7TJB9kMmRHx
    TYNECYiOxUtCJyy2hhZboKPlV8mEDY+GxWgzuE1OC+2YLGR+GMJAHyz5ecmpPIfQ
    JxjqEuMEu2UpzSuY+XaKPDY+wINX4Y1X4IfAhIds7imm2OBjgXhIkhanjakBiEyO
    7XfO1kETXLiaGQ/eu8FaQTlmoFDsHK4wJcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525372462; bh=CeM+ZgfRwla
    dOC0+Wv+D2hwWQCtE5pA4cdf6YAZ3aRg=; b=hOfOi8U6sJbWbAl1Unv+Yl2xlID
    +u+lD5nEdVut0ig1FN5n/9J0XTb46Q4/BOvOpzKIYxZG1/g2Q4E099BuOo4G8x1D
    kMu+uWvxElRvrtoHgRBP928BpD6l0voXMHlQrvqlJVV9uFNs726CG1VOfu484K3U
    WYYJwZ3wtW6IzoRmN3z3Zm0uhcgDlb17lZjGGrAwtoVN6vjyNoe4OWy0IPpDuffO
    Cl7zQgCbuTg0WJTu31X6FTSV1s/ar7cHaDgfzvpeqY8QwNNIrqSWY3oFQIYGASOl
    fOHpNc9hWyT6k2HHXtz4T/rmoAvvsY5m1/dzNrOpPtKV9iLKpJIiufqUDPA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=messagingengine.com header.i=@messagingengine.com
    header.b=afpVS/fY x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=messagingengine.com header.i=@messagingengine.com
      header.b=afpVS/fY x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHey4p1Vsm0tG7QnId7KzpAwn1zvSrfs9k2UBnPh/VkFl6s1ouci43wcHNa4bjs2F5uTEPEyAavYKqA2/BiweWk3egaaJ5lJNjb2wkO3AZ9FN3oTL8IJ
    itsNvOb9z1foXTuEaQ0OfKvpsfKmOaJoWP9rKcPGpVJDto1mXb9NPrERgFgcdWFQoOTIOgtc3w+DNlgEpPAWP4+ILIoNXbXnsQidyDkG+w8pfIIZrPM/yR5L
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=8fekarIL2sqjZ2Qsc3IA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeECSeV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:34:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51519 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750969AbeECSeU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 14:34:20 -0400
X-ME-Sender: <xms:LFbrWl2qukVygU_pIlMl_aDv4Lv15Vd7NZ7MJdq1Tzi90T_axAbx3Q>
Date: Thu, 3 May 2018 11:34:08 -0700
From: Greg KH <greg@kroah.com>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: serial: start_tx & buffer handling
Message-ID: <20180503183408.GA12152@kroah.com>
References: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 08:08:48PM +0530, Muni Sekhar wrote:
> Hi All,
> 
> I’m trying to understand how user mode buffer is written to low level
> serial hardware registers.
> 
> For this I read the kernel code and I came to know that from user mode
> write() API lands into kernel’s tty_write() ("drivers/tty/tty_io.c")
> and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").
> 
> In uart_write(), the buffer is copied to circ_buf and then it calls
> low level serial hardware driver’s start_tx() (struct uart_ops
> .start_tx). But here I could not find how the buffer kept in circ_buf
> is copied to serial port’s TX_FIFO registers?
> 
> Can someone take a moment to explain me on this?

It all depends on which specific UART driver you are looking at, they
all do it a bit different depending on the hardware.

Which one are you looking at?  Look at what the start_tx callback does
for that specific driver, that should give you a hint as to how data
starts flowing.  Usually an interrupt is enabled that is used to flush
the buffer out to the hardware.

thanks,

greg k-h

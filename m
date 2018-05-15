Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1707474-1526346433-2-5874368227053670318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526346432; b=MMrIswYpYntRW6GuihGZWYDCNYvw9LVOVBbW6OqsAXIPceOSFK
    FCFh1TiO305E0HXz2Pydmptv5kpJhdkNP8cFroxIAbLdByRM0HJFDnlBY1BpKOEa
    4N+HphNJ4ZL0X3TfvxPP6NjGu3R+bohNhs9ndz9Tk0iiffjXlnSF2DHYPLaGBrM5
    wr6S+PxnixOpQxDKCYKVc7v8BFObJ8EvvTuGymA7wp0aJxrGNpjqsUbU03nurkzQ
    yBlvtYXP9b/Wp7JrlImncq4XkYGotkP3NE4tNiNht2HrLXUzPZ1LFDVd/vUdFBsY
    +1H1Didyc/zcJryPXApq1Op007NCmTCK4QKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526346432;
    bh=Gt3Qsfk48n7Fg4tXy0Fvax+PM9hdo2TW+OARw5h8kFQ=; b=RFZYp3PmRBqX
    V79OAsKyvybHUGAcIh7Pr+fmMpK20YKmlK+q/V9pxEe85F+oxi46EN2TWTMZqxZB
    b4pB+wRM82F5DWCF8c9BDrzos61mXN2OhZR+xByIsAOqllbJKlJ03Ohcz0xdB8Qd
    0CiWLeUSmffj8V7thCtiJ3VPSjyIZbANPWW5HpUy94X8Gi22UxEALVpN1PsM9w66
    f7ngyQcuuwnTeuQbOLqnnF3AT+KvSDV7HA/RX5P9+ss1MgFto82wpPfpVe01P8Eu
    C4f2CTEWgGff4JqiiWKXFa8WKjdv4qJhEFdHMR8VTlPvBR1vKwxQ8D0fDRjOoZeV
    qB/cWspYDg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Ttc4S2AW
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Ttc4S2AW
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAKjqwOCzUarUqEubIRW4+SbNEZml1KpJ1c9joZ50wJJEOhSWGoG7vA0od5yasaT8/TplDMWny3wI0Vw8goibJikzCBbbk8HaIyTT/kgKs6Mq1ajfTRG
    ASHeBR32iFoEfOvFYaEy/OLs/qcqxdNErwezFxFFKeCpduZTq4jmUi1lm+UU5gmT9wlm5N1bVh0Z6/b1/BUZ05ofQTWtjT7TGI3UPA3XITh5sBxA9ExqjzNv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=1y_YS0F4B0kDIpW5MzgA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeEOBG5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 21:06:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeEOBG4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 14 May 2018 21:06:56 -0400
Subject: Re: USB Floppy Disk Driver
To: Joshua Hudson <joshudson@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
References: <CA+jjjYTDCPSxDrK43yQA2BR8hSDSygW_aCggPL2D9VSPxKtWDg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <56994335-3ddb-9698-0810-3ec5a28581f6@infradead.org>
Date: Mon, 14 May 2018 18:06:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+jjjYTDCPSxDrK43yQA2BR8hSDSygW_aCggPL2D9VSPxKtWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 05:51 PM, Joshua Hudson wrote:
> Has anybody tried the USB floppy disk driver in awhile? I just did to
> read an old disk, and I couldn't read a single byte.
> 
> I started thinking maybe the hardware's bad, but dd didn't raise en
> error even after I pulled it out and got "USB Disconnect" on the
> screen from kernel log.
> 
> I still don't know if the code is broken or if my hardware's bad. It
> worked 15 years ago with a 2.6 series kernel.
> 
> Kernel version:
> 
> joshua@nova:~ϟ uname -a
> Linux nova 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02)
> x86_64 GNU/Linux
> joshua@nova:~ϟ
> 

Both (!) of my USB floppy drives work [on 4.16.6].


-- 
~Randy

Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2891730-1525370047-2-15314109843212669545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525370047; b=XuTv82lLx+2xp5Ah1/EeQNvoaB4fe43OG+xZ5PQgTxZlU8vLU8
    pcQFdHITGKiWrcRF7N19D5Fn1tQifE00KHMP+OD0JPOvVS1FOeTNn4EVjux9ikzK
    9eJ7BlD5tXj6teRdo8rKLvmT8f4f1F5L6DoYLBmrb2aGAlw9C3q3oeBfeycGk4Wj
    +JGokrny5lys4y5r5SZG0XMtAhecd9Pqup7Zt+37HVptYv09YUH7iPdoQGNrtEW3
    6qrY4avgbSAiBvRXvp/Ur1AfXHzPpJ9Qb/3mbxRSVQR670D4hIla0Z77d9lmgCU+
    gMyrLBob/0VxBSHvzIR9OffDkB2WVzTgBvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525370047; bh=N5Uy1fLIqeyhp1QXCefw4qfRQjO0O8
    /ZS8q4yst5xr8=; b=no8OL8SfpXZ+yrDNE+t29NYPJUdFjV6ypJMXAVHcq8h9xH
    HmdKw7vXepwp7idYXyBt4IKfGBsE+oqdZV6AacEDmRkuneRsYEtOmAc1m4vxjZCW
    PdPTu6mQCSqJ+95W940D8QXoM+c/LJNlHu83xHMzQyMMQ57xHkbvEV9dC0YJ+rJx
    XS4yCBm3A5LCz9TZKC20LYC9xUY2rgG9lucXLksPolG1JkQDkOWo8BmVFyUk51KX
    qvEsx/MAJ/agkjFtLBN7Rz4MqLaz5oMdDzhVf2ZooiDcFmmLbWY68bP3AP6oKb1c
    +eZqU2mcjazeFCss3bi83FZwky0aFeTa0tBOZhzQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=Wqg+yhRv x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=Wqg+yhRv x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNKxoRsMqNb5zTK56W/oGk5/d1N2U99TfUYvrDsGBUSiSsoSuf0RgGafghm4IofQAf8ITHh2673rK+nFqZgO6LWc/FRSYkOsUBcRr5cDx4zu6Vr/sl6N
    mNNExPE4tyHFFw39ujxzB4BRkbonnfunFut8JnS+k2P+oYzXBhwr2JxnpNAjfdD6bbjBi7C+mCS5TmLNlGN2jMr0/PbLJNnBjzaplGvaD6EXNxo1/zSaK1Zw
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=JMnnF-g5AAAA:8 a=VwQbUJbxAAAA:8 a=mSTN14KzS1BjpFkkttYA:9
    a=CjuIK1q_8ugA:10 a=_zDC0-8_D9QA:10 a=x8gzFH9gYPwA:10
    a=MIlUOSWcqtxlsnWNI7We:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeECRyE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 13:54:04 -0400
Received: from imap.thunk.org ([74.207.234.97]:58968 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeECRyD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 13:54:03 -0400
Date: Thu, 3 May 2018 13:54:01 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: serial: custom baud rate
Message-ID: <20180503175401.GD29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Muni Sekhar <munisekharrms@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 06:09:13PM +0530, Muni Sekhar wrote:
> Hi All,
> 
> From include/asm-generic/termbits.h , I see baudrate can be one of the
> standard values: 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800,
> 2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800, 500000,
> 576000, 921600, 1000000, 1152000, 1500000, 2000000, 2500000, 3000000,
> 3500000, 4000000.
> 
> If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
> Linux serial framework has any supporting method?

See the setserial man page:t

	https://linux.die.net/man/8/setserial

Not all serial devices support the spd_cust and divisor, however.  In
general, only devices where the kernel directly programs the
8250/16450/16550 UART directly will support this feature.

							- Ted

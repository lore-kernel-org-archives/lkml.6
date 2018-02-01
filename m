Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-325945-1517516133-2-12278368269980443029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517516132; b=LCuFFtd8bDgVKnI7lJq1IAqCg1OXkHXneQ8ZnLsjhNPaeHm
    TDaayLVTbYz8Kfw3//qqP/TcfZaSvXU9EmJLQISnLtUI3DWbulJ5Wp2T6uY888vF
    6ppWJe6AJp1Lljp4ptY/WGivgagHV9sSXZisgwQyOWZNsq+hSHX/KzAqOb6hIKYv
    ukYgHSF1xCZaKYMXs93sW0GZTaII32xXaHBUAlEgUlOamaDpq+FTQApv3lkU2Rdh
    UIDiwID5iSAnhTCOvVjQtO6oFZQotnwRcseQJiS8mO9G9irvwkPnGGtrz2n/u8IZ
    VECDopyuenEgyWLG/+K3bZpvHlxkK4rqJuYAFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517516132; bh=G/WXUf0dlVdVHlS79QoYU1jl/W
    rviah44VIRBLXNGT4=; b=ItzxVEbVdbpW0eksJoSPHjAOyU+1JokDZIdGUDOT9W
    qCoQ8Th3X5cBWh2OE6d/z78/RYo5HTyrp+l/2FgpzlN+pmmwXxgQERfaFRPaxG7S
    XjC3e/Nk191y8Axxgl1/16DDkw+ZubDJ5BDQCjv2dL68dwFHey0lRZiW3njW+YCg
    tpSLT3TE36yJHq8wINBR5fmECn+YIPYQKormZPDl46FRdB9pkU+E5sLJPBWkNxdj
    ER+ORoLwqj9mMRFcqwx503J55KM0TJJbG9FwM4BV2PXsu4gaO+Fr/xxZcm5dJFJS
    mXMnImfum6K4Msm+PDc75Ttlnpt/Se01CBExDLXC7Sog==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754885AbeBAUPO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 15:15:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754663AbeBAUPN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 15:15:13 -0500
Date: Thu, 1 Feb 2018 21:15:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivid Suvarna <ivid.suvarna@gmail.com>
Cc: USB list <linux-usb@vger.kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Peter Chen <Peter.Chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, Felipe Balbi <balbi@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Subject: Re: [usb-serial] Support for console read from usb serial driver
Message-ID: <20180201201509.GA24756@kroah.com>
References: <CABXF_AB8Z1J+s=mqkn012XqZC6xYEhZQ8QUQj=EZ1QAiTnAXyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXF_AB8Z1J+s=mqkn012XqZC6xYEhZQ8QUQj=EZ1QAiTnAXyA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 11:52:18PM +0530, Ivid Suvarna wrote:
> Hi All,
> 
> I was going through usb serial driver console related source code
> (drivers/usb/serial/console.c) in linux kernel and came across
> "usb_console_write" function and was wondering if any usb serial
> convertor drivers were using this function? If so any pointers on how
> it is being used?

Yes, they all can use it.  Have you tried?

> Also can we implement something like "usb_console_read" which can be
> useful for interactive debugging like in kgdb. I saw kgdb using
> something like "poll_get_char and poll_put_char". I found them in most
> of serial drivers like 8250 and so on.

kgdb needs to run without interrupts enabled, which is impossible for
USB normally.  There has been external patches to get USB to work for
debugging, but that might have only been for simple keyboards.

> I am using pl2303 usb to serial convertor for getting a serial
> console. Is there any way to implement something like usb_console_read
> in usb serial drivers? Can you guys give me some pointers on this.

It should "just work" today for you.  What did you try that was not
working properly?

thanks,

greg k-h

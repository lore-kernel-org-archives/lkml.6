Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2659956-1523863608-2-8667557823196888871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523863607; b=tMMgG2wIcPK9KBWhRW8H5PaQDJ9VccPZz97nelnmnMrFfzxiXA
    YKe3Jc/H4U5/Pg8wY6VpQVDh02KOTikgM3bgoE8osyPLy7VZ1vt/on1Ym+KnO2wd
    YVBqd661lrABbW+mFFj9oi7NdEkxlIDztCc+thQuVgRBqS4KVMiC0XGWMCbFcN59
    oWAOHI9BBSpXPfdt1WTWQJdEcQG/9MB8Hleu5qgbi56U0Hbrd2rRqsyGkUeU+crs
    CrY9F75s+mdAuVueWmW7EE4UMertpODUx78jHP+9KWex8kbUN4yJBFuLV4uxvC2d
    U1U5g0eND33t9s//cDwsqaftbYs1GDhoCwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523863607; bh=qU0Wt06xAIpmqzghqkcsfu/YBKl0SE
    R6qmhMPn0N1Yk=; b=qjqp5RRIq0+nDDnaDsESpAreG4nWnvkExzNLWHvvQ6vMiU
    7yy6n6NvaF/d8UhTsJoiN8Ik25aKSBo/dHMdmbw4mCzxY4eRxYoJLe8HkS+zi/M3
    U3QUQq9NgFAR5wUVbxErPCZp6fs58PFj+Kbdm+1ngWyYxKcXJXYWjdodL7wsCkyW
    W7/Tu0fSRgggLmxgoERdGQqJCXTxCUunBkrlds3hjVE1r1Ko/OfZdeVNvr/HSn+L
    wflLnaZQFvzQHoL+zos7sksz6fBsXwP/IKk18uN4cTZ1oLMyoUgxjRGJ+PhY8aaO
    EfOwVQ6Uq0w8zJ/bjOqjW0DLd9uQZxcAlSDU6iYg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XLYj09Ez x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m5lcNb4f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=XLYj09Ez x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m5lcNb4f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLvXvZiof6jRtIvDkqY+iO96+9TNksBDuvSecljjzbQEoG89xExcBxbGIah/G09N1xoyk+4UaDPOEn1S5DUKrSDfs7mhoeINK8LGNwi+NQL5wfHZtdnM
    F+cQ6teoIVKQ0QF9Ohi4ZXUbRGzt4odOckS5jf0z1lXtNn9CFLflVylf7465Z7fe2a0cKK5gSPEb2K6h8jg3cvFiTWPQafBrm6hdY0WL4rI3dX5AJzhx0woC
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=gVGD3344AAAA:8 a=VwQbUJbxAAAA:8 a=DSnVEm2WeWSGjTZyNd0A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xQEvYfgLW3QvObN0DhJi:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeDPH0N (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 03:26:13 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:42198 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeDPH0M (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 03:26:12 -0400
X-Google-Smtp-Source: AIpwx48xZyM+J0Y6OZMxgGEdchcHd5HjZgSxTXkmDQeYSh36uPRuzgcug9+17r1QtR6jXxY0smx/lQ==
Date: Mon, 16 Apr 2018 09:26:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Add ID for NI USB serial console
Message-ID: <20180416072606.GK10795@localhost>
References: <20180409152355.7774-1-kyle.roeschley@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409152355.7774-1-kyle.roeschley@ni.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:23:55AM -0500, Kyle Roeschley wrote:
> Added the USB VID and PID for the USB serial console on some National
> Instruments devices.
> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>

Now applied, thanks.

Johan

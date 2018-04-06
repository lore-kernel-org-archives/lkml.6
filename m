Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022473-2-473655322109928353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022472; b=Jzmn0KNA8GUrXiMnXKZmXUU9MpxUaMCvQuss0k1ZpE+6EHl7/P
    Z2Vqo4vmQVSKCKBnNLVIewuzPHrlr9OJ5JO3m/3S0GzG5Lub4TUVi4H7/3D+5VEn
    emqrZ+8HwpJpxVdJ85IfzEwhfItAwmUm873/kVvE0ANscwNeOThIeXWckco95jIc
    7/jEOaQGbQXQkkIOODhkVfUI22t6cQAEXRg6Kos8ISVHVXdszyVJBJKIBBuBjYLf
    hiNX2eurpMG+ajnxQZT8YCymxb0arWwi8igJhgMOmNvTxOetEo5aVHHX34K5gaj8
    Egqizrf9WU7/nHvcf8EZU+jRd5hnd3VTwV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523022472;
    bh=JDyaRurrrntVfagRqnhMTaJ6BzlTbrK8mP4anqXgWPY=; b=wG8wpJ+wSAsW
    TmApQvy/6+BYqdSaxNx1e4aTXvLFzndoYLJpFPIEEMQxuy7ghdK2e9I6LI4hvuH+
    zytT60lSDbPDJ6W7Ccx56BmqPWQj9pRtIhMox0Gf3bePk7PEiZUT6vRoADE5cSvS
    w35ehQaARElRh0uPF9HuG2LAgXA/bN5NaBBehjBuY7UuAs2oqTR+yCdzNXo1YM9F
    UDrWqH7UT7/0L/aDLrkFpkpQMtSi89lzm7NtYJiEArcLUZlEtZ+gyRsdU2mRT+/A
    sK5/U3Bh5T548Ne8X5SeyMvWF7IJ5H/xJbzyhnOtryxijq35QpZHmyjh6Kbq0C1s
    JxQjQ0XijA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHyF4SfScTKQ4FgUQ5rSchIDPNR/gdQGz9PLmuyUnw96+CLwrGCPg2mKzgIoo1eZh+snXFicgglyqS4cES4hUSY39626sibOuAJ77hTJis7SUcBUz7Uh
    WPxAanu4SA9lm7LRy0bsidPH63wlUtgqE8bPIwkFbE5e6izV4Xwzx4E6NANw64F0AMDjQyWmMJXpdBhhbHvavF6LdaVcUCnfNKnZI9dmKovJ3wTWVgMjePUx
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=tM5qByrR90nFoOxwKLIA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeDFNrh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:47:37 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55858 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933139AbeDFNrf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Apr 2018 09:47:35 -0400
Date: Fri, 6 Apr 2018 14:47:13 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Aaron Durbin <adurbin@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Message-ID: <20180406144713.30d1ca00@alans-desktop>
In-Reply-To: <CAE2855tmMwbOWDOs-iJS7i35=Y7gt0xun4ApfhZyY9Kr5N3NJA@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org>
        <20180314003655.12141-2-djkurtz@chromium.org>
        <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
        <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
        <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
        <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
        <20180326192428.71c23abf@alans-desktop>
        <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
        <20180329143400.6d9256a5@alans-desktop>
        <CAE2855tmMwbOWDOs-iJS7i35=Y7gt0xun4ApfhZyY9Kr5N3NJA@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> But we don't have the full ACPI interpreter up in the early part of
> the kernel. All these 'early' devices have their own setup/config
> which is the source of the issue. Or maybe I am wrong about the full
> interpreter and the early drivers are just not taking advantage of the
> ACPI device binding?

In very early boot with serial console you just have to pray. No change
there. Once ACPI comes up you however have the information to populate
everything and configure correctly.

So it should work fine except for kernel hackers trying to do early boot
debug, which is a small (but important) cornercase ?

Alan

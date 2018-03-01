Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607228-1519930036-2-7139142776719598392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519930035; b=AnlJ+DyyvILwLYqtXHk2EnVRbg8uFYC57R+tcDTrlr8ZlhC
    gGfacAKyd3ya+BtOd20jNW8wBb9jr1eUDGrIonckZuHYSn81YwAVSaBXSmusBB/f
    NMVyki91PVN/ybU0aRCExBGBB21aXqcHx8VSG7mJhzzvZOn4fadPfBrTlQZmIgpa
    1xzhrm/2VP+xt5EgsTE2zM0a0q9Y1hdpqpj896DditddwJ84UfyQ4I6evlmQSqdv
    WgHFHdOHoqYJ/4a2N697JB2zi8rOOs9jm74cPsQLNo/At2F09vA4/tsjzlu0iwz/
    /SiFH7PMq8Pg7lUZIi9BPqHqDbzYMqr/+bfsGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519930035; bh=8+4Qj1QS0JKmSW85MWyXSOmbCdZWgXpR+3Gl+X
    5/TlE=; b=kHwCr5L7DzeGOwO3C79qajtEXbmC2w4eEj0whZKbyqifpK5Y/uLO0n
    OX1a0jsBD3B/dmzxIUzorYYisAVph1QzhQIUoOH1RrJt8Pfe0DeAdLAq3NzJQZy3
    yZQPHvp7ftuOTfZY2pODjwd2GuRWyCdFAUgrC7A6oxlreLgyJS/AQI65dilpFzmE
    2UwCuMWy7CA32hE4WClIfjfBfc2C+UDUmCdrlkGO/0IfdgZySxQbk9IV9WzVOVxw
    NjKMANM5bYvArNThg1lZ3delj+cHoab5iVYuyduXlTD0n0NF8VSIsXUShVysOZDG
    BSVQtM/NPau/jV2DH9CkELAus126OD8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OfwDeYCD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HHhAq+KI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OfwDeYCD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HHhAq+KI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034007AbeCASrM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 13:47:12 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:42113 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034056AbeCASrL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Mar 2018 13:47:11 -0500
X-Google-Smtp-Source: AG47ELsPVl9POkTqA04o6pqiv2Lt1uBIDZy5z6loSLJsV/QCKGXu7GRFnj/SH4/2al5BYcGqkHOgM0DiRpFKmiuG8ko=
MIME-Version: 1.0
In-Reply-To: <20180301184335.248378-1-djkurtz@chromium.org>
References: <20180301184335.248378-1-djkurtz@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 20:47:09 +0200
Message-ID: <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tom Saeger <tom.saeger@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 8:43 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:

Please, hold on with new versions.
I'm not satisfied (yet?) by the approach.

-- 
With Best Regards,
Andy Shevchenko

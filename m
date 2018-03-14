Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2109832-1521045012-2-15023860334514149562
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521045012; b=LRM5rKkp2+klvDodS7C105K6T6qmckKJ33H9Mz5tz8a4BrS
    iowQRWKZ8WiN4I+Sfu6FG+w600r3zERkgyvb1Rx2QC05Z8BOaPNBb0yX3QvEiVhC
    vHapy7bao4cLJiYZZVWP2O5YYUv0XftRB8yn4p1xAtUvAe3WYO+WNCBwBHg8FrXa
    p6vaeZxKKZV0hlMNE9sjFULxTgkTiMnDzi4Jf/TqEd3q8s39autsI5JD1YXIMS4W
    JFHqkI/yBDsGZ5e0HhgwOKqtWKRwcQIX7lKgXN7czIbMeuFVPaTKOlcv+2YS8SiH
    T8IfVjUTXVqh317/9pZfbi1wfIq8grEWk76GBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521045012; bh=h7s92jddtZPeUr5Rz+aXgb3bEtg/gIKMXLTO7g
    EHUwU=; b=Raz1edE4rRg868w/1+cztOT2yiCf9L6uvo8HPpzmBRgR+az117xPy1
    h0K+Ew09MEEB5B+FtisaUihYkd7O5ShJ8GWCYcj7moFYR15SuqsKWFJW2JKLQSgo
    N1vRRLleXexePZhcN3v88c/raO5gAyzEM1ocuWPsBmsMIqMvVlLSpbUxbTetPypg
    0zMfXB81eotvyr0pJJupXdC2mR0SqdgH46fA/XAU0/8jHutmhgjOmI1d3uSY51vu
    PexG54JdVNf4O/irQ2fFJ1cZzjJGalirV6nGkgKllShHyGt8fkst4sXDAsv5RuCN
    vecd6W0z48VwUDleCLU211lnCtW0kG0w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=cVA1vm+q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YyqGG9/5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=cVA1vm+q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YyqGG9/5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeCNQaJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 12:30:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38839 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeCNQaJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 12:30:09 -0400
X-Google-Smtp-Source: AG47ELsgq7EM0q4WRf+TPMdKnaNrdcGUnq1+JvRtjhcVQ/xiiMSOPtUChJWfZ2ghI/qgI+dzmSE8yoxeCMYhH0hQiHU=
MIME-Version: 1.0
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
In-Reply-To: <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Wed, 14 Mar 2018 16:29:56 +0000
Message-ID: <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: ricardo.ribalda@gmail.com
Cc: adurbin@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, marc_gonzalez@sigmadesigns.com,
        Doug Anderson <dianders@chromium.org>, matt.redfearn@mips.com,
        Jeffy <jeffy.chen@rock-chips.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ricardo,

On Wed, Mar 14, 2018 at 4:54 AM Ricardo Ribalda Delgado <
ricardo.ribalda@gmail.com> wrote:

> Hi Daniel


> On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org>
wrote:
> >
> > AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
> > input clock.
> >
> > Allow these platforms to set up this clock by specifying a kernel
command
> > line like:
> > earlycon=amdcz,mmio32,0xfedc6000,115200


> If the port and the mode (mmio32) is always fixed, couldn't we just
> add those two into
> early_amdcz_setup?

There are multiple memory mapped UARTs on at least the one chip I am aware
of, specifying the address here chooses which port to use as the early
console.

In fact, the recommended way is to have firmware specify an ACPI SPCR table
with OEMID="AMDCZ " (see https://patchwork.kernel.org/patch/10281307/) to
configure proper access and address.  With an SPCR table in place,  the
kernel command line just becomes "earlycon", with no parameters.

-Dan

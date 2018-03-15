Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4088809-1521106993-2-3372591044522147128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521106993; b=q4EAo9UL53z2pM2P1LLSli14kU7xMndBy1PL651Hupjpelg
    MWJ7caZgps9M1rGnUP9BBmbNgzI+o7sP+bxTJiBHUNofANnP7fBm3porXk6anXFz
    W+BiFXw4szvdGxo43ibasCpB/G5bGVkm5dmBW61Kohql7cBL2A/OtQqZl7zJ51V2
    ytPWcMGYBxqkWu5H6yCCDBFFaoHDlESAgkkRA9XEMUdtkux2Lk3uMmEx8KH0Y7/9
    Po5EAnnnGENr/r+SWFQkoXKQ+er5hcebqnnS5JSDMLoDPp+creSWII0nroDJGBt8
    ArSWl+2eagW9cEbfgRC7if6mkDOiyzuBkqBrh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=arctest; t=1521106993; bh=Mv8AJ8Qb0PBT2CtkfJJmKup512
    dbEPoS1XN3GDiko8o=; b=jhCAJYZkvDYAhdhnK3U7E0KgSN0hHbEIDQK68ydbKw
    b8e2l4I1NdjiFDl86sQGMxPMoyC5+iwf5trfBVgOnKpP5H3MeznX3hlUq8RMTDko
    2meepUEpQHEImCa47n7Ir3vvMPGdnDGwb8phUoTneiu6nSOwNaJJvIA2mN2kkP/N
    Z007BILb5G0cr+wZCyI+U2+w9rwCjQWNmD+M2IIj4Mt+nxtayOpd9dn7qKCG7FdH
    HqVYEg98s2QIC2VeU7xlHqMQUsg+0IKUe597wLew6nWz4Du1LQGvGjyvpvHpmXJC
    JHisZdK+DRbXqzQ2r7impSWRh5acmPqNAluaBvCg6AiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeCOJnB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 05:43:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751480AbeCOJmz (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 05:42:55 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2928.1521106970.1@warthog.procyon.org.uk>
Date: Thu, 15 Mar 2018 09:42:50 +0000
Message-ID: <2929.1521106970@warthog.procyon.org.uk>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Do we have anything left that still implements NOMMU?

David

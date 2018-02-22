Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1382408-1519342984-2-9875311204413055342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519342983; b=Js70cZQRZwSsGDe+7gaXbAb0VlPPHVmR3re3JYbvhLaJRsw
    38pitmH6EzIA0j749cEvHHCrb601CPIu2oWCglXFO0rKLGLCLtPf0BkLQ0YcU4ZZ
    E8m/r72xNmWjhWMqRTc/Lfndi3CbcD/318e1ijbYqLaZNIDCfgcToTM6V1ZYngBH
    hfGoU5aTyM05S0WhXJeZfJaWEMHe3XrHeScdYs+s2dQklhvBTudyAec/9SNMg0OV
    F/jDFCSkq9aKX4WPtI6U36yRC+L/Uq3ZpGJXGBmJ+ERZ6KDxhkTi9PYlSBEjbHt5
    49XujMpzpU3tBETixkK8vnCFkhjTDCmpfeYJoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=arctest; t=1519342983; bh=3Z1Eu+4guyyOMsNdpjT7Yu0Cdw
    MB/cbP1T/yiePzLzE=; b=qzWNFto//QoQ9bmux+QLwSEF8AyDPT2Z6GRkzDIC+w
    S4ZguC+kJuRoSgJRp6evVAdNOiahG0Muizo3pNMYcsml9tVbjq47NzOGCfbShfIs
    Bjj3dozjAwk17a2FIfE1MkmAKaQ2BEzYZNxxvGwP1oARIcox0a+t/hrHiKufN5F/
    i+OwV3SUsrrv3Osq9SDbDJMwgRynCgroJjQdMA5v+cLGjyvQoKdL0L0izuMfRH5v
    5yNuP1ib+v+7V9WoKInUBBwV/iBs+4JhYZU/FP5U1Q5peHc9EFtqs1XH9T1FqycV
    w4nU/Egq+ApCemgy3v33DzNnGPeSMCLFcFfNswHhTxew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeBVXmT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 18:42:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750916AbeBVXmR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 18:42:17 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <151931646922.27713.5363631712174136041.stgit@warthog.procyon.org.uk>
References: <151931646922.27713.5363631712174136041.stgit@warthog.procyon.org.uk> <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH 6/6] KEYS: Use individual pages in big_key for crypto buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29837.1519342935.1@warthog.procyon.org.uk>
Date: Thu, 22 Feb 2018 23:42:15 +0000
Message-ID: <29838.1519342935@warthog.procyon.org.uk>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David Howells <dhowells@redhat.com> wrote:

> +		l = min(len, PAGE_SIZE);

Sigh.  This needs to be a min_t().

David

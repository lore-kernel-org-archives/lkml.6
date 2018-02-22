Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1382408-1519343100-2-3110021291109823667
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
    t=1519343100; b=aroSdImS2k0TfSGj7FZvuD4nmLPMg46wbCL+m1xtkJa6wjY
    AVQJpebptWF02SqwBAVFXzjQLvk8zs2yP4PU4sJ3mHG9uy/2c4JWF+gIVRVgh1sZ
    5J+9sFzZZyKY6sDNCl5iY6syjbOLrTChvCugm6gGxAlJk2VFG8MIsW3iHyPHCGZs
    QjwGmcmTGFPevL6eh+DgYofG2W1OdY77yR67vVr0MkL3ub8WjraepQsvsmrI4Tsu
    t67qCdES5Z5mN9WGFDt/fVlJSjBA9fB0ZZrQkDhkrXrddj4ZjpXWY0lZqVER6H36
    kxyMt7dB03EERWh5Wann10VcarmriRmrcd8nvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:content-transfer-encoding
    :date:message-id:sender:list-id; s=arctest; t=1519343100; bh=GMD
    Ct7gOkhrPP29gPv9HxhfChejzIBb2lfE+OrQulx0=; b=sZtNwnPg6sfqdu6xHaS
    LIl3RWNOpL4e1X1fPbSazfCXnVjAGLOeOck3sEc20O8C1Yq+qimj4Y1gmH4hrU0f
    7vymKoR8Eg7X/A9R0Cd07aOdOzqF+kCScFD5sYqX2ncrBF2NEB6bHy5SDaMeEyao
    QGhcigv7Iha+HcjWo27j2Hk/vMmRAgwrCmk9+YfgGI+wHZNP89V4w+BjZ94DqopW
    Mm0tpMtPRdBx743N+S8RixLg97bP1N5eJcTHkaXi4qjQwNqMKDW8GEkpVb09Guoc
    vz2rFCRVP208/XQF/nP9uu32ufTzRlpTQrfmjjOBB3PhEWqmR/h1s/RqNnW+kSNR
    wLg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeBVXon convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 22 Feb 2018 18:44:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751345AbeBVXom (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 18:44:42 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
References: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
To: jmorris@namei.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RFC][PATCH 0/6] KEYS: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29945.1519343081.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Thu, 22 Feb 2018 23:44:41 +0000
Message-ID: <29946.1519343081@warthog.procyon.org.uk>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I've posted an update that converts the min() to a min_t() and tagged it:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/tag/?h=keys-fixes-20180222-2

Do you want me to repost the patches?

David

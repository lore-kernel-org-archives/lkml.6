Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-524998-1519316851-2-13141474776452302529
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
    t=1519316851; b=mfxg20zVfk24k0w/zPfYTirDXh5cBtlmDsdBBPdN0Zh90Fc
    wdTDVL2j4U/Zm2bOth/bVvMd4Hq+GSv36w7b5fD9dOE2c53qKRFmn+e9ymkB4HVS
    ep9nr36qvVvQZHivqpPbN5mFTODm9JqsevTCftxpT1zk8KRBb02bBS2avu8tcqWg
    m0E/gfE7K5bAoqRiriHnTvt9ow2nBU49ZANe5f9tx+QonuE6n65k/ooZmmQXshqW
    CbiRLsuYEISaTHsWp2VPdeMDsIzrCiW5aWAaV5ZL0glV0Er+Qa5gwQMAimQ6baBn
    3s/MRO2Jzr1joKx74MXsQYmwbq8QHR8IMQY64Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=arctest; t=1519316851; bh=3cZX+/XeMx1HqQq4qIMSWB6G6P
    xPWGRpZ0yO/k6vczM=; b=wjnAPlT4ixRA1fc6INnpx7f0NQzjkdEvd9I41qlJN5
    L9/M5NdAMpHKsD5COpoCUQd9lGb/IqU3mYzgRWONykxmo1SLKrqGNPIrhnzbiInW
    RuI1n97PzUaxuSp0TSqKtv7snCMN3LR2W+vavaH70kroNQIn9qIrqML1HIiyo5Wd
    5gGSUjHxEHx2VyxOU0eQ6WGwPQouwQiIRMZ+rtnslINmHKx6C1g8wWhFgl5KvvJ9
    TodCbOFq/lvbmd4DSFr3bpqKmLoxCf+xN4zDdzWqSb4B5yG07588EP2Ch8jStqGz
    KLBqdrS8u1NOiBfEktvD+x3guCJrUA7hDq+QPBvSpWCg==
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
        id S933144AbeBVQ12 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:27:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932942AbeBVQ11 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 11:27:27 -0500
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
Content-ID: <28345.1519316845.1@warthog.procyon.org.uk>
Date: Thu, 22 Feb 2018 16:27:25 +0000
Message-ID: <28346.1519316845@warthog.procyon.org.uk>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry, that RFC shouldn't be there in the subject.

David

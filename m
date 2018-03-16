Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3921380-1521234605-2-12797748246046809333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521234605; b=ALa8eoerOvjFTJeNL69aJZMCtGKghibvmPjvWrusoRq5Hqq
    F6oc0Y33p6RepXN3CpAyIEU0vEhE+U7a7AgIyclE5kVHr6utzmw1oG4OpOH6iWMy
    G9FrSPeoJCi3w5Msz4FKeITMcfyr+Xwa0ISustLWTyj8YSkcZYZIn/XG8n5qXqCj
    kD0+lnmiRvcPBhQ/oxMJtbPcVzuDHiMobqhSlLNU7Hc3F5R56bJYdW4qeWd3LFWt
    XuT0BV58QHbgIrMx4Hn0KsFdCS5M2lpDhHaOUvneXvwyGvedaXlj5d4ZTb/SDxMa
    IM6mODndbVrvGtK49kWQA6552iZF7qyQQSN2zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521234605; bh=6pjxQQt7DDKYbm1RDnL4SsVDp+3zXVDwGMv04vEIrnE=; b=d
    UNRnT92wdyXAzrMCA/bDHpdMgjQr8gPo8WnSgOpbbc1UQPy6GJVMmVwFbFe57mOi
    jwRa4T6mNUpS5BgVRX/OgQ3mSHaGrJIwaodlgCPl7Qde0ZS0XZe4BcowN708DrDE
    iqRxHGJP1GF5wk8NFUNr7MNg2jOdO4QiqKXjp1v64bzuhjcJgJ4KnRA6PJ38584C
    L/g9sWlfQm3PCD9y50LSsMfakBjeom7C5xUaloHPYeMiHcjCVbll+TpygI9x59mL
    3Ldyt1nJTyBxZpXATLqlKwkZkKAaGPH9Lg5KZsC9J820QbTQm9EJG6vHtub9M5Ky
    YlhNEOiV2Sa01zg+DEk5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeCPVKC convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Mar 2018 17:10:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeCPVKB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 17:10:01 -0400
Date: Fri, 16 Mar 2018 14:09:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jglisse@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>
Subject: Re: [PATCH 02/14] mm/hmm: fix header file if/else/endif maze
Message-Id: <20180316140959.b603888e2a9ba2e42e56ba1f@linux-foundation.org>
In-Reply-To: <20180316191414.3223-3-jglisse@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
        <20180316191414.3223-3-jglisse@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 15:14:07 -0400 jglisse@redhat.com wrote:

> From: Jérôme Glisse <jglisse@redhat.com>
> 
> The #if/#else/#endif for IS_ENABLED(CONFIG_HMM) were wrong.

"were wrong" is not a sufficient explanation of the problem, especially
if we're requesting a -stable backport.  Please fully describe the
effects of a bug when fixing it?

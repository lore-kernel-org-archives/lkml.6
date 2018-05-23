Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-477338-1527097920-2-15436639299362720416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527097919; b=Ys7XteIb59sc7vpAw2w/Ou9T40aSRI3NDqU1hKpv4P97HUESN/
    p+n8Y1CNVx1L9iXuom6F6WVfuhujIsxEC+eofTGmyT/yetibL90OlHBmZSZqHzbN
    9gCK0wLAyr2oBbwysHaO3eJXadSiH19ETIgsySmQ2BgGx9czKxQcGjO6wl5NEV0o
    8501FpprcNrd2y2giU1llpVRHkZJh398yEc9J13UnPBmvpGpEQxyenzr0SGt/K7D
    yLKg9SGak7ZV7YrMCq1D6P5D+sdliSpDZp38b9DBKywkxINhZFYTe2sQvXoJQAO/
    b9UCkgjemm5lmxikghf/S6kVIGjIs1wItx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527097919; bh=g+u7kmQRzhAl5P+70I50qNwhZTjJgq
    kAApeS+iwfv+w=; b=QlEKgoelIvAcPTIgg++De0GDu2ZHwJUpEhfyuy20u2S+fa
    jj+Lue3Jz6bropekIkngK2ma+ArIAREFgFb6RnIRmO4R5nBLyNNzRC802POGAnc3
    kviQuNH16F5IZ+qqyRDzuAD+qYk6tyuGpSQzw2RvA5j9BDkiccIg5k3LREEdf1tr
    rVZKdUolEuRGs3ovM67b5Q4hEYSlSJy4WJ0mkeDIdUXRqeeYdxFHBwMutpL7AgMA
    v2qoPe2KYPtH+61GIjNjv8tRodXtzO0rpr3C4mwoP3uZHV1ydo5tKgYiN/BFGC+Y
    zCFnCNz1wRUHqz+npE3Y7qhPnhhfu6FFJ72fHXtw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAPj77uU6VmFTZvRRKt+xHJIJ9d9q+r7ZpyTTgYa1yROoPq/CK9HnyfPkkO8gDIiJa2nOnXMcU14Et6vFi/FVlw47VhR8I5i5PT/37tuq0L/oI3ImB4J
    9r6NkMvFLNPcvmNJr68s8z/5vbPXoOkNRCc3m6xM1GvNAkbubyrvK/HbG6O6+dBaGLKeKCGOZkiaNn0CL8i0KB3/B5LK3CFNyGTvXWcFMJACtGU+NLIVr+qB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeEWRv5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 13:51:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbeEWRv4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 13:51:56 -0400
Date: Wed, 23 May 2018 10:35:31 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: semantics of rhashtable and sysvipc
Message-ID: <20180523173531.q7qxm62dkw256nbk@linux-n805>
References: <20180523172500.anfvmjtumww65ief@linux-n805>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180523172500.anfvmjtumww65ief@linux-n805>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 23 May 2018, Davidlohr Bueso wrote:
>I see two possible fixes.

I guess a third option would be to make the hashtable static, but I'm not
against using rhashtables so I'm not really considering this.

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-159713-1518533648-2-2530851146040617467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518533647; b=GaBsZqmuFpowVVR0qVQ7B8vM6eOpJ5gUeSz7Jy2mB88wCf1
    XakTkQw7f9nKW53jgiEz1JVqyax/PPrIG3Lp8c6g7i6+l1getsVYWjg7xAzqVJ8j
    xsja61H3NcgyN1g7UUSDXRW/NIXaOPjo62Gw/5/8vHcvHpYfwAb9DDuVaMJZrk+N
    PoXe57Wz+pXCSL52aOvLcgDmYkllziahqlVtuSLvrwRWcWQSrD1RGfIvcfdA+7IA
    jCpyDhVsFbV809JpuGjh6zuZVCz8YkVCAZQoRVoHEHOeFHMehCmx1ni3fovNx77F
    fck44BITXbD1YuOIBPLE8dDG4KVq/YAIIELeYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518533647; bh=h3nKQBuYzf5Tt0JtV3VzqWUmUP
    CN1eY3R7/XKE52twA=; b=CNnQSuiF9A3kH71TcE3raSIfD+I+zH02RkTXlhvS4g
    2BG9B1TwwaC217k2fjBypojyKvEC4GAueqv03nRp9kVGMoPUnAGlchqBF6Bej/Z8
    gR8oTEJeea2+upRVSlwtO9bGF7eTpYXZsvYVYZ1nXdM/JSnf3ta79Z5+0eWc6F1l
    k8VGmqNXGA3URPgEYWfHdspaCroz3LK6TLZnnwJD5SezuKxzRRd/n/dkxbH99Lc6
    cD/oRW+mpu7WSJfOUAOqD6loIKF7St0YKyhT6QXD8+9hjpWjS1RzXK77C9bqc+mq
    pEVUuee+pM2YqKRYxzBjKoeyQd7YxaGtOgPHPwnGJRnA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935254AbeBMOyG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 09:54:06 -0500
Received: from verein.lst.de ([213.95.11.211]:45417 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933716AbeBMOyG (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 13 Feb 2018 09:54:06 -0500
Date: Tue, 13 Feb 2018 15:54:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
Message-ID: <20180213145404.GB14657@lst.de>
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you wire up your test cases for blktests?

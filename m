Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2858199-1521726612-2-7669837294065411851
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521726610; b=IJ8gEDqGF+f5iSXvbUhGXbetZS2yfBOajjzKjbluF/XyNW8
    xvWcLmRIDZwAnINNcvZP5nR8zI1NN2RQdu1ESGLTsxkK5dEV+Nt/lEFTFtt5FYhw
    pjwdZHF8xWN1UQtbA1/gOxWeMigiKHYffRBPxtgy86y/xkfglhXD9WV2bVq/yLLz
    LSq6BgnrAt0uwXqOg550d9sTxf/vOhnMMyZXBxLjfkHMjuD4ZWPtk7xatHL1/JeY
    DFioiwBcG27qMhGG6VQUO2gQdxs1Y9c7iGsZwQDXCiRmwk0GVUqQugmt9TMAibE2
    3OTuzVHSeQmb7ZE3QIe5MJLz9+JrRu3VaK/j4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521726610; bh=9AQbUXgsFcuRZ49JBrflj6b0Yg
    kWR3iF1Qo54RvKtxQ=; b=TFITurQmxQ0PO/CNiy4raMML0gtcHYtgNa0Xjulsec
    gt7vLqIZAQA6TyfgKBTKH8UFYDVL8QrXTper/SzPIqnxir8T2gI/8H4cjGe7KxWt
    ldEf9S9hV7js+IDrLpEO4Sc26NlW2fWdsPw/whcCLhlDOH5gntUlG9Mnwf1vtWpe
    HpfjE68nST59rRQjyp3WnZI9RLfXx1oiGgWb3PxOphZ7Xovru7uFerg2rVD2eexz
    +bD5d6Z55Snrp6q3ROasZ4aJT/FmgH195L3qfZ+2pjfvFMTNY7HNAhJ1UUsTSwsd
    yJr4dsSIso7cKrGJ3sWdhclMe5dLkHJdCN21sZiTje1g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=Az1bfcjs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=Az1bfcjs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeCVNuF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 09:50:05 -0400
Received: from imap.thunk.org ([74.207.234.97]:44520 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752738AbeCVNuD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 22 Mar 2018 09:50:03 -0400
Date: Thu, 22 Mar 2018 09:49:58 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] random: convert to ->poll_mask
Message-ID: <20180322134958.GB2852@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-29-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:32AM +0100, Christoph Hellwig wrote:
> The big change is that random_read_wait and random_write_wait are merged
> into a single waitqueue that uses keyed wakeups.  Because wait_event_*
> doesn't know about that this will lead to occassional spurious wakeups
> in _random_read and add_hwgenerator_randomness, but wait_event_* is
> designed to handle these and were are not in a a hot path there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>


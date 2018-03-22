Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3138558-1521737582-2-7788914252993886383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521737581; b=UVV7+GSmBpwGOA6aMfE6TeE4REORTvD+oYAbEvRRDVTETsC
    +eILkSQXeDcuuTsh/4V5yZ40NOsa21lWAifKZHwoaaiXn7znCp3+luFEG6R6EPI7
    dQ1DVPJ+Ajbore22QIprbvdimPgFcDVkBMMFXtcwFyY5S35Sc0spcWnwlPMxlx/D
    oxVQYA9oNW6sKbHXHKSDpNr91WggF/ipfCbuDh0NFGmYadG2fo+EivMJ3v8p6X1K
    eOvn1hHTy0qG9iLwxfS5lxzzDW0bJVVO0Hcjb8HWxn1l8wUbBHXFWonxMtkYvvwF
    lnHD+l7X+nL/3FvzV5urpInGhhUQAEWu7N9hsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521737581; bh=H/zGSU3mrRlSl4ucRGvzT1ukao
    z9KBWwNbneb81sEyo=; b=whruqB11Btr0dPkbPiRK+x1X9Z4cMWZ5tz9Erwi5sS
    OgTz9PXDW0CjgbASD+CbPZ+h6kqj04CjuDZq6/c2qiC8zMXF3FdIXadOKSnItNPX
    sAvew06HUfoLjZ5aP3jC2wKUo0VPZ+7w9boOfpN8nV+hvpku494yQnvWXVW1WHut
    B5ucbb3QOmnzPRIhmFTOe2hHpye6vzhy0FhtwH/syjum/93jMlYpSn456ETzRbp4
    U3imuqcz4qpyUK/sX4P9qHBp3M4qVDxq3tnPYyUbwLYZBqrASS6aaD/c6HBR2RzJ
    dTm6vDKvPX5gxl51RHTUBNFMAjkov4bNcPYnf+4lR3nA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCVQw6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 12:52:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35984 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCVQw5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Mar 2018 12:52:57 -0400
Date: Thu, 22 Mar 2018 16:52:55 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/28] aio: implement IOCB_CMD_POLL
Message-ID: <20180322165255.GI30522@ZenIV.linux.org.uk>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-7-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:10AM +0100, Christoph Hellwig wrote:
> Simple one-shot poll through the io_submit() interface.  To poll for
> a file descriptor the application should submit an iocb of type
> IOCB_CMD_POLL.  It will poll the fd for the events specified in the
> the first 32 bits of the aio_buf field of the iocb.
> 
> Unlike poll or epoll without EPOLLONESHOT this interface always works
> in one shot mode, that is once the iocb is completed, it will have to be
> resubmitted.

AFAICS, your wakeup can race with io_cancel(), leading to double fput().
You are checking the "somebody had committed itself to cancelling that
thing" bit outside of ->ctx_lock on the wakeup side, and I don't see
anything to prevent both getting to __aio_poll_complete() on the same
iocb, with obvious results.

I might be missing something subtle in there, but then it would be nice to
have it covered in commit message...

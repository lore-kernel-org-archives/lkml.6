Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646100-1521559247-2-1730117727406599209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521559247; b=fgp4v1nrt1ai6QSULQ7s8CiRieSsjpibQ/J6vOHbeFQQ0Ec
    RMeA2h3N8v5d8F8LQqql+kVyH7lQM3UhJoi4ixUMNC7IO8txUZsjz1Uf9V/YnRIY
    rCoGYVnaKSU4ygHM4ns9mtlRJcmxh535r099U63GLLiCtztsDOAjdw0nztx8ArN2
    iLF3D6Yat2SqS3OLAhr80BZZFSLWYzQJXUDS12txZ1Es8EeOVXwzL4id6/f9CwMj
    gEDah0x0YBbt/xI01nnk54awfPl1OChA+ZJ/X4COv5EW4w5Te469HCbrFA9cxH6p
    6UQGEaNh4sCcexwihhPHon84/kDKBkf8WT4XiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521559247; bh=WkCCaOdclLw/zmOslPn0/t6SDr
    lwrr6vIkWLd3Tc26Y=; b=A8b0IHBUctp0rP+2ANvyex6p1nBFRIWXy1FsBzF59n
    /BDNvxoRhU16AI0HKmURSB3Yqg1+RdLJYxq3yG+hCutKuBqxtPxp0sPWuRt74gfi
    LBkkyFSYXiA8qr7av4q9j2MGZdvCg1HznzG1Scz0UkpcoZ32mTZ2QbQv0nVHp8Vs
    QI6EQdUwtqqtUzKyrkQW3PeAX9j6HbaQI9Z0jU5xHABks8WOSZqtOmLeF7sy1Fpd
    PfR9me/wfx3SyShx7fNqMI9VAVgF6UpzNAqU675PrCpLNiYXjodn39QiN9orbk3K
    B4Vv8bvLaMiAe2FTkWgp97TYFOATQaJOjfh4Wck/TuNg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeCTPU1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:20:27 -0400
Received: from verein.lst.de ([213.95.11.211]:37717 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTPUZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 11:20:25 -0400
Date: Tue, 20 Mar 2018 16:20:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/36] aio: add delayed cancel support
Message-ID: <20180320152022.GB23920@lst.de>
References: <20180305212743.16664-1-hch@lst.de> <20180305212743.16664-8-hch@lst.de> <20180320031957.GJ7282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320031957.GJ7282@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 08:19:57PM -0700, Darrick J. Wong wrote:
> On Mon, Mar 05, 2018 at 01:27:14PM -0800, Christoph Hellwig wrote:
> > The upcoming aio poll support would like to be able to complete the
> > iocb inline from the cancellation context, but that would cause
> > a lock order reversal.  Add support for optionally moving the cancelation
> > outside the context lock to avoid this reversal.
> 
> I started to wonder which lock order reversal the commit message refers
> to?
> 
> I think the reason for adding delayed cancellations is that we want to
> be able to call io_cancel -> kiocb_cancel -> aio_poll_cancel ->
> aio_complete without double locking ctx_lock?

It is.  I've updated the commit message.

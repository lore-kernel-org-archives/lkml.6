Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1445413-1522346937-2-16508871229944713585
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346936; b=GzAoAaTpvhJF8rF6gXkfNUFvC79ccHq2TiMCvSWj+hB1EnX6Bo
    8cS15U8KD0FdDmBXsUcpwWwxrTIwOp1RA0tqZ608FZ1d2gQdb3R/wWdFClN3Rlq3
    yq/3xho4/eP0K8cKrGyQeR0c04BWaCv3Vzccb3FaJKFTjRttOYJIvc8ilNfkWcw+
    fKUpe1ZxXE4HUQHR/4V2y/s/UHEQ3OF0hc8DErtV/Ky13RCrV1oSQcpT4kQzxCmh
    O1QTxz+YTZGORycjjYOdXhWP9J4+RyBlmmzQVhkBT1H31a2UmpkalQe1B19Sb5xw
    tkacfG6ypAMKXNYO/e8mNFAC/ec0diOhT7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522346936; bh=93YwnAVEYSZMAtzuzCwGDAMfxMFU2v
    J8GqxVxI8dsW4=; b=FXIeDh9hUgPhakLmM0NidvFh60IWeWrfgGr6Uy3XiA5J58
    lr7P58RZW8nAlbYdWJ37vwGz8+Aj+UWkT8JJDK3SQJ1JKylYDLyPy36eP2XmRahd
    2hGO+NC32C2bzbdd0EV3rDISXY/k12JP7R/m9R5LwHScvj1OtMBaXRLPe0teFmkx
    dxrYN490yreA6dYnFGHJBYbSQfLnr9ePyjjX9TUqoYd0GW0WqAbZaWDn1Lml9CZk
    LM0hor6rc5mtlov5abWPfwC8m/NeIChQF0OmrruMBo1BOodrBwwLRa63rbYbISnF
    s7j+1JwnCUaDPm1R0/vV3iCHmCxO8sUsYqGeBa/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfADjIq5vuSGqzlkAqgtcBpIWGzu4AurmXnzCtFDzVMysN3GCEY9YDJT4xYffMWwysXkcnG/MctTbfooqXkQ7kq3bMPRnW1R9IzocIAcHkTs5ashQ4sta
    C3kCiJVDvM79dNRgULxKsbSy7Ba5umNr33aS5r+Tv6dN/gsJKVJdyIlgggfrMEGcMM53YPFuc282KtjbAYSOWGKcRLVrw3bMxa0GvVwvPg1+fDLY7C16BQmL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=_nqVeLvL3UPWCy0nb84A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeC2SIf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:08:35 -0400
Received: from verein.lst.de ([213.95.11.211]:51586 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754306AbeC2SId (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Mar 2018 14:08:33 -0400
Date: Thu, 29 Mar 2018 20:08:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] aio: add delayed cancel support
Message-ID: <20180329180831.GA15948@lst.de>
References: <20180328072926.17131-1-hch@lst.de> <20180328072926.17131-8-hch@lst.de> <20180328163526.GV30522@ZenIV.linux.org.uk> <20180329085305.GA22215@lst.de> <20180329142506.GX30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329142506.GX30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:25:06PM +0100, Al Viro wrote:
> OK.  Let's leave that alone for now.  Re deferred cancels - AFAICS, we *must*
> remove the sucker from ctx->active_reqs before dropping ->ctx_lock.
> 
> As it is, you are creating a io_cancel()/io_cancel() race leading to double
> fput().  It's not that hard to fix; I can do that myself while applying your
> series (as described in previous posting - kiocb_cancel_locked() returning
> NULL or ERR_PTR() in non-deferred case and pointer to aio_kiocb removed from
> ->active_reqs in deferred one) or you could fix it in some other way and
> update your branch.

I think that is the right fix.  Let me resend so that I can test the
result first.

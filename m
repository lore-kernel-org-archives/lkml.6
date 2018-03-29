Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1902058-1522362910-2-8901156411023348111
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522362909; b=tWY9IqUn4STCjVOupYwiX3j2CcUT7Xeh4zvMNav807nbS4tuyL
    XpTo+LZJKJE8RZD/N0SLOpUf84d7hrutUAiIEqn8c/eGpzm4yMFPSAYXSTNElkLH
    vGHjeYfBkVCZ08WPlsWHziXLLtE2lleNrckJkc4mdzYR+u3W4ii1QOGqNk0U9H2k
    Fqs+WvEA4g3aOO3/aowVqbBTAT4rbhdE/nD141rwVSA8QANOI1iVjLDBOQZfsSHk
    Obmz7L/ZrhPrmx6/SLBm4kkevVsPMAIFrHa8Hma3RBdbILbm9nAl5RnvMQpGKGPl
    07d0vwVrZdPdLf97dLVE0DvJzO1pZnXM5ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522362909; bh=DxTvbeFk+nwLz0PL//FOOPP0n28JI/
    JuuxBulJx8muw=; b=rkDzADsmrr1bgXr5/6pnjaeVCnvMTVHUVKwEcTmzN2fIcv
    fSwyMOtWTRN0YanRRIE+Ldirua0txI8xZSuIKnwAcy9CbjZLrxvfgufzst1Ql7/i
    FOFM/O82C6Pf6Fm1wiVgwaJ3Yt2r8e1MGjrLrxlERw+LL+akIo8BJ7tYLvNM9gkk
    y43Ojr4lmOUAYoa/ocN8GpzfXCpauUgbI5Kl9fVbDaQb0R0D/Isu3BZ+EvN1/PPY
    hv1MMMPM01cGKobwW/QCKW6KNbCB6Qpt0bRlRAlod5piDAtGF5URvVIs5e9HTxaI
    qEtLyWVBqNwu3BI2Qd3bkkOMtEDvZEZAEHebvATg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4k7ccsl3zgbz6y8dIAH9msgfvcDU/Ym2R/j3gdCilKgz6tdfbjjwmk9wk1+zFk8AwNI+8rr2o0zTeSb73OEBaFOVHImmxPpm4Q2qI2HlDNr0rmc8wR
    Lyy1SZFgVpDzDx+wrsCTPa6piUYeVkv0wz7YvdroYboj1HqpnA30rs9b/heXadOK2p34AKoZC83pIT0v9sgxGIORwPLylXbVRQRseVAxhf3Pc7LNNBooKmC5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=liekiaZb2k_bqfuXDjQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeC2WfH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 18:35:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53168 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeC2WfG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 18:35:06 -0400
Date: Thu, 29 Mar 2018 23:35:00 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] aio: add delayed cancel support
Message-ID: <20180329223500.GY30522@ZenIV.linux.org.uk>
References: <20180329203328.3248-1-hch@lst.de>
 <20180329203328.3248-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329203328.3248-8-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 10:33:05PM +0200, Christoph Hellwig wrote:
> The upcoming aio poll support would like to be able to complete the
> iocb inline from the cancellation context, but that would cause a
> double lock of ctx_lock with the current locking scheme.  Move the
> cancelation outside the context lock to avoid this reversal, which
> suits the existing usb gadgets users just fine as well (in fact
> both unconditionally disable irqs and thus seem broken without
> this change).
> 
> To make this safe aio_complete needs to check if this call should
> complete the iocb.  If it didn't the callers must not release any
> other resources.

Uh-oh...  What happens to existing users of kiocb_set_cancel_fn() now?
AFAICS, those guys will *not* get aio_kiocb freed at all in case of
io_cancel(2).  Look: we mark them with AIO_IOCB_CANCELLED and
call whatever ->ki_cancel() the driver has set.  Later the damn
thing calls ->ki_complete() (i.e. aio_complete_rw()), which calls
aio_complete(iocb, res, res2, 0) and gets false.  Nothing's freed,
struct file is leaked.

Frankly, the more I look at that, the less I like what you've done
with ->ki_cancel() overloading.  In regular case it's just accelerating
the call of ->ki_complete(), which will do freeing.  Here you have
->ki_cancel() free the damn thing, with the resulting need to play
silly buggers with locking, freeing logics in aio_complete(), etc.

Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3138558-1521736660-2-12508765361347255792
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
    t=1521736660; b=gWkKCmnuiRqWbZxGE8nlyYljXbTsjUikAEJyZrGid3a0MU5
    3bUQrWMWdkno0zySpt3ve3ZpKw2H7S6FyRfMor/KSe3XZXfXXe3TwFAB/sCNyXiJ
    BKxJZakCREZtS6kZ1AiLjiH4OUqQpOUS0+mqRVWcAU9WuDQpWWTDY/N3OAz1S/1Y
    2hr4ArvFzu6kOQSGkVMsasAugXprOZzlnD5i5fihXGL4OtR8k3pNluIWCZjwC8pj
    SzuWqyW+T4nSQSnufzWpNwpl2IeRSYpuablAQQ+SCxCjKrhpY1qY+qkSze45yj0H
    LHR/MLXiFjOmS0151Nxd5Aiz1Fp76CIve5zkJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521736660; bh=h3Vcp01FiJSMZrPXWldT0I9Yw9
    RRnowsHplqSrmxFjU=; b=S5ZuWaoHENZl4A352YN6gnuisSDN32ztbdT12YiVgV
    BUN06efNBWtia4qT7of3L/72H0MiIOFedHWZQb+MIYLbH/82lummHlNjos5JST1b
    TVsaz+QL1Ejluj4y6GHA/95JpqcC3v9vWzntLNdHHdoiKlU5L5hPS9+Je5dSfHNM
    k0+aSjwnLLWF3MDZraCyJTmQNWt7lOdXeIh+LPckDk9uEZXdTkN7NIhOUDIsiBWm
    NXVr8135Ha+aSdCjCADtcT40+SCh5JVqSYMJlXWVp/iLANu15jri+xy9vYDq5EYA
    W7K4G9oTktFxmFwaL7CaQyCY/nnLL/23E4bogBLmV6Ww==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1751948AbeCVQhX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 12:37:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35432 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeCVQg5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Mar 2018 12:36:57 -0400
Date: Thu, 22 Mar 2018 16:36:55 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: io_pgetevents & aio fsync
Message-ID: <20180322163655.GA26261@ZenIV.linux.org.uk>
References: <20180321073232.13366-1-hch@lst.de>
 <20180322163605.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322163605.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 04:36:05PM +0000, Al Viro wrote:
> On Wed, Mar 21, 2018 at 08:32:23AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this patch adds workqueue based fsync offload.  Version of this
> > patch have been floating around for a couple years, but we now
> > have a user with seastar used by ScyllaDB (who sponsored this
> > work) that really wants this in addition to the aio poll support.
> > More details are in the patch itself.
> > 
> > Because the iocb types have been defined sine day one (and probably
> > were supported by RHEL3) libaio already supports these calls as-is.
> > 
> > This also pulls in the aio cleanups and io_pgetevents support previously
> > submitted and review as part of the aio poll series.  The aio poll
> > series will be resubmitted on top of this series
> 
> Everything other than 6/9 looks sane; 6/9 belongs in aio poll series
> and AFAICS its user in there is actually broken.

Gyah... 7/9, that is.
